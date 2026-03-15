import Foundation

struct HomeHero {
    let title: String
    let subtitle: String
    let detail: String
    let tagline: String
    let imageURL: URL?

    static let placeholder = HomeHero(
        title: "O céu está vivo agora",
        subtitle: "Seu hub cósmico diário",
        detail: "Carregando a imagem astronômica do dia e o panorama do céu local.",
        tagline: "Atualizando",
        imageURL: nil
    )

    init(title: String, subtitle: String, detail: String, tagline: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.detail = detail
        self.tagline = tagline
        self.imageURL = imageURL
    }

    init(from feature: DailyAstronomyFeature) {
        self.title = feature.title
        self.subtitle = feature.subtitle
        self.detail = feature.explanation
        self.tagline = feature.date
        self.imageURL = feature.thumbnailURL ?? feature.mediaURL
    }
}

struct QuickFact: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let detail: String
}

struct HomeCategory: Identifiable {
    let id = UUID()
    let category: CelestialCategory
}

struct HomeContinueItem: Identifiable {
    let id = UUID()
    let bodyID: CelestialBodyID
    let subtitle: String
}

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var hero: HomeHero = .placeholder
    @Published var liveBodies: [LiveSkyBody] = []
    @Published var categories: [HomeCategory] = CelestialCategory.allCases.map(HomeCategory.init)
    @Published var quickFacts: [QuickFact] = []
    @Published var continueExploring: [HomeContinueItem] = []
    @Published var statusMessage: String?

    private let apiClient: AstronomyAPIClient
    private let locationService: LocationService
    private let skyObservationService: SkyObservationService
    private let contentService: CelestialContentService
    private let cache: DiskCache
    private let userCollectionsStore: UserCollectionsStore

    init(
        apiClient: AstronomyAPIClient = .shared,
        locationService: LocationService = .shared,
        skyObservationService: SkyObservationService = SkyObservationService(),
        contentService: CelestialContentService = CelestialContentService(),
        cache: DiskCache = DiskCache(),
        userCollectionsStore: UserCollectionsStore = UserCollectionsStore()
    ) {
        self.apiClient = apiClient
        self.locationService = locationService
        self.skyObservationService = skyObservationService
        self.contentService = contentService
        self.cache = cache
        self.userCollectionsStore = userCollectionsStore
        self.quickFacts = contentService.quickFactFeed()
        reloadContinueExploring()
    }

    func load() async {
        async let heroTask: Void = loadHero()
        async let skyTask: Void = loadLiveSky()
        _ = await (heroTask, skyTask)
        reloadContinueExploring()
    }

    func recordSelection(_ bodyID: CelestialBodyID) {
        userCollectionsStore.recordVisit(to: bodyID)
        reloadContinueExploring()
    }

    private func loadHero() async {
        do {
            if let cached: DailyAstronomyFeature = try cache.read(DailyAstronomyFeature.self, from: "apod.json", maxAge: 24 * 60 * 60) {
                hero = HomeHero(from: cached)
                return
            }

            let feature = try await apiClient.fetchDailyAstronomyFeature(date: Date())
            hero = HomeHero(from: feature)
            try? cache.write(feature, to: "apod.json")
        } catch {
            statusMessage = "Não foi possível atualizar o destaque do dia."
        }
    }

    private func loadLiveSky() async {
        do {
            let location = try await locationService.requestUserLocation()
            liveBodies = await skyObservationService.loadSnapshot(for: location)
            statusMessage = nil
        } catch {
            let approximate = await skyObservationService.loadSnapshot(for: .unknown)
            liveBodies = approximate
            statusMessage = locationFallbackMessage()
        }
    }

    private func locationFallbackMessage() -> String {
        switch locationService.authorizationState {
        case .denied:
            return "Localização negada. Exibindo um céu aproximado com dados locais e cache."
        case .restricted, .unavailable:
            return "Localização indisponível. Use o mapa do céu para ver uma estimativa offline."
        case .notDetermined:
            return "Ative a localização para ver horários e altitude do seu céu agora."
        case .authorized:
            return "Exibindo um snapshot aproximado enquanto os dados ao vivo são sincronizados."
        }
    }

    private func reloadContinueExploring() {
        let recent = userCollectionsStore.recentBodies()
        let favorites = userCollectionsStore.favoriteBodies()
        let merged = Array((recent + favorites).uniqued().prefix(6))
        continueExploring = merged.map { HomeContinueItem(bodyID: $0, subtitle: userCollectionsStore.isFavorite($0) ? "Favorito" : "Visitado recentemente") }
    }
}

private extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
