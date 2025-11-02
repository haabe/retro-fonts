# Retro Fonts Repository

A collection of retro and pixel fonts optimized for web use, converted to WOFF2 and WOFF formats with Latin character subsetting. Perfect for retro-themed web applications, terminal emulators, and nostalgic user interfaces.

## Features

- 12 carefully selected retro/pixel fonts (with variants)
- Optimized WOFF2 and WOFF formats for web delivery
- Latin character subset (U+0020-007E, U+00A0-00FF) for smaller file sizes
- Automated conversion pipeline with error handling
- Virtual environment for isolated dependency management
- CDN delivery via jsDelivr for fast global access

## Fonts Included

All fonts are provided in both WOFF2 (modern browsers) and WOFF (legacy browser support) formats.

- **VT323** - Classic terminal font (SIL Open Font License 1.1)
- **C64** - Commodore 64 style (Free for personal and commercial use)
  - C64-Regular, C64-Pro, C64-Pro-Mono, C64-Elite-Mono variants
- **Terminus** - Clean bitmap font (SIL Open Font License 1.1)
  - Terminus, Terminus-Bold, Terminus-BoldItalic variants
- **Unscii** - Unicode bitmap font (Public Domain)
- **Amstrad CPC** - Amstrad CPC 464 style (SIL Open Font License 1.1)
- **Tom Thumb** - Tiny 4x6 pixel font (CC0 1.0 Universal - Public Domain)
- **Topaz** - Classic Amiga Workbench font (Recreated, free use)

## Usage via CDN (Recommended)

The easiest way to use these fonts is via jsDelivr CDN. No download or installation required!

### Basic Usage

Add this to your HTML `<head>`:

```html
<!-- Preconnect to CDN for faster loading -->
<link rel="preconnect" href="https://cdn.jsdelivr.net" crossorigin>
<link rel="dns-prefetch" href="https://cdn.jsdelivr.net">
```

Then use `@font-face` in your CSS:

```css
/* VT323 - Classic Terminal Font */
@font-face {
  font-family: 'VT323';
  src: url('https://cdn.jsdelivr.net/gh/YOUR-USERNAME/retro-fonts@1.0.0/vt323/VT323-Regular.woff2') format('woff2'),
       url('https://cdn.jsdelivr.net/gh/YOUR-USERNAME/retro-fonts@1.0.0/vt323/VT323-Regular.woff') format('woff');
  font-style: normal;
  font-weight: 400;
  font-display: swap;
}

/* C64 - Commodore 64 Style */
@font-face {
  font-family: 'C64';
  src: url('https://cdn.jsdelivr.net/gh/YOUR-USERNAME/retro-fonts@1.0.0/c64/C64-Regular.woff2') format('woff2'),
       url('https://cdn.jsdelivr.net/gh/YOUR-USERNAME/retro-fonts@1.0.0/c64/C64-Regular.woff') format('woff');
  font-style: normal;
  font-weight: 400;
  font-display: swap;
}

/* Terminus - Clean Bitmap Font */
@font-face {
  font-family: 'Terminus';
  src: url('https://cdn.jsdelivr.net/gh/YOUR-USERNAME/retro-fonts@1.0.0/terminus/Terminus.woff2') format('woff2'),
       url('https://cdn.jsdelivr.net/gh/YOUR-USERNAME/retro-fonts@1.0.0/terminus/Terminus.woff') format('woff');
  font-style: normal;
  font-weight: 400;
  font-display: swap;
}

/* Apply to elements */
body {
  font-family: 'VT323', monospace;
}

.retro-text {
  font-family: 'C64', monospace;
}
```

### Font Subsetting Strategy

All fonts are subset to include only Latin characters to minimize file size:

- **Basic Latin**: U+0020-007E (space through tilde)
- **Latin-1 Supplement**: U+00A0-00FF (non-breaking space through ÿ)

This reduces font file sizes by 70-90% compared to full character sets, resulting in faster page loads while supporting English and most Western European languages.

**Optimization techniques applied:**
- Desubroutinization for better compression
- Hinting removal to reduce file size
- WOFF2 Brotli compression (smaller than WOFF)
- Layout features preserved for proper rendering

### Direct Download

You can also download fonts directly from the [releases page](https://github.com/YOUR-USERNAME/retro-fonts/releases) if you prefer to self-host.

## Local Development Setup

If you want to convert fonts locally or add new fonts:

### 1. Setup

Run the setup script to create a virtual environment and install dependencies:

```bash
./setup.sh
```

This will:
- Create a Python virtual environment in `venv/`
- Install `fonttools` and `brotli` packages
- Verify the installation

### 2. Convert Fonts

Run the conversion script:

```bash
./convert-fonts.sh
```

The script will:
- Automatically activate the virtual environment (if available)
- Validate all dependencies are installed
- Check that source TTF files exist
- Convert each font to WOFF2 and WOFF formats
- Verify output files were created successfully
- Display file sizes and total summary

### 3. Output Structure

After conversion, fonts will be organized in directories:

```
vt323/
  VT323-Regular.woff2
  VT323-Regular.woff
  LICENSE.txt
c64/
  C64-Regular.woff2
  C64-Regular.woff
  C64-Pro.woff2
  C64-Pro.woff
  C64-Pro-Mono.woff2
  C64-Pro-Mono.woff
  C64-Elite-Mono.woff2
  C64-Elite-Mono.woff
  LICENSE.txt
...
```

## Requirements

- Python 3.x
- pip (Python package manager)

The setup script will install:
- `fonttools` - Font manipulation library
- `brotli` - Compression library for WOFF2

## Manual Installation

If you prefer not to use the setup script:

```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# Install dependencies
pip install fonttools brotli

# Run conversion
./convert-fonts.sh
```

## Error Handling

The conversion script includes comprehensive error handling:

- **Dependency checks** - Verifies Python, fonttools, and brotli are installed
- **Source validation** - Confirms TTF files exist and are readable
- **Output verification** - Ensures WOFF2 and WOFF files are created successfully
- **Clear error messages** - Provides actionable guidance when issues occur

## Project Structure

```
.
├── setup.sh              # Setup script for dependencies
├── convert-fonts.sh      # Font conversion script
├── sources/              # Source TTF files
│   ├── VT323-Regular.ttf
│   ├── C64-Regular.ttf
│   └── ...
├── vt323/               # Converted VT323 fonts
├── c64/                 # Converted C64 fonts
└── ...
```

## License Information

Each font has its own license. Please check the `LICENSE.txt` file in each font directory for complete license information.

**License Summary:**

- **VT323**: SIL Open Font License 1.1
- **C64**: Free for personal and commercial use
- **Terminus**: SIL Open Font License 1.1
- **Unscii**: Public Domain
- **Amstrad CPC**: SIL Open Font License 1.1
- **Tom Thumb**: CC0 1.0 Universal (Public Domain)
- **Topaz**: Free use (recreated font)

For detailed attribution and source information, see [SOURCES.md](SOURCES.md).

## Contributing

To add new fonts:

1. Place the TTF file in the `sources/` directory
2. Add a conversion line in `convert-fonts.sh`
3. Run the conversion script
4. Update this README with the new font information
