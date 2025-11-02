#!/usr/bin/env python3
"""Validate TTF font files in the sources directory."""

import os
import sys

try:
    from fontTools.ttLib import TTFont
except ImportError:
    print("❌ fontTools not installed. Install with: pip install fonttools")
    sys.exit(1)

fonts = [
    'sources/AmstradCPC-Regular.ttf',
    'sources/C64-Regular.ttf',
    'sources/Terminus.ttf',
    'sources/TerminusTTF-Bold-4.49.3.ttf',
    'sources/TerminusTTF-Bold-Italic-4.49.3.ttf',
    'sources/TomThumb.ttf',
    'sources/Unscii-8.ttf',
    'sources/VT323-Regular.ttf'
]

print('Font Validation Report')
print('=' * 70)

valid_count = 0
invalid_count = 0

for font_path in fonts:
    if not os.path.exists(font_path):
        print(f'\n❌ {os.path.basename(font_path)}')
        print(f'   Error: File not found')
        invalid_count += 1
        continue
    
    try:
        font = TTFont(font_path)
        name_table = font['name']
        
        # Get font family name
        family_name = None
        subfamily_name = None
        version = None
        
        for record in name_table.names:
            if record.nameID == 1:  # Family name
                family_name = record.toUnicode()
            elif record.nameID == 2:  # Subfamily name
                subfamily_name = record.toUnicode()
            elif record.nameID == 5:  # Version
                version = record.toUnicode()
        
        # Get basic info
        glyph_count = len(font.getGlyphSet())
        tables = sorted(font.keys())
        
        # Check for required tables
        required_tables = ['cmap', 'head', 'hhea', 'hmtx', 'maxp', 'name', 'post']
        missing_tables = [t for t in required_tables if t not in tables]
        
        print(f'\n✅ {os.path.basename(font_path)}')
        print(f'   Family: {family_name}')
        if subfamily_name:
            print(f'   Style: {subfamily_name}')
        if version:
            print(f'   Version: {version}')
        print(f'   Glyphs: {glyph_count}')
        print(f'   Tables: {len(tables)} ({", ".join(tables[:8])}{"..." if len(tables) > 8 else ""})')
        
        if missing_tables:
            print(f'   ⚠️  Missing tables: {", ".join(missing_tables)}')
        
        font.close()
        valid_count += 1
        
    except Exception as e:
        print(f'\n❌ {os.path.basename(font_path)}')
        print(f'   Error: {str(e)}')
        invalid_count += 1

print('\n' + '=' * 70)
print(f'\nSummary: {valid_count} valid, {invalid_count} invalid')

if invalid_count > 0:
    sys.exit(1)
