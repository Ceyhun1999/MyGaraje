import PhotosUI
import SwiftData
import SwiftUI

struct AddCarView: View {

    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    // MARK: - State
    @State private var selectedPhoto: PhotosPickerItem?

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
            print("Brend secin")
            return
        }

        guard !selectedModel.isEmpty else {
            print("Model secin")
            return
        }

        guard selectedYear > 0 else {
            print("Il secin")
            return
        }

        guard !selectedFuel.isEmpty else {
            print("Yanacaq novunu secin")
            return
        }

        guard !selectedTransmission.isEmpty else {
            print("Karabka novunu secin")
            return
        }

        guard let mileageValue = Int(mileage),
            mileageValue >= 0
        else {
            print("Введите корректный пробег")
            return
        }

        let car = Car(
            brand: selectedBrand,
            model: selectedModel,
            year: selectedYear,
            fuelType: selectedFuel,
            transmission: selectedTransmission,
            mileage: mileageValue,

        )

        modelContext.insert(car)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.rollback()
            print("Ошибка сохранения автомобиля: \(error)")
        }
    }

}

// MARK: - Preview
#Preview {
    AddCarView()
}
