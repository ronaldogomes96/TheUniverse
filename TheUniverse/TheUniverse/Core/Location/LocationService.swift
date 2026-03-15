import CoreLocation
import Foundation

enum LocationAuthorizationState: Equatable {
    case notDetermined
    case authorized
    case denied
    case restricted
    case unavailable
}

enum LocationServiceError: Error {
    case unavailable
    case denied
    case failed
}

final class LocationService: NSObject, CLLocationManagerDelegate {
    static let shared = LocationService()

    private let manager: CLLocationManager
    private var continuation: CheckedContinuation<UserLocation, Error>?

    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    var authorizationState: LocationAuthorizationState {
        guard CLLocationManager.locationServicesEnabled() else { return .unavailable }
        switch manager.authorizationStatus {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorizedAlways, .authorizedWhenInUse:
            return .authorized
        @unknown default:
            return .unavailable
        }
    }

    func requestUserLocation() async throws -> UserLocation {
        guard CLLocationManager.locationServicesEnabled() else { throw LocationServiceError.unavailable }

        switch manager.authorizationStatus {
        case .denied:
            throw LocationServiceError.denied
        case .restricted:
            throw LocationServiceError.unavailable
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = manager.location {
                return UserLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, displayName: "Sua localização")
            }
        case .notDetermined:
            break
        @unknown default:
            throw LocationServiceError.unavailable
        }

        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            manager.requestWhenInUseAuthorization()
            manager.requestLocation()
        }
    }

    func requestLocation() async throws -> CLLocation {
        let userLocation = try await requestUserLocation()
        return CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied {
            continuation?.resume(throwing: LocationServiceError.denied)
            continuation = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            continuation?.resume(throwing: LocationServiceError.failed)
            continuation = nil
            return
        }
        continuation?.resume(returning: UserLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, displayName: "Sua localização"))
        continuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
}
