import SwiftUI

struct CharacteristicsSectionView: View {

    // MARK: - Bindings
    @Binding var selectedFuel: String
    @Binding var selectedTransmission: String
    @Binding var mileage: String

    // MARK: - Data
    let catalog: CarCatalog

    // MARK: - Body
    var body: some View {
        Section("Характеристики") {
            Picker("Топливо", selection: $selectedFuel) {
                Text("Выбрать").tag("")

                ForEach(catalog.fuelTypes, id: \.self) { fuel in
                    Text(fuel).tag(fuel)
                }
            }

            Picker("Коробка", selection: $selectedTransmission) {
                Text("Выбрать").tag("")

                ForEach(catalog.transmissionTypes, id: \.self) { transmission in
                    Text(transmission).tag(transmission)
                }
            }

            LabeledContent("Пробег") {
                TextField("0", text: $mileage)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 110)
            }
        }
    }
}
