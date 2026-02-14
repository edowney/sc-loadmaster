import SwiftUI

struct ContainerVisualizationView: View {
    let distribution: ContainerDistribution

    var body: some View {
        HStack(spacing: 6) {
            ForEach(distribution.asArray, id: \.size) { container in
                ContainerBadge(size: container.size, count: container.count)
            }
        }
    }
}

struct ContainerBadge: View {
    let size: Int
    let count: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Container icon
            Image("container")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .foregroundColor(AppTheme.accent)
                .overlay(
                    Text("\(size)")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary)
                )

            // Count badge
            Circle()
                .fill(AppTheme.containerBadgeBackground)
                .frame(width: 20, height: 20)
                .overlay(
                    Text("\(count)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(AppTheme.containerBadgeText)
                )
                .offset(x: 6, y: -6)
        }
    }
}

#Preview {
    VStack {
        ContainerVisualizationView(
            distribution: ContainerDistribution(
                size16: 7,
                size8: 1,
                size4: 1,
                size2: 1,
                size1: 1
            )
        )
    }
    .padding()
    .background(AppTheme.background)
}
