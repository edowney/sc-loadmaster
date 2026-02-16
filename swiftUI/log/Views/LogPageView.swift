//
//  LogPageView.swift
//  SC-LOADMASTER
//
//  Main Log page view displaying historical cargo deliveries
//

import SwiftUI

struct LogPageView: View {
    // Sample data - in production, this would come from persistent storage
    @State private var logEntries: [LogEntry] = LogEntry.sampleData

    // Pagination
    @State private var currentPage: Int = 1
    let entriesPerPage: Int = 7

    var totalPages: Int {
        max(1, Int(ceil(Double(logEntries.count) / Double(entriesPerPage))))
    }

    var currentPageEntries: [LogEntry] {
        let startIndex = (currentPage - 1) * entriesPerPage
        let endIndex = min(startIndex + entriesPerPage, logEntries.count)

        guard startIndex < logEntries.count else { return [] }
        return Array(logEntries[startIndex..<endIndex])
    }

    var body: some View {
        ZStack {
            // Background
            Color.black.ignoresSafeArea()

            // Background image with opacity
            Image("background-image") // Replace with actual asset name
                .resizable()
                .scaledToFill()
                .frame(width: 393, height: 852)
                .opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // App header
                AppHeaderView()

                // Page title
                PageTitleView(title: "LOG")
                    .padding(.top, 10)

                Spacer()
                    .frame(height: 16)

                // Log table
                if logEntries.isEmpty {
                    // Empty state
                    VStack(spacing: 16) {
                        Text("No completed deliveries yet")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)

                        Text("Save deliveries from the Contracts page to see them here")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    LogTableView(entries: currentPageEntries)
                        .padding(.top, 0)

                    // Pagination controls (if more than 7 entries)
                    if totalPages > 1 {
                        HStack(spacing: 20) {
                            // Previous button
                            Button(action: {
                                if currentPage > 1 {
                                    currentPage -= 1
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(currentPage > 1 ? .scPrimary : .gray)
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .disabled(currentPage <= 1)

                            // Page indicator
                            Text("Page \(currentPage) of \(totalPages)")
                                .font(.system(size: 12))
                                .foregroundColor(.white)

                            // Next button
                            Button(action: {
                                if currentPage < totalPages {
                                    currentPage += 1
                                }
                            }) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(currentPage < totalPages ? .scPrimary : .gray)
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .disabled(currentPage >= totalPages)
                        }
                        .padding(.top, 20)
                    }
                }

                Spacer()

                // Footer navigation
                FooterView()
            }
        }
        .frame(width: 393, height: 852)
    }
}

#Preview {
    LogPageView()
}
