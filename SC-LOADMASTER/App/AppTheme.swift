import SwiftUI

struct AppTheme {
    // Primary Colors (based on Figma screenshots)
    static let background = Color(hex: "#2C4A4E")
    static let accent = Color(hex: "#4DD0E1")
    static let textPrimary = Color(hex: "#E0F7FA")
    static let textSecondary = Color(hex: "#80DEEA")

    // Interactive Elements
    static let inputBackground = Color(hex: "#37474F")
    static let cardBackground = Color(hex: "#1E3A3E")

    // Status Indicators
    static let containerBadgeBackground = Color.red
    static let containerBadgeText = Color.yellow

    // UI Measurements
    static let cornerRadius: CGFloat = 8
    static let inputHeight: CGFloat = 44
    static let buttonSize: CGFloat = 44
    static let cardPadding: CGFloat = 16
    static let spacing: CGFloat = 12
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
