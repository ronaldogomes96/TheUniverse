import Foundation

final class CelestialContentService {
    private let astronomyAPIClient: AstronomyAPIClient
    private let skyObservationService: SkyObservationService
    private let audioService: CosmicAudioService
    private let curatedContentStore: CuratedContentStore

    init(
        astronomyAPIClient: AstronomyAPIClient = .shared,
        skyObservationService: SkyObservationService = SkyObservationService(),
        audioService: CosmicAudioService = CosmicAudioService(),
        curatedContentStore: CuratedContentStore = CuratedContentStore()
    ) {
        self.astronomyAPIClient = astronomyAPIClient
        self.skyObservationService = skyObservationService
        self.audioService = audioService
        self.curatedContentStore = curatedContentStore
    }

    func detail(for body: CelestialBodyID) async -> CelestialDetail {
        async let snapshot = astronomyAPIClient.fetchEphemeris(for: body, observer: .unknown, date: Date())
        async let audioExperience = audioService.audioExperience(for: body)
        async let gallery = astronomyAPIClient.searchMedia(for: body)

        let content = curatedContentStore.content(for: body)
        let liveSnapshot = try? await snapshot
        let remoteGallery = (try? await gallery) ?? []
        let audio = await audioExperience

        let heroMedia = remoteGallery.first ?? RemoteMediaAsset(
            title: body.displayName,
            imageURL: Bundle.main.bundleURL,
            thumbnailURL: nil,
            sourceURL: nil
        )

        let detailSections = content.sections + [
            CelestialSection(title: "Curiosidades", body: content.curiosities.joined(separator: "\n\n"))
        ]

        return CelestialDetail(
            body: body,
            heroMedia: heroMedia.imageURL.isFileURL || heroMedia.imageURL.scheme?.hasPrefix("http") == true ? heroMedia : nil,
            quickFacts: content.quickFacts,
            liveSnapshot: liveSnapshot,
            audioExperience: audio,
            sections: detailSections,
            gallery: remoteGallery,
            relatedMissions: content.relatedMissions,
            comparisonCandidates: content.comparisonCandidates
        )
    }

    func compare(_ lhs: CelestialBodyID, _ rhs: CelestialBodyID) async -> BodyComparison {
        let left = curatedContentStore.content(for: lhs).quickFacts
        let right = curatedContentStore.content(for: rhs).quickFacts
        let metrics = zip(left, right).map { leftFact, rightFact in
            CelestialQuickFact(label: leftFact.label, value: "\(lhs.displayName): \(leftFact.value) • \(rhs.displayName): \(rightFact.value)")
        }
        return BodyComparison(lhs: lhs, rhs: rhs, metrics: metrics)
    }

    func quickFactFeed() -> [QuickFact] {
        curatedContentStore.quickFactFeed()
    }

    func eventCatalog() -> [CosmicEvent] {
        curatedContentStore.cosmicEvents()
    }
}
