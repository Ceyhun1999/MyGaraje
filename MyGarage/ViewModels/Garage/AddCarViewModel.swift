import Foundation
import Observation
import SwiftData

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
    var selectedBrand = ""
    var selectedModel = ""
    var selectedYear = 0
    var selectedFuel = ""
    var selectedTransmission = ""
    var mileage = ""

    // MARK: - Actions
    func saveCar(using modelContext: ModelContext) -> String? {
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
