import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class AddCarViewModel {

    var selectedBrand = ""
    var selectedModel = ""
    var selectedYear = 0
    var selectedFuel = ""
    var selectedTransmission = ""
    var mileage = ""
    
    func validate() -> String? {
        guard !selectedBrand.isEmpty else {
            return "Выберите марку автомобиля"
        }

        guard !selectedModel.isEmpty else {
            return "Выберите модель автомобиля"
            
        }

        guard selectedYear > 0 else {
            return "Выберите год выпуска"
        }

        guard !selectedFuel.isEmpty else {
            return "Выберите тип топлива"
        }

        guard !selectedTransmission.isEmpty else {
            return "Выберите коробку передач"
            
        }

        guard let mileageValue = Int(mileage),
            mileageValue >= 0
        else {
            return "Введите корректный пробег"
        }
        
        return nil
    }
}
