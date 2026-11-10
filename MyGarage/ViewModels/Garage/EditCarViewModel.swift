import Observation
import SwiftUI

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
    
    init( car: Car) {
        self.car = car
        selectedBrand = car.brand
          selectedModel = car.model
          selectedYear = car.year
          selectedFuel = car.fuelType
          selectedTransmission = car.transmission
          mileage = String(car.mileage)
    }
}
