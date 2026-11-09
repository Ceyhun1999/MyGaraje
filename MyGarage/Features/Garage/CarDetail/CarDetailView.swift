import SwiftUI

struct CarDetailView: View {

    // MARK: - Data
    let car: Car

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("\(car.brand) \(car.model)")
                    .font(AppTheme.Fonts.title)

                CarPhotoView(photoData: car.photoData)
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .clipped()
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: AppTheme.Radius.button
                        )
                    )
                summarySection
                characteristicsSection

                historySection
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, AppTheme.Spacing.screen)
        .appScreenBackground()
    }

    // MARK: - Summary Section
    private var summarySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("ПРОБЕГ")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)

            Text("\(car.mileage.formatted()) км")
                .font(.system(size: 32, weight: .bold))

            Text(String(car.year))
                .font(.system(size: 15))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            Color(uiColor: .secondarySystemGroupedBackground),
            in: RoundedRectangle(cornerRadius: 20)
        )
    }

    // MARK: - Characteristics Section
    private var characteristicsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("ХАРАКТЕРИСТИКИ")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)

            VStack(spacing: 0) {
                HStack {
                    Text("Топливо")

                    Spacer()

                    Text(car.fuelType)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 20)
                .frame(height: 60)

                Divider()
                    .padding(.leading, 20)

                HStack {
                    Text("Трансмиссия")

                    Spacer()

                    Text(car.transmission)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 20)
                .frame(height: 60)
            }
            .font(.system(size: 17))
            .background(
                Color(uiColor: .secondarySystemGroupedBackground),
                in: RoundedRectangle(cornerRadius: 16)
            )
        }
    }

    // MARK: - History Section
    private var historySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("ИСТОРИЯ")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)

            VStack(spacing: 0) {
                HStack {
                    Text("Обслуживание")

                    Spacer()
                }
                .padding(.horizontal, 20)
                .frame(height: 74)

                Divider()
                    .padding(.leading, 20)

                HStack {
                    Text("История пробега")

                    Spacer()
                }
                .padding(.horizontal, 20)
                .frame(height: 74)
            }
            .font(.system(size: 17))
            .background(
                Color(uiColor: .secondarySystemGroupedBackground),
                in: RoundedRectangle(cornerRadius: 16)
            )
        }
    }
}

// MARK: - Preview
#Preview {
    CarDetailView(
        car: Car(
            brand: "Hyundai",
            model: "Elantra",
            year: 2020,
            fuelType: "Бензин",
            transmission: "Автомат",
            mileage: 20000
        )
    )
}
