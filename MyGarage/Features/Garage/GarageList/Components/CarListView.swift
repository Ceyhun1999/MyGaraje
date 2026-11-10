import SwiftUI
import SwiftData

struct CarListView: View {

    @Environment(AppRouter.self) private var router

    // MARK: - Data
    let cars: [Car]

    // MARK: - Actions
    let onDelete: (Car) -> Void

    // MARK: - Body
    var body: some View {
        List {
            Section("Мои автомобили") {
                ForEach(cars) { car in
                    Button {
                        router.push(.carDetail(car.persistentModelID))
                    } label: {
                        CarRowView(
                            brand: car.brand,
                            model: car.model,
                            year: car.year,
                            mileage: car.mileage,
                            photoData: car.photoData
                        )
                    }
                    .buttonStyle(.plain)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            onDelete(car)
                        } label: {
                            Label("Удалить", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .contentMargins(.horizontal, 1, for: .scrollContent)
        .scrollIndicators(.hidden)
    }
}
