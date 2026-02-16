//
//  CommodityItemView.swift
//  SC-LOADMASTER
//
//  Commodity list item with container breakdown
//

import SwiftUI

struct CommodityItemView: View {
    let commodity: Commodity
    let onSave: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            // Commodity header row
            HStack(spacing: 13) {
                // Arrow icon
                Image(systemName: commodity.isDelivery ? "arrow.up.circle" : "arrow.down.circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.scPrimary)

                Text(commodity.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.scPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Text("\(commodity.quantity)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.scPrimary)
                    .frame(width: 45, alignment: .trailing)

                Button(action: onSave) {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.scPrimary)
                }
            }
            .padding(.vertical, 4)

            // Container breakdown
            HStack(spacing: 8) {
                ForEach(commodity.containers) { container in
                    ContainerBadgeView(
                        size: container.size,
                        count: container.count
                    )
                }
                Spacer()
            }
        }
    }
}

#Preview {
    VStack(spacing: 8) {
        CommodityItemView(
            commodity: Commodity(
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
            onSave: {}
        )

        Divider()
            .frame(height: 1)
            .background(Color.scPrimary)

        CommodityItemView(
            commodity: Commodity(
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
            ),
            onSave: {}
        )
    }
    .padding()
    .background(Color.scCardBackground)
}
