import Foundation
import CoreData
import Combine

class ShipsViewModel: ObservableObject {
    @Published var ships: [Ship] = []
    @Published var nameInput: String = ""
    @Published var cargoSCUInput: String = ""
    @Published var showDeleteConfirmation: Bool = false
    @Published var errorMessage: String?

    private var shipToDelete: Ship?
    private let dataService = DataPersistenceService.shared

    init() {
        fetchShips()
    }

    func fetchShips() {
        ships = dataService.fetchShips()
    }

    func addShip() {
        guard !nameInput.isEmpty else {
            errorMessage = "Ship name is required"
            return
        }

        guard let cargoSCU = Int(cargoSCUInput), cargoSCU > 0 else {
            errorMessage = "Please enter a valid cargo capacity greater than 0"
            return
        }

        // Check for duplicate names
        if ships.contains(where: { $0.name.lowercased() == nameInput.lowercased() }) {
            errorMessage = "A ship with this name already exists"
            return
        }

        do {
            try dataService.saveShip(name: nameInput, cargoCapacitySCU: cargoSCU)
            fetchShips()
            clearInputs()
            errorMessage = nil
        } catch {
            errorMessage = "Failed to save ship: \(error.localizedDescription)"
        }
    }

    func requestDelete(_ ship: Ship) {
        shipToDelete = ship
        showDeleteConfirmation = true
    }

    func confirmDelete() {
        guard let ship = shipToDelete else { return }

        do {
            try dataService.deleteShip(ship)
            fetchShips()
            showDeleteConfirmation = false
            shipToDelete = nil
        } catch {
            errorMessage = "Failed to delete ship: \(error.localizedDescription)"
            showDeleteConfirmation = false
        }
    }

    func cancelDelete() {
        showDeleteConfirmation = false
        shipToDelete = nil
    }

    private func clearInputs() {
        nameInput = ""
        cargoSCUInput = ""
    }

    var deleteConfirmationTitle: String {
        guard let ship = shipToDelete else { return "Delete Ship?" }
        return "Delete \(ship.name)?"
    }
}
