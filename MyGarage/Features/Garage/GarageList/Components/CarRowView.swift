import SwiftUI

struct CarRowView: View {

    // MARK: - Data
    let title: String
    let model: String
    let year: Int
    let mileage: Int
    let imageName: String

    // MARK: - Body
    var body: some View {
        HStack(spacing: 12) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 5) {
                Text("\(title) \(model)")
                    .font(.system(size: 17, weight: .semibold))

                Text("\(String(year)) · \(mileage.formatted()) км")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview
#Preview {
    CarRowView(
        title: "BMW",
        model: "320i",
        year: 2020,
        mileage: 48250,
        imageName: "carImage"
    )
    .padding()
}
