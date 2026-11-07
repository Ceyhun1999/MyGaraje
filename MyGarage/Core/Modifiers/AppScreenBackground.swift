
import SwiftUI

struct AppScreenBackground: ViewModifier {

    // MARK: - Properties
    var horizontalPadding: CGFloat = AppTheme.Spacing.screen

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, horizontalPadding)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                AppTheme.Colors.background
                    .ignoresSafeArea()
            )
    }
}

extension View {

    // MARK: - Screen Background
    func appScreenBackground(
        horizontalPadding: CGFloat = AppTheme.Spacing.screen
    ) -> some View {
        modifier(
            AppScreenBackground(
                horizontalPadding: horizontalPadding
            )
        )
    }
}
