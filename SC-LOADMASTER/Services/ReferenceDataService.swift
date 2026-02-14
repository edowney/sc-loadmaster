import Foundation

class ReferenceDataService {
    static let shared = ReferenceDataService()

    private(set) var locations: [String] = []
    private(set) var commodities: [String] = []

    private init() {
        loadLocations()
        loadCommodities()
    }

    private func loadLocations() {
        guard let url = Bundle.main.url(forResource: "locations-list", withExtension: "txt", subdirectory: "assets") else {
            print("Warning: locations-list.txt not found in assets")
            return
        }

        do {
            let content = try String(contentsOf: url, encoding: .utf8)
            locations = content.components(separatedBy: .newlines)
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .filter { !$0.isEmpty }
                .sorted()
        } catch {
            print("Error loading locations: \(error)")
        }
    }

    private func loadCommodities() {
        guard let url = Bundle.main.url(forResource: "commodities-list", withExtension: "txt", subdirectory: "assets") else {
            print("Warning: commodities-list.txt not found in assets")
            return
        }

        do {
            let content = try String(contentsOf: url, encoding: .utf8)
            commodities = content.components(separatedBy: .newlines)
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .filter { !$0.isEmpty }
                .sorted()
        } catch {
            print("Error loading commodities: \(error)")
        }
    }

    /// Filter items using case-insensitive substring matching
    /// - Parameters:
    ///   - items: Array of strings to filter
    ///   - searchText: Search text to match
    /// - Returns: Filtered and prioritized array of matches
    func filterItems(_ items: [String], searchText: String) -> [String] {
        guard !searchText.isEmpty else { return items }

        let lowercasedSearch = searchText.lowercased()
        var exactMatches: [String] = []
        var startOfStringMatches: [String] = []
        var startOfWordMatches: [String] = []
        var substringMatches: [String] = []

        for item in items {
            let lowercasedItem = item.lowercased()

            if lowercasedItem == lowercasedSearch {
                exactMatches.append(item)
            } else if lowercasedItem.hasPrefix(lowercasedSearch) {
                startOfStringMatches.append(item)
            } else if let range = lowercasedItem.range(of: lowercasedSearch) {
                // Check if match is at start of a word
                if range.lowerBound == lowercasedItem.startIndex ||
                   lowercasedItem[lowercasedItem.index(before: range.lowerBound)].isWhitespace ||
                   lowercasedItem[lowercasedItem.index(before: range.lowerBound)] == "-" {
                    startOfWordMatches.append(item)
                } else {
                    substringMatches.append(item)
                }
            }
        }

        // Return prioritized matches
        return exactMatches + startOfStringMatches + startOfWordMatches + substringMatches
    }
}
