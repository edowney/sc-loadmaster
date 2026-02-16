//
//  MissionDetailsView.swift
//  SC-LOADMASTER
//
//  Mission details form (ship name and max container size)
//

import SwiftUI

struct MissionDetailsView: View {
    @Binding var shipName: String
    @Binding var maxContainerSize: String

    var body: some View {
        HStack(spacing: 15) {
            // Ship name
            HStack(spacing: 6) {
                Text("SHIP")
                    .font(.system(size: 12))
                    .foregroundColor(.white)

                TextField("", text: $shipName)
                    .padding(.horizontal, 8)
                    .frame(width: 137, height: 30)
                    .background(Color.scTextboxBackground)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }

            // Max container size
            HStack(spacing: 6) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("MAX")
                    Text("CONTAINER")
                    Text("SIZE")
                }
                .font(.system(size: 12))
                .foregroundColor(.white)
                .fixedSize()

                TextField("", text: $maxContainerSize)
                    .padding(.horizontal, 8)
                    .frame(width: 85, height: 30)
                    .background(Color.scTextboxBackground)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
        }
        .frame(width: 392, height: 68)
        .padding(.horizontal, 20)
    }
}

#Preview {
    MissionDetailsView(
        shipName: .constant(""),
        maxContainerSize: .constant("")
    )
    .background(Color.black)
}
