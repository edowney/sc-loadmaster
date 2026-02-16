//
//  AppHeaderView.swift
//  SC-LOADMASTER
//
//  App header component with title
//

import SwiftUI

struct AppHeaderView: View {
    var body: some View {
        ZStack {
            Color.scBackground

            Text("SC-LOADMASTER")
                .font(.custom("Audiowide-Regular", size: 30))
                .foregroundColor(.scPrimary)
                .padding(.bottom, 7)
        }
        .frame(width: 393, height: 99)
    }
}

#Preview {
    AppHeaderView()
}
