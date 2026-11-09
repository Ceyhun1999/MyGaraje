import SwiftUI

struct CarPhotoView: View {

    // MARK: - Data
    let photoData: Data?

    // MARK: - Body
    var body: some View {
        Group {
            if let photoData,
                let image = UIImage(data: photoData)
            {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Image("carPlaceholder")
                    .resizable()
                    .scaledToFill()
            }
        }
    }
}
