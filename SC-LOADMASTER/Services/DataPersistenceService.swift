import Foundation
import CoreData

class DataPersistenceService: ObservableObject {
    static let shared = DataPersistenceService()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "SCLoadmaster")

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    // MARK: - Ship Operations

    func saveShip(name: String, cargoCapacitySCU: Int) throws {
        let context = container.viewContext
        _ = Ship(context: context, name: name, cargoCapacitySCU: cargoCapacitySCU)
        try context.save()
    }

    func deleteShip(_ ship: Ship) throws {
        let context = container.viewContext
        context.delete(ship)
        try context.save()
    }

    func fetchShips() -> [Ship] {
        let request = Ship.allShipsFetchRequest()
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error fetching ships: \(error)")
            return []
        }
    }

    // MARK: - Log Entry Operations

    func saveLogEntry(
        collectLocation: String,
        deliveryLocation: String,
        commodity: String,
        scuAmount: Int
    ) throws {
        let context = container.viewContext
        _ = LogEntry(
            context: context,
            collectLocation: collectLocation,
            deliveryLocation: deliveryLocation,
            commodity: commodity,
            scuAmount: scuAmount
        )
        try context.save()
    }

    func fetchLogEntries(page: Int = 0, pageSize: Int = 12) -> [LogEntry] {
        let request = LogEntry.allLogEntriesFetchRequest()
        request.fetchOffset = page * pageSize
        request.fetchLimit = pageSize

        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error fetching log entries: \(error)")
            return []
        }
    }

    func getLogEntriesCount() -> Int {
        let request = LogEntry.fetchRequest()
        do {
            return try container.viewContext.count(for: request)
        } catch {
            print("Error counting log entries: \(error)")
            return 0
        }
    }
}
