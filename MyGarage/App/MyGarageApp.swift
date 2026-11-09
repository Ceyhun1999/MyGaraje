import SwiftData
import SwiftUI

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
