import SwiftUI

struct AutocompleteTextField: View {
    let label: String
    @Binding var text: String
    let suggestions: [String]
    let onCommit: () -> Void

    @State private var showSuggestions = false
    @FocusState private var isFocused: Bool

    private var filteredSuggestions: [String] {
        ReferenceDataService.shared.filterItems(suggestions, searchText: text)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(AppTheme.textSecondary)
                .textCase(.uppercase)

            ZStack(alignment: .topLeading) {
                TextField("", text: $text)
                    .textFieldStyle(SCTextFieldStyle())
                    .focused($isFocused)
                    .onChange(of: text) { _ in
                        showSuggestions = !text.isEmpty && !filteredSuggestions.isEmpty
                    }
                    .onChange(of: isFocused) { focused in
                        if !focused {
                            showSuggestions = false
                        } else if !text.isEmpty {
                            showSuggestions = !filteredSuggestions.isEmpty
                        }
                    }
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)

                if showSuggestions && isFocused {
                    VStack(spacing: 0) {
                        Spacer()
                            .frame(height: AppTheme.inputHeight + 4)

                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(Array(filteredSuggestions.prefix(7)), id: \.self) { suggestion in
                                    Button(action: {
                                        text = suggestion
                                        showSuggestions = false
                                        isFocused = false
                                        onCommit()
                                    }) {
                                        HStack {
                                            Text(highlightedText(suggestion, matching: text))
                                                .font(.system(size: 14))
                                                .foregroundColor(AppTheme.textPrimary)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 10)
                                        .frame(maxWidth: .infinity)
                                        .background(AppTheme.inputBackground)
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                    if suggestion != filteredSuggestions.prefix(7).last {
                                        Divider()
                                            .background(AppTheme.accent.opacity(0.3))
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: 250)
                        .background(AppTheme.inputBackground)
                        .cornerRadius(AppTheme.cornerRadius)
                        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                }
            }
        }
    }

    private func highlightedText(_ text: String, matching search: String) -> AttributedString {
        var attributedString = AttributedString(text)

        guard !search.isEmpty else { return attributedString }

        let lowercasedText = text.lowercased()
        let lowercasedSearch = search.lowercased()

        if let range = lowercasedText.range(of: lowercasedSearch) {
            let startIndex = text.distance(from: text.startIndex, to: range.lowerBound)
            let endIndex = text.distance(from: text.startIndex, to: range.upperBound)

            if let attributedRange = Range<AttributedString.Index>(
                NSRange(location: startIndex, length: endIndex - startIndex),
                in: attributedString
            ) {
                attributedString[attributedRange].foregroundColor = AppTheme.accent
                attributedString[attributedRange].font = .system(size: 14, weight: .bold)
            }
        }

        return attributedString
    }
}

struct SCTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .background(AppTheme.inputBackground)
            .foregroundColor(AppTheme.textPrimary)
            .cornerRadius(AppTheme.cornerRadius)
            .frame(height: AppTheme.inputHeight)
    }
}
