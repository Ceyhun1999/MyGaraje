import Foundation

struct CarCatalog {

    // MARK: - Data
    private var modelsByBrand: [String: [String]] = [:]

    // MARK: - Years
    var years: [Int] {
        Array(
            (1980...Calendar.current.component(.year, from: Date()))
                .reversed()
        )
    }

    // MARK: - Fuel Types
    let fuelTypes: [String] = [
        "Бензин",
        "Дизель",
        "Гибрид",
        "Электро",
        "Газ",
    ]

    // MARK: - Transmissions
    let transmissionTypes: [String] = [
        "Автомат",
        "Механика",
        "Робот",
        "Вариатор",
    ]

    // MARK: - Initialization
    init() {
        guard
            let url = Bundle.main.url(
                forResource: "cars",
                withExtension: "json"
            )
        else {
            print("Файл cars.json не найден")
            modelsByBrand = [:]
            return
        }

        do {
            let data = try Data(contentsOf: url)

            modelsByBrand = try JSONDecoder().decode(
                [String: [String]].self,
                from: data
            )
            
            print("Загружено марок: \(modelsByBrand.count)")

        } catch {
            print("Ошибка загрузки каталога: \(error)")
        }
    }
    
    // MARK: - Brands
    var brands: [String] {
        modelsByBrand.keys.sorted()
    }
    
    // MARK: - Models
    func models(for brand: String) -> [String] {
        (modelsByBrand[brand] ?? []).sorted()
    }
}
