import PhotosUI
import SwiftUI

struct PhotoSectionView: View {

    // MARK: - Bindings
    @Binding var selectedPhoto: PhotosPickerItem?

    // MARK: - Body
    var body: some View {
        PhotosPicker(
            selection: $selectedPhoto,
            matching: .images
        ) {
            VStack(spacing: 10) {
                Image(systemName: "camera")
                    .font(.system(size: 28))
                    .foregroundStyle(.blue)
                    .frame(width: 80, height: 80)
                    .background(
                        Color(uiColor: .systemGray5),
                        in: Circle()
                    )

                Text("Добавить фото")
                    .foregroundStyle(.blue)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
        .listRowBackground(Color.clear)
    }
}
