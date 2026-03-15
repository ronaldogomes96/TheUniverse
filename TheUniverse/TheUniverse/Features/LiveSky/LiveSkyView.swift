import SwiftUI

struct LiveSkyView: View {
    @ObservedObject var viewModel: LiveSkyViewModel
    let onSelectBody: (CelestialBodyID) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: UniverseSpacing.lg) {
                SectionHeader(title: "Seu céu agora", subtitle: viewModel.headerText)
                if let message = viewModel.statusMessage {
                    GlassInfoCard {
                        Text(message)
                            .font(UniverseTypography.body)
                            .foregroundStyle(UniverseColor.textSecondary)
                    }
                }

                if !viewModel.events.isEmpty {
                    VStack(alignment: .leading, spacing: UniverseSpacing.md) {
                        SectionHeader(title: "Calendário cósmico", subtitle: "Eventos recorrentes e janelas observacionais")
                        ForEach(viewModel.events) { event in
                            EventRow(event: event)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: UniverseSpacing.md) {
                    SectionHeader(title: "Visibilidade", subtitle: "Corpos em destaque na sua localização")
                    ForEach(viewModel.visibleBodies) { snapshot in
                        Button {
                            onSelectBody(snapshot.bodyID)
                        } label: {
                            GlassInfoCard {
                                VStack(alignment: .leading, spacing: UniverseSpacing.sm) {
                                    HStack {
                                        Text(snapshot.bodyID.displayName)
                                            .font(UniverseTypography.subtitle)
                                            .foregroundStyle(UniverseColor.textPrimary)
                                        Spacer()
                                        VisibilityBadge(text: snapshot.isVisible ? "Visível agora" : "Abaixo do horizonte", isPositive: snapshot.isVisible)
                                    }
                                    Text(snapshot.phaseDescription ?? "Condição estimada para observação")
                                        .font(UniverseTypography.body)
                                        .foregroundStyle(UniverseColor.textSecondary)
                                    HStack {
                                        Label(snapshot.altitude.map { String(format: "%.0f°", $0) } ?? "--", systemImage: "location.north.line")
                                        Label(snapshot.riseTime?.formatted(date: .omitted, time: .shortened) ?? "--", systemImage: "sunrise")
                                        Label(snapshot.setTime?.formatted(date: .omitted, time: .shortened) ?? "--", systemImage: "sunset")
                                    }
                                    .font(UniverseTypography.caption)
                                    .foregroundStyle(UniverseColor.textSecondary)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(UniverseSpacing.lg)
        }
        .background(UniverseColor.space.ignoresSafeArea())
        .navigationTitle("Mapa do céu")
        .task { await viewModel.load() }
    }
}

@MainActor
final class LiveSkyViewModel: ObservableObject {
    @Published var visibleBodies: [BodySnapshot] = []
    @Published var events: [CosmicEvent] = []
    @Published var statusMessage: String?

    private let skyObservationService: SkyObservationService
    private let locationService: LocationService
    private let contentService: CelestialContentService

    init(
        skyObservationService: SkyObservationService = SkyObservationService(),
        locationService: LocationService = .shared,
        contentService: CelestialContentService = CelestialContentService()
    ) {
        self.skyObservationService = skyObservationService
        self.locationService = locationService
        self.contentService = contentService
        self.events = contentService.eventCatalog()
    }

    var headerText: String {
        visibleBodies.isEmpty ? "Aguardando dados observacionais." : "Uma mistura de efemérides estimadas, cache e dados locais." 
    }

    func load() async {
        let locationStatus = locationService.authorizationState
        if locationStatus == .denied || locationStatus == .restricted {
            statusMessage = "Localização indisponível. Exibindo um céu aproximado com base no catálogo local."
        }

        do {
            let location = try await locationService.requestUserLocation()
            let snapshot = await skyObservationService.currentSky(for: location, date: Date())
            visibleBodies = snapshot.visibleBodies
        } catch {
            let snapshot = await skyObservationService.currentSky(for: .unknown, date: Date())
            visibleBodies = snapshot.visibleBodies
            statusMessage = "Não foi possível obter a localização. Exibindo um panorama aproximado."
        }
    }
}
