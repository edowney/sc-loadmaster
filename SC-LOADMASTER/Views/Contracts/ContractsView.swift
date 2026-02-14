import SwiftUI

struct ContractsView: View {
    @StateObject private var viewModel = ContractsViewModel()
    private let referenceData = ReferenceDataService.shared

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Page title
                    Text("CONTRACTS")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary)
                        .padding(.top, 10)

                    // Ship and Max Container Size fields
                    VStack(spacing: 12) {
                        AutocompleteTextField(
                            label: "SHIP",
                            text: $viewModel.shipName,
                            suggestions: viewModel.ships.map { $0.name },
                            onCommit: {}
                        )

                        NumericTextField(
                            label: "MAX CONTAINER SIZE",
                            value: $viewModel.maxContainerSize
                        )
                    }
                    .padding(.horizontal, 16)

                    // Contract Details Section (Progressive Disclosure)
                    if viewModel.showContractDetailsSection {
                        VStack(spacing: 12) {
                            HStack(spacing: 8) {
                                AutocompleteTextField(
                                    label: "COLLECT",
                                    text: $viewModel.collectLocation,
                                    suggestions: referenceData.locations,
                                    onCommit: {}
                                )

                                AutocompleteTextField(
                                    label: "DELIVERY",
                                    text: $viewModel.deliveryLocation,
                                    suggestions: referenceData.locations,
                                    onCommit: {}
                                )
                            }

                            HStack(spacing: 8) {
                                AutocompleteTextField(
                                    label: "COMMODITY",
                                    text: $viewModel.commodity,
                                    suggestions: referenceData.commodities,
                                    onCommit: {}
                                )

                                NumericTextField(
                                    label: "SCU",
                                    value: $viewModel.scuAmount
                                )
                                .frame(maxWidth: 100)

                                Button(action: viewModel.addEntry) {
                                    Image("plus-circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 28, height: 28)
                                }
                                .frame(width: AppTheme.buttonSize, height: AppTheme.buttonSize)
                                .offset(y: 12)
                            }

                            if let error = viewModel.errorMessage {
                                Text(error)
                                    .font(.system(size: 12))
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    // Contract Entry List
                    if !viewModel.contractEntries.isEmpty {
                        VStack(spacing: 8) {
                            ForEach(viewModel.contractEntries) { entry in
                                ContractEntryRow(
                                    entry: entry,
                                    onDelete: { viewModel.requestDeleteEntry(entry) },
                                    onMoveToCard: { viewModel.moveEntryToCard(entry) }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    // Contract Cards
                    if !viewModel.contractCards.isEmpty {
                        VStack(spacing: 16) {
                            ForEach(viewModel.contractCards) { card in
                                ContractCardView(
                                    card: card,
                                    cardNumber: viewModel.getCardNumber(card),
                                    shipCapacity: viewModel.selectedShip.map { Int($0.cargoCapacitySCU) },
                                    onMoveBack: { entryId in
                                        viewModel.moveEntryBackToList(cardId: card.id, entryId: entryId)
                                    },
                                    onSave: { entryId in
                                        viewModel.saveEntryToLog(cardId: card.id, entryId: entryId)
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    Spacer(minLength: 40)
                }
            }

            // Delete confirmation dialog
            if viewModel.showDeleteConfirmation {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.cancelDelete()
                    }

                ConfirmationDialog(
                    title: viewModel.deleteConfirmationTitle,
                    message: nil,
                    confirmTitle: "Delete",
                    confirmAction: viewModel.confirmDeleteEntry,
                    cancelAction: viewModel.cancelDelete
                )
                .padding(.horizontal, 40)
            }
        }
        .onAppear {
            viewModel.fetchShips()
        }
    }
}

struct ContractEntryRow: View {
    let entry: ContractEntry
    let onDelete: () -> Void
    let onMoveToCard: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Button(action: onDelete) {
                Image("minus-circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .frame(width: 40, height: 40)

            Text(entry.collectLocation)
                .font(.system(size: 12))
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(entry.deliveryLocation)
                .font(.system(size: 12))
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(entry.commodity)
                .font(.system(size: 12))
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("\(entry.scuAmount)")
                .font(.system(size: 12))
                .foregroundColor(AppTheme.textPrimary)
                .frame(width: 40, alignment: .trailing)

            Button(action: onMoveToCard) {
                Image("arrow-down-circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .frame(width: 40, height: 40)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(AppTheme.cardBackground)
        .cornerRadius(AppTheme.cornerRadius)
    }
}

#Preview {
    ContractsView()
}
