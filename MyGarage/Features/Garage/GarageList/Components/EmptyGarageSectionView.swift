import SwiftUI

struct EmptyGarageSectionView: View {

    // MARK: - Actions
    let onAddCar: () -> Void

    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 18) {
            Image(systemName: "car")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 70)
                .foregroundStyle(AppTheme.Colors.primaryBlue)
                .padding(.bottom, 18)

            Text("Ваш гараж пока пуст")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text(
                "Здесь появятся пробег, ближайшее ТО, расходы и последние события."
            )
            .font(AppTheme.Fonts.body)
            .foregroundStyle(AppTheme.Colors.textSecondary)
            .multilineTextAlignment(.center)
            .lineSpacing(5)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.bottom, 16)

            PrimaryButton(title: "Новый автомобиль") {
                onAddCar()
            }
        }
    }
}
