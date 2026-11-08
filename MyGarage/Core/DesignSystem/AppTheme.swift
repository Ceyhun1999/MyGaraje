import SwiftUI

enum AppTheme {

    // MARK: - Colors
    enum Colors {
        static let primaryBlue = Color(red: 0.02, green: 0.55, blue: 1.0)
        static let deepBlue = Color(red: 0.04, green: 0.30, blue: 0.95)
        static let lightBlue = Color(red: 0.88, green: 0.93, blue: 1.0)

        static let background = Color(uiColor: .secondarySystemBackground)
        static let surface = Color(uiColor: .systemBackground)

        static let textPrimary = Color.primary
        static let textSecondary = Color.secondary
    }

    // MARK: - Gradients
    enum Gradients {
        static let primaryButton = LinearGradient(
            colors: [
                Colors.primaryBlue,
                Colors.deepBlue
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // MARK: - Fonts
    enum Fonts {
        static let title = Font.system(size: 29, weight: .bold)
        static let body = Font.system(size: 16, weight: .regular)
        static let button = Font.system(size: 17, weight: .semibold)
        static let caption = Font.system(size: 13, weight: .regular)
    }

    // MARK: - Spacing
    enum Spacing {
        static let screen: CGFloat = 20
        static let section: CGFloat = 24
        static let item: CGFloat = 12
    }

    // MARK: - Radius
    enum Radius {
        static let card: CGFloat = 24
        static let button: CGFloat = 27
    }
}
