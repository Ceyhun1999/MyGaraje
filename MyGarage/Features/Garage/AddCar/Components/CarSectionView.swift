import SwiftUI

struct CarSectionView: View {
    
    // MARK: - Bindings
    @Binding var selectedBrand: String
    @Binding var selectedModel: String
    @Binding var selectedYear: Int
    
    // MARK: - Data
    let catalog: CarCatalog
   
    // MARK: - Body
    var body: some View {
        Section("Автомобиль") {

            Picker("Марка", selection: $selectedBrand) {
                Text("Выбрать").tag("")

                ForEach(catalog.brands, id: \.self) { brand in
                    Text(brand).tag(brand)
                }
            }
            .onChange(of: selectedBrand) { _, _ in
                selectedModel = ""
            }

            Picker("Модель", selection: $selectedModel) {
                Text("Выбрать").tag("")

                ForEach(catalog.models(for: selectedBrand), id: \.self) {
                    model in
                    Text(model).tag(model)
                }
            }
            .disabled(selectedBrand.isEmpty)

            Picker("Год выпуска", selection: $selectedYear) {
                Text("Выбрать").tag(0)

                ForEach(catalog.years, id: \.self) { year in
                    Text(String(year)).tag(year)
                }
            }
        }
    }
}
