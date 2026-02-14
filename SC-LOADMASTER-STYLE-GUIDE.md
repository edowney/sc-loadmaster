# SC-LOADMASTER Style Guide

**Version:** 1.0  
**Date:** February 14, 2026  
**Platform:** iOS Mobile App  
**Design Tool:** Figma

---

## Table of Contents

1. [Color Palette](#color-palette)
2. [Typography](#typography)
3. [Spacing System](#spacing-system)
4. [Layout & Grid](#layout--grid)
5. [Components](#components)
6. [Icons & Graphics](#icons--graphics)
7. [States & Interactions](#states--interactions)
8. [Accessibility](#accessibility)

---

## How to Use This Guide

This style guide is a template to be filled in with exact values from your Figma design. Below each section, you'll find instructions on how to extract the values from Figma.

---

## Color Palette

### Primary Colors

**Background Colors:**

- **Main Background:** `#000000`
  - file: `background-image.png` oppacity set to 40%
  - Usage: Main screen background
  - Figma: **\*\***\_**\*\***

- **Card Background:** `#1C3741`
  - Usage: Contract cards, elevated elements
  - Figma: **\*\***\_**\*\***

- **Input Field Background:** `#FFFFFF` but at 40% oppacity
  - Usage: Text input fields, inactive state
  - Figma: **\*\***\_**\*\***

**Accent Colors:**

- **Primary Accent (Cyan/Teal):** `#______`
  - Usage: Headers, active elements, highlights
  - Figma: **\*\***\_**\*\***

- **Secondary Accent:** `#______`
  - Usage: **\*\***\_**\*\***
  - Figma: **\*\***\_**\*\***

**Text Colors:**

- **Primary Text:** `#509CB2`
  - Usage: Main text, headers
  - Figma: **\*\***\_**\*\***

- **Secondary Text:** `#FFFFFF`
  - Usage: Subtext, labels
  - Figma: **\*\***\_**\*\***

- **Muted Text:** `#______`
  - Usage: Placeholder text, disabled states
  - Figma: **\*\***\_**\*\***

**Status Colors:**

- **Container Badge Background (Red):** `#FF0000` at 50% oppacity
  - Usage: Container count badge background
  - Figma: **\*\***\_**\*\***

- **Container Badge Text (Yellow):** `#FFFF00`
  - Usage: Container count numbers
  - Figma: **\*\***\_**\*\***

- **Success/Confirmation:** `#______`
  - Usage: **\*\***\_**\*\***
  - Figma: **\*\***\_**\*\***

- **Error/Delete:** `#______`
  - Usage: Delete buttons, error states
  - Figma: **\*\***\_**\*\***

**Border & Separator Colors:**

- **Card Border:** `#509CB2`
  - Usage: Card outlines
  - Figma: **\*\***\_**\*\***

- **Horizontal Rule:** `#509CB2`
  - Usage: Dividers between items
  - Figma: **\*\***\_**\*\***

- **Input Border:** `#000000`
  - Usage: Input field borders
  - Figma: **\*\***\_**\*\***

### 📋 Extraction Instructions - Colors

**In Figma:**

1. Select any element (like the background of the Contracts page)
2. Look at the **right panel** under "Fill"
3. Click the color square to see the hex value
4. Copy the hex code (it will look like #2C4A4E)
5. Paste it in the template above

**Repeat for each element type:**

- Select a card → get card background color
- Select title text → get text color
- Select input field → get input background color
- Select the cyan headers → get accent color
- Select the red container badge → get badge color
- Select the yellow number → get badge text color

---

## Typography

### Font Family

- **Primary Font:** `Inter`
  - iOS Default: SF Pro Text / SF Pro Display
  - Check in Figma: Select any text → look for "Font family" in right panel

### Font Sizes

**Headers:**

- **App Title (SC-LOADMASTER):**
  - Size: `30` pt
  - Weight: `_Regular_` (e.g., Bold, Semibold)
  - Letter Spacing: `_0_` %
  - Figma: **\*\***\_**\*\***

- **Page Titles (CONTRACTS, LOG, SHIPS):**
  - Size: `_24_` pt
  - Weight: `_Bold_`
  - Letter Spacing: `19` %
  - Figma: **\*\***\_**\*\***

- **Card Headers (e.g., "1 Everus Harbor → HDPC-Cassillo"):**
  - Size: `_14_` pt
  - Weight: `Bold`
  - Letter Spacing: `_0_` %
  - Figma: **\*\***\_**\*\***

- **Section Headers (COLLECT, DELIVERY, etc.):**
  - Size: `_12_` pt
  - Weight: `_Regular_`
  - Letter Spacing: `_0_` %
  - Figma: **\*\***\_**\*\***

**Body Text:**

- **Primary Body (Commodity names, Ship names):**
  - Size: `_18_` pt
  - Weight: `Bold`
  - Line Height: `_22_` pt or `___` %
  - Figma: **\*\***\_**\*\***

- **Secondary Body (SCU amounts, numbers):**
  - Size: `_18_` pt
  - Weight: `Bold`
  - Figma: **\*\***\_**\*\***

- **Small Text (Labels, table headers):**
  - Size: `_12_` pt
  - Weight: `Semi bold`
  - Figma: **\*\***\_**\*\***

**Special Text:**

- **Container Size Numbers (16, 8, 4, 2, 1):**
  - Font: `Audiowide`
  - Size: `_16__` pt
  - Weight: `Regular`
  - Figma: **\*\***\_**\*\***

- **Container Count Badge (yellow numbers):**
  - Font: `Audiowide`
  - Size: `_12_` pt
  - Weight: `Regular`
  - Color: `#FFFF00`
  - Figma: **\*\***\_**\*\***

- **Totals (Total 139, Remaining 57):**
  - Size: `_18_` pt
  - Weight: `Bold`
  - Figma: **\*\***\_**\*\***

### Text Case

- **Uppercase:** Page titles, section headers, field labels
- **Title Case:** Card headers, button labels
- **Sentence Case:** Body text, commodity names

### 📋 Extraction Instructions - Typography

**In Figma:**

1. Select any text element (like "CONTRACTS")
2. Look at the **right panel** under "Text"
3. Note these values:
   - **Font family** (e.g., "SF Pro Display")
   - **Font size** (e.g., "24")
   - **Font weight** (e.g., "Bold", "Semibold", "Regular")
   - **Line height** (e.g., "Auto" or "32")
   - **Letter spacing** (e.g., "0%" or "5%")
4. Fill in the template above

**Repeat for:**

- App title "SC-LOADMASTER"
- Page titles "CONTRACTS", "LOG", "SHIPS"
- Field labels "SHIP", "COLLECT", etc.
- Commodity names like "Pressurized Ice"
- SCU numbers
- Container badge numbers

---

## Spacing System

### Base Unit

- **Base Spacing Unit:** `_varied_`
  - iOS Standard: Usually 8px
  - Your Design: **\*\***\_**\*\***

### Common Spacing Values

**Margins (Screen Edges):**

- **Left/Right Screen Margin:** `_varied_`
  - Figma: Measure from screen edge to first element

- **Top Margin (below page title):** `_147_` px
  - Figma: **\*\***\_**\*\***

- **Bottom Margin (above navigation):** `_75_` px
  - Figma: **\*\***\_**\*\***

**Padding (Inside Components):**

- **Card Padding:** `_varied_` px
  - Figma: Measure from card edge to internal content

- **Input Field Padding:** `_2_` px
  - Horizontal: `_1_` px
  - Vertical: `_1_` px
  - Figma: **\*\***\_**\*\***

- **Button/Icon Padding:** `_varied_` px
  - Figma: **\*\***\_**\*\***

**Component Spacing:**

- **Between Input Fields (horizontal):** `_10_` px
  - Figma: **\*\***\_**\*\***

- **Between Form Rows (vertical):** `_10_` px
  - Figma: **\*\***\_**\*\***

- **Between List Items:** `_10_` px
  - Figma: **\*\***\_**\*\***

- **Between Cards:** `_10_` px
  - Figma: **\*\***\_**\*\***

- **Between Container Icons:** `_12__` px
  - Figma: **\*\***\_**\*\***

### 📋 Extraction Instructions - Spacing

**In Figma:**

1. Select an element
2. Hold **Alt/Option** key
3. Hover over another element
4. Figma will show the distance between them in red
5. Note the pixel value

**Or use the Inspect panel:**

1. Select an element
2. Look at the right panel under "Frame" or "Auto Layout"
3. Check padding values (if using Auto Layout)

**Key measurements to get:**

- Distance from screen edge to "SHIP" label
- Distance between "SHIP" and "MAX CONTAINER SIZE" fields
- Distance between field labels and input boxes
- Padding inside a card
- Space between card entries
- Distance between container icons

---

## Layout & Grid

### Screen Dimensions

- **Design Width:** `_393_` px
  - Common: 375px (iPhone standard)
  - Your Design: **\*\***\_**\*\***

- **Design Height:** `_852_` px
  - Common: 812px (iPhone standard)
  - Your Design: **\*\***\_**\*\***

### Safe Areas

- **Top Safe Area (notch):** `_35_` px
  - Figma: **\*\***\_**\*\***

- **Bottom Safe Area (home indicator):** `_0_` px
  - Figma: **\*\***\_**\*\***

### 📋 Extraction Instructions - Layout

**In Figma:**

1. Select the entire screen frame (the iPhone outline)
2. Look at the right panel under "Frame"
3. Note the Width (W) and Height (H)
4. Check if there are guides showing safe areas

---

## Components

### Buttons & Icons

**Plus Icon (+):**

- **Size:** `_20_` × `_20_` px
- **Color:** `#65ACBF`
- **Stroke Width:** `_2_` px
- **Figma:** **\*\***\_**\*\***

**Minus Icon (−):**

- **Size:** `_20__` × `_20_` px
- **Color:** `#65ACBF`
- **Stroke Width:** `_2_` px
- **Figma:** **\*\***\_**\*\***

**Up Arrow Icon (↑):**

- **Size:** `_20_` × `_20_` px
- **Color:** `#65ACBF`
- **Stroke Width:** `_2_` px
- **Figma:** **\*\***\_**\*\***

**Down Arrow Icon (↓):**

- **Size:** `_20_` × `_20_` px
- **Color:** `#65ACBF`
- **Stroke Width:** `_2_` px
- **Figma:** **\*\***\_**\*\***

**Save/Disk Icon (💾):**

- **Size:** `_25__` × `_25__` px
- **Color:** `#65ACBF`
- **Style:** Outline / Filled
- **Stroke Width:** `_2_` px
- **Figma:** **\*\***\_**\*\***

### Navigation Icons

**Home Icon:**

- **Size:** `_40_` × `_40_` px
- **Color (Inactive):** `#33606D`
- **Color (Active):** `#509CB2`
- **Stroke Width:** `_3.5_` px
- **Figma:** **\*\***\_**\*\***

**Document Icon:**

- **Size:** `_40_` × `_40_` px
- **Color (Inactive):** `#33606D`
- **Color (Active):** `#509CB2`
- **Stroke Width:** `_3.5_` px
- **Figma:** **\*\***\_**\*\***

**Anchor Icon:**

- **Size:** `_40_` × `_40_` px
- **Color (Inactive):** `#33606D`
- **Color (Active):** `#509CB2`
- **Stroke Width:** `_3.5_` px
- **Figma:** **\*\***\_**\*\***

### Input Fields

**Text Input:**

- **Height:** `_20_` px
- **Border Radius:** `_5_` px
- **Border Width:** `_1_` px
- **Border Color:** `#000000`
- **Background Color:** `#FFFFFF` with an oppacity of 40%
- **Text Color:** `#FFFFFF`
- **Padding (Horizontal):** `_1__` px
- **Padding (Vertical):** `_1_` px
- **Font Size:** `_12_` pt
- **Figma:** **\*\***\_**\*\***

**Input Field States:**

- **Default:** Background `#FFFFFF` with an oppacity of 40%, Border `#000000`
- **Focus/Active:** Background `#FFFFFF` with an oppacity of 40%, Border `#000000`
- **Error:** Background `#FFFFFF` with an oppacity of 40%, Border `RED`
- **Disabled:** Background `#______`, Border `#______`

### Cards

**Contract Card:**

- **Background Color:** `#509CB2`
- **Border Radius:** `_20_` px but only on the lower right
- **Border Width:** `_1_` px
- **Border Color:** `#509CB2`
- **Padding:** `_0_` px
- **Shadow:** No
- **Figma:** **\*\***\_**\*\***

**Card Header:**

- **Background Color:** `#164553` (if different from card)
- **Text Color:** `#509CB2`
- **Font Size:** `_14__` pt
- **Font Weight:** `___Bold____`
- **Padding:** `__0_` px
- **Figma:** **\*\***\_**\*\***

**Horizontal Rule (Card Divider):**

- **Height:** `_1_` px
- **Color:** `#509CB2`
- **Opacity:** `_100_` %
- **Margin (Top/Bottom):** `10___` px
- **Figma:** **\*\***\_**\*\***

### Container Visualization Icons

**Container Icon (Generic):**

- **Width:** `_34.13_` px
- **Height:** `_29.88__` px
- **Border Radius:** `_0_` px
- **Border Width:** `_2_` px
- **Border Color:** `#509CB2`
- **Background:** Transparent
- **Figma:** **\*\***\_**\*\***

**Container Size Label:**

- **Font:** `Audiowide`
- **Font Size:** `_16_` pt
- **Font Weight:** `_Regular_`
- **Color:** `#509CB2`
- **Position:** Inside icon
- **Figma:** **\*\***\_**\*\***

**Container Count Badge:**

- **Size (Diameter):** `_20.86__` px
- **Background Color:** `#FF0000` with a 50% oppacity
- **Position:** buttom-right corner
- **Figma:** **\*\***\_**\*\***

**Container Count Number:**

- **Font Size:** `_12_` pt
- **Font Weight:** `Regular`
- **Color:** `#FFFF00`
- **Figma:** **\*\***\_**\*\***

### Lists

**List Item:**

- **Height:** `_20_` px
- **Background Color:** `Transparent`
- **Border/Separator:** No
- **Padding (Horizontal):** `_7__` px
- **Padding (Vertical):** `_7__` px
- **Figma:** **\*\***\_**\*\***

**Table Row (Log/Ships pages):**

- **Height:** `_33_` px
- **Background Color (Odd):** `Transparent`
- **Background Color (Even):** `#164553`
- **Border Color:** `#509CB2`
- **Padding:** `_0_` px
- **Figma:** **\*\***\_**\*\***

### Navigation Bar

**Navigation Bar:**

- **Height:** `___` px
- **Background Color:** `#______`
- **Border Top:** Yes / No
  - **Color:** `#______`
  - **Width:** `___` px
- **Figma:** **\*\***\_**\*\***

**Navigation Item:**

- **Icon Size:** `_40_` × `_40__` px
- **Spacing Between Icons:** `_50_` px
- **Active Indicator:** Color
  - **Color:** `#509CB2`
- **Figma:** **\*\***\_**\*\***

### 📋 Extraction Instructions - Components

**In Figma:**

1. Select a component (like an input field)
2. Look at the right panel:
   - **Width (W)** and **Height (H)** for size
   - **Fill** for background color
   - **Stroke** for border color and width
   - **Corner Radius** for rounded corners
   - **Effects** for shadows
3. For spacing within Auto Layout components:
   - Look for "Padding" values
   - Look for "Item spacing" (gap between elements)

**For icons specifically:**

1. Select the icon
2. Check if it's a vector or image
3. Note the size (W × H)
4. Check stroke color and width
5. Check if it has fill or is outline only

---

## Icons & Graphics

### Icon Style

- **Style:** Outline / Filled / Duotone
- **Stroke Weight:** `___` px
- **Corner Radius:** `___` px (for rounded stroke caps)

### Container Size Icons

Document each container size icon:

**16 SCU Container:**

- **Icon File:** `container.png`
- **Dimensions:** `34.13` × `29.88` px
- **Style:** **\*\***\_**\*\***
- **Figma Frame Name:** **\*\***\_**\*\***

**8 SCU Container:**

- **Icon File:** `container.png`
- **Dimensions:** `_34.13_` × `_29.88_` px
- **Style:** **\*\***\_**\*\***
- **Figma Frame Name:** **\*\***\_**\*\***

**4 SCU Container:**

- **Icon File:** `container.png`
- **Dimensions:** `_34.13_` × `_29.88_` px
- **Style:** **\*\***\_**\*\***
- **Figma Frame Name:** **\*\***\_**\*\***

**2 SCU Container:**

- **Icon File:** `container.png`
- **Dimensions:** `_34.13_` × `_29.88_` px
- **Style:** **\*\***\_**\*\***
- **Figma Frame Name:** **\*\***\_**\*\***

**1 SCU Container:**

- **Icon File:** `container.png`
- **Dimensions:** `_34.13_` × `_29.88_` px
- **Style:** **\*\***\_**\*\***
- **Figma Frame Name:** **\*\***\_**\*\***

### App Icon

- **Size (Required iOS Sizes):** 40×40px
- **Background:** `Transparent`
- **Foreground Elements:** **\*\***\_**\*\***
- **Figma:** **\*\***\_**\*\***

### 📋 Extraction Instructions - Icons

**In Figma:**

1. Select each icon individually
2. Note the width and height
3. Check if it's a vector shape or imported image
4. For export:
   - Right-click → "Copy as PNG" or "Copy as SVG"
   - Or use Export settings in right panel

---

## States & Interactions

### Interactive States

**Button/Icon States:**

- **Default:**
  - Opacity: `_100__` %
  - Color: `#509CB2`
- **Hover (if applicable on iOS):**
  - Opacity: `_100_` %
  - Color: `#509CB2`
- **Pressed/Active:**
  - Opacity: `_100_` %
  - Color: `#509CB2`
  - Scale: `_100_` %
  - Background: `Transparent`
- **Disabled:**
  - Opacity: `___` %
  - Color: `#______`

**Input Field States:**

- **Default:**
  - Border: `#______`
  - Background: `#______`
- **Focus:**
  - Border: `#______`
  - Background: `#______`
  - Glow/Shadow: Yes / No
- **Error:**
  - Border: `#000000`
  - Background: `FFFFFF` opacity 40%
  - Text Color: `RED`

### Animations

**Navigation Transition:**

- **Type:** Slide
- **Duration:** `20` ms
- **Easing:** Ease-in

**List Item Add:**

- **Type:** Slide down
- **Duration:** `20` ms
- **Easing:** **\*\***\_**\*\***

**List Item Remove:**

- **Type:** Slide up
- **Duration:** `20` ms
- **Easing:** **\*\***\_**\*\***

**Button Press:**

- **Type:** Scale
- **Duration:** `20` ms
- **Scale Amount:** `120` %
- **Opacity Change:** `0` %

### 📋 Extraction Instructions - States

**In Figma:**

- If you created variants or component states:
  1. Select the component
  2. Look for "Variants" in the left panel
  3. Check each variant's properties
- If no variants, note what should change visually:
  - Pressed buttons typically have 80-90% opacity
  - Active nav items might be brighter or have underline
  - Focus states often have a glow or brighter border

---

## Accessibility

### Color Contrast

- **Text on Dark Background:** Pass WCAG AA? Yes / No
  - Contrast Ratio: `___.___:1`
- **Text on Light Background:** Pass WCAG AA? Yes / No
  - Contrast Ratio: `___.___:1`

### Touch Targets

- **Minimum Size:** 44 × 44 pt (iOS requirement)
- **Your Icon Sizes Meet Minimum:** Yes / No
- **Adjustments Needed:** **\*\***\_**\*\***

### Dynamic Type Support

- **Supports iOS Dynamic Type:** Yes / No / To Be Implemented
- **Maximum Scale:** **\*\***\_**\*\***
- **Minimum Scale:** **\*\***\_**\*\***

---

## Design System Notes

### Design Principles

- Clarity and readability in a space/sci-fi theme
- Dark theme optimized for low-light gameplay environments
- High contrast for important information
- Minimal friction in data entry with smart autocomplete
- Visual hierarchy through size, color, and spacing

### Inspiration/References

- Star Citizen game aesthetic
- Sci-fi HUD interfaces
- Military/industrial design language
- Space station terminal interfaces

### Future Considerations

- Light theme variant
- Tablet/iPad layout
- Landscape orientation
- Additional container sizes if game adds them

---

## Appendix: Figma Quick Reference

### How to Find Values in Figma

**Colors:**

1. Select element → Right panel → "Fill" → Click color square → Copy hex

**Text Properties:**

1. Select text → Right panel → "Text" section → Note all values

**Spacing:**

1. Select element → Hold Alt/Option → Hover over another element → See distance
2. Or: Select element → Right panel → Check "Auto Layout" padding/spacing

**Sizes:**

1. Select element → Right panel → "W" (width) and "H" (height)

**Shadows/Effects:**

1. Select element → Right panel → "Effects" → Expand to see details

**Border Radius:**

1. Select element → Right panel → Look for corner radius values

**Export Assets:**

1. Select element → Right panel → "Export" section → Choose format (PNG/SVG)
2. Or: Right-click → "Copy as PNG" or "Copy as SVG"

---

## Version History

**Version 1.0** - February 14, 2026

- Initial style guide template
- Ready for value extraction from Figma

---

**Next Steps:**

1. Fill in all hex colors from your Figma design
2. Document all text sizes and weights
3. Measure spacing values
4. Export icon assets
5. Review for completeness
6. Share with development team

**Questions or Missing Information:**

- List any uncertainties here
- Note any design decisions that need confirmation
- Document any variations or alternatives considered

---

**END OF STYLE GUIDE TEMPLATE**
