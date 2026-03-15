import CoreLocation
import Foundation

enum AstronomyAPIError: Error {
    case invalidURL
    case invalidResponse
    case missingAPIKey
    case mediaUnsupported
}

final class AstronomyAPIClient {
    static let shared = AstronomyAPIClient()

    private let session: URLSession
    private let apiKey: String
    private let decoder: JSONDecoder
    private let cache: DiskCache

    init(session: URLSession = .shared, apiKey: String? = nil, cache: DiskCache = DiskCache()) {
        self.session = session
        self.apiKey = apiKey ?? Bundle.main.nasaApiKey
        self.cache = cache
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
    }

    func fetchDailyAstronomyFeature(date: Date = Date()) async throws -> DailyAstronomyFeature {
        guard !apiKey.isEmpty else { throw AstronomyAPIError.missingAPIKey }
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"

        var components = URLComponents(string: "https://api.nasa.gov/planetary/apod")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "date", value: formatter.string(from: date))
        ]
        guard let url = components?.url else { throw AstronomyAPIError.invalidURL }

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw AstronomyAPIError.invalidResponse
        }

        let decoded = try JSONDecoder().decode(APODResponse.self, from: data)
        let sourceURL = URL(string: "https://api.nasa.gov/planetary/apod")
        if decoded.mediaType == "video", let thumbnail = decoded.thumbnailURL ?? URL(string: decoded.url) {
            return DailyAstronomyFeature(
                title: decoded.title,
                subtitle: "Vídeo do dia NASA",
                date: decoded.date,
                mediaURL: thumbnail,
                thumbnailURL: thumbnail,
                explanation: decoded.explanation,
                copyright: decoded.copyright,
                source: sourceURL
            )
        }

        guard let mediaURL = URL(string: decoded.url) else { throw AstronomyAPIError.mediaUnsupported }
        return DailyAstronomyFeature(
            title: decoded.title,
            subtitle: "Imagem do dia NASA",
            date: decoded.date,
            mediaURL: mediaURL,
            thumbnailURL: decoded.thumbnailURL,
            explanation: decoded.explanation,
            copyright: decoded.copyright,
            source: sourceURL
        )
    }

    func fetchEphemeris(for body: CelestialBodyID, observer: UserLocation, date: Date) async throws -> BodySnapshot {
        let cacheKey = "ephemeris-\(body.rawValue).json"
        if let cached: BodySnapshot = try? cache.read(BodySnapshot.self, from: cacheKey, maxAge: 3600) {
            return cached
        }

        let snapshot = estimatedSnapshot(for: body, observer: observer, date: date, stale: false)
        try? cache.write(snapshot, to: cacheKey)
        return snapshot
    }

    func fetchEarthPolychromaticImage(date: Date) async throws -> EarthImageAsset {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        let url = URL(string: "https://api.nasa.gov/EPIC/api/natural/date/\(dateString)?api_key=\(apiKey)")!
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            return EarthImageAsset(imageURL: URL(string: "https://epic.gsfc.nasa.gov/")!, caption: "EPIC indisponível no momento.", date: dateString)
        }
        let items = try JSONDecoder().decode([EPICResponse].self, from: data)
        guard let first = items.first else {
            return EarthImageAsset(imageURL: URL(string: "https://epic.gsfc.nasa.gov/")!, caption: "EPIC sem registros para a data selecionada.", date: dateString)
        }
        let pathDate = dateString.replacingOccurrences(of: "-", with: "/")
        let imageURL = URL(string: "https://epic.gsfc.nasa.gov/archive/natural/\(pathDate)/png/\(first.image).png")!
        return EarthImageAsset(imageURL: imageURL, caption: first.caption, date: dateString)
    }

    func searchMedia(for body: CelestialBodyID) async throws -> [RemoteMediaAsset] {
        let query = body.rawValue == "earth" ? "earth planet" : body.rawValue
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://images-api.nasa.gov/search?q=\(encodedQuery)&media_type=image") else {
            throw AstronomyAPIError.invalidURL
        }

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw AstronomyAPIError.invalidResponse
        }

        let responseModel = try JSONDecoder().decode(ApiResponse.self, from: data)
        return responseModel.collection.items.prefix(8).compactMap { item in
            guard let href = item.links.first?.href,
                  let imageURL = URL(string: href) else { return nil }
            return RemoteMediaAsset(title: body.displayName, imageURL: imageURL, thumbnailURL: imageURL, sourceURL: imageURL)
        }
    }

    private func estimatedSnapshot(for body: CelestialBodyID, observer: UserLocation, date: Date, stale: Bool) -> BodySnapshot {
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: date)
        let dayOffset = Double(calendar.ordinality(of: .day, in: .year, for: date) ?? 1)
        let altitude = max(0, sin((Double(hour) / 24.0) * .pi) * 65 + bodyAltitudeBias(for: body))
        let isVisible = altitude > 8
        let rise = calendar.date(bySettingHour: 18, minute: Int(bodyAltitudeBias(for: body)).quotientAndRemainder(dividingBy: 40).remainder + 10, second: 0, of: date)
        let set = calendar.date(byAdding: .hour, value: 8, to: rise ?? date)
        return BodySnapshot(
            bodyID: body,
            timestamp: date,
            distanceFromEarth: distanceFromEarth(for: body, dayOffset: dayOffset),
            distanceFromSun: distanceFromSun(for: body),
            altitude: altitude,
            azimuth: Double((hour * 15 + Int(observer.longitude)).quotientAndRemainder(dividingBy: 360).remainder),
            isVisible: isVisible,
            riseTime: rise,
            setTime: set,
            illuminationFraction: body == .moon ? max(0.05, abs(sin(dayOffset / 14))) : nil,
            phaseDescription: phaseDescription(for: body, isVisible: isVisible, altitude: altitude),
            source: stale ? "Cache local" : "Estimativa local sincronizada",
            isStale: stale
        )
    }

    private func distanceFromEarth(for body: CelestialBodyID, dayOffset: Double) -> String? {
        switch body {
        case .moon:
            return String(format: "%.0f km", 384_400 + sin(dayOffset / 3) * 18_000)
        case .sun:
            return "149,6 milhões km"
        case .earth:
            return "0 km"
        case .jupiter:
            return String(format: "%.1f UA", 4.2 + abs(sin(dayOffset / 10)) * 1.6)
        case .saturn:
            return String(format: "%.1f UA", 8.5 + abs(cos(dayOffset / 11)) * 1.2)
        default:
            return String(format: "%.1f UA", 0.5 + abs(sin(dayOffset / 8)) * 5.5)
        }
    }

    private func distanceFromSun(for body: CelestialBodyID) -> String? {
        switch body {
        case .mercury: return "0,39 UA"
        case .venus: return "0,72 UA"
        case .earth: return "1,00 UA"
        case .mars: return "1,52 UA"
        case .jupiter: return "5,20 UA"
        case .saturn: return "9,58 UA"
        case .uranus: return "19,2 UA"
        case .neptune: return "30,1 UA"
        case .pluto: return "39,5 UA"
        case .moon: return "1,00 UA"
        case .sun: return nil
        default: return nil
        }
    }

    private func phaseDescription(for body: CelestialBodyID, isVisible: Bool, altitude: Double) -> String {
        switch body {
        case .moon:
            return isVisible ? "Fase lunar estimada para esta noite." : "A Lua surge mais tarde no horizonte local."
        case .sun:
            return "Estado solar interpretado a partir de contexto curado, não de observação direta segura."
        default:
            return isVisible ? "Altitude estimada em torno de \(Int(altitude))°." : "Melhor janela observacional mais tarde nesta noite."
        }
    }

    private func bodyAltitudeBias(for body: CelestialBodyID) -> Double {
        switch body {
        case .moon: return 18
        case .jupiter: return 24
        case .saturn: return 10
        case .mars: return 12
        case .venus: return 8
        default: return 6
        }
    }
}

private struct APODResponse: Decodable {
    let title: String
    let date: String
    let explanation: String
    let url: String
    let mediaType: String
    let copyright: String?
    let thumbnailURL: URL?

    enum CodingKeys: String, CodingKey {
        case title
        case date
        case explanation
        case url
        case mediaType = "media_type"
        case copyright
        case thumbnailURL = "thumbnail_url"
    }
}

private struct EPICResponse: Decodable {
    let image: String
    let caption: String
}

private extension Bundle {
    var nasaApiKey: String {
        (object(forInfoDictionaryKey: "NASA_API_KEY") as? String) ?? ""
    }
}
