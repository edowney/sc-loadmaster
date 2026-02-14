import SwiftUI

@main
struct SCLoadmasterApp: App {
    @StateObject private var dataService = DataPersistenceService.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataService.container.viewContext)
        }
    }
}
