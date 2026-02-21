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

### 1.5 HTML Prototype Reference — Primary Design Source

> **CRITICAL: All three pages of SC-LOADMASTER have been fully designed and prototyped as interactive HTML files. Implementers MUST treat these files as the authoritative design specification. Do not invent or interpret the visual design — open and inspect the HTML files directly.**

All prototype files are located in the `html-test/` folder at the root of this project. The HTML files use **HTML, CSS, and Tailwind CSS** and represent the final, approved design. The native iOS implementation must faithfully replicate the layout, colors, typography, spacing, interactions, and visual style demonstrated in these prototypes.

#### Prototype HTML Files

| File                       | Description                                                                                                   |
| -------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `html-test/contracts.html` | Contracts page — ship selection, container size, contract entry list, contract cards, container visualization |
| `html-test/log.html`       | Log page — delivery history table with pagination                                                             |
| `html-test/ships.html`     | Ships page — fleet management, add/delete ships                                                               |

#### Image Assets (`html-test/images/`)

All production-ready image assets are included and must be used as-is in the iOS implementation:

| Asset                                                                          | Description                                 |
| ------------------------------------------------------------------------------ | ------------------------------------------- |
| `app-icon.png`                                                                 | Application icon                            |
| `background-image.png` / `background-image-40.png` / `background-image-60.png` | Background images at varying opacity levels |
| `contract.png`                                                                 | Contracts tab navigation icon               |
| `log.png`                                                                      | Log tab navigation icon                     |
| `ships.png`                                                                    | Ships tab navigation icon                   |
| `plus-circle.png`                                                              | Add entry button icon                       |
| `minus-circle.png`                                                             | Delete entry button icon                    |
| `arrow-down-circle.png`                                                        | Move entry to card (down arrow) icon        |
| `arrow-up-circle.png`                                                          | Move entry back to list (up arrow) icon     |
| `save.png`                                                                     | Save to log (floppy disk) icon              |
| `container-badge.png`                                                          | Generic container badge reference image     |

#### Pre-Rendered Container Badge Images (`html-test/images/container-badge/`)

Container badges are provided as pre-rendered PNG images for all container size and count combinations. The naming convention is:

```
cargo-container-badge-[SIZE]-[COUNT].png
```

Where:

- **SIZE** = container size in SCU: `1`, `2`, `4`, `8`, `16`
- **COUNT** = number of containers: `1` through `15`, plus `q` (represents 16 or more)

**Examples:**

- `cargo-container-badge-16-7.png` → badge showing 7× 16-SCU containers
- `cargo-container-badge-8-1.png` → badge showing 1× 8-SCU container
- `cargo-container-badge-1-q.png` → badge showing 16+× 1-SCU containers

Use the appropriate pre-rendered badge image rather than generating container badge graphics programmatically. This ensures pixel-perfect visual consistency with the approved design.

#### Reference Data Files (`html-test/images/`)

The autocomplete data lists are provided as text files and must be used as the data source for all autocomplete fields:

| File                          | Used By                                  |
| ----------------------------- | ---------------------------------------- |
| `assets/locations-list.txt`   | COLLECT and DELIVERY autocomplete fields |
| `assets/commodities-list.txt` | COMMODITY autocomplete field             |

These files define the complete, approved lists of valid locations and commodities. Do not substitute or supplement these lists.

#### Implementation Directive

The HTML prototypes resolve all open design questions listed in Section 23. Implementers should:

1. **Open all three HTML files** before writing any code
2. **Inspect the HTML/CSS** to extract exact color values, spacing, font sizes, and component structure
3. **Use all provided image assets** directly — do not recreate icons or badges
4. **Load autocomplete data** from the provided `.txt` files
5. **Reference the HTML behavior** for interaction patterns (dropdowns, progressive disclosure, card creation, etc.)

The HTML prototypes are the definitive design reference for this project. All abstract design descriptions in this document are supplementary context only.

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

**Type:** Dropdown/Picker

**Data Source:**

- Populated from ships added in the Ships page
- Displays all available ships from the user's fleet
- List updates dynamically when ships are added or removed

**Behavior:**

- User taps field to open dropdown menu
- Shows all ships that have been added on the Ships page
- Ship names displayed in list format
- User selects one ship from the list

**Validation:**

- Required field
- Must select a ship before proceeding

**Visual Feedback:**

- When ship selected: Displays selected ship name in field
- When no ships available: Displays "No ships available" in red text
- Dropdown arrow indicator on the right side
- Grey background (as per design)
- Dropdown overlay appears on tap (only when ships are available)

**Empty State:**

- If no ships exist in Ships page:
  - Display placeholder text "No ships available" in red color
  - Disable field (cannot be tapped/opened)
  - Field should appear visually disabled or grayed out
  - Red text indicates user action is required
- Optional: Provide link/button to navigate to Ships page to add ships

**Examples:**

- User taps field → Dropdown shows: "ARGO RAFT", "MISC Hull A", "Anvil C2"
- User selects "ARGO RAFT" → Field displays "ARGO RAFT"

#### 2.1.3 Max Container Size Field

**Type:** Dropdown/Picker

**Available Values:**

- 16 SCU
- 8 SCU
- 4 SCU
- 2 SCU
- 1 SCU

**Display Order:**

- Values displayed in descending order (16, 8, 4, 2, 1)
- Each value shown with "SCU" suffix for clarity

**Behavior:**

- User taps field to open dropdown menu
- User selects one container size from the predefined list
- Represents the largest container size available for this contract
- Used as the starting point for container calculation algorithm
- Critical for determining optimal container distribution

**Validation:**

- Required field
- Must select a value before proceeding

**Visual Feedback:**

- Displays selected size in field (e.g., "16 SCU")
- Dropdown arrow indicator on the right side
- Grey background (as per design)
- Dropdown overlay appears on tap

**Examples:**

- User taps field → Dropdown shows: "16 SCU", "8 SCU", "4 SCU", "2 SCU", "1 SCU"
- User selects "16 SCU" → Field displays "16 SCU"

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
- Data source: `assets/locations-list.txt`

**DELIVERY Field:**

- Type: Autocomplete text input
- Data: Star Citizen location names (delivery points)
- **Matching:** Substring matching (e.g., "cas" matches "HDPC-Cassillo")
- Validation: Required field
- Data source: `assets/locations-list.txt`

**COMMODITY Field:**

- Type: Autocomplete text input
- Data: Star Citizen commodity names
- **Matching:** Substring matching (e.g., "ice" matches "Pressurized Ice", "food" matches "Processed Food")
- Validation: Required field
- Data source: `assets/commodities-list.txt`

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
- **COLLECT-DELIVER:** Collection location name stacked on top of the delivery location name
- **COMMODITY:** Commodity name
- **SCU:** Total SCU amount as integer

**Sort Order:**

- Default: Most recent first (descending by date)
- Consider adding sort options in future versions

#### 2.2.4 Pagination

**Requirements:**

- Page size: 7 entries per page
- Navigation controls are implemented in `html-test/log.html` — reference that file for the approved design
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

## 3. Behavioral Logic Specification

> **CRITICAL FOR IMPLEMENTERS:** This section defines every dynamic behavior in the application as explicit, numbered rules. These are non-negotiable requirements. Do not skip or defer any rule. Visual structure alone is not sufficient — every MUST statement below must be implemented and verified before the feature is considered complete.

---

### 3.1 Contracts Page — State Machine

The Contracts page has three distinct UI states. The transitions between them are strictly controlled by user input.

#### State 1: Initial (page load)

| Element                      | Visible |
| ---------------------------- | ------- |
| App header ("SC-LOADMASTER") | ✅ Yes  |
| Page title ("CONTRACTS")     | ✅ Yes  |
| SHIP dropdown                | ✅ Yes  |
| MX CNTR SZ dropdown          | ✅ Yes  |
| Divider line                 | ❌ No   |
| COLLECT field                | ❌ No   |
| DELIVER field                | ❌ No   |
| COMMODITY field              | ❌ No   |
| SCU field                    | ❌ No   |
| Plus (+) button              | ❌ No   |
| Entry list                   | ❌ No   |
| Any contract cards           | ❌ No   |

#### State 2: Ready for Entry

**Trigger:** Both SHIP and MX CNTR SZ dropdowns have a selected value.

| Element                 | Visible                                             |
| ----------------------- | --------------------------------------------------- |
| Everything from State 1 | ✅ Yes                                              |
| Divider line            | ✅ Yes                                              |
| COLLECT field           | ✅ Yes                                              |
| DELIVER field           | ✅ Yes                                              |
| COMMODITY field         | ✅ Yes                                              |
| SCU field               | ✅ Yes                                              |
| Plus (+) button         | ✅ Yes                                              |
| Entry list              | ❌ No (appears only after first entry is added)     |
| Contract cards          | ❌ No (appear only when entries are moved to cards) |

#### State 3: Active

**Trigger:** State 2 is active AND one or more entries have been added.

All State 2 elements remain visible. Entry list and/or cards appear as applicable.

---

### 3.2 Contracts Page — Rule: Progressive Disclosure

**RULE 1:** The COLLECT, DELIVER, COMMODITY, and SCU fields, and the Plus (+) button, MUST NOT be visible when the Contracts page first loads.

**RULE 2:** The COLLECT, DELIVER, COMMODITY, and SCU fields and the Plus (+) button MUST become visible only when BOTH the SHIP dropdown AND the MX CNTR SZ dropdown have a valid selected value (not the placeholder/empty option).

**RULE 3:** If the user resets either the SHIP or MX CNTR SZ dropdown back to its empty/placeholder state, the contract detail fields and Plus (+) button MUST be hidden again. Any entries already in the entry list MUST remain — they are not destroyed by this transition.

---

### 3.3 Contracts Page — Action: Plus (+) Button (Add Entry to List)

**RULE 4:** The Plus (+) button MUST be disabled (non-tappable, visually inactive) if any of the four fields — COLLECT, DELIVER, COMMODITY, SCU — are empty or contain an invalid value.

**RULE 5:** When the Plus (+) button is tapped and all four fields are valid, the following steps MUST execute in this exact order:

1. A new row is appended to the bottom of the entry list
2. The row displays: `[minus icon] | [COLLECT] | [DELIVER] | [COMMODITY] | [SCU] | [down-arrow icon]`
3. All four fields (COLLECT, DELIVER, COMMODITY, SCU) are cleared to empty
4. Focus returns to the COLLECT field
5. The SHIP and MX CNTR SZ values remain unchanged

**RULE 6:** The entry list MUST become visible the first time an entry is added. It MUST NOT exist in the layout before that point.

**RULE 7:** COLLECT and DELIVER MUST only accept values that match an entry in `assets/locations-list.txt`. A free-typed value that does not match the list MUST be rejected — the Plus (+) button must not add the entry.

**RULE 8:** COMMODITY MUST only accept values that match an entry in `assets/commodities-list.txt`. A free-typed value that does not match the list MUST be rejected.

**RULE 9:** SCU MUST only accept a positive integer greater than zero. Decimal values, zero, and negative numbers MUST be rejected with an inline error message.

---

### 3.4 Contracts Page — Action: Minus (−) Button (Delete Entry from List)

**RULE 10:** When the Minus (−) button is tapped on any entry row, a confirmation dialog MUST appear before any deletion occurs.

- Dialog message: `"Delete entry?"`
- Buttons: Cancel | Delete

**RULE 11:** If the user confirms deletion:

1. The entry row is immediately removed from the list
2. If the list is now empty, the entry list MUST be hidden

**RULE 12:** If the user cancels, no change occurs.

---

### 3.5 Contracts Page — Action: Down Arrow (↓) Button (Move Entry to Card)

**RULE 13:** When the Down Arrow (↓) button is tapped on an entry row, the following steps MUST execute:

1. Check whether a contract card already exists with the same COLLECT and DELIVER values (comparison is case-insensitive)
2. **If a matching card exists:** add a new commodity row to the bottom of that card's body (above the footer)
3. **If no matching card exists:** create a new contract card (see card structure in Rule 15)
4. Remove the entry row from the entry list
5. If the entry list is now empty, hide it

**RULE 14:** No confirmation dialog is required for moving an entry to a card.

**RULE 15:** A new contract card MUST be structured as follows:

- **Card header:** `[COLLECT] → [DELIVER]`
- **Card body:** one commodity row per entry that shares this route (see Rule 16)
- **Card footer:** `Total [X]` and `Remaining [Y]` (see Rule 20)

**RULE 16:** Each commodity row inside a card MUST display the following elements in order:

1. Up-arrow icon (left edge) — tapping moves the entry back to the list (Rule 17)
2. Commodity name (truncated with ellipsis if too long)
3. SCU amount (right-aligned)
4. Save icon (right edge) — tapping saves to log (Rule 18)
5. On the row below, indented: container badge images calculated from the SCU value and the selected MX CNTR SZ (see Rule 19)

---

### 3.6 Contracts Page — Action: Up Arrow (↑) Button (Move Entry Back to List)

**RULE 17:** When the Up Arrow (↑) button is tapped on a commodity row inside a card, the following steps MUST execute:

1. The commodity row is removed from the card
2. A new entry row is added to the bottom of the entry list using the same COLLECT, DELIVER, COMMODITY, and SCU values from that commodity row
3. The entry list MUST become visible if it was hidden
4. The card footer Total and Remaining values MUST update immediately (Rule 20)
5. If the card now has zero commodity rows, the entire card (header, body, and footer) MUST be removed from the page

---

### 3.7 Contracts Page — Action: Save (💾) Button (Save Entry to Log)

**RULE 18:** When the Save (💾) button is tapped on a commodity row inside a card, the following steps MUST execute:

1. A log entry is created and immediately written to persistent storage containing: current date (MM/DD/YY format), COLLECT, DELIVER, COMMODITY, SCU
2. The commodity row is removed from the card
3. The card footer Total and Remaining values MUST update immediately (Rule 20)
4. If the card now has zero commodity rows, the entire card MUST be removed from the page

**RULE 19 (Save is not destructive):** No confirmation dialog is shown before saving. The save action is permanent but not destructive — the data is preserved in the Log.

---

### 3.8 Contracts Page — Container Badge Display

**RULE 20:** Container badges MUST be calculated using the greedy algorithm defined in Section 5 (Container Calculation Specification). Inputs are the commodity's SCU amount and the currently selected MX CNTR SZ (Max Container Size).

**RULE 21:** Container badges MUST be rendered using the pre-rendered PNG images located in `html-test/images/container-badge/`. Select the image using this naming pattern:

```
cargo-container-badge-[SIZE]-[COUNT].png
```

- `SIZE` = container size in SCU: `1`, `2`, `4`, `8`, or `16`
- `COUNT` = number of containers needed: `1` through `15`
- If COUNT is 16 or more, use the `q` variant: `cargo-container-badge-[SIZE]-q.png`

**RULE 22:** Only display badge images for container sizes that have a count greater than zero. Do not render a badge for a size with zero containers.

**RULE 23:** Badge images MUST be displayed in descending size order, left to right: 16 SCU → 8 SCU → 4 SCU → 2 SCU → 1 SCU.

---

### 3.9 Contracts Page — Card Footer Totals

**RULE 24:** The card footer MUST display two values:

- `Total [X]` — the sum of the SCU amounts of all commodity rows currently in the card
- `Remaining [Y]` — the selected ship's CARGO SCU capacity minus the Total

**RULE 25:** Both values MUST recalculate and re-render automatically whenever a commodity row is added to or removed from the card (via down-arrow, up-arrow, or save actions). They are never static.

**RULE 26:** Remaining MAY be negative if the total SCU exceeds the ship's capacity. Display the negative number — do not clamp to zero.

---

### 3.10 Contracts Page — Autocomplete Fields

**RULE 27:** Autocomplete suggestions MUST appear after the user types 1 or more characters into a COLLECT, DELIVER, or COMMODITY field.

**RULE 28:** Matching MUST be case-insensitive substring matching — the typed string may match anywhere within a candidate string, not just at the start.

**RULE 29:** Suggestions MUST be sorted in this priority order:

1. Exact match (typed string equals candidate, case-insensitive)
2. Starts-with match (candidate begins with typed string)
3. Word-boundary match (typed string matches the start of any word within the candidate)
4. Anywhere match (typed string appears anywhere else in the candidate)

**RULE 30:** A maximum of 7 suggestions MUST be shown at one time. If more results match, show only the highest-priority results.

**RULE 31:** Tapping a suggestion MUST populate the field with the full suggestion text and dismiss the dropdown.

**RULE 32:** The dropdown MUST be dismissed when the user taps outside it or when the field loses focus.

---

### 3.11 Contracts Page — Field Reset After Adding Entry

**RULE 33:** After an entry is successfully added to the list (Rule 5), the following fields MUST be cleared: COLLECT, DELIVER, COMMODITY, SCU. The SHIP and MX CNTR SZ values MUST remain as selected.

---

### 3.12 Ships Page — State Machine

**State 1: Empty** — no ships added yet

- Visible: App header, page title, Plus (+) button, NAME field, CARGO SCU field
- Hidden: ships table

**State 2: Has Ships** — at least one ship exists

- Visible: everything from State 1 + ships table with all added ships

---

### 3.13 Ships Page — Action: Plus (+) Button (Add Ship)

**RULE 34:** The Plus (+) button MUST be disabled if NAME is empty or if CARGO SCU is empty or invalid.

**RULE 35:** CARGO SCU MUST only accept a positive integer greater than zero.

**RULE 36:** When the Plus (+) button is tapped with valid values, the following steps MUST execute:

1. Check whether a ship with the same NAME already exists (case-insensitive comparison)
2. **If duplicate name:** display an inline error message, do not add the ship, keep the current field values intact
3. **If valid and unique:**
   - Add a new row to the ships table: `[minus icon] | [NAME] | [CARGO SCU]`
   - Clear the NAME and CARGO SCU fields
   - Return focus to the NAME field
   - If this is the first ship, the ships table MUST become visible
   - The new ship MUST immediately appear as an option in the SHIP dropdown on the Contracts page

---

### 3.14 Ships Page — Action: Minus (−) Button (Delete Ship)

**RULE 37:** When the Minus (−) button is tapped on a ship row, a confirmation dialog MUST appear:

- Dialog message: `"Delete [SHIP NAME]?"`
- Buttons: Cancel | Delete

**RULE 38:** If the user confirms deletion:

1. The ship is removed from the table and from persistent storage
2. The ship is immediately removed from the SHIP dropdown on the Contracts page
3. If the ships table is now empty, hide it
4. **Special case:** If the deleted ship is currently selected in the Contracts page SHIP dropdown, the dropdown MUST reset to its empty/placeholder state, and the Contracts page MUST revert to State 1 (contract detail fields hidden)

**RULE 39:** If the user cancels, no change occurs.

---

### 3.15 Log Page — Display Rules

**RULE 40:** Log entries MUST be displayed in descending date order (most recent entry at the top).

**RULE 41:** The table MUST display exactly 7 entries per page. If fewer than 7 entries exist total, only those entries are shown — no empty placeholder rows.

**RULE 42:** The DATE column MUST display dates in `MM/DD/YY` format (e.g., `02/20/26`).

**RULE 43:** Table rows MUST alternate background colors: odd rows use `#164553`, even rows use no background (transparent).

**RULE 44:** Log entries are read-only. No editing, deleting, or interacting with individual entries is possible from this page.

**RULE 45:** When no log entries exist, display the message "No completed deliveries yet" centered in the content area. The table MUST NOT be rendered.

---

### 3.16 Log Page — Pagination Rules

**RULE 46:** Pagination controls MUST only be rendered when the total number of log entries exceeds 7.

**RULE 47:** The Previous button MUST be disabled (non-tappable) when the user is on page 1.

**RULE 48:** The Next button MUST be disabled (non-tappable) when the user is on the last page.

**RULE 49:** A page indicator MUST display as `Page X of Y` where X is the current page and Y is the total number of pages.

---

### 3.17 Navigation Rules

**RULE 50:** The footer tab bar MUST be fixed at the bottom of every page and MUST remain visible at all times — it must not scroll with the page content.

**RULE 51:** The icon representing the currently active page MUST be visually distinct (e.g., full opacity, not wrapped in a link). The other two icons MUST be tappable and navigate to their respective pages.

**RULE 52:** The scrollable content area on all pages MUST scroll independently of the fixed header and footer. The header (app title) and footer (tab bar) MUST remain stationary while content scrolls.

**RULE 53:** Navigating away from the Contracts page and returning MUST restore all state exactly as it was left: selected SHIP, selected MX CNTR SZ, all entry list rows, all contract cards with their commodity rows and calculated badges.

**RULE 54:** Navigating away from the Log page and returning MUST restore the user to the same pagination page they were on.

---

### 3.18 Global Rules

**RULE 55:** Every destructive action (delete entry from list, delete ship) MUST display a confirmation dialog before executing. Save to log (Rule 18) is NOT destructive and does NOT require a confirmation dialog.

**RULE 56:** Ships data MUST persist between app sessions. The ship list must survive the app being closed and reopened.

**RULE 57:** Log entries MUST persist between app sessions. No log entry may ever be lost due to app close or restart.

**RULE 58:** Contracts page state (selected ship, MX CNTR SZ, entry list, cards) is transient by default but SHOULD be persisted if technically straightforward in the chosen storage approach.

**RULE 59:** All numeric SCU input fields MUST display the numeric keyboard on iOS. Decimal input MUST be prevented at the keyboard level where possible, and rejected at validation if entered.

**RULE 60:** No rule in this section may be overridden by a general description found elsewhere in this document. Where a conflict exists between this section and any other section, this section takes precedence.

---

## 4. Data Model

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

**Extracted from HTML Prototype (`html-test/contracts.html`):**

**Primary Colors:**

- Background: Dark teal (`#164553`)
- Accent: Cyan/teal (`#509CB2`)
- Text Primary: White (`#FFFFFF`)
- Text Secondary: Cyan/teal (`#509CB2`)

**Interactive Elements:**

- Input fields: Gray (`bg-gray-400` / approx `#9CA3AF`)
- Buttons/Icons: Cyan (`#509CB2`)
- Card background: Darker teal (`#1C3741`)

**Status Indicators:**

- Container count badge: Pre-rendered PNG images (see `html-test/images/container-badge/`)
- Active navigation: Highlighted cyan (`#509CB2`)

**Note:** These values are extracted directly from the HTML prototypes and are authoritative. Reference `html-test/contracts.html` for full context.

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

**Fonts (verified against all three HTML prototypes):**

All font files are located in the `assets/` folder at the root of this project.

**Audiowide** — app title only ("SC-LOADMASTER")

| File                           | Weight  | Used for         |
| ------------------------------ | ------- | ---------------- |
| `assets/Audiowide-Regular.ttf` | Regular | App title header |

**Inter** — all other UI text (page titles, labels, body text, table data, totals)

Only three weights are used across all three pages. Bundle exactly these files:

| File                       | Weight              | Used for                          |
| -------------------------- | ------------------- | --------------------------------- |
| `assets/Inter-Regular.otf` | 400 (`font-normal`) | Body text, list items, table data |
| `assets/Inter-Medium.otf`  | 500 (`font-medium`) | Card body text, commodity entries |
| `assets/Inter-Bold.otf`    | 700 (`font-bold`)   | Page titles, section labels       |

Do not bundle any other Inter variants (Black, ExtraBold, SemiBold, ExtraLight, Thin, or any italic variants) — they are not used in the app.

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

| Field              | Type         | Required | Validation Rules               |
| ------------------ | ------------ | -------- | ------------------------------ |
| Ship               | Autocomplete | Yes      | Must match existing ship       |
| Max Container Size | Integer      | Yes      | > 0, integer only              |
| Collect            | Autocomplete | Yes      | Must match location list       |
| Delivery           | Autocomplete | Yes      | Must match location list       |
| Commodity          | Autocomplete | Yes      | Must match commodity list      |
| SCU                | Integer      | Yes      | > 0, integer only              |
| Ship Name          | Text         | Yes      | 1-50 chars, unique recommended |
| Ship Cargo         | Integer      | Yes      | > 0, integer only              |

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
✅ Visual design matches HTML prototype specifications (`html-test/`)

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

### 15.4 SwiftUI Implementation Template

The Contracts page has been implemented as a reference template demonstrating the project's architectural patterns, component design, and styling system. All future pages (Log, Ships) should follow these established patterns for consistency.

#### Reference Implementation Location

`swiftUI/contracts/` - Complete Contracts page implementation

See `swiftUI/contracts/README.md` for complete implementation details and architecture overview.

#### Key Patterns to Follow

**1. File Organization:**

```
[PageName]/
├── Models/          # Data structures
├── Views/           # Page-level views
├── Components/      # Reusable components
├── Extensions/      # Theme and utilities
└── Resources/       # Assets and documentation
```

**2. Reusable Components (MUST USE):**

The following components are designed for reuse across all pages and MUST be used to maintain consistency:

- **`AppHeaderView`** - App branding header with "SC-LOADMASTER" title
  - Usage: Place at top of all pages
  - Provides consistent branding across application

- **`PageTitleView`** - Page title with letter tracking
  - Usage: Display page names ("CONTRACTS", "LOG", "SHIPS")
  - Includes consistent typography and spacing

- **`FooterView`** - Tab navigation footer with 3 tabs (Home, Log, Ships)
  - Usage: Fixed at bottom of all pages
  - Provides consistent navigation across application

- **`CardHeaderView`** - Card header component for route information
  - Usage: Display route cards with "COLLECT → DELIVERY" format
  - Maintains consistent card styling

- **`Color+Theme.swift`** - Design system color extensions
  - Usage: Use defined color extensions (`.scPrimary`, `.scBackground`, etc.)
  - Never hardcode hex values directly in views

**3. Design System:**

**Colors (from `Color+Theme.swift`):**

Use the following color extensions consistently across all pages:

```swift
.scPrimary         // #509cb2 - Teal/Cyan (primary accent)
.scBackground      // #164553 - Dark Teal (page background)
.scCardBackground  // #1c3741 - Darker Teal (card backgrounds)
.scTextbox         // #7b8486 - Gray (input field backgrounds)
```

**Typography:**

- **Custom Fonts:**
  - `Audiowide-Regular` - Used for app title and emphasized numbers
  - `Inter-Bold` - Used for page titles, labels, and emphasis
  - `Inter-Regular` - Used for form labels and body text

- **System Fonts:**
  - Use `.system(size:, weight:)` for standard UI elements
  - Common sizes: 12pt (small), 14pt (body), 16pt (labels), 20pt+ (titles)

- **Letter Tracking:**
  - Page titles: `.tracking(4.56)` for "CONTRACTS", "LOG", "SHIPS"
  - Use tracking to match HTML prototype design (e.g., `tracking-[7px]` as seen in `contracts.html`)

**Spacing and Layout:**

- **Screen Size:** 393×852 (iPhone design dimensions)
- **Horizontal Margins:** 20px standard margin from screen edges
- **Component Spacing:** 8-16px between components
- **Card Padding:** 12-16px internal padding

**4. Data Flow Pattern:**

Follow these SwiftUI state management patterns:

- **`@State`** - Use for local component state (e.g., text field values, toggle states)
- **`@Binding`** - Use to pass mutable state to child components
- **Calculated Properties** - Use for derived data (e.g., totals, remaining capacity)
- **`Identifiable` Protocol** - Implement for all list items to enable ForEach

**Example:**

```swift
struct ParentView: View {
    @State private var items: [Item] = []

    var totalCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    var body: some View {
        ChildView(items: $items, total: totalCount)
    }
}

struct ChildView: View {
    @Binding var items: [Item]
    let total: Int

    var body: some View {
        // Implementation
    }
}
```

**5. Code Quality Standards:**

Maintain these standards across all implementations:

- **Include `#Preview` for all components** - Enables visual development and testing
- **Separation of concerns** - One component = one responsibility
- **Meaningful variable names** - Use descriptive names (e.g., `totalSCU` not `total`)
- **Inline comments** - Add comments for complex logic and calculations
- **Component composition** - Break down complex views into smaller components

#### Example Reference Points

When implementing specific features, refer to these existing components as templates:

**For Ship Dropdown Implementation (Section 2.1.2):**

- **Reference:** `MissionDetailsView.swift` and `DataEntryFormView.swift`
- **Pattern:** Text input fields with proper state management
- **Adaptation:** Convert text input pattern to Picker control for ship selection
- **Key Learning:** How to handle user input and validation

**For Log Table Display (Section 2.2.2):**

- **Reference:** `RouteCardView.swift` and `CommodityItemView.swift`
- **Pattern:** Card-based data display with list items
- **Usage:** Shows how to structure tabular data in card format
- **Key Learning:** List layout with ForEach, card styling, data presentation

**For Ships List (Section 2.3.5):**

- **Reference:** `CommodityItemView.swift`
- **Pattern:** List item component with interactive elements (delete button)
- **Usage:** Shows row component with actions and proper spacing
- **Key Learning:** List item design, button placement, confirmation dialogs

**For Form Input Patterns:**

- **Reference:** `DataEntryFormView.swift`
- **Pattern:** Multiple text fields with labels and validation
- **Usage:** Shows proper form layout and input handling
- **Key Learning:** Form organization, field validation, user feedback

**For Container Calculation Logic:**

- **Reference:** `HomePageView.swift` - `calculateContainers()` method
- **Pattern:** Greedy algorithm for optimal container distribution
- **Usage:** Algorithm that breaks down SCU into container sizes
- **Key Learning:** Calculation logic, algorithm implementation in Swift

#### Architecture Principles

Follow these architectural principles established in the Contracts implementation:

1. **Component Hierarchy:**
   - Page-level views orchestrate layout and data flow
   - Reusable components handle specific UI elements
   - Models define data structures
   - Extensions provide theming and utilities

2. **State Management:**
   - Keep state as local as possible
   - Pass data down, actions up
   - Use @State for view-local state
   - Use @Binding for parent-child communication

3. **Styling Approach:**
   - Define colors in Color+Theme.swift
   - Use modifier chains for consistent styling
   - Create custom ViewModifiers for repeated styles
   - Match HTML prototype specifications exactly (reference `html-test/` files)

4. **Code Organization:**
   - One file per component/view
   - Group related files in folders (Models, Views, Components)
   - Keep files focused and concise
   - Use meaningful file and type names

---

## 17. Reference Data

### 17.1 Location Names

**Source file:** `assets/locations-list.txt`

This file contains the complete, approved list of Star Citizen location names used for the COLLECT and DELIVERY autocomplete fields. Load this file directly — do not hardcode or substitute the list.

**Format for iOS implementation:**

```json
{
  "locations": [
    // Load from assets/locations-list.txt
  ]
}
```

### 17.2 Commodity Names

**Source file:** `assets/commodities-list.txt`

This file contains the complete, approved list of Star Citizen commodity names used for the COMMODITY autocomplete field. Load this file directly — do not hardcode or substitute the list.

**Format for iOS implementation:**

```json
{
  "commodities": [
    // Load from assets/commodities-list.txt
  ]
}
```

---

## 18. Glossary

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

## 19. Dependencies and Prerequisites

### 19.1 Development Environment

- macOS with Xcode installed
- iOS SDK (latest stable version)
- Swift Package Manager (built into Xcode)

### 19.2 External Dependencies

**Recommended Packages:**

- None required for core functionality
- Optional: SwiftLint for code quality
- Optional: SwiftFormat for code formatting

### 19.3 Design Assets

All design assets are provided in `html-test/images/`. No assets need to be created.

| Asset                               | File                                                                           |
| ----------------------------------- | ------------------------------------------------------------------------------ |
| App icon                            | `html-test/images/app-icon.png`                                                |
| Navigation icon — Contracts         | `html-test/images/contract.png`                                                |
| Navigation icon — Log               | `html-test/images/log.png`                                                     |
| Navigation icon — Ships             | `html-test/images/ships.png`                                                   |
| Add button                          | `html-test/images/plus-circle.png`                                             |
| Delete button                       | `html-test/images/minus-circle.png`                                            |
| Move to card button                 | `html-test/images/arrow-down-circle.png`                                       |
| Move to list button                 | `html-test/images/arrow-up-circle.png`                                         |
| Save to log button                  | `html-test/images/save.png`                                                    |
| Background image                    | `html-test/images/background-image.png` (also at 40% and 60% opacity variants) |
| Container badges (all sizes/counts) | `html-test/images/container-badge/cargo-container-badge-[SIZE]-[COUNT].png`    |
| HTML prototype — Contracts          | `html-test/contracts.html`                                                     |
| HTML prototype — Log                | `html-test/log.html`                                                           |
| HTML prototype — Ships              | `html-test/ships.html`                                                         |

### 19.4 Reference Data

- Complete location names list
- Complete commodity names list
- Ship data (optional - can be user-generated only)

---

## 20. Success Metrics (Optional)

### 20.1 User Engagement

- Daily active users
- Average session duration
- Contracts created per session
- Log entries created per week

### 20.2 Performance Metrics

- App launch time
- Page transition times
- Crash-free rate
- Calculation accuracy rate

### 20.3 Quality Metrics

- User-reported bugs
- App Store rating
- User retention (7-day, 30-day)

---

## 21. Deployment Considerations

### 21.1 App Store Submission

**Requirements:**

- App icon (all required sizes)
- Screenshots (multiple device sizes)
- App description
- Keywords
- Privacy policy (if collecting any data)
- App category: Utilities or Productivity

### 21.2 Version Management

**Versioning Scheme:** Semantic Versioning (e.g., 1.0.0)

**Initial Release:** v1.0.0

- Core features as defined in this PRD
- Stable and tested
- Basic error handling
- Data persistence

### 21.3 Update Strategy

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

## 22. Open Questions and Decisions Needed

### 22.1 Design Decisions

- [ ] Final color palette confirmation (exact hex values)
- [ ] Font family selection
- [ ] Icon design source (custom vs. SF Symbols)
- [ ] Confirmation dialog design
- [ ] Pagination controls design
- [ ] Loading states design

### 22.2 Technical Decisions

- [ ] Core Data vs. alternative storage solution
- [ ] SwiftUI vs. UIKit for UI
- [ ] Minimum iOS version support
- [ ] iPad support strategy
- [ ] Landscape orientation support

### 22.3 Business Decisions

- [ ] App pricing model (free, paid, freemium)
- [ ] Privacy policy requirements
- [ ] Analytics collection (if any)
- [ ] Future monetization strategy

### 22.4 Data Decisions

- [ ] Complete locations list
- [ ] Complete commodities list
- [ ] Ship data source strategy
- [ ] Data update mechanism for game changes

---

## 23. Next Steps

### 23.1 Immediate Actions

1. ✅ Review and approve this PRD
2. ⏳ Finalize design specifications (colors, fonts, icons)
3. ⏳ Prepare reference data (locations, commodities)
4. ⏳ Create style guide document
5. ⏳ Set up development environment

### 23.2 Development Phases

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

## 24. Document Version History

**Version 1.4** - February 20, 2026

- Added Section 3: Behavioral Logic Specification — 60 explicit MUST rules covering all dynamic behaviors across all three pages
- Covers: Contracts page state machine (3 states), progressive disclosure, all 5 button actions, autocomplete rules, container badge selection, card footer calculations, Ships page add/delete, Log page display and pagination, navigation state preservation, and global rules
- Section 3 is declared the highest-priority reference — overrides any conflicting description elsewhere in the document
- Previous sections 3–24 renumbered to 4–25 to accommodate new section

**Version 1.3** - February 20, 2026

- Added Section 1.5: HTML Prototype Reference — Primary Design Source
- Documented all assets in `html-test/` folder as the authoritative design specification
- Listed all prototype HTML files, image assets, container badge naming convention, and reference data files
- Removed all Figma references; replaced with HTML prototype references throughout
- Updated Section 5.1 color palette with exact hex values extracted from `contracts.html`
- Updated Section 5.2 typography: documented Audiowide and Inter fonts used in prototypes; flagged font licensing for discussion
- Updated autocomplete field notes to reference actual `.txt` data source files
- Updated Section 17 (Reference Data) to point to `locations-list.txt` and `commodities-list.txt`
- Updated Section 19.3 (Design Assets) with complete asset inventory — no assets remain "to be created"
- Added ⚠️ flag in Section 5.2 for font bundling decision (App Store release)

**Version 1.2** - February 16, 2026

- Added Section 15.4: SwiftUI Implementation Template
- Referenced existing `swiftUI/contracts/` implementation as architectural template
- Documented reusable components, design system, and code patterns
- Provided specific implementation guidance for Log and Ships pages
- Renumbered sections 16-23 to 17-24 to accommodate new section

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
