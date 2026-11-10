import SwiftData
import SwiftUI

struct AppNavigationStack<Content: View>: View {

    @State private var router = AppRouter()

    @Environment(\.modelContext) private var modelContext

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {

        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: AppRoute.self) { route in
                    Group {
                        switch route {
                        case .carDetail(let carID):
                            if let car = modelContext.model(for: carID) as? Car
                            {
                                CarDetailView(car: car)
                            } else {
                                ContentUnavailableView(
                                    "Автомобиль не найден",
                                    systemImage: "car"
                                )
                            }
                        case .editCar(let carID):
                            if let car = modelContext.model(for: carID) as? Car
                            {
                                EditCarView(car: car)
                            } else {
                                ContentUnavailableView(
                                    "Автомобиль не найден",
                                    systemImage: "car"
                                )
                            }
                        }

                    }
                    .toolbar(
                        route.hidesBottomBar ? .hidden : .visible,
                        for: .tabBar
                    )
                }
        }
        .environment(router)
        // Present outside the stack's destination hierarchy so the modal's
        // keyboard and pickers have an independent presentation context.
        .sheet(isPresented: $router.isAddingCar) {
            AddCarView()
        }
    }
}
