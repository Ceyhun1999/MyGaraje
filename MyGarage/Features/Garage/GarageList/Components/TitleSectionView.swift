import SwiftUI

struct TitleSectionView: View {

    // MARK: - Body
    var body: some View {

        Text("Ваш гараж пока пуст")
            .font(.system(size: 28, weight: .bold, design: .rounded))
            .foregroundStyle(AppTheme.Colors.textPrimary)
            .multilineTextAlignment(.center)

    }
}
