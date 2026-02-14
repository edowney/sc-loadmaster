import Foundation
import CoreData

@objc(Ship)
public class Ship: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var cargoCapacitySCU: Int32
    @NSManaged public var createdDate: Date

    convenience init(context: NSManagedObjectContext, name: String, cargoCapacitySCU: Int) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
        self.cargoCapacitySCU = Int32(cargoCapacitySCU)
        self.createdDate = Date()
    }
}

extension Ship {
    static func fetchRequest() -> NSFetchRequest<Ship> {
        return NSFetchRequest<Ship>(entityName: "Ship")
    }

    static func allShipsFetchRequest() -> NSFetchRequest<Ship> {
        let request = fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Ship.name, ascending: true)]
        return request
    }
}
