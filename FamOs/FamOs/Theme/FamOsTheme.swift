import SwiftUI

enum FamOsTheme {
    // MARK: - Primary Colors
    static let primaryIndigo = Color(hex: "2D4A8A")
    static let primaryLight = Color(hex: "D6E2F5")
    static let primary = Color(hex: "103272")

    // MARK: - Accent Colors
    static let accentCoral = Color(hex: "E8724A")
    static let semanticPositive = Color(hex: "3AA876")
    static let semanticPositiveBg = Color(hex: "E8F5F0")
    static let memberMiel = Color(hex: "F5C842")

    // MARK: - Neutral Colors
    static let brandDark = Color(hex: "2A2520")
    static let neutralGrey = Color(hex: "8A8480")
    static let onSurface = Color(hex: "1E1B18")

    // MARK: - Surface Colors
    static let background = Color(hex: "F6F4F0")
    static let surface = Color.white
    static let surfaceContainerLow = Color(hex: "FAF2ED")
    static let surfaceContainer = Color(hex: "F5ECE7")
    static let surfaceContainerHigh = Color(hex: "EFE7E2")
    static let elevatedSection = Color(hex: "ECEAE6")
    static let outlineVariant = Color(hex: "C4C6D2")

    // MARK: - Semantic Colors
    static let error = Color(hex: "BA1A1A")
    static let errorContainer = Color(hex: "FFDAD6")
    static let secondaryFixed = Color(hex: "FFDBD0")
    static let secondary = Color(hex: "A23E1B")

    // MARK: - Corner Radius
    static let radiusSmall: CGFloat = 12
    static let radiusMedium: CGFloat = 16
    static let radiusLarge: CGFloat = 20
    static let radiusFull: CGFloat = 999

    // MARK: - Spacing
    static let spacingXS: CGFloat = 4
    static let spacingSM: CGFloat = 8
    static let spacingMD: CGFloat = 12
    static let spacingLG: CGFloat = 16
    static let spacingXL: CGFloat = 24
    static let spacingXXL: CGFloat = 32
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = ((int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
