//
//  ShipTableView.swift
//  SC-LOADMASTER
//
//  Table container for ship list with headers and rows
//

import SwiftUI

struct ShipTableView: View {
    let ships: [Ship]
    let onDelete: (Ship) -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Table headers
            HStack(spacing: 0) {
                Text("NAME")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 62)

                Text("CARGO SCU")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(alignment: .trailing)
                    .padding(.trailing, 24)
            }
            .frame(width: 357)
            .padding(.bottom, 10)

            // Ships table container
            VStack(spacing: 0) {
                ForEach(Array(ships.enumerated()), id: \.element.id) { index, ship in
                    VStack(spacing: 0) {
                        ShipRowView(
                            ship: ship,
                            isAlternating: index % 2 == 1,
                            onDelete: { onDelete(ship) }
                        )

                        // Border between rows
                        if index < ships.count - 1 {
                            Rectangle()
                                .fill(Color.scPrimary)
                                .frame(height: 2)
                        }
                    }
                }
            }
            .frame(width: 357)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.scPrimary, lineWidth: 2)
            )
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        ShipTableView(
            ships: Ship.sampleData,
            onDelete: { _ in }
        )
    }
}
