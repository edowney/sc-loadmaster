//
//  CardHeaderView.swift
//  SC-LOADMASTER
//
//  Card header component for route cards
//

import SwiftUI

struct CardHeaderView: View {
    let fromLocation: String
    let toLocation: String

    var body: some View {
        ZStack(alignment: .leading) {
            Color.scHeaderBackground

            Text("\(fromLocation) → \(toLocation)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.scPrimary)
                .padding(.leading, 6)
        }
        .frame(height: 32)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(Color.scPrimary, lineWidth: 2, antialiased: true)
        )
        .cornerRadius(10, corners: [.topLeft])
    }
}

// Extension to support selective corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    CardHeaderView(fromLocation: "Everus Harbor", toLocation: "HDPC-Cassillo")
        .frame(width: 353)
}
