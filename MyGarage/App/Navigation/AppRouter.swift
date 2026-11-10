import Observation

@MainActor
@Observable
final class AppRouter {
    
    var path: [AppRoute] = []

    var isAddingCar = false
    
    var currentRoute: AppRoute? {
        path.last
    }
    
    var isRoot: Bool {
        path.isEmpty
    }
    
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
