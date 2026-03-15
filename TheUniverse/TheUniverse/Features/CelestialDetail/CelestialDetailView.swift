import AVFoundation
import SwiftUI

struct CelestialDetailView: View {
    @ObservedObject var viewModel: CelestialDetailViewModel
    let openLegacy3D: (CelestialBodyID) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: UniverseSpacing.lg) {
                if let detail = viewModel.detail {
                    detailHeader(detail)
                    nowSection(detail)
                    audioSection(detail)
                    explore3DSection(detail)
                    learnSection(detail)
                    gallerySection(detail)
                    missionsSection(detail)
                    comparisonSection
                } else {
                    SkeletonCard(height: 220)
                    SkeletonCard(height: 140)
                    SkeletonCard(height: 220)
                }
            }
            .padding(UniverseSpacing.lg)
        }
        .background(UniverseColor.space.ignoresSafeArea())
        .navigationTitle(viewModel.bodyID.displayName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: viewModel.toggleFavorite) {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(UniverseColor.accentGold)
                }
            }
        }
        .task { await viewModel.load() }
    }

    private func detailHeader(_ detail: CelestialDetail) -> some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            ParallaxHeader(title: detail.body.displayName, subtitle: detail.body.subtitle, imageURL: detail.heroMedia?.imageURL)
            GlassInfoCard {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: UniverseSpacing.sm) {
                    ForEach(detail.quickFacts) { fact in
                        QuickFactChip(title: fact.label, value: fact.value)
                    }
                }
            }
        }
    }

    private func nowSection(_ detail: CelestialDetail) -> some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            SectionHeader(title: "Agora", subtitle: "Contexto observacional dinâmico")
            GlassInfoCard {
                if let snapshot = detail.liveSnapshot {
                    VStack(alignment: .leading, spacing: UniverseSpacing.sm) {
                        HStack {
                            VisibilityBadge(text: snapshot.isVisible ? "Visível agora" : "Abaixo do horizonte", isPositive: snapshot.isVisible)
                            if snapshot.isStale {
                                VisibilityBadge(text: "Última atualização", isPositive: false)
                            }
                        }
                        Text(snapshot.phaseDescription ?? "Sem fase definida")
                            .font(UniverseTypography.body)
                            .foregroundStyle(UniverseColor.textPrimary)
                        Text("Distância da Terra: \(snapshot.distanceFromEarth ?? "estimativa indisponível")")
                            .font(UniverseTypography.caption)
                            .foregroundStyle(UniverseColor.textSecondary)
                        Text("Fonte: \(snapshot.source)")
                            .font(UniverseTypography.caption)
                            .foregroundStyle(UniverseColor.textSecondary)
                    }
                } else {
                    Text("Os dados ao vivo ainda não foram sincronizados para este corpo.")
                        .font(UniverseTypography.body)
                        .foregroundStyle(UniverseColor.textSecondary)
                }
            }
        }
    }

    private func audioSection(_ detail: CelestialDetail) -> some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            SectionHeader(title: "Ouça este mundo", subtitle: "Sonificação científica ou paisagem inspirada por dados")
            if let audio = detail.audioExperience {
                AudioMiniPlayer(experience: audio)
            }
        }
    }

    private func explore3DSection(_ detail: CelestialDetail) -> some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            SectionHeader(title: "Explore em 3D", subtitle: "Mantenha o viewer legado como fallback durante a migração")
            Button {
                openLegacy3D(detail.body)
            } label: {
                GlassInfoCard {
                    HStack {
                        Image(systemName: "arkit")
                            .font(.title2)
                        VStack(alignment: .leading) {
                            Text("Abrir viewer 3D")
                                .font(UniverseTypography.subtitle)
                            Text(detail.body.modelTextureName == nil ? "Modelo 3D indisponível para este corpo" : "Usar a experiência atual como fallback")
                                .font(UniverseTypography.caption)
                                .foregroundStyle(UniverseColor.textSecondary)
                        }
                        Spacer()
                    }
                }
            }
            .buttonStyle(.plain)
            .disabled(detail.body.modelTextureName == nil)
        }
    }

    private func learnSection(_ detail: CelestialDetail) -> some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            SectionHeader(title: "Aprenda", subtitle: "Conteúdo curado para uso offline")
            ForEach(detail.sections) { section in
                GlassInfoCard {
                    VStack(alignment: .leading, spacing: UniverseSpacing.sm) {
                        Text(section.title)
                            .font(UniverseTypography.subtitle)
                            .foregroundStyle(UniverseColor.textPrimary)
                        Text(section.body)
                            .font(UniverseTypography.body)
                            .foregroundStyle(UniverseColor.textSecondary)
                    }
                }
            }
        }
    }

    private func gallerySection(_ detail: CelestialDetail) -> some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            SectionHeader(title: "Galeria", subtitle: "Mídia remota com cache incremental")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: UniverseSpacing.md) {
                    ForEach(detail.gallery) { asset in
                        AsyncImage(url: asset.thumbnailURL ?? asset.imageURL) { phase in
                            ZStack(alignment: .bottomLeading) {
                                switch phase {
                                case .success(let image):
                                    image.resizable().scaledToFill()
                                default:
                                    UniverseColor.card
                                }
                                LinearGradient(colors: [.clear, .black.opacity(0.75)], startPoint: .center, endPoint: .bottom)
                                Text(asset.title)
                                    .font(UniverseTypography.caption)
                                    .foregroundStyle(.white)
                                    .padding(12)
                            }
                        }
                        .frame(width: 220, height: 160)
                        .clipShape(.rect(cornerRadius: 20))
                    }
                }
            }
        }
    }

    private func missionsSection(_ detail: CelestialDetail) -> some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            SectionHeader(title: "Como aprendemos isso", subtitle: "Missões e instrumentos relacionados")
            ForEach(detail.relatedMissions) { mission in
                GlassInfoCard {
                    VStack(alignment: .leading, spacing: UniverseSpacing.xs) {
                        Text(mission.name)
                            .font(UniverseTypography.subtitle)
                            .foregroundStyle(UniverseColor.textPrimary)
                        Text(mission.summary)
                            .font(UniverseTypography.body)
                            .foregroundStyle(UniverseColor.textSecondary)
                    }
                }
            }
        }
    }

    private var comparisonSection: some View {
        VStack(alignment: .leading, spacing: UniverseSpacing.md) {
            SectionHeader(title: "Comparar", subtitle: "Diferenças rápidas com outro corpo relevante")
            if let comparison = viewModel.comparison {
                GlassInfoCard {
                    VStack(alignment: .leading, spacing: UniverseSpacing.sm) {
                        Text("\(comparison.lhs.displayName) vs \(comparison.rhs.displayName)")
                            .font(UniverseTypography.subtitle)
                            .foregroundStyle(UniverseColor.textPrimary)
                        ForEach(comparison.metrics) { metric in
                            Text("• \(metric.value)")
                                .font(UniverseTypography.caption)
                                .foregroundStyle(UniverseColor.textSecondary)
                        }
                    }
                }
            }
        }
    }
}

struct AudioMiniPlayer: View {
    let experience: AudioExperience
    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false

    var body: some View {
        GlassInfoCard {
            VStack(alignment: .leading, spacing: UniverseSpacing.sm) {
                HStack {
                    Text(experience.title)
                        .font(UniverseTypography.subtitle)
                        .foregroundStyle(UniverseColor.textPrimary)
                    Spacer()
                    Text(experience.kind == .scientificSonification ? "Sonificação científica" : "Inspirado por dados")
                        .font(UniverseTypography.caption)
                        .foregroundStyle(UniverseColor.accentCyan)
                }
                Text(experience.description)
                    .font(UniverseTypography.body)
                    .foregroundStyle(UniverseColor.textSecondary)
                Text("Atribuição: \(experience.attribution)")
                    .font(UniverseTypography.caption)
                    .foregroundStyle(UniverseColor.textSecondary)
                HStack {
                    Button(isPlaying ? "Pausar" : "Ouvir") {
                        togglePlayback()
                    }
                    .buttonStyle(.borderedProminent)
                    Text(Duration.seconds(experience.duration).formatted(.time(pattern: .minuteSecond)))
                        .font(UniverseTypography.caption)
                        .foregroundStyle(UniverseColor.textSecondary)
                }
            }
        }
    }

    private func togglePlayback() {
        if isPlaying {
            player?.stop()
            isPlaying = false
            return
        }

        player = try? AVAudioPlayer(contentsOf: experience.audioURL)
        player?.play()
        isPlaying = true
    }
}
