import SwiftUI

struct CarImageView: View {

    // MARK: - Body
    var body: some View {

        Image(systemName: "car")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 70)
            .foregroundStyle(AppTheme.Colors.primaryBlue)
            .padding(.bottom, 18)

    }
}
