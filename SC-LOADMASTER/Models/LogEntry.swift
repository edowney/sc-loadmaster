import Foundation
import CoreData

@objc(LogEntry)
public class LogEntry: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var collectLocation: String
    @NSManaged public var deliveryLocation: String
    @NSManaged public var commodity: String
    @NSManaged public var scuAmount: Int32

    convenience init(
        context: NSManagedObjectContext,
        collectLocation: String,
        deliveryLocation: String,
        commodity: String,
        scuAmount: Int
    ) {
        self.init(context: context)
        self.id = UUID()
        self.date = Date()
        self.collectLocation = collectLocation
        self.deliveryLocation = deliveryLocation
        self.commodity = commodity
        self.scuAmount = Int32(scuAmount)
    }
}

extension LogEntry {
    static func fetchRequest() -> NSFetchRequest<LogEntry> {
        return NSFetchRequest<LogEntry>(entityName: "LogEntry")
    }

    static func allLogEntriesFetchRequest() -> NSFetchRequest<LogEntry> {
        let request = fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \LogEntry.date, ascending: false)]
        return request
    }

    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        return formatter.string(from: date)
    }
}
