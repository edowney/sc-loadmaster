import SwiftUI

struct ContractCardView: View {
    let card: ContractCard
    let cardNumber: Int
    let shipCapacity: Int?
    let onMoveBack: (UUID) -> Void
    let onSave: (UUID) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Card header
            HStack {
                Text("\(cardNumber) \(card.collectLocation) → \(card.deliveryLocation)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary)
                Spacer()
            }
            .padding(.bottom, 4)

            // Card entries
            ForEach(Array(card.entries.enumerated()), id: \.element.id) { index, entry in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Button(action: { onMoveBack(entry.id) }) {
                            Image("arrow-up-circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        .frame(width: 40, height: 40)

                        Text(entry.commodity)
                            .font(.system(size: 14))
                            .foregroundColor(AppTheme.textPrimary)

                        Spacer()

                        Text("\(entry.scuAmount)")
                            .font(.system(size: 14))
                            .foregroundColor(AppTheme.textPrimary)

                        Button(action: { onSave(entry.id) }) {
                            Image("save")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        .frame(width: 40, height: 40)
                    }

                    ContainerVisualizationView(distribution: entry.containers)
                        .padding(.leading, 40)
                }

                if index < card.entries.count - 1 {
                    Divider()
                        .background(AppTheme.accent.opacity(0.2))
                }
            }

            // Card footer
            if let capacity = shipCapacity {
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Total \(card.totalSCU)")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.accent)

                        Text("Remaining \(card.remainingCapacity(shipCapacity: capacity))")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.accent)
                    }
                }
            }
        }
        .padding(AppTheme.cardPadding)
        .background(AppTheme.cardBackground)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
    }
}
