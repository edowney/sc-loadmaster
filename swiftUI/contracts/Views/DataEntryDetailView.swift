//
//  DataEntryDetailView.swift
//  SC-LOADMASTER
//
//  Current data entry detail display
//

import SwiftUI

struct DataEntryDetailView: View {
    let collectLocation: String
    let deliveryLocation: String
    let commodityName: String
    let scu: String
    let onRemove: () -> Void
    let onMoveDown: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onRemove) {
                Image(systemName: "minus.circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.scPrimary)
            }

            Text(collectLocation)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .lineLimit(1)

            Text(deliveryLocation)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .lineLimit(1)

            Text(commodityName)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .lineLimit(1)

            Text(scu)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .lineLimit(1)

            Button(action: onMoveDown) {
                Image(systemName: "arrow.down.circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.scPrimary)
            }
        }
        .frame(width: 391, height: 32)
        .padding(.horizontal, 10)
    }
}

#Preview {
    DataEntryDetailView(
        collectLocation: "Everus Harbor",
        deliveryLocation: "HDPC-Cassillo",
        commodityName: "Pressurized Ice",
        scu: "176",
        onRemove: {},
        onMoveDown: {}
    )
    .background(Color.black)
}
