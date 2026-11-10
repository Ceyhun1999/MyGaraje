
import SwiftUI

struct EditCarView: View {

    // MARK: - Data

    let car: Car

    // MARK: - ViewModel

    @State private var viewModel: EditCarViewModel
    
    @Environment(\.modelContext) private var modelContext

    // MARK: - Init

    init(car: Car) {
        self.car = car
        _viewModel = State(
            initialValue: EditCarViewModel(car: car)
        )
    }

    // MARK: - Body

    var body: some View {

        Form {

            CarPhotoView(photoData: car.photoData)
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .clipped()
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: AppTheme.Radius.button
                    )
                )
                .listRowBackground(Color.clear)

            CarSectionView(
                selectedBrand: $viewModel.selectedBrand,
                selectedModel: $viewModel.selectedModel,
                selectedYear: $viewModel.selectedYear,
                catalog: viewModel.catalog
            )

            CharacteristicsSectionView(
                selectedFuel: $viewModel.selectedFuel,
                selectedTransmission: $viewModel.selectedTransmission,
                mileage: $viewModel.mileage,
                catalog: viewModel.catalog
            )

            PrimaryButton(title: "Сохранить") {
                viewModel.saveChanges(using: modelContext)
            }
            .disabled(true)
            .padding(.top, 12)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Редактирование")
        .navigationBarTitleDisplayMode(.inline)
        .appScreenBackground()
    }
}
