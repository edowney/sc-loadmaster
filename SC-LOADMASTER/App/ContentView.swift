import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            // Background image
            BackgroundImageView()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // App Title
                Text("SC-LOADMASTER")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary)
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                // Tab content
                TabView(selection: $selectedTab) {
                    ContractsView()
                        .tag(0)

                    LogView()
                        .tag(1)

                    ShipsView()
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                // Custom bottom navigation
                BottomNavigationBar(selectedTab: $selectedTab)
            }
        }
    }
}

struct BackgroundImageView: View {
    var body: some View {
        Image("background-image")
            .resizable()
            .scaledToFill()
            .overlay(
                Color.black.opacity(0.3)
            )
    }
}

#Preview {
    ContentView()
}
