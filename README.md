# dye
## An ultrafast image colorizer tool

### Installation
#### From Source
**Deps:**
- nim
- nimble

```bash
git clone https://github.com/Infinitybeond1/dye # clone the repo
cd dye
nimble build_install # Build and install dye
```
#### Binary
Coming Soon!

### Usage
```bash
# Get command info
dye --help

# Convert 'test.jpg' using the dark-decay color palette
dye -b --colorfile dark-decay test.jpg

# List color palettes
dye list

# Set a custom directory to search for palettes
export DYE_PALETTE_DIR="hello"  
```
