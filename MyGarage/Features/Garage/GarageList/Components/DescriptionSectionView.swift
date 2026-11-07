import SwiftUI

struct DescriptionSectionView: View {

    // MARK: - Body
    var body: some View {
        Text(
            "Здесь появятся пробег, ближайшее ТО, расходы и последние события."
        )
        .font(AppTheme.Fonts.body)
        .foregroundStyle(AppTheme.Colors.textSecondary)
        .multilineTextAlignment(.center)
        .lineSpacing(5)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.bottom, 16)
    }

}
