//
//  ShipPageView.swift
//  SC-LOADMASTER
//
//  Main Ships page view for managing user's fleet
//

import SwiftUI

struct ShipPageView: View {
    // Sample data - in production, this would come from persistent storage
    @State private var ships: [Ship] = Ship.sampleData

    // Input fields
    @State private var shipName: String = ""
    @State private var cargoSCU: String = ""

    // Alert state
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    // Delete confirmation
    @State private var showDeleteConfirmation: Bool = false
    @State private var shipToDelete: Ship?

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
                PageTitleView(title: "SHIPS")
                    .padding(.top, 0)

                Spacer()
                    .frame(height: 0)

                // Input section
                ShipInputView(
                    shipName: $shipName,
                    cargoSCU: $cargoSCU,
                    onAdd: addShip
                )
                .padding(.top, 0)

                Spacer()
                    .frame(height: 27)

                // Ships table or empty state
                if ships.isEmpty {
                    // Empty state
                    VStack(spacing: 16) {
                        Text("No ships in your fleet yet")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)

                        Text("Add ships above to see them here")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    ShipTableView(
                        ships: ships,
                        onDelete: confirmDelete
                    )
                }

                Spacer()

                // Footer navigation
                FooterView()
            }
        }
        .frame(width: 393, height: 852)
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
        .alert("Delete \(shipToDelete?.name ?? "Ship")?", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) {
                shipToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let ship = shipToDelete {
                    deleteShip(ship)
                }
            }
        } message: {
            Text("This action cannot be undone.")
        }
    }

    // MARK: - Actions

    private func addShip() {
        let validation = Ship.validate(name: shipName, cargo: cargoSCU)

        guard validation.isValid else {
            alertMessage = validation.errorMessage ?? "Invalid input"
            showAlert = true
            return
        }

        // Check for duplicate name
        let trimmedName = shipName.trimmingCharacters(in: .whitespaces)
        if ships.contains(where: { $0.name.lowercased() == trimmedName.lowercased() }) {
            alertMessage = "A ship with this name already exists"
            showAlert = true
            return
        }

        // Create and add new ship
        let newShip = Ship(
            name: trimmedName,
            cargoCapacitySCU: Int(cargoSCU) ?? 0
        )

        ships.append(newShip)

        // Clear input fields
        shipName = ""
        cargoSCU = ""
    }

    private func confirmDelete(_ ship: Ship) {
        shipToDelete = ship
        showDeleteConfirmation = true
    }

    private func deleteShip(_ ship: Ship) {
        ships.removeAll { $0.id == ship.id }
        shipToDelete = nil
    }
}

#Preview {
    ShipPageView()
}
