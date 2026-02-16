# SC-LOADMASTER Ships Page - SwiftUI Implementation

This folder contains the SwiftUI implementation of the SC-LOADMASTER Ships page, converted from Figma design.

## Project Structure

```
swiftUI/ships/
├── Models/
│   └── Ship.swift                  # Ship data model with validation
├── Components/
│   ├── ShipInputView.swift         # Input section for adding ships
│   └── ShipRowView.swift           # Individual ship row component
├── Views/
│   ├── ShipPageView.swift          # Main ships page view
│   └── ShipTableView.swift         # Table container with headers
└── README.md                       # This file
```

## Features Implemented

- ✅ App header with branding (reused from Contracts)
- ✅ Page title "SHIPS" with letter tracking (reused from Contracts)
- ✅ Input section with NAME and CARGO SCU fields
- ✅ Plus (+) button to add ships
- ✅ Table headers: NAME | CARGO SCU
- ✅ Ship rows with alternating backgrounds
- ✅ Delete buttons (minus icons) with confirmation dialog
- ✅ Input validation (required fields, positive numbers, max length)
- ✅ Duplicate name checking
- ✅ Empty state message
- ✅ Footer navigation (reused from Contracts)
- ✅ Responsive layout matching Figma design
- ✅ Color theme system (reused from Contracts)

## Design Specifications

### Colors
Uses the established color system from `swiftUI/contracts/Extensions/Color+Theme.swift`:
- **Primary**: `#509cb2` (Teal/Cyan) - `.scPrimary`
- **Background**: `#164553` (Dark Teal) - `.scBackground`
- **Textbox**: `#7b8486` (Gray) - `.scTextbox`
- **Border**: Primary color with 2px width
- **Text**: White

### Typography
- **App Title**: Audiowide-Regular, 30pt
- **Page Title**: Inter-Bold, 24pt, letter tracking 4.56
- **Labels**: Inter-Regular, 12pt
- **Table Headers**: Inter-Semibold, 12pt
- **Table Data**: Inter-Regular, 12pt

### Layout
- **Screen Size**: 393×852 (iPhone design)
- **Input Section**:
  - Height: 34px
  - Plus icon: 20×20px
  - NAME field: 137px wide, 30px height
  - CARGO SCU field: 50px wide, 30px height
  - Border radius: 5px, 2px black border
- **Table**:
  - Width: 357px
  - Row height: 33px
  - Border: 2px, rounded corners (10px)
  - Alternating rows: Odd transparent, even dark teal

## Data Model

### Ship
```swift
struct Ship: Identifiable {
    let id: UUID
    var name: String
    var cargoCapacitySCU: Int

    var isValid: Bool
    static func validate(name: String, cargo: String) -> ValidationResult
}
```

### Validation Rules
- **Name**: Required, 1-50 characters, unique (case-insensitive)
- **Cargo SCU**: Required, must be positive integer

## Components

### ShipPageView
Main page view that:
- Displays app header and page title
- Shows input section for adding ships
- Renders ship table or empty state
- Handles add/delete operations
- Shows validation errors
- Includes confirmation dialogs
- Includes footer navigation

### ShipInputView
Input section component that:
- Displays plus icon button
- Shows NAME text field
- Shows CARGO SCU text field
- Calls add callback when plus button tapped
- Applies proper styling and layout

### ShipTableView
Table container that:
- Renders column headers
- Displays ship rows
- Handles delete callbacks
- Applies border and rounded corners

### ShipRowView
Individual row component that:
- Displays minus icon button
- Shows ship name
- Shows cargo capacity
- Applies alternating background
- Calls delete callback

## Reusable Components (from Contracts)

The following components are reused from `swiftUI/contracts/`:
- **AppHeaderView** - App branding header
- **PageTitleView** - Page title with letter tracking
- **FooterView** - Navigation footer
- **Color+Theme.swift** - Color system extensions

## Implementation Notes

### Input Validation
- **Real-time validation** on add button tap
- **Error alerts** show specific validation messages
- **Duplicate checking** prevents same ship name twice
- **Number validation** ensures positive integers for cargo

### Delete Confirmation
- **Confirmation dialog** required for all deletions
- **Ship name displayed** in confirmation message
- **Cancel option** to abort deletion
- **Destructive button style** for delete action

### Empty State
When no ships exist:
- Displays "No ships in your fleet yet"
- Shows helpful message to guide user
- Centered on screen

### Data Persistence
Current implementation uses sample data. For production:
- Integrate with Core Data or SwiftData
- Load ships from persistent storage
- Save after add/delete operations
- Sync with Contracts page ship dropdown

## Integration Steps

1. **Copy Files to Xcode Project**
   - Copy all files from this folder structure to your Xcode project
   - Ensure file organization matches project structure

2. **Link Reusable Components**
   - Ensure `AppHeaderView`, `PageTitleView`, and `FooterView` are accessible
   - Link `Color+Theme.swift` extension file
   - Verify all imports resolve correctly

3. **Add Background Image Asset**
   - Add background image to Assets.xcassets
   - Name it "background-image" or update reference in ShipPageView

4. **Configure Fonts**
   - Ensure Audiowide and Inter fonts are added to project
   - Update Info.plist with font references

5. **Set Up Navigation**
   - Integrate ShipPageView with app navigation system
   - Link footer buttons to navigate between pages

6. **Connect to Contracts Page**
   - Share ships data between pages
   - Update ship dropdown in Contracts when ships change
   - Use shared data model or persistence layer

## Next Steps

### Data Integration
1. Implement Core Data or SwiftData model
2. Create data persistence service
3. Load ships from storage on view appear
4. Save after add/delete operations
5. Share data with Contracts page

### Features to Add
1. **Edit Ships**
   - Tap row to edit ship details
   - Update name and cargo capacity
   - Save changes with validation

2. **Sort/Filter**
   - Sort by name or capacity
   - Filter ships by criteria
   - Search functionality

3. **Ship Details**
   - Add ship manufacturer
   - Add ship type/class
   - Add ship image/icon
   - Show additional metadata

4. **Import/Export**
   - Import ship data from file
   - Export fleet list
   - Share functionality

5. **Usage Tracking**
   - Show which ships are in active contracts
   - Display usage history
   - Warning before deleting in-use ships

## Testing Checklist

- [ ] Input section displays correctly
- [ ] Plus button adds ship when valid
- [ ] Validation shows errors for invalid input
- [ ] Duplicate ship names are rejected
- [ ] Table displays ships correctly
- [ ] Alternating row backgrounds work
- [ ] Minus button shows confirmation dialog
- [ ] Deletion works after confirmation
- [ ] Empty state displays when no ships
- [ ] Footer navigation buttons work
- [ ] Border and rounded corners display correctly
- [ ] Colors match Figma design
- [ ] Typography matches design specifications
- [ ] Keyboard dismisses properly
- [ ] Number keyboard shows for cargo field

## Differences from PRD

| PRD Specification | Figma Design | Implementation |
|-------------------|--------------|----------------|
| Table/Grid structure | Card with border | Implemented as designed |
| Delete icon position | Left of row | Implemented as designed |
| Add button position | Left of inputs | Implemented as designed (plus icon) |

## Support

For questions or issues with this implementation, refer to:
- Original Figma design file
- SC-LOADMASTER PRD (Section 2.3: Ships Page)
- `swiftUI/contracts/README.md` for architectural patterns
