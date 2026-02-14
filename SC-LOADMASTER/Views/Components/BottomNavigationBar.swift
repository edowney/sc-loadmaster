import SwiftUI

struct BottomNavigationBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: 0) {
            Spacer()

            NavigationButton(
                iconName: "contract",
                isSelected: selectedTab == 0,
                action: { selectedTab = 0 }
            )

            Spacer()

            NavigationButton(
                iconName: "log",
                isSelected: selectedTab == 1,
                action: { selectedTab = 1 }
            )

            Spacer()

            NavigationButton(
                iconName: "ships",
                isSelected: selectedTab == 2,
                action: { selectedTab = 2 }
            )

            Spacer()
        }
        .frame(height: 70)
        .background(AppTheme.background.opacity(0.95))
    }
}

struct NavigationButton: View {
    let iconName: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundColor(isSelected ? AppTheme.accent : AppTheme.textSecondary)
                .opacity(isSelected ? 1.0 : 0.6)
        }
        .frame(width: AppTheme.buttonSize, height: AppTheme.buttonSize)
    }
}
