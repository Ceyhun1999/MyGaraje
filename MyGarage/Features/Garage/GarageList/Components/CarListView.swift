import SwiftUI

struct CarListView: View {

    // MARK: - Data
    let cars: [Car]
    let onDelete: (Car) -> Void

    // MARK: - Body
    var body: some View {
        List {
            Section("Мои автомобили") {
                ForEach(cars) { car in
                    NavigationLink {
                        Text("\(car.brand) \(car.model)")
                    } label: {
                        CarRowView(
                            title: car.brand,
                            model: car.model,
                            year: car.year,
                            mileage: car.mileage,
                            imageName: "carImage"
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
