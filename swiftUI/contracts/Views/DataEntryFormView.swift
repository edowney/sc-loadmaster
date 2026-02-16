//
//  DataEntryFormView.swift
//  SC-LOADMASTER
//
//  Data entry form for commodity collection/delivery
//

import SwiftUI

struct DataEntryFormView: View {
    @Binding var collectLocation: String
    @Binding var deliveryLocation: String
    @Binding var commodityName: String
    @Binding var scu: String

    let onAdd: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            // Collect and Delivery headers
            HStack(spacing: 0) {
                Text("COLLECT")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .frame(width: 170, alignment: .leading)

                Spacer()
                    .frame(width: 10)

                Text("DELIVERY")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .frame(width: 170, alignment: .leading)
            }
            .frame(height: 15)

            // Collect and Delivery textboxes
            HStack(spacing: 10) {
                TextField("", text: $collectLocation)
                    .padding(.horizontal, 8)
                    .frame(width: 170, height: 30)
                    .background(Color.scTextboxBackground)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )

                TextField("", text: $deliveryLocation)
                    .padding(.horizontal, 8)
                    .frame(width: 170, height: 30)
                    .background(Color.scTextboxBackground)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }

            // Commodity and SCU headers
            HStack(spacing: 0) {
                Text("COMMODITY")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .frame(width: 170, alignment: .leading)

                Spacer()
                    .frame(width: 10)

                Text("SCU")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .frame(width: 73, alignment: .leading)
            }
            .frame(height: 25)
            .padding(.top, 10)

            // Commodity and SCU textboxes with add button
            HStack(spacing: 10) {
                TextField("", text: $commodityName)
                    .padding(.horizontal, 8)
                    .frame(width: 170, height: 30)
                    .background(Color.scTextboxBackground)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )

                TextField("", text: $scu)
                    .padding(.horizontal, 8)
                    .frame(width: 73, height: 30)
                    .background(Color.scTextboxBackground)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )

                Button(action: onAdd) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.scPrimary)
                }
            }
        }
        .frame(width: 392, height: 124)
        .padding(.horizontal, 20)
    }
}

#Preview {
    DataEntryFormView(
        collectLocation: .constant(""),
        deliveryLocation: .constant(""),
        commodityName: .constant(""),
        scu: .constant(""),
        onAdd: {}
    )
    .background(Color.black)
}
