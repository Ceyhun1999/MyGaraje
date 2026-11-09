import SwiftUI

struct PrimaryButton: View {

    // MARK: - Properties
    let title: String

    var color: Color = AppTheme.Colors.primaryBlue
    var textColor: Color = .white
    var isLoading: Bool = false

    // MARK: - Actions
    let action: () -> Void

    // MARK: - Body
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .tint(textColor)
                }

                Text(isLoading ? "Сохранение..." : title)
                    .font(AppTheme.Fonts.button)
            }
            .foregroundStyle(textColor)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(color)
            .clipShape(Capsule())
        }
        .disabled(isLoading)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 16) {
        PrimaryButton(title: "Сохранить") {
            print("Сохранить")
        }

        PrimaryButton(
            title: "Сохранить",
            isLoading: true
        ) {}
    }
    .padding(AppTheme.Spacing.screen)
}
