import SwiftUI

struct ShipsView: View {
    @StateObject private var viewModel = ShipsViewModel()

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // Page title
                Text("SHIPS")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary)
                    .padding(.top, 10)

                // Input section
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Button(action: viewModel.addShip) {
                            Image("plus-circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                        }
                        .frame(width: AppTheme.buttonSize, height: AppTheme.buttonSize)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("NAME")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(AppTheme.textSecondary)

                            TextField("", text: $viewModel.nameInput)
                                .textFieldStyle(SCTextFieldStyle())
                                .autocorrectionDisabled()
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("CARGO SCU")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(AppTheme.textSecondary)

                            TextField("", text: $viewModel.cargoSCUInput)
                                .textFieldStyle(SCTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                    }
                    .padding(.horizontal, 16)

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .padding(.horizontal, 16)
                    }
                }

                // Ships list
                if viewModel.ships.isEmpty {
                    Spacer()
                    Text("No ships added yet")
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.textSecondary)
                    Spacer()
                } else {
                    VStack(spacing: 0) {
                        // Header
                        HStack {
                            Text("NAME")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(AppTheme.textSecondary)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("CARGO SCU")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(AppTheme.textSecondary)
                                .frame(width: 100, alignment: .trailing)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)

                        Divider()
                            .background(AppTheme.accent.opacity(0.3))

                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(viewModel.ships) { ship in
                                    ShipRow(ship: ship, onDelete: {
                                        viewModel.requestDelete(ship)
                                    })

                                    if ship.id != viewModel.ships.last?.id {
                                        Divider()
                                            .background(AppTheme.accent.opacity(0.2))
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }

                Spacer()
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
                    confirmAction: viewModel.confirmDelete,
                    cancelAction: viewModel.cancelDelete
                )
                .padding(.horizontal, 40)
            }
        }
    }
}

struct ShipRow: View {
    let ship: Ship
    let onDelete: () -> Void

    var body: some View {
        HStack {
            Button(action: onDelete) {
                Image("minus-circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .frame(width: 40, height: 40)

            Text(ship.name)
                .font(.system(size: 14))
                .foregroundColor(AppTheme.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("\(ship.cargoCapacitySCU)")
                .font(.system(size: 14))
                .foregroundColor(AppTheme.textPrimary)
                .frame(width: 100, alignment: .trailing)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
    }
}

#Preview {
    ShipsView()
}
