import Observation
import SwiftUI
import SwiftData

@MainActor
@Observable
final class EditCarViewModel {

    let catalog = CarCatalog()
    let car: Car

    var selectedBrand: String {
        didSet {
            if oldValue != selectedBrand {
                selectedModel = ""
            }
        }
    }

    var selectedModel: String
    var selectedYear: Int
    var selectedFuel: String
    var selectedTransmission: String
    var mileage: String

    init(car: Car) {
        self.car = car
        selectedBrand = car.brand
        selectedModel = car.model
        selectedYear = car.year
        selectedFuel = car.fuelType
        selectedTransmission = car.transmission
        mileage = String(car.mileage)
    }

    func saveChanges(using modelContext: ModelContext) -> String? {
        let mileageValue: Int
        
        switch validate() {
        case .valid(let value):
            mileageValue = value
            
        case .invalid(let message):
            return message
        }
        
        car.brand = selectedBrand
        car.model = selectedModel
        car.year = selectedYear
        car.fuelType = selectedFuel
        car.transmission = selectedTransmission
        car.mileage = mileageValue
        
        do {
            try modelContext.save()
            return nil
        } catch  {
            modelContext.rollback()
            return "Не удалось сохранить изменения"
        }

    }

    func validate() -> CarValidator.ValidationResult {
        return CarValidator.validate(
            brand: selectedBrand,
            model: selectedModel,
            year: selectedYear,
            fuel: selectedFuel,
            transmission: selectedTransmission,
            mileage: mileage
        )
    }
}
