//
//  RouteCardView.swift
//  SC-LOADMASTER
//
//  Route card showing commodities with container breakdowns
//

import SwiftUI

struct RouteCardView: View {
    let route: Route

    var body: some View {
        VStack(spacing: 0) {
            // Card header
            CardHeaderView(
                fromLocation: route.collectLocation,
                toLocation: route.deliveryLocation
            )

            // Card detail
            VStack(spacing: 8) {
                // Commodities with container breakdowns
                ForEach(Array(route.commodities.enumerated()), id: \.element.id) { index, commodity in
                    CommodityItemView(
                        commodity: commodity,
                        onSave: {}
                    )

                    // Divider between commodities (but not after last one before totals)
                    if index < route.commodities.count - 1 {
                        Divider()
                            .frame(height: 1)
                            .background(Color.scPrimary)
                            .frame(width: 336)
                    }
                }

                // Divider before totals
                Divider()
                    .frame(height: 1)
                    .background(Color.scPrimary)
                    .frame(width: 336)
                    .padding(.top, 8)

                // Total and Remaining
                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        Text("Total")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.scPrimary)

                        Text("\(route.totalCommodities)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.scPrimary)

                        Spacer()
                    }

                    HStack(spacing: 10) {
                        Text("Remaining")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.scPrimary)

                        Text("\(route.remainingCapacity)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.scPrimary)

                        Spacer()
                    }
                }
                .frame(width: 333)
            }
            .padding(EdgeInsets(top: 9, leading: 6, bottom: 9, trailing: 6))
            .background(Color.scCardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.scPrimary, lineWidth: 2)
            )
            .cornerRadius(20, corners: [.bottomRight])
        }
        .frame(width: 353)
    }
}

#Preview {
    RouteCardView(
        route: Route(
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
    )
    .padding()
    .background(Color.black)
}
