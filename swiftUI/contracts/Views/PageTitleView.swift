//
//  PageTitleView.swift
//  SC-LOADMASTER
//
//  Page title component
//

import SwiftUI

struct PageTitleView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.scPrimary)
            .tracking(4.56)
            .frame(width: 392, height: 67)
    }
}

#Preview {
    PageTitleView(title: "CONTRACTS")
        .background(Color.black)
}
