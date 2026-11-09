import PhotosUI
import SwiftUI

struct PhotoSectionView: View {

    // MARK: - Bindings
    @Bindable var viewModel: AddCarViewModel

    // MARK: - State
    @State private var showPhotoPicker = false

    // MARK: - Body
    var body: some View {
        Button {
            showPhotoPicker = true
        } label: {
            VStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(Color(uiColor: .systemGray5))

                    if let image = viewModel.previewImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else if viewModel.showPhotoLoader {
                        ProgressView()
                            .tint(.blue)
                    } else {
                        Image(systemName: "camera")
                            .font(.system(size: 28))
                            .foregroundStyle(.blue)
                    }
                }
                .frame(width: 80, height: 80)

                Text(photoTitle)
                    .foregroundStyle(.blue)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
        .listRowBackground(Color.clear)
        .disabled(viewModel.isSaving)
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: $viewModel.selectedPhoto,
            matching: .images
        )
        .task(id: viewModel.selectedPhoto) {
            await viewModel.loadPhotoPreview()
        }
    }

    // MARK: - Photo Title
    private var photoTitle: String {
        if viewModel.photoError != nil {
            return "Не удалось загрузить фото"
        }

        return viewModel.previewImage == nil
            ? "Добавить фото"
            : "Изменить фото"
    }
}
