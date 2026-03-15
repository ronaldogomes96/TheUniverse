import Foundation

final class SkyObservationService {
    private let astronomyAPIClient: AstronomyAPIClient
    private let contentStore: CuratedContentStore

    init(astronomyAPIClient: AstronomyAPIClient = .shared, contentStore: CuratedContentStore = CuratedContentStore()) {
        self.astronomyAPIClient = astronomyAPIClient
        self.contentStore = contentStore
    }

    func currentSky(for location: UserLocation, date: Date) async -> SkySnapshot {
        let bodies = await contentStore.featuredBodies().asyncMap { body in
            do {
                return try await astronomyAPIClient.fetchEphemeris(for: body, observer: location, date: date)
            } catch {
                return BodySnapshot(
                    bodyID: body,
                    timestamp: date,
                    distanceFromEarth: nil,
                    distanceFromSun: nil,
                    altitude: nil,
                    azimuth: nil,
                    isVisible: false,
                    riseTime: nil,
                    setTime: nil,
                    illuminationFraction: nil,
                    phaseDescription: "Sem sincronização disponível.",
                    source: "Falha ao carregar",
                    isStale: true
                )
            }
        }

        let visibleBodies = bodies.sorted { ($0.altitude ?? 0) > ($1.altitude ?? 0) }
        return SkySnapshot(
            timestamp: date,
            observerLocation: location,
            visibleBodies: visibleBodies,
            featuredBody: visibleBodies.first,
            tonightHighlights: contentStore.cosmicEvents(referenceDate: date)
        )
    }

    func bestObservationWindow(for body: CelestialBodyID, location: UserLocation, date: Date) async -> ObservationWindow {
        let snapshot = try? await astronomyAPIClient.fetchEphemeris(for: body, observer: location, date: date)
        let start = snapshot?.riseTime ?? date
        let end = snapshot?.setTime ?? Calendar.current.date(byAdding: .hour, value: 4, to: date) ?? date
        let quality: ObservationWindow.Quality = (snapshot?.isVisible ?? false) ? .great : .fair
        let reason = snapshot?.isVisible == true ? "Altitude estimada favorável acima do horizonte." : "O corpo surge mais tarde na noite local."
        return ObservationWindow(start: start, end: end, quality: quality, reason: reason)
    }

    func loadSnapshot(for location: UserLocation) async -> [LiveSkyBody] {
        let snapshot = await currentSky(for: location, date: Date())
        return snapshot.visibleBodies.map {
            LiveSkyBody(
                bodyID: $0.bodyID,
                name: $0.bodyID.displayName,
                status: $0.phaseDescription ?? "Sem contexto disponível",
                detail: "Nasce \($0.riseTime?.formatted(date: .omitted, time: .shortened) ?? "--") • Fonte: \($0.source)",
                visibility: $0.isVisible ? "Visível agora" : "Mais tarde"
            )
        }
    }
}

private extension Array {
    func asyncMap<T>(_ transform: (Element) async -> T) async -> [T] {
        var results: [T] = []
        for element in self {
            results.append(await transform(element))
        }
        return results
    }
}
