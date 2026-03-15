import Foundation

@MainActor
final class CelestialDetailViewModel: ObservableObject {
    @Published var detail: CelestialDetail?
    @Published var comparison: BodyComparison?
    @Published var isFavorite = false

    let bodyID: CelestialBodyID
    private let contentService: CelestialContentService
    private let userCollectionsStore: UserCollectionsStore

    init(
        bodyID: CelestialBodyID,
        contentService: CelestialContentService = CelestialContentService(),
        userCollectionsStore: UserCollectionsStore = UserCollectionsStore()
    ) {
        self.bodyID = bodyID
        self.contentService = contentService
        self.userCollectionsStore = userCollectionsStore
        self.isFavorite = userCollectionsStore.isFavorite(bodyID)
    }

    func load() async {
        userCollectionsStore.recordVisit(to: bodyID)
        let detail = await contentService.detail(for: bodyID)
        self.detail = detail

        if let firstCandidate = detail.comparisonCandidates.first {
            self.comparison = await contentService.compare(bodyID, firstCandidate)
        }
    }

    func toggleFavorite() {
        userCollectionsStore.toggleFavorite(bodyID)
        isFavorite = userCollectionsStore.isFavorite(bodyID)
    }
}
