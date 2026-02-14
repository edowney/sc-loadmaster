import Foundation

struct ContractEntry: Identifiable, Equatable {
    let id: UUID
    var collectLocation: String
    var deliveryLocation: String
    var commodity: String
    var scuAmount: Int
    var isInCard: Bool

    init(
        id: UUID = UUID(),
        collectLocation: String,
        deliveryLocation: String,
        commodity: String,
        scuAmount: Int,
        isInCard: Bool = false
    ) {
        self.id = id
        self.collectLocation = collectLocation
        self.deliveryLocation = deliveryLocation
        self.commodity = commodity
        self.scuAmount = scuAmount
        self.isInCard = isInCard
    }
}

struct ContractCard: Identifiable, Equatable {
    let id: UUID
    let collectLocation: String
    let deliveryLocation: String
    var entries: [ContractCardEntry]

    init(
        id: UUID = UUID(),
        collectLocation: String,
        deliveryLocation: String,
        entries: [ContractCardEntry] = []
    ) {
        self.id = id
        self.collectLocation = collectLocation
        self.deliveryLocation = deliveryLocation
        self.entries = entries
    }

    var totalSCU: Int {
        entries.reduce(0) { $0 + $1.scuAmount }
    }

    func remainingCapacity(shipCapacity: Int) -> Int {
        shipCapacity - totalSCU
    }
}

struct ContractCardEntry: Identifiable, Equatable {
    let id: UUID
    var commodity: String
    var scuAmount: Int
    var containers: ContainerDistribution

    init(
        id: UUID = UUID(),
        commodity: String,
        scuAmount: Int,
        containers: ContainerDistribution
    ) {
        self.id = id
        self.commodity = commodity
        self.scuAmount = scuAmount
        self.containers = containers
    }
}

struct ContainerDistribution: Equatable {
    var size16: Int
    var size8: Int
    var size4: Int
    var size2: Int
    var size1: Int

    init(size16: Int = 0, size8: Int = 0, size4: Int = 0, size2: Int = 0, size1: Int = 0) {
        self.size16 = size16
        self.size8 = size8
        self.size4 = size4
        self.size2 = size2
        self.size1 = size1
    }

    var asArray: [(size: Int, count: Int)] {
        var result: [(size: Int, count: Int)] = []
        if size16 > 0 { result.append((16, size16)) }
        if size8 > 0 { result.append((8, size8)) }
        if size4 > 0 { result.append((4, size4)) }
        if size2 > 0 { result.append((2, size2)) }
        if size1 > 0 { result.append((1, size1)) }
        return result
    }
}
