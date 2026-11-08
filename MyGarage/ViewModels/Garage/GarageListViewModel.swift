import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class GarageListViewModel {

    // MARK: - State
    private(set) var carToDelete: Car?
    private(set) var errorMessage = ""

    // MARK: - Actions
    func requestDelete(_ car: Car) {
        carToDelete = car
    }

    func cancelDelete() {
        carToDelete = nil
    }

    func deleteCar(using modelContext: ModelContext) -> Bool {
        defer {
            cancelDelete()
        }

        guard let car = carToDelete else {
            return false
        }

        modelContext.delete(car)

        do {
            try modelContext.save()
            return true
        } catch {
            modelContext.rollback()
            errorMessage = "Не удалось сохранить изменения. Попробуйте ещё раз."
            print("Ошибка удаления: \(error)")
            return false
        }
    }
}
