import PhotosUI
import SwiftData
import SwiftUI

struct AddCarView: View {

    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    // MARK: - State
    @State private var viewModel = AddCarViewModel()
    @State private var selectedPhoto: PhotosPickerItem?

    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    // MARK: - Data
    private let catalog = CarCatalog()

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                PhotoSectionView(selectedPhoto: $selectedPhoto)
                CarSectionView(
                    selectedBrand: $viewModel.selectedBrand,
                    selectedModel: $viewModel.selectedModel,
                    selectedYear: $viewModel.selectedYear,
                    catalog: catalog
                )
                CharacteristicsSectionView(
                    selectedFuel: $viewModel.selectedFuel,
                    selectedTransmission: $viewModel.selectedTransmission,
                    mileage: $viewModel.mileage,
                    catalog: catalog
                )
                buttonsSection
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Новый автомобиль")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    closeButton
                }
            }
            .toolbarBackground(
                Color(uiColor: .secondarySystemBackground),
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear {
                print("Database folder:", URL.applicationSupportDirectory.path)
            }
            .alert("Проверьте данные", isPresented: $showErrorAlert) {
                Button("Понятно", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
    }

    // MARK: - Buttons Section
    private var buttonsSection: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Сохранить") {
                saveCar()
            }
        }
        .padding(.top, 12)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }

    // MARK: - Close Button
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }
        .accessibilityLabel("Закрыть")
    }

    private func saveCar() {

        if let error = viewModel.validate() {
            showError(error)
            return
        }

        guard let mileageValue = Int(viewModel.mileage) else {
            showError("Введите корректный пробег")
            return
        }

        let car = Car(
            brand: viewModel.selectedBrand,
            model: viewModel.selectedModel,
            year: viewModel.selectedYear,
            fuelType: viewModel.selectedFuel,
            transmission: viewModel.selectedTransmission,
            mileage: mileageValue
        )

        modelContext.insert(car)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.rollback()
            showError("Не удалось сохранить автомобиль")
            print("Ошибка сохранения: \(error)")
        }
    }

    // MARK: - Error Handling
    private func showError(_ message: String) {
        errorMessage = message
        showErrorAlert = true
    }
}

// MARK: - Preview
#Preview {
    AddCarView()
}
