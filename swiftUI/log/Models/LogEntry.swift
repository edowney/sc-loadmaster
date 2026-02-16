//
//  LogEntry.swift
//  SC-LOADMASTER
//
//  Log entry data model for completed cargo deliveries
//

import Foundation

struct LogEntry: Identifiable {
    let id: UUID
    let date: Date
    let collectLocation: String
    let deliveryLocation: String
    let commodity: String
    let scuAmount: Int

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        collectLocation: String,
        deliveryLocation: String,
        commodity: String,
        scuAmount: Int
    ) {
        self.id = id
        self.date = date
        self.collectLocation = collectLocation
        self.deliveryLocation = deliveryLocation
        self.commodity = commodity
        self.scuAmount = scuAmount
    }

    // Date formatter for MM/DD/YY format
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        return formatter.string(from: date)
    }
}

// MARK: - Sample Data for Preview
extension LogEntry {
    static let sampleData: [LogEntry] = [
        LogEntry(
            date: Date(),
            collectLocation: "Everus Harbor",
            deliveryLocation: "Lorville",
            commodity: "Ship Ammunition",
            scuAmount: 64
        ),
        LogEntry(
            date: Date(),
            collectLocation: "Everus Harbor",
            deliveryLocation: "Lorville",
            commodity: "Ship Ammunition",
            scuAmount: 64
        ),
        LogEntry(
            date: Date(),
            collectLocation: "Everus Harbor",
            deliveryLocation: "Lorville",
            commodity: "Ship Ammunition",
            scuAmount: 64
        ),
        LogEntry(
            date: Date(),
            collectLocation: "Everus Harbor",
            deliveryLocation: "Lorville",
            commodity: "Ship Ammunition",
            scuAmount: 64
        ),
        LogEntry(
            date: Date(),
            collectLocation: "Port Olisar",
            deliveryLocation: "ArcCorp",
            commodity: "Medical Supplies",
            scuAmount: 128
        ),
        LogEntry(
            date: Date(),
            collectLocation: "Crusader",
            deliveryLocation: "Microtech",
            commodity: "Agricultural Supplies",
            scuAmount: 96
        ),
        LogEntry(
            date: Date(),
            collectLocation: "Hurston",
            deliveryLocation: "New Babbage",
            commodity: "Processed Food",
            scuAmount: 48
        )
    ]
}
