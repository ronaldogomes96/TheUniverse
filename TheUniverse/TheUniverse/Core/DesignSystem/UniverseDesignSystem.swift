import SwiftUI
import UIKit

enum UniverseSpacing {
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
}

enum UniverseTypography {
    static let heroTitle = Font.system(size: 34, weight: .bold, design: .rounded)
    static let sectionTitle = Font.system(size: 22, weight: .bold, design: .rounded)
    static let subtitle = Font.system(size: 16, weight: .semibold, design: .rounded)
    static let body = Font.system(size: 15, weight: .regular, design: .rounded)
    static let caption = Font.system(size: 12, weight: .medium, design: .rounded)
}

enum UniverseColor {
    static let space = Color(red: 0.03, green: 0.05, blue: 0.12)
    static let card = Color(red: 0.09, green: 0.11, blue: 0.17)
    static let glass = Color.white.opacity(0.08)
    static let accentCyan = Color(red: 0.34, green: 0.94, blue: 0.86)
    static let accentGold = Color(red: 1.0, green: 0.78, blue: 0.20)
    static let accentAqua = Color(red: 0.46, green: 0.85, blue: 0.86)
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.72)
}

enum UniverseShadow {
    static let soft = Color.black.opacity(0.35)
}

enum UniverseMotion {
    static let standard = Animation.easeInOut(duration: 0.28)
    static let slowFloat = Animation.easeInOut(duration: 4).repeatForever(autoreverses: true)
}

struct GlassInfoCard<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(UniverseSpacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(UniverseColor.card.opacity(0.88))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
            )
            .shadow(color: UniverseShadow.soft, radius: 18, x: 0, y: 12)
    }
}

struct SectionHeader: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(UniverseTypography.sectionTitle)
                .foregroundStyle(UniverseColor.textPrimary)
            Text(subtitle)
                .font(UniverseTypography.body)
                .foregroundStyle(UniverseColor.textSecondary)
        }
    }
}

struct QuickFactChip: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(UniverseTypography.subtitle)
                .foregroundStyle(UniverseColor.textPrimary)
            Text(title)
                .font(UniverseTypography.caption)
                .foregroundStyle(UniverseColor.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(UniverseSpacing.sm)
        .background(Color.white.opacity(0.06))
        .clipShape(.rect(cornerRadius: 14))
    }
}

struct VisibilityBadge: View {
    let text: String
    let isPositive: Bool

    var body: some View {
        Text(text)
            .font(UniverseTypography.caption)
            .foregroundStyle(isPositive ? UniverseColor.space : UniverseColor.textPrimary)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(isPositive ? UniverseColor.accentCyan : Color.white.opacity(0.12))
            .clipShape(Capsule())
    }
}

struct ParallaxHeader: View {
    let title: String
    let subtitle: String
    let imageURL: URL?

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                if let imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().scaledToFill()
                        default:
                            LinearGradient(colors: [UniverseColor.accentGold, UniverseColor.accentAqua], startPoint: .topLeading, endPoint: .bottomTrailing)
                        }
                    }
                } else {
                    LinearGradient(colors: [UniverseColor.accentGold, UniverseColor.accentAqua], startPoint: .topLeading, endPoint: .bottomTrailing)
                }
            }
            LinearGradient(colors: [.clear, .black.opacity(0.78)], startPoint: .center, endPoint: .bottom)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(UniverseTypography.heroTitle)
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(UniverseTypography.body)
                    .foregroundStyle(Color.white.opacity(0.88))
            }
            .padding(UniverseSpacing.lg)
        }
        .frame(height: 260)
        .clipShape(.rect(cornerRadius: 28))
        .shadow(color: UniverseShadow.soft, radius: 24, x: 0, y: 14)
    }
}

struct SkeletonCard: View {
    let height: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.white.opacity(0.07))
            .frame(height: height)
            .redacted(reason: .placeholder)
    }
}
