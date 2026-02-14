import Foundation
import Combine

class ContractsViewModel: ObservableObject {
    // Ship and max container size fields
    @Published var shipName: String = ""
    @Published var maxContainerSize: String = ""

    // Contract entry fields
    @Published var collectLocation: String = ""
    @Published var deliveryLocation: String = ""
    @Published var commodity: String = ""
    @Published var scuAmount: String = ""

    // Data
    @Published var contractEntries: [ContractEntry] = []
    @Published var contractCards: [ContractCard] = []
    @Published var ships: [Ship] = []

    // UI State
    @Published var showDeleteConfirmation: Bool = false
    @Published var errorMessage: String?

    private var entryToDelete: ContractEntry?
    private let dataService = DataPersistenceService.shared
    private let referenceData = ReferenceDataService.shared

    var showContractDetailsSection: Bool {
        !shipName.isEmpty && !maxContainerSize.isEmpty && maxContainerSizeInt != nil
    }

    var selectedShip: Ship? {
        ships.first { $0.name == shipName }
    }

    var maxContainerSizeInt: Int? {
        Int(maxContainerSize)
    }

    init() {
        fetchShips()
    }

    func fetchShips() {
        ships = dataService.fetchShips()
    }

    func addEntry() {
        guard !collectLocation.isEmpty else {
            errorMessage = "Collection location is required"
            return
        }

        guard !deliveryLocation.isEmpty else {
            errorMessage = "Delivery location is required"
            return
        }

        guard !commodity.isEmpty else {
            errorMessage = "Commodity is required"
            return
        }

        guard let scu = Int(scuAmount), scu > 0 else {
            errorMessage = "Please enter a valid SCU amount greater than 0"
            return
        }

        let entry = ContractEntry(
            collectLocation: collectLocation,
            deliveryLocation: deliveryLocation,
            commodity: commodity,
            scuAmount: scu
        )

        contractEntries.append(entry)
        clearEntryFields()
        errorMessage = nil
    }

    func requestDeleteEntry(_ entry: ContractEntry) {
        entryToDelete = entry
        showDeleteConfirmation = true
    }

    func confirmDeleteEntry() {
        guard let entry = entryToDelete else { return }
        contractEntries.removeAll { $0.id == entry.id }
        showDeleteConfirmation = false
        entryToDelete = nil
    }

    func cancelDelete() {
        showDeleteConfirmation = false
        entryToDelete = nil
    }

    func moveEntryToCard(_ entry: ContractEntry) {
        guard let maxSize = maxContainerSizeInt else { return }

        // Remove from entries list
        contractEntries.removeAll { $0.id == entry.id }

        // Find or create card
        if let cardIndex = contractCards.firstIndex(where: {
            $0.collectLocation == entry.collectLocation &&
            $0.deliveryLocation == entry.deliveryLocation
        }) {
            // Add to existing card
            let containers = ContainerCalculator.calculateContainers(
                totalSCU: entry.scuAmount,
                maxContainerSize: maxSize
            )

            let cardEntry = ContractCardEntry(
                commodity: entry.commodity,
                scuAmount: entry.scuAmount,
                containers: containers
            )

            contractCards[cardIndex].entries.append(cardEntry)
        } else {
            // Create new card
            let containers = ContainerCalculator.calculateContainers(
                totalSCU: entry.scuAmount,
                maxContainerSize: maxSize
            )

            let cardEntry = ContractCardEntry(
                commodity: entry.commodity,
                scuAmount: entry.scuAmount,
                containers: containers
            )

            let newCard = ContractCard(
                collectLocation: entry.collectLocation,
                deliveryLocation: entry.deliveryLocation,
                entries: [cardEntry]
            )

            contractCards.append(newCard)
        }
    }

    func moveEntryBackToList(cardId: UUID, entryId: UUID) {
        guard let cardIndex = contractCards.firstIndex(where: { $0.id == cardId }) else { return }
        guard let entryIndex = contractCards[cardIndex].entries.firstIndex(where: { $0.id == entryId }) else { return }

        let cardEntry = contractCards[cardIndex].entries[entryIndex]

        // Create contract entry from card entry
        let contractEntry = ContractEntry(
            collectLocation: contractCards[cardIndex].collectLocation,
            deliveryLocation: contractCards[cardIndex].deliveryLocation,
            commodity: cardEntry.commodity,
            scuAmount: cardEntry.scuAmount
        )

        // Add to list
        contractEntries.append(contractEntry)

        // Remove from card
        contractCards[cardIndex].entries.remove(at: entryIndex)

        // Remove card if empty
        if contractCards[cardIndex].entries.isEmpty {
            contractCards.remove(at: cardIndex)
        }
    }

    func saveEntryToLog(cardId: UUID, entryId: UUID) {
        guard let cardIndex = contractCards.firstIndex(where: { $0.id == cardId }) else { return }
        guard let entryIndex = contractCards[cardIndex].entries.firstIndex(where: { $0.id == entryId }) else { return }

        let card = contractCards[cardIndex]
        let cardEntry = card.entries[entryIndex]

        do {
            try dataService.saveLogEntry(
                collectLocation: card.collectLocation,
                deliveryLocation: card.deliveryLocation,
                commodity: cardEntry.commodity,
                scuAmount: cardEntry.scuAmount
            )

            // Remove from card
            contractCards[cardIndex].entries.remove(at: entryIndex)

            // Remove card if empty
            if contractCards[cardIndex].entries.isEmpty {
                contractCards.remove(at: cardIndex)
            }

            errorMessage = nil
        } catch {
            errorMessage = "Failed to save to log: \(error.localizedDescription)"
        }
    }

    func getCardNumber(_ card: ContractCard) -> Int {
        guard let index = contractCards.firstIndex(where: { $0.id == card.id }) else { return 0 }
        return index + 1
    }

    private func clearEntryFields() {
        collectLocation = ""
        deliveryLocation = ""
        commodity = ""
        scuAmount = ""
    }

    var deleteConfirmationTitle: String {
        guard let entry = entryToDelete else { return "Delete Entry?" }
        return "Remove \(entry.commodity)?"
    }
}
