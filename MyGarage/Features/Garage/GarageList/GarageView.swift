import SwiftUI
import SwiftData

struct GarageView: View {

    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext

    // MARK: - Data
    @Query private var cars: [Car]

    // MARK: - State
    @State private var viewModel = GarageListViewModel()

    @State private var showAddCar = false
    @State private var showDeleteAlert = false
    @State private var showErrorAlert = false
    @State private var pendingErrorAlert = false

    // MARK: - Body
    var body: some View {
        Group {
            if cars.isEmpty {
                EmptyGarageSectionView {
                    showAddCar = true
                }
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

        // MARK: - Delete Confirmation
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

        // MARK: - Delete Error
        .alert(
            "Не удалось удалить автомобиль",
            isPresented: $showErrorAlert
        ) {
            Button("Понятно", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage)
        }

        // MARK: - Alert Coordination
        .onChange(of: showDeleteAlert) { _, isPresented in
            if !isPresented && pendingErrorAlert {
                pendingErrorAlert = false
                showErrorAlert = true
            }
        }
    }

    // MARK: - Cars List
    private var carsListView: some View {
        CarListView(cars: cars) { car in
            viewModel.requestDelete(car)
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
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        GarageView()
    }
    .modelContainer(for: Car.self, inMemory: true)
}
