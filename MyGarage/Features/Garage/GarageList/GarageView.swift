import SwiftData
import SwiftUI

struct GarageView: View {

    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext
    @Environment(AppRouter.self) private var router

    // MARK: - Data
    @Query private var cars: [Car]

    // MARK: - State
    @State private var viewModel = GarageListViewModel()

    @State private var showDeleteAlert = false
    @State private var showErrorAlert = false
    @State private var pendingErrorAlert = false

    // MARK: - Body
    var body: some View {
        Group {
            if cars.isEmpty {
                EmptyGarageSectionView {
                    router.isAddingCar = true
                }
            } else {
                carsListView
            }
        }
        .padding(
            .horizontal,
            cars.isEmpty
                ? AppTheme.Spacing.screen
                : AppTheme.Spacing.screen - 1
        )
        .appScreenBackground()
        .navigationTitle("Мой гараж")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                addCarButton
            }
        }

        // Delete Confirmation
        .alert("Удалить автомобиль?", isPresented: $showDeleteAlert) {
            Button("Отмена", role: .cancel) {
                viewModel.cancelDelete()
            }

            Button("Удалить", role: .destructive) {
                let isDeleted = viewModel.deleteCar(
                    using: modelContext
                )

                if !isDeleted {
                    pendingErrorAlert = true
                }
            }
        }

        // Delete Error
        .alert(
            "Не удалось удалить автомобиль",
            isPresented: $showErrorAlert
        ) {
            Button("Понятно", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage)
        }

        // Alert Coordination
        .onChange(of: showDeleteAlert) { _, isPresented in
            if !isPresented && pendingErrorAlert {
                pendingErrorAlert = false
                showErrorAlert = true
            }
        }
    }

    // MARK: - Add Car Button
    private var addCarButton: some View {
        Button {
            router.isAddingCar = true
        } label: {
            Image(systemName: "plus")
        }
        .tint(AppTheme.Colors.primaryBlue)
    }

    // MARK: - Cars List
    private var carsListView: some View {
        CarListView(cars: cars) { car in
            viewModel.requestDelete(car)
            showDeleteAlert = true
        }
    }
}

// MARK: - Preview
#Preview {
    AppNavigationStack {
        GarageView()
    }
    .modelContainer(for: Car.self, inMemory: true)
}
