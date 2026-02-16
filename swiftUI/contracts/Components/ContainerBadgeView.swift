//
//  ContainerBadgeView.swift
//  SC-LOADMASTER
//
//  Container size badge component with count indicator
//

import SwiftUI

struct ContainerBadgeView: View {
    let size: Int
    let count: Int

    var body: some View {
        ZStack {
            // Badge background with border
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.scPrimary, lineWidth: 2)
                .frame(width: 50, height: 42)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.scCardBackground.opacity(0.5))
                )

            VStack(spacing: 0) {
                // Container size number
                Text("\(size)")
                    .font(.custom("Audiowide-Regular", size: 16))
                    .foregroundColor(.scPrimary)
                    .offset(y: -3)

                Spacer()
            }
            .frame(height: 42)

            // Count badge (bottom right)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 18, height: 18)

                        Text("\(count)")
                            .font(.custom("Audiowide-Regular", size: 12))
                            .foregroundColor(.yellow)
                    }
                    .offset(x: 5, y: 5)
                }
            }
            .frame(width: 50, height: 42)
        }
        .frame(width: 50, height: 42)
    }
}

#Preview {
    HStack(spacing: 8) {
        ContainerBadgeView(size: 16, count: 2)
        ContainerBadgeView(size: 8, count: 1)
        ContainerBadgeView(size: 4, count: 1)
        ContainerBadgeView(size: 2, count: 1)
        ContainerBadgeView(size: 1, count: 1)
    }
    .padding()
    .background(Color.scCardBackground)
}
