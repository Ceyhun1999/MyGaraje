import SwiftUI
import SwiftData

@main
struct MyGarageApp: App {
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: Car.self)
    }
}
