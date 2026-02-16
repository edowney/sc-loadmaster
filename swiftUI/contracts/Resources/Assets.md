# Asset Resources

## Image Assets Required

The following image assets are referenced in the Figma design and should be downloaded and added to your Xcode project's Assets catalog:

### Icons and UI Elements
- **contract.png** - Contract/document icon for footer navigation
- **log.png** - Log/list icon for footer navigation
- **ships.png** - Ships/vessels icon for footer navigation
- **arrow-up-circle.png** - Upload/delivery indicator icon
- **arrow-down-circle.png** - Download/collect indicator icon
- **save.png** - Save/bookmark icon
- **plus-circle.png** - Add/create new entry icon
- **minus-circle.png** - Remove/delete entry icon
- **container-badge.png** - Container size badge background

### Background
- **background-image.png** - Background texture/image with space theme

### Custom Fonts
The design uses the following custom fonts:
- **Audiowide-Regular** - Used for the main title "SC-LOADMASTER" and container numbers
- **Inter-Bold** - Used for page titles and labels
- **Inter-Regular** - Used for form labels and body text

## Implementation Notes

### Using SF Symbols (Recommended)
Instead of custom image assets, you can use SF Symbols for most icons:
- `doc.text` → Contract icon
- `list.bullet.rectangle` → Log icon
- `ferry` → Ships icon
- `arrow.up.circle` → Upload/delivery
- `arrow.down.circle` → Download/collect
- `square.and.arrow.down` → Save icon
- `plus.circle` → Add icon
- `minus.circle` → Remove icon

### Custom Assets
For assets that don't have SF Symbol equivalents:
1. Download assets from Figma (localhost URLs provided in design context)
2. Add to Xcode Assets.xcassets
3. Reference using `Image("asset-name")`

### Container Badge
The container badge now includes:
- Border with primary color
- Container size number (16, 8, 4, 2, 1)
- Red circle badge with yellow count number in bottom-right corner

### Fonts
1. Download Audiowide and Inter fonts from Google Fonts
2. Add .ttf or .otf files to Xcode project
3. Update Info.plist with "Fonts provided by application" array
4. Add font filenames to the array

## Asset URLs from Figma
```
Contract: http://localhost:3845/assets/50f898e6ee9c0322d3f202bca258534bb6bcd36a.png
Log: http://localhost:3845/assets/3e48e7422ac39b47998edee5cd1c70bc96cc9221.png
Ships: http://localhost:3845/assets/ce6270e46885f0a900e3fa18b6537bd14e371860.png
Background: http://localhost:3845/assets/8f3ac561d69abc1ac01b4ae7796ad60f98adfeb6.png
Arrow Up: http://localhost:3845/assets/56f64ab81eb223b54bb3e7b72303753dd81a1563.png
Save: http://localhost:3845/assets/b4eb2c670f45179340cabcd7d7b797aa370793b3.png
Container Badge: http://localhost:3845/assets/f954f040bb276015a625ed794ed0f0a4a4e901c6.png
Plus Circle: http://localhost:3845/assets/cd8a5fa014baf4258da509cc096445bb61a15d5e.png
Minus Circle: http://localhost:3845/assets/b0efb7b3ce51d070049c6b8038ef2f1f8f59552c.png
Arrow Down: http://localhost:3845/assets/9f857ee08a3518f7746e4ac110ec011c94de3e9c.png
```
