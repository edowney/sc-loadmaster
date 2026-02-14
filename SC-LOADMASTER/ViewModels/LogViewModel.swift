import Foundation
import Combine

class LogViewModel: ObservableObject {
    @Published var logEntries: [LogEntry] = []
    @Published var currentPage: Int = 0

    private let pageSize = 12
    private let dataService = DataPersistenceService.shared

    var totalPages: Int {
        let totalCount = dataService.getLogEntriesCount()
        return max(1, Int(ceil(Double(totalCount) / Double(pageSize))))
    }

    var canGoToPreviousPage: Bool {
        currentPage > 0
    }

    var canGoToNextPage: Bool {
        currentPage < totalPages - 1
    }

    var pageIndicator: String {
        let total = totalPages
        let current = min(currentPage + 1, total)
        return "Page \(current) of \(total)"
    }

    init() {
        fetchLogEntries()
    }

    func fetchLogEntries() {
        logEntries = dataService.fetchLogEntries(page: currentPage, pageSize: pageSize)
    }

    func nextPage() {
        guard canGoToNextPage else { return }
        currentPage += 1
        fetchLogEntries()
    }

    func previousPage() {
        guard canGoToPreviousPage else { return }
        currentPage -= 1
        fetchLogEntries()
    }

    func refresh() {
        fetchLogEntries()
    }
}
