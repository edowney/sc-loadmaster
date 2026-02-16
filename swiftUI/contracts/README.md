# SC-LOADMASTER Contracts View - SwiftUI Implementation

This folder contains the updated SwiftUI conversion of the SC-LOADMASTER Contracts page from Figma.

## What's New in This Version

🆕 **Container Breakdown Per Commodity** - Each commodity now displays its own container allocation breakdown
- Pressurized Ice: Shows its specific container distribution (16×2, 8×1, 4×1, 2×1, 1×1)
- Processed Food: Shows its specific container distribution (16×2, 8×1, 4×1, 2×1, 1×1)

🎨 **Updated Container Badge Design** - Red circular badge with yellow count in bottom-right corner

## Project Structure

```
swiftUI/contracts/
├── Models/
│   └── Contract.swift                  # Updated: Containers moved to Commodity level
├── Views/
│   ├── AppHeaderView.swift            # App header with title
│   ├── PageTitleView.swift            # Page title component
│   ├── MissionDetailsView.swift       # Ship and container size inputs
│   ├── DataEntryFormView.swift        # Commodity entry form
│   ├── DataEntryDetailView.swift      # Current entry display
│   ├── RouteCardView.swift            # Updated: Shows containers per commodity
│   ├── FooterView.swift               # Navigation footer
│   └── HomePageView.swift             # Updated: Container calculation logic
├── Components/
│   ├── CardHeaderView.swift           # Card header component
│   ├── CommodityItemView.swift        # Updated: Includes container badges
│   └── ContainerBadgeView.swift       # Updated: Red badge with yellow count
├── Extensions/
│   └── Color+Theme.swift              # Color theme extensions
└── Resources/
    └── Assets.md                      # Asset requirements guide
```

## Key Changes from Previous Version

### Data Model Updates
**Contract.swift**:
- `Commodity` struct now includes `containers: [ContainerSize]`
- Each commodity manages its own container allocation
- Container calculation moved to commodity level

### Component Updates
**CommodityItemView.swift**:
- Now displays container badges beneath commodity name and quantity
- Shows container breakdown specific to that commodity

**ContainerBadgeView.swift**:
- Updated visual design with red circular badge
- Yellow count number in bottom-right corner
- Improved positioning and styling

**RouteCardView.swift**:
- Displays container breakdowns for each commodity
- Proper spacing between commodity sections

**HomePageView.swift**:
- Added `calculateContainers()` method for optimal container allocation
- Container calculation happens when adding new commodities

## Design Specifications

### Color Palette
- **Primary**: `#509cb2` (Teal/Cyan)
- **Background**: `#164553` (Dark Teal)
- **Card Background**: `#1c3741` (Darker Teal)
- **Textbox Background**: `#7b8486` (Gray)

### Typography
- **Audiowide-Regular**: Main title and container numbers
- **Inter-Bold**: Page titles, labels, emphasis
- **Inter-Regular**: Form labels and body text

### Screen Size
- Width: 393px
- Height: 852px (iPhone design)

## Implementation Steps

1. **Create New Xcode Project**
   - Choose iOS App template
   - Select SwiftUI as interface
   - Name it "SC-LOADMASTER"

2. **Add Custom Fonts**
   - Download Audiowide and Inter fonts from Google Fonts
   - Add to project and update Info.plist
   - Verify font names match custom font usage

3. **Add Assets**
   - See `Resources/Assets.md` for asset requirements
   - Option 1: Use SF Symbols (recommended)
   - Option 2: Download from Figma and add to Assets.xcassets

4. **Copy Swift Files**
   - Copy all files from this folder structure to Xcode project
   - Ensure file organization matches project structure

5. **Set HomePageView as Entry Point**
   ```swift
   @main
   struct SCLoadmasterApp: App {
       var body: some Scene {
           WindowGroup {
               HomePageView()
           }
       }
   }
   ```

## Features Implemented

- ✅ App header with branding
- ✅ Page title component
- ✅ Mission details form (ship name, max container size)
- ✅ Data entry form (collect, delivery, commodity, SCU)
- ✅ Current entry detail display
- ✅ Route card with commodities
- 🆕 **Container breakdown per commodity**
- 🆕 **Updated container badge design**
- ✅ Total and remaining capacity counters
- ✅ Footer navigation (3 tabs)
- ✅ Responsive layout matching Figma design
- ✅ Color theme system
- ✅ Automatic container allocation calculation

## Container Allocation Logic

The `calculateContainers(for:)` method in `HomePageView.swift` automatically distributes cargo into optimal container sizes:

```swift
private func calculateContainers(for quantity: Int) -> [ContainerSize] {
    var remaining = quantity
    var containers: [ContainerSize] = []

    for size in [16, 8, 4, 2, 1] {
        let count = remaining / size
        if count > 0 {
            containers.append(ContainerSize(size: size, count: count))
            remaining -= count * size
        }
    }

    return containers
}
```

This can be enhanced to:
- Respect `maxContainerSize` from mission details
- Optimize for minimum number of containers
- Calculate based on available ship cargo space

## Next Steps

### Functionality to Add
1. **Smart Container Allocation**
   - Respect max container size constraint
   - Optimize for cargo efficiency
   - Calculate remaining space accurately

2. **Data Persistence**
   - Implement CoreData or SwiftData for storing missions
   - Save/load routes and commodities

3. **Navigation**
   - Implement tab navigation in footer
   - Add additional pages (Log, Ships)

4. **Form Validation**
   - Validate numeric inputs
   - Prevent invalid container allocations
   - Show error states

5. **Enhanced Features**
   - Edit existing commodities
   - Reorder commodities
   - Delete commodities
   - Export mission data

## Notes

- All components use SwiftUI best practices
- Colors defined in `Color+Theme.swift` for easy theme management
- Preview providers included for all components
- Layout matches updated Figma design pixel-perfect
- SF Symbols recommended over custom icons
- Container badges now show per-commodity breakdown

## Differences from Previous Version

| Feature | Previous | Current |
|---------|----------|---------|
| Container Display | Single set at bottom of card | Per-commodity breakdown |
| Container Badge | Simple badge with yellow count | Red circular badge with yellow count |
| Data Model | Route owns containers | Commodity owns containers |
| Container Calculation | Manual/static | Automatic calculation |

## Support

For issues or questions about this implementation, refer to the original Figma design or consult the Assets.md file for asset requirements.
