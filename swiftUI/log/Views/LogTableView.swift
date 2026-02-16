//
//  LogTableView.swift
//  SC-LOADMASTER
//
//  Table container for log entries with headers and rows
//

import SwiftUI

struct LogTableView: View {
    let entries: [LogEntry]

    var body: some View {
        VStack(spacing: 0) {
            // Table headers
            HStack(spacing: 0) {
                Text("DATE")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 60, alignment: .leading)
                    .padding(.leading, 26)

                Text("COLLECT-DELIVER")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 140, alignment: .leading)
                    .padding(.leading, 5)

                Spacer()

                Text("COMMODITY")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.trailing, 10)

                Text("SCU")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, alignment: .trailing)
                    .padding(.trailing, 24)
            }
            .padding(.bottom, 16)

            // Table container
            VStack(spacing: 0) {
                ForEach(Array(entries.enumerated()), id: \.element.id) { index, entry in
                    VStack(spacing: 0) {
                        LogRowView(entry: entry, isAlternating: index % 2 == 1)

                        // Border between rows
                        if index < entries.count - 1 {
                            Rectangle()
                                .fill(Color.scPrimary)
                                .frame(height: 2)
                        }
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.scPrimary, lineWidth: 2)
            )
        }
        .frame(width: 357)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        LogTableView(entries: Array(LogEntry.sampleData.prefix(4)))
    }
}
