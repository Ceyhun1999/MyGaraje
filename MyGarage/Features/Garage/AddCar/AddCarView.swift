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

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                PhotoSectionView(
                    selectedPhoto: $selectedPhoto
                )

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
            .alert(
                "Проверьте данные",
                isPresented: $showErrorAlert
            ) {
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
                Task {
                    await saveCar()
                }
            }
            .disabled(viewModel.isSaving)
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
    @MainActor
    private func saveCar() async {
        if let error = await viewModel.saveCar(
            using: modelContext,
            selectedPhoto: selectedPhoto
        ) {
            showError(error)
            return
        }

        dismiss()
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
