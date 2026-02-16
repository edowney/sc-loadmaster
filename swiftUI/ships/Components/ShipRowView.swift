//
//  ShipRowView.swift
//  SC-LOADMASTER
//
//  Individual ship row component with delete button
//

import SwiftUI

struct ShipRowView: View {
    let ship: Ship
    let isAlternating: Bool
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            // Delete button (minus icon)
            Button(action: onDelete) {
                Image(systemName: "minus.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.scPrimary)
            }

            // Ship name
            HStack(spacing: 11) {
                Text(ship.name)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(width: 270, alignment: .leading)

            Spacer()

            // Cargo capacity
            Text("\(ship.cargoCapacitySCU)")
                .font(.system(size: 12))
                .foregroundColor(.white)
                .frame(alignment: .trailing)
        }
        .padding(.horizontal, 11)
        .frame(height: 33)
        .background(isAlternating ? Color.scBackground : Color.clear)
    }
}

#Preview {
    VStack(spacing: 0) {
        ShipRowView(
            ship: Ship.sampleData[0],
            isAlternating: false,
            onDelete: {}
        )
        ShipRowView(
            ship: Ship.sampleData[1],
            isAlternating: true,
            onDelete: {}
        )
        ShipRowView(
            ship: Ship.sampleData[2],
            isAlternating: false,
            onDelete: {}
        )
        ShipRowView(
            ship: Ship.sampleData[3],
            isAlternating: true,
            onDelete: {}
        )
    }
    .background(Color.black)
}
