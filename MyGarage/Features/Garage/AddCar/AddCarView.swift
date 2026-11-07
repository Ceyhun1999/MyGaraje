import PhotosUI
import SwiftData
import SwiftUI

struct AddCarView: View {

    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    // MARK: - State
    @State private var selectedPhoto: PhotosPickerItem?
    
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    @State private var selectedBrand = ""
    @State private var selectedModel = ""
    @State private var selectedYear = 0

    @State private var selectedFuel = ""
    @State private var selectedTransmission = ""

    @State private var mileage = ""

    // MARK: - Data
    private let catalog = CarCatalog()

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                PhotoSectionView(selectedPhoto: $selectedPhoto)
                CarSectionView(
                    selectedBrand: $selectedBrand,
                    selectedModel: $selectedModel,
                    selectedYear: $selectedYear,
                    catalog: catalog
                )
                CharacteristicsSectionView(
                    selectedFuel: $selectedFuel,
                    selectedTransmission: $selectedTransmission,
                    mileage: $mileage,
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

    // MARK: - Actions
    private func saveCar() {
        guard !selectedBrand.isEmpty else {
            showError("Выберите марку автомобиля")
            return
        }

        guard !selectedModel.isEmpty else {
            showError("Выберите модель автомобиля")
            return
        }

        guard selectedYear > 0 else {
            showError("Выберите год выпуска")
            return
        }

        guard !selectedFuel.isEmpty else {
            showError("Выберите тип топлива")
            return
        }

        guard !selectedTransmission.isEmpty else {
            showError("Выберите коробку передач")
            return
        }

        guard let mileageValue = Int(mileage),
              mileageValue >= 0 else {
            showError("Введите корректный пробег")
            return
        }

        let car = Car(
            brand: selectedBrand,
            model: selectedModel,
            year: selectedYear,
            fuelType: selectedFuel,
            transmission: selectedTransmission,
            mileage: mileageValue
        )

        modelContext.insert(car)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.rollback()
            showError("Не удалось сохранить автомобиль")
            print("Ошибка сохранения автомобиля: \(error)")
        }
    }

    
    private func showError(_ message: String) {
        errorMessage = message
        showErrorAlert = true
    }

}

// MARK: - Preview
#Preview {
    AddCarView()
}
