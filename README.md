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
nimble bi # Build and install dye
```
#### Binary
There are many binaries for different operating systems and architectures on the github releases page

### Usage
```bash
# Get command info
dye --help

# Convert 'test.jpg' using the dark-decay color palette
dye -b --colorfile dark-decay test.jpg

# List color palettes
dye list
```
