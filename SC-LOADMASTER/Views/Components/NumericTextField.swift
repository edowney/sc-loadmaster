import SwiftUI

struct NumericTextField: View {
    let label: String
    @Binding var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(AppTheme.textSecondary)
                .textCase(.uppercase)

            TextField("", text: $value)
                .textFieldStyle(SCTextFieldStyle())
                .keyboardType(.numberPad)
        }
    }
}

struct ConfirmationDialog: View {
    let title: String
    let message: String?
    let confirmTitle: String
    let confirmAction: () -> Void
    let cancelAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(AppTheme.textPrimary)

            if let message = message {
                Text(message)
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
            }

            HStack(spacing: 16) {
                Button(action: cancelAction) {
                    Text("Cancel")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(AppTheme.textPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(AppTheme.inputBackground)
                        .cornerRadius(AppTheme.cornerRadius)
                }

                Button(action: confirmAction) {
                    Text(confirmTitle)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.red)
                        .cornerRadius(AppTheme.cornerRadius)
                }
            }
        }
        .padding(24)
        .background(AppTheme.cardBackground)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
    }
}
