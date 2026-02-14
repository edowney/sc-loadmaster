# SC-LOADMASTER Product Requirements Document

## 1. Product Overview

### 1.1 Product Name
**SC-LOADMASTER**

### 1.2 Product Vision
SC-LOADMASTER is an iOS mobile application designed to assist Star Citizen players in managing cargo transportation contracts. The app streamlines the process of calculating container requirements, tracking completed deliveries, and managing ship inventories.

### 1.3 Target Users
- Star Citizen players who engage in cargo transportation gameplay
- Players who need to optimize cargo container usage
- Players managing multiple ships with different cargo capacities

### 1.4 Core Value Proposition
The app eliminates manual calculation errors when determining cargo container requirements, provides a clear visual representation of container distribution, and maintains a historical log of completed cargo runs.

---

## 2. Functional Requirements

### 2.1 Contracts Page (Home Screen)

#### 2.1.1 Initial State
**Display Elements:**
- Page title: "CONTRACTS" (centered, prominent)
- Ship field (autocomplete text input)
- Max Container Size field (positive integer input)

**Behavior:**
- Only these two fields are visible initially
- Both fields must have valid values before additional fields appear
- Progressive disclosure pattern: form expands as user completes sections

#### 2.1.2 Ship Field
**Type:** Autocomplete text input

**Data Source:**
- Populated from ships added in the Ships page
- Should match ship names as user types
- **Substring matching:** User can type any part of the ship name (e.g., "hull" matches "MISC **Hull** A")
- Case-insensitive matching

**Validation:**
- Must match an existing ship name from Ships page
- Required field

**Visual Feedback:**
- Show autocomplete suggestions as dropdown/overlay
- Highlight matching text within suggestions
- Grey text box (as per design)

**Examples:**
- Typing "raft" matches "ARGO **RAFT**"
- Typing "misc" matches "**MISC** Hull A"
- Typing "hull" matches "MISC **Hull** A"

#### 2.1.3 Max Container Size Field
**Type:** Positive integer input

**Validation:**
- Must be a positive integer greater than 0
- Only numeric input allowed
- Represents the largest container size available for this contract
- Valid values: typically 1, 2, 4, 8, 16, or 32 (but accept any positive integer)

**Behavior:**
- Used as the starting point for container calculation algorithm
- Critical for determining optimal container distribution

#### 2.1.4 Contract Details Section (Progressive Disclosure)

**Trigger:** Appears when Ship and Max Container Size fields both have valid values

**Display Elements:**
- Section header labels: COLLECT, DELIVERY, COMMODITY, SCU
- Four text input fields aligned horizontally
- Plus icon (+) button to the right of the fields

**Field Specifications:**

**COLLECT Field:**
- Type: Autocomplete text input
- Data: Star Citizen location names (collection points)
- **Matching:** Substring matching (e.g., "har" matches "Everus Harbor", "HDPC" matches "HDPC-Cassillo")
- Validation: Required field
- Note: Specific location list to be provided during implementation

**DELIVERY Field:**
- Type: Autocomplete text input
- Data: Star Citizen location names (delivery points)
- **Matching:** Substring matching (e.g., "cas" matches "HDPC-Cassillo")
- Validation: Required field
- Note: Specific location list to be provided during implementation

**COMMODITY Field:**
- Type: Autocomplete text input
- Data: Star Citizen commodity names
- **Matching:** Substring matching (e.g., "ice" matches "Pressurized Ice", "food" matches "Processed Food")
- Validation: Required field
- Note: Specific commodity list to be provided during implementation

**SCU Field:**
- Type: Positive integer input
- Validation: Must be positive integer greater than 0
- Represents: Total SCU (Standard Cargo Units) for this commodity shipment

#### 2.1.5 Contract Entry List

**Trigger:** Appears below the Contract Details Section when at least one entry has been added

**Entry Creation:**
- User fills all four fields (COLLECT, DELIVERY, COMMODITY, SCU)
- User clicks the plus icon (+)
- Entry is added to the list immediately

**List Entry Display Format:**
```
[−] [COLLECT NAME] [DELIVERY NAME] [COMMODITY NAME] [SCU AMOUNT] [↓]
```

**Example:**
```
[−] Everus Harbor  HDPC-Cassillo  Pressurized Ice  176  [↓]
```

**Interactive Elements:**

**Minus Icon (−):**
- Position: Left side of entry
- Action: Delete entry from list
- Behavior: 
  - Display confirmation dialog before deletion
  - Confirmation required for all deletions in app
  - If confirmed, remove entry from list immediately

**Down Arrow Icon (↓):**
- Position: Right side of entry
- Action: Convert entry to Contract Card
- Behavior:
  - Remove entry from list
  - Create new Contract Card below the list OR
  - Add to existing Contract Card if COLLECT and DELIVERY match

#### 2.1.6 Contract Cards

**Card Creation:**
- Created when user clicks down arrow (↓) on a list entry
- Multiple cards can exist simultaneously
- Cards are grouped by unique COLLECT → DELIVERY route combinations

**Card Header Format:**
```
[CARD NUMBER] [COLLECT LOCATION] → [DELIVERY LOCATION]
```

**Example:**
```
1 Everus Harbor → HDPC-Cassillo
```

**Card Body - Commodity Entry Format:**

Each commodity entry displays:
```
[↑] [COMMODITY NAME]     [SCU AMOUNT]  [💾]
    [Container Visualization]
```

**Example:**
```
[↑] Pressurized Ice      12  [💾]
    [8₂] [4₁]

[↑] Processed Food      127  [💾]
    [16₇] [8₁] [4₁] [2₁] [1₁]
```

**Interactive Elements:**

**Up Arrow Icon (↑):**
- Position: Left side of commodity entry
- Action: Move entry back to Contract Entry List
- Behavior:
  - Remove from card
  - Add back to list above
  - If card becomes empty, remove entire card

**Floppy Disk Icon (💾):**
- Position: Right side of commodity entry
- Action: Save to Log
- Behavior:
  - Remove entry from card
  - Save to Log page with current timestamp
  - Data saved: Date, COLLECT, DELIVERY, COMMODITY, SCU
  - If card becomes empty, remove entire card

#### 2.1.7 Container Visualization Algorithm

**Purpose:** Calculate and display the optimal distribution of cargo containers needed to transport the specified SCU amount

**Container Sizes Available:** 16, 8, 4, 2, 1 SCU

**Algorithm Steps:**

```
FUNCTION calculateContainers(totalSCU, maxContainerSize):
    containers = {}  // Dictionary to store container counts
    remainingSCU = totalSCU
    containerSizes = [16, 8, 4, 2, 1]  // Sorted descending
    
    // Filter container sizes to only use sizes <= maxContainerSize
    availableSizes = filterSizes(containerSizes, maxContainerSize)
    
    FOR EACH size IN availableSizes (descending order):
        IF remainingSCU >= size:
            count = FLOOR(remainingSCU / size)
            containers[size] = count
            remainingSCU = remainingSCU - (count * size)
    
    RETURN containers
```

**Detailed Example:**
- Total SCU: 127
- Max Container Size: 16

**Step-by-step calculation:**
1. 127 ÷ 16 = 7 remainder 15 → Seven 16-SCU containers (7 × 16 = 112)
2. Remaining: 127 - 112 = 15
3. 15 ÷ 8 = 1 remainder 7 → One 8-SCU container (1 × 8 = 8)
4. Remaining: 15 - 8 = 7
5. 7 ÷ 4 = 1 remainder 3 → One 4-SCU container (1 × 4 = 4)
6. Remaining: 7 - 4 = 3
7. 3 ÷ 2 = 1 remainder 1 → One 2-SCU container (1 × 2 = 2)
8. Remaining: 3 - 2 = 1
9. 1 ÷ 1 = 1 remainder 0 → One 1-SCU container (1 × 1 = 1)
10. Remaining: 1 - 1 = 0 ✓

**Result:** [16₇] [8₁] [4₁] [2₁] [1₁]

**Verification:** (7 × 16) + (1 × 8) + (1 × 4) + (1 × 2) + (1 × 1) = 112 + 8 + 4 + 2 + 1 = 127 ✓

**Visual Display:**
- Container size shown as icon/badge with the number
- Count shown in a yellow number inside a red circle (subscript style)
- Only display containers that are needed (count > 0)
- Order: Descending by size (16, 8, 4, 2, 1)

**Icon Representation:**
```
[SIZE₍COUNT₎]
```
Where:
- SIZE = Container size in SCU (16, 8, 4, 2, or 1)
- COUNT = Number of containers needed (shown in yellow text in red circle)

#### 2.1.8 Card Formatting

**Entry Separator:**
- Horizontal rule line between each commodity entry
- Consistent styling with app theme

**Card Footer Display:**

After the last commodity entry, display:

```
Total [TOTAL_SCU]
Remaining [REMAINING_CAPACITY]
```

**Calculations:**
- **TOTAL_SCU:** Sum of all SCU values for all commodity entries in the card
- **REMAINING_CAPACITY:** Ship's cargo capacity - TOTAL_SCU
  - Ship cargo capacity comes from the selected ship in the Ship field
  - Look up capacity value from Ships page data

**Example:**
```
Total 139
Remaining 57
```
(If ship capacity is 196 SCU)

**Formatting:**
- Right-aligned text
- Distinct color (cyan/teal as shown in design)
- Clear visual separation from commodity entries

#### 2.1.9 Field Clearing and Reset

**Behavior After Adding to List:**
- After user clicks plus (+) to add an entry to the list
- Clear all four fields (COLLECT, DELIVERY, COMMODITY, SCU)
- Keep Ship and Max Container Size values unchanged
- Focus returns to COLLECT field for next entry

---

### 2.2 Log Page

#### 2.2.1 Page Purpose
Read-only historical record of all completed cargo deliveries that have been saved from the Contracts page using the floppy disk icon (💾).

#### 2.2.2 Page Layout

**Header:**
- Page title: "LOG" (centered, prominent)

**Table Structure:**
- Column headers: DATE | COLLECT | DELIVER | COMMODITY | SCU
- Data rows displaying saved delivery records
- Responsive table design for mobile viewing

#### 2.2.3 Data Display

**Date Format:**
- MM/DD/YY format (e.g., "02/13/26")
- Automatically captured when floppy disk icon is clicked
- Uses device's current date/time

**Column Specifications:**
- **DATE:** Date the entry was saved (not the delivery date)
- **COLLECT:** Collection location name
- **DELIVER:** Delivery location name (note: "DELIVER" not "DELIVERY")
- **COMMODITY:** Commodity name
- **SCU:** Total SCU amount as integer

**Sort Order:**
- Default: Most recent first (descending by date)
- Consider adding sort options in future versions

#### 2.2.4 Pagination

**Requirements:**
- Page size: 12 entries per page
- Navigation controls to be designed
- Show current page number and total pages

**Pagination Controls:**
- Previous page button (disabled on first page)
- Next page button (disabled on last page)
- Page indicator: "Page X of Y"
- Consider jump-to-page functionality for large datasets

#### 2.2.5 Empty State

**Display when no entries exist:**
- Centered message: "No completed deliveries yet"
- Helpful text: "Save deliveries from the Contracts page to see them here"

#### 2.2.6 Data Persistence

**Storage:**
- Entries must persist between app sessions
- Consider local storage (Core Data, SQLite, or similar)
- No data synchronization required (local only)

---

### 2.3 Ships Page

#### 2.3.1 Page Purpose
Manage the user's fleet of Star Citizen ships and their cargo capacities. Ship names entered here populate the autocomplete field on the Contracts page.

#### 2.3.2 Page Layout

**Header:**
- Page title: "SHIPS" (centered, prominent)

**Input Section:**
- Two text input fields horizontally aligned
- Plus icon (+) button to the left of the fields
- Field labels above fields

#### 2.3.3 Input Fields

**NAME Field:**
- Type: Free-form text input
- Validation: 
  - Required (cannot be empty)
  - Reasonable length limit (e.g., 50 characters)
  - Trim whitespace
  - Check for duplicates (optional but recommended)
- Purpose: User enters the name of their ship
- Examples: "ARGO RAFT", "MISC Hull A", "Anvil C2"

**CARGO SCU Field:**
- Type: Positive integer input
- Validation:
  - Must be positive integer greater than 0
  - Only numeric input allowed
- Purpose: Total cargo capacity of the ship in SCU
- Examples: 196, 64, 324

#### 2.3.4 Adding Ships

**Process:**
1. User fills both NAME and CARGO SCU fields
2. User clicks plus icon (+) button
3. Validation occurs:
   - Ensure both fields have valid values
   - Check for duplicate ship names (recommended)
4. If valid:
   - Add ship to the list
   - Clear both input fields
   - Focus returns to NAME field
5. If invalid:
   - Display error message
   - Keep field values for correction

#### 2.3.5 Ships List Display

**Table Structure:**
- Column headers: NAME | CARGO SCU
- Data rows showing saved ships
- Minus icon (−) on the left of each row

**Visual State:**
- Empty state: No grid/table displayed until first ship is added
- Populated state: Table appears with header and rows

**Example Display:**
```
NAME            CARGO SCU
[−] ARGO RAFT         196
[−] MISC HULL A        64
```

#### 2.3.6 Deleting Ships

**Process:**
1. User clicks minus icon (−) next to a ship
2. Confirmation dialog displays:
   - Message: "Delete [SHIP_NAME]?"
   - Buttons: "Cancel" and "Delete"
3. If user confirms:
   - Remove ship from list
   - Update persistent storage
   - If this was the last ship, hide the table
4. If user cancels:
   - No action taken, close dialog

**Important Considerations:**
- Check if ship is currently in use on Contracts page
- Consider warning if ship is selected in active contract
- All deletions require confirmation (per app-wide standard)

#### 2.3.7 Data Integration

**Usage in Contracts Page:**
- All ship names from this list populate the Ship autocomplete field
- Ship cargo capacity is used for "Remaining" calculation in contract cards
- Real-time updates: If ship list changes, reflect in Contracts page immediately

**Data Persistence:**
- Ships must persist between app sessions
- Local storage only (no cloud sync required)
- Consider data migration if storage structure changes

---

### 2.4 Navigation

#### 2.4.1 Bottom Navigation Bar

**Position:** Fixed at bottom of screen on all pages

**Navigation Items:**

**1. Home Icon (House/Building)**
- Action: Navigate to Contracts page
- Active state: Highlighted when on Contracts page
- Label: Optional "Contracts" label

**2. Document Icon (Paper/File)**
- Action: Navigate to Log page
- Active state: Highlighted when on Log page
- Label: Optional "Log" label

**3. Anchor Icon (Ship Anchor)**
- Action: Navigate to Ships page
- Active state: Highlighted when on Ships page
- Label: Optional "Ships" label

#### 2.4.2 Navigation Behavior

**State Persistence:**
- Each page maintains its state when navigating away
- Contracts page: Preserve all entered data and cards
- Log page: Maintain current pagination position
- Ships page: Maintain scroll position if applicable

**Active State Indicators:**
- Currently active page should be visually distinct
- Consider color change, underline, or icon fill

**Tap Targets:**
- Minimum 44x44 points for iOS accessibility
- Clear visual feedback on tap

---

## 3. Data Model

### 3.1 Ship Entity

```typescript
Ship {
  id: string (UUID)
  name: string
  cargoCapacitySCU: number (positive integer)
  createdDate: Date
}
```

**Constraints:**
- name: Required, 1-50 characters, unique (recommended)
- cargoCapacitySCU: Required, > 0
- id: Auto-generated UUID
- createdDate: Auto-generated timestamp

### 3.2 LogEntry Entity

```typescript
LogEntry {
  id: string (UUID)
  date: Date
  collectLocation: string
  deliveryLocation: string
  commodity: string
  scuAmount: number (positive integer)
}
```

**Constraints:**
- All string fields: Required, non-empty
- scuAmount: Required, > 0
- id: Auto-generated UUID
- date: Auto-generated on save

### 3.3 ContractEntry (Transient)

```typescript
ContractEntry {
  id: string (UUID)
  collectLocation: string
  deliveryLocation: string
  commodity: string
  scuAmount: number (positive integer)
  isInCard: boolean
}
```

**Notes:**
- Transient data (only exists during session)
- isInCard: Tracks whether entry is in list or card state
- Optional: May not need persistence if app loses state on close

### 3.4 ContractCard (Transient)

```typescript
ContractCard {
  id: string (UUID)
  collectLocation: string
  deliveryLocation: string
  entries: ContractCardEntry[]
}

ContractCardEntry {
  id: string (UUID)
  commodity: string
  scuAmount: number (positive integer)
  containers: ContainerDistribution
}

ContainerDistribution {
  size16: number (count of 16 SCU containers)
  size8: number (count of 8 SCU containers)
  size4: number (count of 4 SCU containers)
  size2: number (count of 2 SCU containers)
  size1: number (count of 1 SCU containers)
}
```

**Notes:**
- Transient data structure
- Cards combine entries with matching COLLECT → DELIVERY routes
- Container distribution calculated on-the-fly

### 3.5 Reference Data (Static/Configuration)

**Location Names:**
```typescript
LocationReference {
  locations: string[] // Array of location names
}
```

**Commodity Names:**
```typescript
CommodityReference {
  commodities: string[] // Array of commodity names
}
```

**Notes:**
- Provided during implementation phase
- Can be hard-coded or loaded from configuration file
- May need updates as Star Citizen game evolves

---

## 4. Container Calculation Specification

### 4.1 Algorithm Requirements

**Input Parameters:**
- totalSCU: Total cargo units to transport (positive integer)
- maxContainerSize: Maximum container size available (positive integer, typically 16)

**Output:**
- Dictionary/Map of container sizes to quantities needed

**Container Sizes (Fixed):**
- Available sizes: [16, 8, 4, 2, 1] SCU

### 4.2 Algorithm Logic

```
FUNCTION calculateContainers(totalSCU: number, maxContainerSize: number): Map<number, number>
    // Initialize result map
    result = new Map()
    
    // Remaining SCU to allocate
    remaining = totalSCU
    
    // Available container sizes (descending order)
    sizes = [16, 8, 4, 2, 1]
    
    // Filter to only use containers <= maxContainerSize
    availableSizes = sizes.filter(size => size <= maxContainerSize)
    
    // Greedy algorithm: Use largest containers first
    FOR EACH size IN availableSizes:
        IF remaining >= size:
            count = Math.floor(remaining / size)
            result.set(size, count)
            remaining = remaining - (count * size)
    
    RETURN result
END FUNCTION
```

### 4.3 Validation

**Post-calculation check:**
```
FUNCTION validateContainerCalculation(containers: Map<number, number>, expectedTotal: number): boolean
    calculatedTotal = 0
    
    FOR EACH (size, count) IN containers:
        calculatedTotal += size * count
    
    RETURN calculatedTotal === expectedTotal
END FUNCTION
```

### 4.4 Edge Cases

**Edge Case 1: SCU equals max container size**
- Input: totalSCU = 16, maxContainerSize = 16
- Output: {16: 1}

**Edge Case 2: SCU less than smallest container**
- Input: totalSCU = 1, maxContainerSize = 16
- Output: {1: 1}

**Edge Case 3: Perfect fit**
- Input: totalSCU = 64, maxContainerSize = 16
- Output: {16: 4}

**Edge Case 4: Max container size is 1**
- Input: totalSCU = 100, maxContainerSize = 1
- Output: {1: 100}

**Edge Case 5: Complex distribution**
- Input: totalSCU = 127, maxContainerSize = 16
- Output: {16: 7, 8: 1, 4: 1, 2: 1, 1: 1}
- Total: (7×16) + (1×8) + (1×4) + (1×2) + (1×1) = 127 ✓

---

## 5. User Interface Specifications

### 5.1 Color Palette

**Based on Figma Screenshots:**

**Primary Colors:**
- Background: Dark teal/blue-grey (#2C4A4E approximate)
- Accent: Cyan/teal (#4DD0E1 approximate)
- Text Primary: Light cyan/white (#E0F7FA approximate)
- Text Secondary: Muted cyan (#80DEEA approximate)

**Interactive Elements:**
- Input fields: Grey/dark (#37474F approximate)
- Buttons/Icons: Cyan (#4DD0E1 approximate)
- Card background: Darker teal/blue (#1E3A3E approximate)

**Status Indicators:**
- Container count badge: Red circle with yellow text
- Active navigation: Highlighted cyan

**Note:** Final color values should match Figma design exactly

### 5.2 Typography

**Headers:**
- App title (SC-LOADMASTER): Large, bold, uppercase
- Page titles (CONTRACTS, LOG, SHIPS): Medium-large, uppercase
- Card headers: Medium, standard case with arrow symbol
- Table headers: Small, uppercase

**Body Text:**
- Input labels: Small-medium, uppercase
- List items: Medium, standard case
- Table data: Medium, standard case
- Totals: Medium, bold or emphasized

**Note:** Font family to be specified in style guide (likely SF Pro for iOS)

### 5.3 Layout Grid

**Mobile (iOS):**
- Safe area insets respected (notch, home indicator)
- Margins: 16-20px typical
- Component spacing: 8-16px
- Card padding: 12-16px

### 5.4 Component Specifications

#### 5.4.1 Autocomplete Text Input Fields
**Component Type:** Custom text field with dropdown suggestions

**Dimensions:**
- Height: 40-44px (comfortable tap target)
- Border radius: 4-8px
- Padding: 8-12px
- Border: 1px solid or subtle shadow
- Focus state: Highlighted border or glow

**Dropdown Specifications:**
- Max visible items: 5-7 suggestions
- Position: Below input field
- Width: Match input field width
- Max height: ~200-250px (scrollable if needed)
- Background: Distinct from input (darker or lighter)
- Item height: 40-44px each
- Item padding: 8-12px

**Matching Algorithm:**
- **Substring matching:** Search anywhere in the string, not just at the beginning
- Case-insensitive comparison
- Update results on each keystroke

**Match Highlighting (Recommended):**
- Highlight the matched substring within each suggestion
- Use accent color or bold text
- Visual example: User types "har" → Shows "Everus **Har**bor"

**Prioritization Logic:**
1. Exact matches first
2. Matches at start of string
3. Matches at start of words
4. Matches anywhere else

**Examples:**
```
User types: "har"
Results shown:
  - Harbor Station (starts with word)
  - Everus Harbor (contains substring)
  - Port Olisar Harbor Wing (contains substring)

User types: "ice"
Results shown:
  - Pressurized Ice (contains substring)
  - Ice Mining Facility (starts with word)

User types: "HDPC"
Results shown:
  - HDPC-Cassillo (starts with string)
  - HDPC-Tram & Myers (starts with string)
```

**Interaction:**
- Tap anywhere on suggestion item to select
- Selected value fills the entire input field
- Dropdown dismisses on selection
- Dropdown dismisses when clicking outside
- Dropdown dismisses when field loses focus

**Performance:**
- Filter results with < 100ms delay
- Smooth scrolling in dropdown
- Efficient string matching for large lists (consider fuzzy search library if needed)

#### 5.4.2 Standard Text Input Fields
- Height: 40-44px (comfortable tap target)
- Border radius: 4-8px
- Padding: 8-12px
- Border: 1px solid or subtle shadow
- Focus state: Highlighted border or glow
- Numeric fields: Show numeric keyboard on iOS

#### 5.4.3 Buttons/Icons
- Minimum size: 44x44px (iOS accessibility requirement)
- Icon size: 20-24px within button
- Spacing from text: 8-12px
- Tap feedback: Opacity change or scale animation

#### 5.4.4 Cards
- Border radius: 8-12px
- Padding: 12-16px
- Shadow: Subtle elevation (2-4px)
- Border: 1px accent color or none
- Margin between cards: 12-16px

#### 5.4.5 Container Icons
- Size: 32-40px (icon + badge)
- Badge size: 20-24px (red circle)
- Badge text: 12-14px (yellow number)
- Spacing between icons: 4-8px

#### 5.4.6 Navigation Bar
- Height: 60-80px (including safe area)
- Icon size: 24-28px
- Active indicator: Color change or underline
- Background: Solid color or subtle gradient

---

## 6. Interaction Patterns

### 6.1 Autocomplete Behavior

**Triggering:**
- Show suggestions after 1-2 characters typed
- Update suggestions on each keystroke
- Clear suggestions when field loses focus

**Matching Algorithm:**
- **Case-insensitive substring matching** (matches anywhere in the string, not just at the beginning)
- User can type any part of the target string to find matches
- Examples:
  - Typing "har" matches "Everus **Har**bor"
  - Typing "ice" matches "Pressurized **Ice**"
  - Typing "press" matches "**Press**urized Ice"
  - Typing "HDPC" matches "**HDPC**-Cassillo"
  - Typing "cas" matches "HDPC-**Cas**sillo"

**Match Prioritization (Recommended):**
1. Exact matches (if typing complete string)
2. Matches at the start of the string (e.g., "Ever" for "Everus Harbor")
3. Matches at the start of any word (e.g., "Har" for "Everus Harbor")
4. Matches anywhere in the string (e.g., "arbo" for "Everus Harbor")

**Display:**
- Show maximum 5-7 suggestions
- Highlight the matched substring within each suggestion (optional but recommended)
- If more than max suggestions match, show the highest priority matches

**Selection:**
- Tap suggestion to fill field
- Entire suggestion replaces field content
- Field validates after selection
- Focus moves to next field (optional)

**Performance:**
- Efficient substring search algorithm
- Update suggestions with minimal lag (< 100ms)

### 6.2 Form Validation

**Real-time Validation:**
- Validate on blur (field loses focus)
- Show error state with red border/text
- Display error message below field
- Clear error when user corrects input

**Submit Validation:**
- Validate all fields before adding to list
- Highlight all fields with errors
- Scroll to first error if not visible
- Prevent submission if any field invalid

### 6.3 Confirmation Dialogs

**Standard Pattern:**
```
Title: [Action] [Item Name]?
Message: This action cannot be undone. (optional)
Buttons: [Cancel] [Confirm/Delete]
```

**Examples:**
- "Delete ARGO RAFT?"
- "Remove Pressurized Ice from route?"

**Button Styling:**
- Cancel: Secondary style
- Confirm/Delete: Primary style (red for destructive)

### 6.4 List Animations

**Adding Items:**
- Fade in + slide down animation
- Duration: 200-300ms
- Easing: ease-out

**Removing Items:**
- Fade out + collapse animation
- Duration: 200-300ms
- Easing: ease-in

**Moving Items (List ↔ Card):**
- Crossfade between states
- Duration: 300ms
- Maintain visual continuity

### 6.5 Loading States

**Data Loading:**
- Show skeleton screens or loading indicators
- Disable interactions during load
- Timeout after 5-10 seconds with error message

**Saving Data:**
- Show success confirmation (checkmark, toast)
- Brief animation (200-300ms)
- Auto-dismiss after 2-3 seconds

---

## 7. Validation Rules Summary

### 7.1 Field Validation

| Field | Type | Required | Validation Rules |
|-------|------|----------|------------------|
| Ship | Autocomplete | Yes | Must match existing ship |
| Max Container Size | Integer | Yes | > 0, integer only |
| Collect | Autocomplete | Yes | Must match location list |
| Delivery | Autocomplete | Yes | Must match location list |
| Commodity | Autocomplete | Yes | Must match commodity list |
| SCU | Integer | Yes | > 0, integer only |
| Ship Name | Text | Yes | 1-50 chars, unique recommended |
| Ship Cargo | Integer | Yes | > 0, integer only |

### 7.2 Business Logic Validation

**Container Calculation:**
- Sum of (container_size × count) must equal total SCU
- Only use containers ≤ max container size
- All container counts must be ≥ 0

**Card Totals:**
- Sum of all commodity SCU in card must equal displayed total
- Remaining capacity = Ship capacity - Total SCU
- Remaining can be negative (over capacity warning)

**State Consistency:**
- Entry cannot exist in both list and card simultaneously
- Empty cards should be automatically removed
- Ship selection should persist across page navigation

---

## 8. Error Handling

### 8.1 User Input Errors

**Invalid Input:**
- Display inline error message
- Highlight field in red
- Prevent form submission
- Clear error on correction

**Missing Required Field:**
- "This field is required"
- Highlight all empty required fields
- Scroll to first error

**Invalid Format:**
- "Please enter a valid number"
- "Please select from the list"
- Show format requirements

### 8.2 Data Errors

**Calculation Errors:**
- Log error to console
- Show user-friendly message
- Provide fallback behavior
- Example: "Unable to calculate containers. Please check your inputs."

**Storage Errors:**
- "Unable to save data. Please try again."
- Retry mechanism (optional)
- Data loss prevention

### 8.3 State Errors

**Inconsistent State:**
- Detect and auto-correct where possible
- Log warnings for debugging
- Prevent cascading errors

---

## 9. Performance Requirements

### 9.1 Response Times

**User Interactions:**
- Button/icon tap: < 100ms feedback
- Navigation: < 300ms page transition
- Autocomplete suggestions: < 200ms display
- List operations (add/remove): < 100ms

**Data Operations:**
- Load ships list: < 500ms
- Load log entries (page): < 500ms
- Save to log: < 200ms
- Container calculation: < 50ms

### 9.2 Rendering Performance

**Smooth Animations:**
- 60fps target for all animations
- No jank during scrolling
- Efficient list rendering (virtualization for long lists)

**Memory Management:**
- Efficient image/icon handling
- Proper cleanup of event listeners
- No memory leaks in navigation

---

## 10. Accessibility Requirements

### 10.1 iOS Accessibility

**VoiceOver Support:**
- All interactive elements properly labeled
- Meaningful descriptions for icons
- Logical reading order
- Announce dynamic changes

**Touch Targets:**
- Minimum 44x44pt for all interactive elements
- Adequate spacing between tappable elements
- Clear visual feedback on interaction

**Color Contrast:**
- WCAG AA compliance minimum
- Text readable against backgrounds
- Not reliant on color alone for information

### 10.2 Dynamic Type Support

**Text Scaling:**
- Support iOS Dynamic Type
- Test at largest accessibility sizes
- Ensure layout doesn't break
- Truncate long text appropriately

---

## 11. Data Persistence Strategy

### 11.1 Local Storage

**Technology Options:**
- Core Data (recommended for iOS)
- SQLite
- Realm
- UserDefaults (for simple preferences only)

### 11.2 Persistence Requirements

**Ships Data:**
- Persist all ships between sessions
- Survive app termination
- Backup recommended

**Log Entries:**
- Persist all log entries indefinitely
- Efficient querying for pagination
- Consider data export option (future)

**Contracts Page State:**
- Optional: Persist in-progress contracts
- Allow user to continue where they left off
- Clear/reset option

### 11.3 Data Migration

**Version Compatibility:**
- Handle data schema changes gracefully
- Migrate old data to new formats
- Maintain backward compatibility where possible

---

## 12. Future Enhancements (Out of Scope for v1.0)

### 12.1 Potential Features

**Contracts Page:**
- Save contract templates
- Multiple contracts simultaneously
- Contract history
- Export contract details
- Profitability calculator
- Route optimization

**Log Page:**
- Sort and filter options
- Search functionality
- Date range filtering
- Export to CSV
- Statistics dashboard

**Ships Page:**
- Ship images/icons
- Additional ship metadata (speed, fuel, etc.)
- Ship comparison tool
- Import ship data from API

**General:**
- Cloud sync across devices
- Share contracts with friends
- Dark/light theme toggle
- Offline mode improvements
- Push notifications for reminders

### 12.2 Technical Improvements

- Background data sync
- Improved caching strategies
- Performance analytics
- Crash reporting
- User analytics (opt-in)

---

## 13. Testing Requirements

### 13.1 Unit Tests

**Critical Functions:**
- Container calculation algorithm
- Card total calculation
- Remaining capacity calculation
- Input validation functions
- **Autocomplete substring matching algorithm**
- **Autocomplete prioritization logic**

**Autocomplete Test Cases:**
- Substring match at beginning of string
- Substring match in middle of string
- Substring match at end of string
- Case-insensitive matching
- Multiple matches prioritization
- Empty input handling
- No matches scenario
- Special characters in search

**Coverage Target:** 80% minimum

### 13.2 Integration Tests

**Key Flows:**
- Complete contract creation flow
- Save to log flow
- Ship management flow
- Navigation between pages

### 13.3 UI Tests

**User Scenarios:**
- Create and complete a full contract
- Add and delete ships
- View paginated log entries
- Error handling scenarios

### 13.4 Manual Testing Checklist

**Contracts Page:**
- [ ] Ship autocomplete works correctly
- [ ] Ship autocomplete supports substring matching (e.g., "hull" finds "MISC Hull A")
- [ ] Max container size validation
- [ ] All autocomplete fields match correctly with substring search
- [ ] COLLECT autocomplete substring matching works (e.g., "har" finds "Everus Harbor")
- [ ] DELIVERY autocomplete substring matching works
- [ ] COMMODITY autocomplete substring matching works (e.g., "ice" finds "Pressurized Ice")
- [ ] Autocomplete matches are case-insensitive
- [ ] Autocomplete highlighting shows matched substring (if implemented)
- [ ] Adding entries to list works
- [ ] Deleting entries shows confirmation
- [ ] Moving entries to card works
- [ ] Moving entries back to list works
- [ ] Container visualization displays correctly
- [ ] Container calculations are accurate
- [ ] Card totals are correct
- [ ] Remaining capacity is accurate
- [ ] Multiple cards work simultaneously
- [ ] Empty cards are removed

**Log Page:**
- [ ] Entries display correctly
- [ ] Pagination works
- [ ] Date format is correct
- [ ] No duplicate entries
- [ ] Empty state displays when no logs

**Ships Page:**
- [ ] Adding ships works
- [ ] Ship validation works
- [ ] Deleting ships shows confirmation
- [ ] Ship list updates autocomplete
- [ ] Duplicate ship name handling
- [ ] Empty state displays correctly

**Navigation:**
- [ ] All navigation buttons work
- [ ] Active page is highlighted
- [ ] Page state persists on navigation
- [ ] Back button behavior (if applicable)

**General:**
- [ ] App doesn't crash under normal use
- [ ] Performance is acceptable
- [ ] No visual glitches
- [ ] Accessibility features work
- [ ] Data persists between sessions

---

## 14. Acceptance Criteria

### 14.1 Contracts Page Success Criteria

✅ User can select a ship from their fleet  
✅ **Autocomplete supports substring matching (e.g., "hull" finds "MISC Hull A")**  
✅ **Autocomplete is case-insensitive**  
✅ **Autocomplete highlights matched text within suggestions (recommended)**  
✅ User can enter max container size  
✅ Progressive disclosure works (fields appear when required)  
✅ User can add multiple contract entries to list  
✅ **All autocomplete fields (COLLECT, DELIVERY, COMMODITY) support substring matching**  
✅ User can delete entries from list with confirmation  
✅ User can move entries to cards  
✅ Container visualization displays correctly for all SCU amounts  
✅ Container calculations are mathematically accurate  
✅ Multiple cards can exist for different routes  
✅ Card totals and remaining capacity calculate correctly  
✅ User can move entries back to list from cards  
✅ User can save entries to log  

### 14.2 Log Page Success Criteria

✅ All saved entries appear in log  
✅ Date displays in correct format  
✅ Pagination works correctly  
✅ Entries are read-only  
✅ Empty state displays appropriately  

### 14.3 Ships Page Success Criteria

✅ User can add ships with name and capacity  
✅ Ship validation works correctly  
✅ User can delete ships with confirmation  
✅ Ships list updates in real-time  
✅ Ships populate Contracts page autocomplete  
✅ Empty state displays appropriately  

### 14.4 Navigation Success Criteria

✅ All three navigation buttons work  
✅ Active page is visually indicated  
✅ Navigation is smooth and responsive  
✅ Page state persists during navigation  

### 14.5 General Success Criteria

✅ App follows iOS design guidelines  
✅ All interactions have appropriate feedback  
✅ Data persists between app sessions  
✅ No crashes during normal operation  
✅ Performance meets requirements  
✅ Accessibility requirements met  
✅ Visual design matches Figma specifications  

---

## 15. Technical Architecture Recommendations

### 15.1 iOS Development Stack

**Recommended Approach:**
- **Language:** Swift
- **UI Framework:** SwiftUI (recommended) or UIKit
- **Data Persistence:** Core Data
- **Architecture:** MVVM (Model-View-ViewModel)
- **Navigation:** SwiftUI NavigationStack or Coordinator pattern

### 15.2 Project Structure

```
SC-LOADMASTER/
├── App/
│   ├── SCLoadmasterApp.swift
│   └── ContentView.swift
├── Models/
│   ├── Ship.swift
│   ├── LogEntry.swift
│   ├── ContractEntry.swift
│   └── ContainerCalculator.swift
├── ViewModels/
│   ├── ContractsViewModel.swift
│   ├── LogViewModel.swift
│   └── ShipsViewModel.swift
├── Views/
│   ├── Contracts/
│   │   ├── ContractsView.swift
│   │   ├── ContractCardView.swift
│   │   └── ContainerVisualizationView.swift
│   ├── Log/
│   │   └── LogView.swift
│   ├── Ships/
│   │   └── ShipsView.swift
│   └── Components/
│       ├── AutocompleteTextField.swift
│       ├── NavigationBar.swift
│       └── ConfirmationDialog.swift
├── Services/
│   ├── DataPersistenceService.swift
│   └── ReferenceDataService.swift
├── Resources/
│   ├── Assets.xcassets
│   ├── LocationsData.json
│   └── CommoditiesData.json
└── Tests/
    ├── UnitTests/
    ├── IntegrationTests/
    └── UITests/
```

### 15.3 Key Classes/Components

**ContainerCalculator:**
```swift
class ContainerCalculator {
    static func calculateContainers(
        totalSCU: Int,
        maxContainerSize: Int
    ) -> [Int: Int] {
        // Algorithm implementation
    }
    
    static func validateCalculation(
        containers: [Int: Int],
        expectedTotal: Int
    ) -> Bool {
        // Validation logic
    }
}
```

**AutocompleteTextField:**
```swift
struct AutocompleteTextField: View {
    // Custom SwiftUI component for autocomplete behavior
    // Implements substring matching algorithm
    // Shows filtered suggestions based on user input
    
    func filterSuggestions(_ input: String, from options: [String]) -> [String] {
        // Substring matching implementation
        // Case-insensitive search
        // Prioritizes matches appropriately
    }
}
```

**DataPersistenceService:**
```swift
protocol DataPersistenceService {
    func saveShip(_ ship: Ship) throws
    func fetchShips() -> [Ship]
    func deleteShip(_ ship: Ship) throws
    
    func saveLogEntry(_ entry: LogEntry) throws
    func fetchLogEntries(page: Int, pageSize: Int) -> [LogEntry]
    func getLogEntriesCount() -> Int
}
```

---

## 16. Reference Data

### 16.1 Location Names (To Be Provided)

**Format:**
```json
{
  "locations": [
    "Everus Harbor",
    "HDPC-Cassillo",
    "HDMS ASDFGH",
    // ... additional locations
  ]
}
```

**Note:** Complete list to be provided during implementation

### 16.2 Commodity Names (To Be Provided)

**Format:**
```json
{
  "commodities": [
    "Pressurized Ice",
    "Processed Food",
    "Quartz",
    // ... additional commodities
  ]
}
```

**Note:** Complete list to be provided during implementation

---

## 17. Glossary

**SCU (Standard Cargo Unit):** The unit of measurement for cargo volume in Star Citizen. One SCU represents a standardized cargo container size.

**Container:** A cargo storage unit in Star Citizen. Available in sizes of 1, 2, 4, 8, and 16 SCU.

**Collect/Collection Location:** The starting location where cargo is picked up.

**Delivery Location:** The destination where cargo is delivered.

**Commodity:** The type of cargo being transported (e.g., Pressurized Ice, Processed Food, Quartz).

**Contract:** A cargo transportation job in Star Citizen, consisting of one or more commodity deliveries.

**Card:** A grouped view of contract entries sharing the same collection and delivery locations.

**Max Container Size:** The largest container size available for a particular contract, which determines the container calculation algorithm.

**Cargo Capacity:** The total SCU a ship can carry.

**Remaining Capacity:** The difference between a ship's total capacity and the current contract total.

---

## 18. Dependencies and Prerequisites

### 18.1 Development Environment

- macOS with Xcode installed
- iOS SDK (latest stable version)
- Swift Package Manager (built into Xcode)

### 18.2 External Dependencies

**Recommended Packages:**
- None required for core functionality
- Optional: SwiftLint for code quality
- Optional: SwiftFormat for code formatting

### 18.3 Design Assets

- Figma design files (provided)
- App icons (to be created)
- Container icons (to be created)
- Navigation icons (to be created)

### 18.4 Reference Data

- Complete location names list
- Complete commodity names list
- Ship data (optional - can be user-generated only)

---

## 19. Success Metrics (Optional)

### 19.1 User Engagement

- Daily active users
- Average session duration
- Contracts created per session
- Log entries created per week

### 19.2 Performance Metrics

- App launch time
- Page transition times
- Crash-free rate
- Calculation accuracy rate

### 19.3 Quality Metrics

- User-reported bugs
- App Store rating
- User retention (7-day, 30-day)

---

## 20. Deployment Considerations

### 20.1 App Store Submission

**Requirements:**
- App icon (all required sizes)
- Screenshots (multiple device sizes)
- App description
- Keywords
- Privacy policy (if collecting any data)
- App category: Utilities or Productivity

### 20.2 Version Management

**Versioning Scheme:** Semantic Versioning (e.g., 1.0.0)

**Initial Release:** v1.0.0
- Core features as defined in this PRD
- Stable and tested
- Basic error handling
- Data persistence

### 20.3 Update Strategy

**Patch Updates (1.0.x):**
- Bug fixes
- Minor UI improvements
- Performance optimizations

**Minor Updates (1.x.0):**
- New features
- UI enhancements
- Additional reference data

**Major Updates (x.0.0):**
- Significant feature additions
- Data model changes
- API integrations

---

## 21. Open Questions and Decisions Needed

### 21.1 Design Decisions

- [ ] Final color palette confirmation (exact hex values)
- [ ] Font family selection
- [ ] Icon design source (custom vs. SF Symbols)
- [ ] Confirmation dialog design
- [ ] Pagination controls design
- [ ] Loading states design

### 21.2 Technical Decisions

- [ ] Core Data vs. alternative storage solution
- [ ] SwiftUI vs. UIKit for UI
- [ ] Minimum iOS version support
- [ ] iPad support strategy
- [ ] Landscape orientation support

### 21.3 Business Decisions

- [ ] App pricing model (free, paid, freemium)
- [ ] Privacy policy requirements
- [ ] Analytics collection (if any)
- [ ] Future monetization strategy

### 21.4 Data Decisions

- [ ] Complete locations list
- [ ] Complete commodities list
- [ ] Ship data source strategy
- [ ] Data update mechanism for game changes

---

## 22. Next Steps

### 22.1 Immediate Actions

1. ✅ Review and approve this PRD
2. ⏳ Finalize design specifications (colors, fonts, icons)
3. ⏳ Prepare reference data (locations, commodities)
4. ⏳ Create style guide document
5. ⏳ Set up development environment

### 22.2 Development Phases

**Phase 1: Setup and Infrastructure**
- Project initialization
- Core Data setup
- Navigation structure
- Base UI components

**Phase 2: Ships Page**
- Ship CRUD operations
- Data persistence
- Validation

**Phase 3: Contracts Page - Basic**
- Initial form fields
- Progressive disclosure
- List management

**Phase 4: Contracts Page - Advanced**
- Card creation
- Container calculation
- Visualizations

**Phase 5: Log Page**
- Display saved entries
- Pagination
- Save from Contracts

**Phase 6: Polish and Testing**
- UI refinements
- Bug fixes
- Performance optimization
- Testing

**Phase 7: Deployment**
- App Store preparation
- Submission
- Launch

---

## 23. Document Version History

**Version 1.1** - February 14, 2026
- Added comprehensive substring autocomplete matching specification
- Enhanced autocomplete behavior with detailed examples and prioritization logic
- Added Appendix C with autocomplete matching examples
- Updated component specifications for AutocompleteTextField
- Added autocomplete-specific testing requirements

**Version 1.0** - February 14, 2026
- Initial PRD creation
- Complete feature specification
- Ready for Claude Code implementation

---

## Appendix A: Container Calculation Examples

### Example 1: Simple Case
- Total SCU: 16
- Max Container Size: 16
- Result: {16: 1}
- Verification: 1 × 16 = 16 ✓

### Example 2: Exact Fit
- Total SCU: 32
- Max Container Size: 8
- Result: {8: 4}
- Verification: 4 × 8 = 32 ✓

### Example 3: Mixed Containers
- Total SCU: 12
- Max Container Size: 16
- Result: {8: 1, 4: 1}
- Verification: (1 × 8) + (1 × 4) = 12 ✓

### Example 4: Complex Distribution
- Total SCU: 127
- Max Container Size: 16
- Result: {16: 7, 8: 1, 4: 1, 2: 1, 1: 1}
- Verification: (7 × 16) + (1 × 8) + (1 × 4) + (1 × 2) + (1 × 1) = 127 ✓

### Example 5: Small Max Size
- Total SCU: 20
- Max Container Size: 4
- Result: {4: 5}
- Verification: 5 × 4 = 20 ✓

### Example 6: All Small Containers
- Total SCU: 7
- Max Container Size: 16
- Result: {4: 1, 2: 1, 1: 1}
- Verification: (1 × 4) + (1 × 2) + (1 × 1) = 7 ✓

---

## Appendix B: UI State Diagrams

### Contracts Page State Flow

```
Initial State
    │
    ├─> Ship + Max Size Filled
    │       │
    │       └─> Contract Details Section Appears
    │               │
    │               ├─> Entry Added to List
    │               │       │
    │               │       ├─> Delete Entry (Confirmation)
    │               │       │
    │               │       └─> Move to Card
    │               │               │
    │               │               ├─> Save to Log
    │               │               │
    │               │               └─> Move back to List
    │               │
    │               └─> Multiple Entries/Cards Coexist
    │
    └─> Navigate Away (State Preserved)
```

---

## Appendix C: Autocomplete Substring Matching Examples

### Example 1: Location Search - "har"
**Available Locations:**
- Everus Harbor
- Harbor Station
- Port Olisar
- HDPC-Cassillo

**User Types:** "har"

**Matches Found:**
1. Harbor Station (starts with word "Harbor")
2. Everus Harbor (contains "har")

**Not Matched:**
- Port Olisar (doesn't contain "har")
- HDPC-Cassillo (doesn't contain "har")

---

### Example 2: Commodity Search - "ice"
**Available Commodities:**
- Pressurized Ice
- Processed Food
- Ice Cream (hypothetical)
- Quartz
- Diamond

**User Types:** "ice"

**Matches Found:**
1. Ice Cream (starts with "Ice")
2. Pressurized Ice (contains "ice")

**Not Matched:**
- Processed Food
- Quartz
- Diamond

---

### Example 3: Location Search - "HDPC"
**Available Locations:**
- HDPC-Cassillo
- HDPC-Tram & Myers
- Everus Harbor
- Port Olisar

**User Types:** "HDPC"

**Matches Found:**
1. HDPC-Cassillo (starts with "HDPC")
2. HDPC-Tram & Myers (starts with "HDPC")

**Not Matched:**
- Everus Harbor
- Port Olisar

---

### Example 4: Ship Search - "hull"
**Available Ships (from user's fleet):**
- ARGO RAFT
- MISC Hull A
- Anvil C2 Hercules

**User Types:** "hull"

**Matches Found:**
1. MISC Hull A (contains "Hull")

**Not Matched:**
- ARGO RAFT
- Anvil C2 Hercules

---

### Example 5: Case-Insensitive Matching
**Available Commodities:**
- Pressurized Ice
- PROCESSED FOOD
- Agricultural Supplies

**User Types:** "PRESS" (all caps)

**Matches Found:**
1. Pressurized Ice (contains "press", case-insensitive)
2. PROCESSED FOOD (starts with "PROCESS", case-insensitive, contains "PRESS")

**User Types:** "press" (all lowercase)

**Matches Found:** (Same results due to case-insensitive matching)
1. Pressurized Ice
2. PROCESSED FOOD

---

### Example 6: Multiple Word Matching
**Available Locations:**
- Port Olisar Main Hub
- Everus Harbor Trading Deck
- Lorville Central Business District

**User Types:** "main"

**Matches Found:**
1. Port Olisar Main Hub (contains "Main")

**User Types:** "business"

**Matches Found:**
1. Lorville Central Business District (contains "Business")

---

### Example 7: Partial Word Matching
**Available Locations:**
- Microtech
- Microsoft Station (hypothetical)
- Crusader

**User Types:** "micro"

**Matches Found:**
1. Microtech (starts with "Micro")
2. Microsoft Station (starts with "Micro")

**User Types:** "tech"

**Matches Found:**
1. Microtech (ends with "tech")

---

### Example 8: No Matches
**Available Commodities:**
- Pressurized Ice
- Processed Food
- Quartz

**User Types:** "diamond"

**Matches Found:** (None)

**UI Behavior:**
- Show "No matches found" message in dropdown
- Or hide dropdown entirely
- User can continue typing to refine search
- User can clear input and try different search term

---

### Example 9: Special Case - Numbers and Symbols
**Available Ships:**
- C2 Hercules
- M2 Hercules
- A2 Hercules
- 890 Jump

**User Types:** "2"

**Matches Found:**
1. C2 Hercules (contains "2")
2. M2 Hercules (contains "2")
3. A2 Hercules (contains "2")

**User Types:** "C2"

**Matches Found:**
1. C2 Hercules (starts with "C2")

---

### Example 10: Prioritization Demonstration
**Available Locations:**
- Harbor
- Harbor Station
- Everus Harbor
- Safe Harbor Trading Post
- Port Olisar Harbor Wing

**User Types:** "harbor"

**Matches (in priority order):**
1. **Harbor** (exact match)
2. **Harbor Station** (starts with string)
3. **Everus Harbor** (starts with word)
4. **Safe Harbor Trading Post** (starts with word)
5. **Port Olisar Harbor Wing** (contains substring)

**Display Order Logic:**
1. Exact: "Harbor"
2. Start of string: "Harbor Station"
3. Start of word: "Everus Harbor", "Safe Harbor Trading Post"
4. Anywhere: "Port Olisar Harbor Wing"

---

**END OF PRODUCT REQUIREMENTS DOCUMENT**

---

This PRD is now ready to be used by Claude Code for implementation of the SC-LOADMASTER iOS application. All functional requirements, specifications, and acceptance criteria are clearly defined and actionable.
