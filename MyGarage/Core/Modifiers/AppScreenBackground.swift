import SwiftUI

struct AppScreenBackground: ViewModifier {

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                AppTheme.Colors.background
                    .ignoresSafeArea()
            )
    }
}

extension View {

    // MARK: - Screen Background
    func appScreenBackground() -> some View {
        modifier(AppScreenBackground())
    }
}
