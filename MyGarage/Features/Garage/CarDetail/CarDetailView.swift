import SwiftUI

struct CarDetailView: View {

    // MARK: - Data
    let car: Car

    // MARK: - Body
    var body: some View {
        Text("\(car.brand) \(car.model)")
    }
}
