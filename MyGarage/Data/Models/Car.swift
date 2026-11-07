import SwiftData

@Model
final class Car {
    // MARK: - Properties
    var brand: String
    var model: String
    var year: Int
    var fuelType: String
    var transmission: String
    var mileage: Int
    
    // MARK: - Initialization
    init(brand: String, model: String, year: Int, fuelType: String, transmission: String, mileage: Int) {
        self.brand = brand
        self.model = model
        self.year = year
        self.fuelType = fuelType
        self.transmission = transmission
        self.mileage = mileage
    }
}
