enum CarValidator {

    enum ValidationResult {
        case valid(mileage: Int)
        case invalid(String)
    }

    static func validate(
        brand: String,
        model: String,
        year: Int,
        fuel: String,
        transmission: String,
        mileage: String
    ) -> ValidationResult {
        guard !brand.isEmpty else {
            return .invalid("Выберите марку автомобиля")
        }

        guard !model.isEmpty else {
            return .invalid("Выберите модель автомобиля")
        }

        guard year > 0 else {
            return .invalid("Выберите год выпуска")
        }

        guard !fuel.isEmpty else {
            return .invalid("Выберите тип топлива")
        }

        guard !transmission.isEmpty else {
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
