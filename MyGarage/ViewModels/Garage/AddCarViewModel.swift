import Observation
import PhotosUI
import SwiftData
import SwiftUI
import UIKit

@MainActor
@Observable
final class AddCarViewModel {

    // MARK: - Types
    enum ValidationResult {
        case valid(mileage: Int)
        case invalid(String)
    }

    // MARK: - Data
    let catalog = CarCatalog()

    // MARK: - State
    private(set) var isSaving = false

    var selectedBrand = ""
    var selectedModel = ""
    var selectedYear = 0
    var selectedFuel = ""
    var selectedTransmission = ""
    var mileage = ""

    // MARK: - Actions
    func saveCar(
        using modelContext: ModelContext,
        selectedPhoto: PhotosPickerItem?
    ) async -> String? {
        guard !isSaving else {
            return "Сохранение уже выполняется"
        }

        isSaving = true
        defer {
            isSaving = false
        }

        let mileageValue: Int

        switch validate() {
        case .valid(let value):
            mileageValue = value

        case .invalid(let message):
            return message
        }

        // Load and compress the selected photo.
        var photoData: Data?

        if let selectedPhoto {
            do {
                guard
                    let data = try await selectedPhoto.loadTransferable(
                        type: Data.self
                    ),
                    let image = UIImage(data: data),
                    let compressedData = image.jpegData(
                        compressionQuality: 0.75
                    )
                else {
                    return "Не удалось загрузить фотографию"
                }

                photoData = compressedData
            } catch {
                print("Ошибка загрузки фотографии: \(error)")
                return "Не удалось загрузить фотографию"
            }
        }

        let car = Car(
            brand: selectedBrand,
            model: selectedModel,
            year: selectedYear,
            fuelType: selectedFuel,
            transmission: selectedTransmission,
            mileage: mileageValue
        )

        car.photoData = photoData

        modelContext.insert(car)

        do {
            try modelContext.save()
            return nil
        } catch {
            modelContext.rollback()
            print("Ошибка сохранения автомобиля: \(error)")
            return "Не удалось сохранить автомобиль"
        }
    }

    // MARK: - Validation
    func validate() -> ValidationResult {
        guard !selectedBrand.isEmpty else {
            return .invalid("Выберите марку автомобиля")
        }

        guard !selectedModel.isEmpty else {
            return .invalid("Выберите модель автомобиля")
        }

        guard selectedYear > 0 else {
            return .invalid("Выберите год выпуска")
        }

        guard !selectedFuel.isEmpty else {
            return .invalid("Выберите тип топлива")
        }

        guard !selectedTransmission.isEmpty else {
            return .invalid("Выберите коробку передач")
        }

        guard let mileageValue = Int(mileage),
            mileageValue >= 0
        else {
            return .invalid("Введите корректный пробег")
        }

        return .valid(mileage: mileageValue)
    }
}
