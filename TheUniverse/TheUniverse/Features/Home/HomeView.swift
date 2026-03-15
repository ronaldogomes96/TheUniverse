import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    let showExplorer: (CelestialCategory?) -> Void
    let showLiveSky: () -> Void
    let showBodyDetail: (CelestialBodyID) -> Void
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var gridColumns: [GridItem] {
        horizontalSizeClass == .regular ? [GridItem(.adaptive(minimum: 260), spacing: UniverseSpacing.md)] : [GridItem(.flexible())]
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: UniverseSpacing.lg) {
                    cosmicBackdrop
                    heroSection
                    liveSkySection
                    categorySection
                    discoverSection
                    continueExploringSection
                }
                .padding(.horizontal, UniverseSpacing.lg)
                .padding(.bottom, 60)
            }
            .background(UniverseColor.space.ignoresSafeArea())
            .navigationTitle("TheUniverse")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showExplorer(nil) }) {
                        Label("Explorar", systemImage: "sparkles")
                    }
                    .foregroundStyle(UniverseColor.accentCyan)
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }

    private var cosmicBackdrop: some View {
        RoundedRectangle(cornerRadius: 28, style: .continuous)
            .fill(
                LinearGradient(colors: [UniverseColor.accentGold.opacity(0.15), .clear, UniverseColor.accentAqua.opacity(0.08)], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .frame(height: 1)
            .overlay(alignment: .topLeading) {
                EmptyView()
            }
    }

    private var heroSection: some View {
        Button {
            showBodyDetail(.earth)
        } label: {
            CosmicHeroCard(hero: viewModel.hero)
        }
        .buttonStyle(.plain)
    }

    private var liveSkySection: some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            SectionHeader(title: "Agora no seu céu", subtitle: "O que está acontecendo acima de você neste momento")
            if let statusMessage = viewModel.statusMessage {
                GlassInfoCard {
                    Text(statusMessage)
                        .font(UniverseTypography.body)
                        .foregroundStyle(UniverseColor.textSecondary)
                }
            }
            LazyVGrid(columns: gridColumns, spacing: UniverseSpacing.md) {
                ForEach(viewModel.liveBodies) { body in
                    Button {
                        viewModel.recordSelection(body.bodyID)
                        showBodyDetail(body.bodyID)
                    } label: {
                        LiveBodyCard(liveBody: body)
                    }
                    .buttonStyle(.plain)
                }
            }
            Button(action: showLiveSky) {
                Text("Ver mapa do céu")
                    .font(UniverseTypography.subtitle)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(UniverseColor.accentCyan)
        }
    }

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            SectionHeader(title: "Explore por categoria", subtitle: "Catálogos curados e rotas rápidas para continuar no legado")
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: UniverseSpacing.md)], spacing: UniverseSpacing.md) {
                ForEach(viewModel.categories) { item in
                    Button {
                        showExplorer(item.category == .events || item.category == .missions ? nil : item.category)
                    } label: {
                        GlassInfoCard {
                            VStack(alignment: .leading, spacing: UniverseSpacing.sm) {
                                Image(systemName: item.category.systemImage)
                                    .font(.title2)
                                    .foregroundStyle(UniverseColor.accentGold)
                                Text(item.category.title)
                                    .font(UniverseTypography.subtitle)
                                    .foregroundStyle(UniverseColor.textPrimary)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var discoverSection: some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            SectionHeader(title: "Descubra algo incrível", subtitle: "Curiosidades rápidas para compartilhar")
            LazyVGrid(columns: gridColumns, spacing: UniverseSpacing.md) {
                ForEach(viewModel.quickFacts) { fact in
                    GlassInfoCard {
                        VStack(alignment: .leading, spacing: UniverseSpacing.xs) {
                            Text(fact.value)
                                .font(UniverseTypography.sectionTitle)
                                .foregroundStyle(UniverseColor.textPrimary)
                            Text(fact.title)
                                .font(UniverseTypography.subtitle)
                                .foregroundStyle(UniverseColor.textSecondary)
                            Text(fact.detail)
                                .font(UniverseTypography.caption)
                                .foregroundStyle(UniverseColor.textSecondary)
                        }
                    }
                }
            }
        }
    }

    private var continueExploringSection: some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            SectionHeader(title: "Continue explorando", subtitle: "Histórico recente e favoritos")
            if viewModel.continueExploring.isEmpty {
                GlassInfoCard {
                    Text("Explore um corpo celeste para montar sua trilha pessoal.")
                        .font(UniverseTypography.body)
                        .foregroundStyle(UniverseColor.textSecondary)
                }
            } else {
                ForEach(viewModel.continueExploring) { item in
                    Button {
                        showBodyDetail(item.bodyID)
                    } label: {
                        GlassInfoCard {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.bodyID.displayName)
                                        .font(UniverseTypography.subtitle)
                                        .foregroundStyle(UniverseColor.textPrimary)
                                    Text(item.subtitle)
                                        .font(UniverseTypography.caption)
                                        .foregroundStyle(UniverseColor.textSecondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(UniverseColor.textSecondary)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct CosmicHeroCard: View {
    let hero: HomeHero

    var body: some View {
        ZStack(alignment: .leading) {
            if let imageURL = hero.imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFill()
                    default:
                        heroGradient
                    }
                }
            } else {
                heroGradient
            }

            LinearGradient(colors: [.clear, .black.opacity(0.82)], startPoint: .center, endPoint: .bottom)

            VStack(alignment: .leading, spacing: UniverseSpacing.sm) {
                Text(hero.subtitle)
                    .font(UniverseTypography.caption)
                    .foregroundStyle(UniverseColor.accentCyan)
                Text(hero.title)
                    .font(UniverseTypography.heroTitle)
                    .foregroundStyle(.white)
                Text(hero.detail)
                    .font(UniverseTypography.body)
                    .foregroundStyle(Color.white.opacity(0.88))
                    .lineLimit(4)
                HStack {
                    VisibilityBadge(text: hero.tagline, isPositive: false)
                    Spacer()
                    Text("Abrir detalhe")
                        .font(UniverseTypography.caption)
                        .foregroundStyle(.white)
                }
            }
            .padding(28)
        }
        .frame(height: 280)
        .clipShape(.rect(cornerRadius: 28))
        .shadow(color: UniverseShadow.soft, radius: 26, x: 0, y: 16)
    }

    private var heroGradient: some View {
        LinearGradient(colors: [UniverseColor.accentGold, UniverseColor.accentAqua, UniverseColor.space], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct LiveBodyCard: View {
    let liveBody: LiveSkyBody

    var body: some View {
        GlassInfoCard {
            VStack(alignment: .leading, spacing: UniverseSpacing.xs) {
                HStack {
                    Text(liveBody.name)
                        .font(UniverseTypography.subtitle)
                        .foregroundStyle(UniverseColor.textPrimary)
                    Spacer()
                    VisibilityBadge(text: liveBody.visibility, isPositive: liveBody.visibility.contains("Visível"))
                }
                Text(liveBody.status)
                    .font(UniverseTypography.body)
                    .foregroundStyle(UniverseColor.textSecondary)
                Text(liveBody.detail)
                    .font(UniverseTypography.caption)
                    .foregroundStyle(UniverseColor.textSecondary)
            }
        }
    }
}

struct EventRow: View {
    let event: CosmicEvent

    var body: some View {
        GlassInfoCard {
            HStack {
                VStack(alignment: .leading) {
                    Text(event.name)
                        .font(UniverseTypography.subtitle)
                        .foregroundStyle(UniverseColor.textPrimary)
                    Text(event.detail)
                        .font(UniverseTypography.body)
                        .foregroundStyle(UniverseColor.textSecondary)
                }
                Spacer()
                Text(event.dateString)
                    .font(UniverseTypography.caption)
                    .foregroundStyle(UniverseColor.accentCyan)
            }
        }
    }
}
