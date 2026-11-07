import SwiftData
import SwiftUI

struct GarageView: View {

    // MARK: - Data
    @Query private var cars: [Car]

    // MARK: - State
    @State private var showAddCar: Bool = false
    @State private var carToDelete: Car?
    @State private var showDeleteAlert = false

    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext

    // MARK: - Body
    var body: some View {
        Group {
            if cars.isEmpty {
                emptyGarageView
            } else {
                carsListView
            }
        }
        .sheet(isPresented: $showAddCar) {
            AddCarView()
        }
        .appScreenBackground(
            horizontalPadding: cars.isEmpty
                ? AppTheme.Spacing.screen
                : AppTheme.Spacing.screen - 1
        )
        .navigationTitle("Мой гараж")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Cars List
    private var carsListView: some View {

        CarListView(cars: cars) { car in
            carToDelete = car
            showDeleteAlert = true
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddCar = true
                } label: {
                    Image(systemName: "plus")
                }
                .tint(AppTheme.Colors.primaryBlue)
            }
        }
        .alert("Удалить автомобиль?", isPresented: $showDeleteAlert) {
            Button("Отмена", role: .cancel) {}

            Button("Удалить", role: .destructive) {
                if let car = carToDelete {
                    deleteCar(car)
                }
            }
        }
    }

    // MARK: - Empty Garage
    private var emptyGarageView: some View {
        VStack(alignment: .center, spacing: 18) {
            CarImageView()
            TitleSectionView()
            DescriptionSectionView()
            addCarButton
        }
    }

    // MARK: - Add Car Button
    private var addCarButton: some View {
        PrimaryButton(title: "Новый автомобиль") {
            showAddCar = true
        }
    }

    // MARK: - Actions
    private func deleteCar(_ car: Car) {
        modelContext.delete(car)

        do {
            try modelContext.save()
        } catch {
            modelContext.rollback()
            print("Ошибка удаления автомобиля: \(error)")
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        GarageView()
    }
}
