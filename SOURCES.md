# Font Sources and Attribution

This document provides detailed attribution information for all fonts included in this repository, including original authors, source URLs, licenses, and repositories.

## Conversion Methodology

All fonts in this repository have been converted from their original TTF (TrueType Font) format to web-optimized WOFF2 and WOFF formats using the following process:

- **Tool**: Python `fonttools` library with `pyftsubset`
- **Subsetting**: Latin characters only (U+0020-007E, U+00A0-00FF)
- **Optimization**: Desubroutinization, hinting removal, Brotli compression
- **Formats**: WOFF2 (primary, modern browsers) and WOFF (fallback, legacy browsers)
- **Features**: All layout features preserved for proper rendering

This conversion reduces file sizes by 70-90% while maintaining full functionality for Latin-based languages.

---

## VT323

**Author**: Peter Hull

**Source**: Google Fonts

**Source URL**: https://fonts.google.com/specimen/VT323

**Repository**: https://github.com/google/fonts/tree/main/ofl/vt323

**License**: SIL Open Font License 1.1

**License URL**: https://scripts.sil.org/OFL

**Description**: VT323 is a monospace font based on the DEC VT320 text terminal, which was introduced in 1987. It features the classic terminal aesthetic with a fixed-width design perfect for code editors and retro interfaces.

---

## C64

**Author**: Style (Style64.org)

**Source**: Style64 TrueType Project

**Source URL**: https://style64.org/c64-truetype

**Repository**: N/A (Direct download from website)

**License**: Free for personal and commercial use

**License URL**: https://style64.org/c64-truetype (see license.txt in distribution)

**Description**: The C64 TrueType fonts recreate the iconic Commodore 64 character set. This collection includes multiple variants:
- **C64-Regular**: Standard C64 character set
- **C64-Pro**: Enhanced version with additional characters
- **C64-Pro-Mono**: Monospace variant of C64 Pro
- **C64-Elite-Mono**: Legacy monospace variant

---

## Terminus

**Author**: Dimitar Toshkov Zhekov

**Source**: Terminus Font Home Page

**Source URL**: https://terminus-font.sourceforge.net/

**Repository**: https://sourceforge.net/projects/terminus-font/

**License**: SIL Open Font License 1.1

**License URL**: https://scripts.sil.org/OFL

**Description**: Terminus is a clean, fixed-width bitmap font designed for long work with computers. It includes multiple variants:
- **Terminus**: Regular weight
- **Terminus-Bold**: Bold weight
- **Terminus-BoldItalic**: Bold italic variant

The TrueType version used here is from the TerminusTTF project.

---

## Unscii

**Author**: Viznut (Ville-Matias Heikkilä)

**Source**: Unscii - Bitmapped Unicode fonts

**Source URL**: http://pelulamu.net/unscii/

**Repository**: https://github.com/viznut/unscii

**License**: Public Domain

**License URL**: http://unlicense.org/

**Description**: Unscii is a set of bitmapped Unicode fonts based on classic system fonts. The fonts are designed to support a wide range of scripts while maintaining a consistent retro aesthetic. This repository includes Unscii-8, the 8x8 pixel variant.

---

## Amstrad CPC

**Author**: Frederic Cambus (based on original Amstrad character set)

**Source**: Amstrad CPC Font

**Source URL**: https://github.com/fcambus/amstrad-cpc-font

**Repository**: https://github.com/fcambus/amstrad-cpc-font

**License**: SIL Open Font License 1.1

**License URL**: https://scripts.sil.org/OFL

**Description**: A TrueType font based on the character set from the Amstrad CPC 464, a popular 8-bit home computer from the 1980s. The font captures the distinctive look of the CPC's text mode display.

---

## Tom Thumb

**Author**: Robey Pointer (original), Brian Swetland (TrueType conversion)

**Source**: Tom Thumb TrueType

**Source URL**: https://robey.lag.net/2010/01/23/tiny-monospace-font.html

**Repository**: https://github.com/swetland/tom-thumb-ttf

**License**: CC0 1.0 Universal (Public Domain Dedication)

**License URL**: https://creativecommons.org/publicdomain/zero/1.0/

**Description**: Tom Thumb is an extremely small 4x6 pixel monospace font. Despite its tiny size, it remains surprisingly readable and is perfect for space-constrained interfaces or artistic retro designs.

---

## Topaz

**Author**: Various (recreated from Amiga Workbench)

**Source**: Topaz Font Recreation

**Source URL**: https://www.dafont.com/topaz-a-new-coding-font.font

**Repository**: N/A

**License**: Free use (recreated font)

**License URL**: N/A (Public recreation of classic Amiga font)

**Description**: Topaz is a recreation of the classic Amiga Workbench system font. The original Topaz font was designed by the Amiga development team and became iconic in the demoscene and retro computing communities. This TrueType version recreates the distinctive look of the original bitmap font.

---

## Additional Resources

For more information about web font optimization and the conversion process:

- **fonttools Documentation**: https://fonttools.readthedocs.io/
- **WOFF2 Specification**: https://www.w3.org/TR/WOFF2/
- **Font Subsetting Guide**: https://web.dev/reduce-webfont-size/

## Acknowledgments

Special thanks to all the font authors and maintainers who have made these fonts available for use. Their work preserves computing history and enables modern developers to create authentic retro experiences.

If you use these fonts in your project, please consider crediting the original authors and linking back to their source repositories.
