import SwiftUI

struct PrimaryButton: View {

    // MARK: - Properties
    let title: String
    var color: Color = AppTheme.Colors.primaryBlue
    var textColor: Color = .white
    let action: () -> Void

    // MARK: - Body
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(AppTheme.Fonts.button)
                .foregroundStyle(textColor)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(color)
                .clipShape(Capsule())
        }
    }
}

// MARK: - Preview
#Preview {
    PrimaryButton(title: "Test button") {
        print("test")
    }
    .padding(AppTheme.Spacing.screen)
}
