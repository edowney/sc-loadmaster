//
//  Contract.swift
//  SC-LOADMASTER
//
//  Data models for contract and cargo management
//

import Foundation

struct ContainerSize: Identifiable {
    let id = UUID()
    var size: Int
    var count: Int
}

struct Commodity: Identifiable {
    let id = UUID()
    var name: String
    var quantity: Int
    var isDelivery: Bool // true = delivery, false = collect
    var containers: [ContainerSize]
}

struct Route: Identifiable {
    let id = UUID()
    var collectLocation: String
    var deliveryLocation: String
    var commodities: [Commodity]

    var totalCommodities: Int {
        commodities.reduce(0) { $0 + $1.quantity }
    }

    var remainingCapacity: Int {
        // Calculate remaining capacity based on container allocation
        // For now, returning placeholder value
        return 57
    }
}

struct Mission {
    var shipName: String
    var maxContainerSize: Int
    var routes: [Route]
}
