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

    // MARK: - Form State
    private(set) var isSaving = false

    var selectedBrand = "" {
        didSet {
            if oldValue != selectedBrand {
                selectedModel = ""
            }
        }
    }

    var selectedModel = ""
    var selectedYear = 0
    var selectedFuel = ""
    var selectedTransmission = ""
    var mileage = ""

    // MARK: - Photo State
    var selectedPhoto: PhotosPickerItem? {
        didSet {
            guard oldValue != selectedPhoto else {
                return
            }

            previewImage = nil
            photoData = nil
            photoError = nil
            isLoadingPhoto = selectedPhoto != nil
            showPhotoLoader = false
        }
    }

    private(set) var previewImage: UIImage?
    private(set) var isLoadingPhoto = false
    private(set) var showPhotoLoader = false
    private(set) var photoError: String?

    private var photoData: Data?

    // MARK: - Save Car
    func saveCar(using modelContext: ModelContext) -> String? {
        guard !isSaving else {
            return "Сохранение уже выполняется"
        }

        guard !isLoadingPhoto else {
            return "Дождитесь загрузки фотографии"
        }

        if selectedPhoto != nil && photoData == nil {
            return photoError ?? "Не удалось загрузить фотографию"
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
            print("Ошибка сохранения: \(error)")
            return "Не удалось сохранить автомобиль"
        }
    }

    // MARK: - Photo Loading
    func loadPhotoPreview() async {
        guard let selectedPhoto else {
            previewImage = nil
            photoData = nil
            photoError = nil
            isLoadingPhoto = false
            showPhotoLoader = false
            return
        }

        previewImage = nil
        photoData = nil
        photoError = nil
        isLoadingPhoto = true
        showPhotoLoader = false

        // Показать loader только через 200 мс.
        let loaderTask = Task { [weak self] in
            do {
                try await Task.sleep(for: .milliseconds(200))
            } catch {
                return
            }

            guard !Task.isCancelled,
                let self,
                self.selectedPhoto == selectedPhoto
            else {
                return
            }

            self.showPhotoLoader = true
        }

        defer {
            loaderTask.cancel()

            if self.selectedPhoto == selectedPhoto {
                isLoadingPhoto = false
                showPhotoLoader = false
            }
        }

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
                guard !Task.isCancelled,
                    self.selectedPhoto == selectedPhoto
                else {
                    return
                }

                photoError = "Не удалось загрузить фотографию"
                return
            }

            // Не применяем результат старой загрузки.
            guard !Task.isCancelled,
                self.selectedPhoto == selectedPhoto
            else {
                return
            }

            previewImage = image
            photoData = compressedData
        } catch {
            guard !Task.isCancelled,
                self.selectedPhoto == selectedPhoto
            else {
                return
            }

            photoError = "Не удалось загрузить фотографию"
            print("Ошибка загрузки фото: \(error)")
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
