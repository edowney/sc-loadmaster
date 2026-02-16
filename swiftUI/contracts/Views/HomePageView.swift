//
//  HomePageView.swift
//  SC-LOADMASTER
//
//  Main contracts page view with all components
//

import SwiftUI

struct HomePageView: View {
    @State private var shipName: String = ""
    @State private var maxContainerSize: String = ""
    @State private var collectLocation: String = ""
    @State private var deliveryLocation: String = ""
    @State private var commodityName: String = ""
    @State private var scu: String = ""
    @State private var selectedTab: Int = 0

    // Sample route data
    @State private var currentRoute = Route(
        collectLocation: "Everus Harbor",
        deliveryLocation: "HDPC-Cassillo",
        commodities: [
            Commodity(
                name: "Pressurized Ice",
                quantity: 12,
                isDelivery: true,
                containers: [
                    ContainerSize(size: 16, count: 2),
                    ContainerSize(size: 8, count: 1),
                    ContainerSize(size: 4, count: 1),
                    ContainerSize(size: 2, count: 1),
                    ContainerSize(size: 1, count: 1)
                ]
            ),
            Commodity(
                name: "Processed Food",
                quantity: 127,
                isDelivery: true,
                containers: [
                    ContainerSize(size: 16, count: 2),
                    ContainerSize(size: 8, count: 1),
                    ContainerSize(size: 4, count: 1),
                    ContainerSize(size: 2, count: 1),
                    ContainerSize(size: 1, count: 1)
                ]
            )
        ]
    )

    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()

            // Background image with opacity
            // Note: Replace with actual asset
            Image("background-image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 393, height: 852)
                .opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                AppHeaderView()

                // Page title
                PageTitleView(title: "CONTRACTS")

                // Mission details
                MissionDetailsView(
                    shipName: $shipName,
                    maxContainerSize: $maxContainerSize
                )
                .padding(.top, 0)

                // Separator line
                Divider()
                    .frame(height: 2)
                    .background(Color.scPrimary)
                    .frame(width: 336)
                    .padding(.top, 8)

                // Data entry form
                DataEntryFormView(
                    collectLocation: $collectLocation,
                    deliveryLocation: $deliveryLocation,
                    commodityName: $commodityName,
                    scu: $scu,
                    onAdd: addCommodity
                )
                .padding(.top, 8)

                // Separator line
                Divider()
                    .frame(height: 2)
                    .background(Color.scPrimary)
                    .frame(width: 336)
                    .padding(.top, 8)

                // Data entry detail
                DataEntryDetailView(
                    collectLocation: "Everus Harbor",
                    deliveryLocation: "HDPC-Cassillo",
                    commodityName: "Pressurized Ice",
                    scu: "176",
                    onRemove: {},
                    onMoveDown: {}
                )
                .padding(.top, 8)

                // Route card
                RouteCardView(route: currentRoute)
                    .padding(.top, 54)

                Spacer()

                // Footer
                FooterView(selectedTab: $selectedTab)
            }
        }
        .frame(width: 393, height: 852)
    }

    private func addCommodity() {
        // Add logic to create new commodity with container allocation
        guard !commodityName.isEmpty, !scu.isEmpty else { return }

        if let quantity = Int(scu) {
            // Calculate optimal container allocation (simplified)
            let newCommodity = Commodity(
                name: commodityName,
                quantity: quantity,
                isDelivery: !deliveryLocation.isEmpty,
                containers: calculateContainers(for: quantity)
            )
            currentRoute.commodities.append(newCommodity)

            // Clear form
            commodityName = ""
            scu = ""
        }
    }

    private func calculateContainers(for quantity: Int) -> [ContainerSize] {
        // Simplified container allocation
        // In real app, this would optimize based on maxContainerSize
        var remaining = quantity
        var containers: [ContainerSize] = []

        for size in [16, 8, 4, 2, 1] {
            let count = remaining / size
            if count > 0 {
                containers.append(ContainerSize(size: size, count: count))
                remaining -= count * size
            }
        }

        return containers
    }
}

#Preview {
    HomePageView()
}
