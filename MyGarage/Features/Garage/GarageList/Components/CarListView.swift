import SwiftUI

struct CarListView: View {

    // MARK: - Data
    let cars: [Car]

    // MARK: - Actions
    let onDelete: (Car) -> Void

    // MARK: - Body
    var body: some View {
        List {
            Section("Мои автомобили") {
                ForEach(cars) { car in
                    NavigationLink {
                        CarDetailView(car: car)
                    } label: {
                        CarRowView(
                            title: car.brand,
                            model: car.model,
                            year: car.year,
                            mileage: car.mileage,
                            photoData: car.photoData
                        )
                    }
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
    }
}
