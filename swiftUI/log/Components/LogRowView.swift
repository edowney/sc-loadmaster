//
//  LogRowView.swift
//  SC-LOADMASTER
//
//  Individual log entry row component
//

import SwiftUI

struct LogRowView: View {
    let entry: LogEntry
    let isAlternating: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 11) {
            // Date column
            Text(entry.formattedDate)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .frame(width: 60, alignment: .leading)

            // Collect-Deliver column (stacked)
            VStack(alignment: .leading, spacing: 10) {
                Text(entry.collectLocation)
                    .font(.system(size: 12))
                    .foregroundColor(.white)

                Text(entry.deliveryLocation)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }
            .frame(width: 129, alignment: .leading)

            Spacer()

            // Commodity column
            Text(entry.commodity)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .frame(alignment: .center)

            Spacer()

            // SCU column
            Text("\(entry.scuAmount)")
                .font(.system(size: 12))
                .foregroundColor(.white)
                .frame(width: 30, alignment: .trailing)
        }
        .padding(.horizontal, 11)
        .frame(height: 66)
        .background(isAlternating ? Color.scBackground : Color.clear)
    }
}

#Preview {
    VStack(spacing: 0) {
        LogRowView(entry: LogEntry.sampleData[0], isAlternating: false)
        LogRowView(entry: LogEntry.sampleData[1], isAlternating: true)
        LogRowView(entry: LogEntry.sampleData[2], isAlternating: false)
        LogRowView(entry: LogEntry.sampleData[3], isAlternating: true)
    }
    .background(Color.black)
}
