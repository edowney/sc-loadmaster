import SwiftUI

struct LogView: View {
    @StateObject private var viewModel = LogViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Page title
            Text("LOG")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppTheme.textPrimary)
                .padding(.top, 10)

            if viewModel.logEntries.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Text("No completed deliveries yet")
                        .font(.system(size: 16))
                        .foregroundColor(AppTheme.textPrimary)

                    Text("Save deliveries from the Contracts page to see them here")
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                Spacer()
            } else {
                // Table header
                HStack(spacing: 8) {
                    Text("DATE")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                        .frame(width: 60, alignment: .leading)

                    Text("COLLECT")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("DELIVER")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("COMMODITY")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("SCU")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                        .frame(width: 40, alignment: .trailing)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 4)

                Divider()
                    .background(AppTheme.accent.opacity(0.3))

                // Table content
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.logEntries) { entry in
                            LogEntryRow(entry: entry)

                            if entry.id != viewModel.logEntries.last?.id {
                                Divider()
                                    .background(AppTheme.accent.opacity(0.2))
                            }
                        }
                    }
                }

                // Pagination controls
                HStack(spacing: 20) {
                    Button(action: viewModel.previousPage) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(viewModel.canGoToPreviousPage ? AppTheme.accent : AppTheme.textSecondary.opacity(0.3))
                    }
                    .disabled(!viewModel.canGoToPreviousPage)

                    Text(viewModel.pageIndicator)
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.textSecondary)

                    Button(action: viewModel.nextPage) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(viewModel.canGoToNextPage ? AppTheme.accent : AppTheme.textSecondary.opacity(0.3))
                    }
                    .disabled(!viewModel.canGoToNextPage)
                }
                .padding(.bottom, 10)
            }

            Spacer()
        }
        .onAppear {
            viewModel.refresh()
        }
    }
}

struct LogEntryRow: View {
    let entry: LogEntry

    var body: some View {
        HStack(spacing: 8) {
            Text(entry.dateFormatted)
                .font(.system(size: 11))
                .foregroundColor(AppTheme.textPrimary)
                .frame(width: 60, alignment: .leading)

            Text(truncate(entry.collectLocation, maxLength: 12))
                .font(.system(size: 11))
                .foregroundColor(AppTheme.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(truncate(entry.deliveryLocation, maxLength: 12))
                .font(.system(size: 11))
                .foregroundColor(AppTheme.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(truncate(entry.commodity, maxLength: 12))
                .font(.system(size: 11))
                .foregroundColor(AppTheme.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("\(entry.scuAmount)")
                .font(.system(size: 11))
                .foregroundColor(AppTheme.textPrimary)
                .frame(width: 40, alignment: .trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }

    private func truncate(_ text: String, maxLength: Int) -> String {
        if text.count > maxLength {
            return String(text.prefix(maxLength - 1)) + "…"
        }
        return text
    }
}

#Preview {
    LogView()
}
