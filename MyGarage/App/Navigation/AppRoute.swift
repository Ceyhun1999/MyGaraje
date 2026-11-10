import SwiftData

enum AppRoute: Hashable {

    case carDetail(PersistentIdentifier)
    case editCar(PersistentIdentifier)

    var hidesBottomBar: Bool {
        switch self {
        case .carDetail, .editCar:
            return true
        }
    }
}
