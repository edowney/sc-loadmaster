//
//  FooterView.swift
//  SC-LOADMASTER
//
//  Footer navigation component
//

import SwiftUI

struct FooterView: View {
    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
            Color.scBackground

            HStack(spacing: 50) {
                Button(action: { selectedTab = 0 }) {
                    Image(systemName: "doc.text")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(selectedTab == 0 ? .scPrimary : .white.opacity(0.6))
                }

                Button(action: { selectedTab = 1 }) {
                    Image(systemName: "list.bullet.rectangle")
                        .resizable()
                        .frame(width: 31, height: 37)
                        .foregroundColor(selectedTab == 1 ? .scPrimary : .white.opacity(0.6))
                }

                Button(action: { selectedTab = 2 }) {
                    Image(systemName: "ferry")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(selectedTab == 2 ? .scPrimary : .white.opacity(0.6))
                }
            }
            .padding(.top, 13)
        }
        .frame(width: 392, height: 75)
    }
}

#Preview {
    FooterView(selectedTab: .constant(0))
}
