import SwiftUI

struct OnboardingFlowView: View {
    let finish: () -> Void
    @State private var page = 0

    private let pages: [(title: String, body: String, symbol: String)] = [
        ("Descubra o céu ao vivo", "Veja o que está visível agora, com contexto observacional e fallback offline quando necessário.", "sparkles.rectangle.stack.fill"),
        ("Ouça o universo", "Diferencie sonificações científicas de paisagens sonoras inspiradas por dados, com transparência editorial.", "waveform.badge.mic"),
        ("Explore em 3D", "Use o viewer legado como fallback enquanto a experiência imersiva evolui para a próxima fase.", "arkit")
    ]

    var body: some View {
        ZStack {
            UniverseColor.space.ignoresSafeArea()
            VStack(spacing: UniverseSpacing.xl) {
                TabView(selection: $page) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, item in
                        VStack(spacing: UniverseSpacing.lg) {
                            Image(systemName: item.symbol)
                                .font(.system(size: 68, weight: .semibold))
                                .foregroundStyle(UniverseColor.accentCyan)
                            Text(item.title)
                                .font(UniverseTypography.heroTitle)
                                .foregroundStyle(UniverseColor.textPrimary)
                                .multilineTextAlignment(.center)
                            Text(item.body)
                                .font(UniverseTypography.body)
                                .foregroundStyle(UniverseColor.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, UniverseSpacing.lg)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))

                Button(page == pages.count - 1 ? "Entrar no TheUniverse" : "Continuar") {
                    if page == pages.count - 1 {
                        finish()
                    } else {
                        withAnimation(.easeInOut) {
                            page += 1
                        }
                    }
                }
                .font(UniverseTypography.subtitle)
                .frame(maxWidth: .infinity)
                .padding()
                .background(UniverseColor.accentCyan)
                .foregroundStyle(UniverseColor.space)
                .clipShape(.rect(cornerRadius: 18))
                .padding(.horizontal, UniverseSpacing.lg)
                .padding(.bottom, UniverseSpacing.xl)
            }
        }
    }
}
