//
//  ShipInputView.swift
//  SC-LOADMASTER
//
//  Input section for adding new ships
//

import SwiftUI

struct ShipInputView: View {
    @Binding var shipName: String
    @Binding var cargoSCU: String
    let onAdd: () -> Void

    var body: some View {
        HStack(spacing: 13) {
            // Plus icon button
            Button(action: onAdd) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.scPrimary)
            }

            // Name field
            HStack(spacing: 8) {
                Text("NAME")
                    .font(.system(size: 12))
                    .foregroundColor(.white)

                TextField("", text: $shipName)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .frame(width: 137, height: 30)
                    .padding(.horizontal, 8)
                    .background(Color.scTextbox)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }

            // Cargo SCU field
            HStack(spacing: 4) {
                Text("CARGO SCU")
                    .font(.system(size: 12))
                    .foregroundColor(.white)

                TextField("", text: $cargoSCU)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .keyboardType(.numberPad)
                    .frame(width: 50, height: 30)
                    .padding(.horizontal, 8)
                    .background(Color.scTextbox)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
        }
        .frame(width: 353, height: 34)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        ShipInputView(
            shipName: .constant(""),
            cargoSCU: .constant(""),
            onAdd: {}
        )
    }
}
