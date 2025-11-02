#!/bin/bash

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}=== Font Repository Analysis ===${NC}\n"

# Fonts that SHOULD exist (from README and download script)
echo -e "${BLUE}1. Fonts that SHOULD exist (per README):${NC}"
SHOULD_EXIST=(
  "VT323-Regular.ttf"
  "C64-Regular.ttf"
  "Terminus.ttf"
  "Unscii-8.ttf"
  "Funscii.ttf"
  "CP437.ttf"
  "TomThumb.ttf"
)

for font in "${SHOULD_EXIST[@]}"; do
  echo "  - $font"
done
echo ""

# Additional fonts from download script
echo -e "${BLUE}Additional fonts from download script:${NC}"
DOWNLOAD_SCRIPT_FONTS=(
  "AmstradCPC-Regular.ttf"
  "Topaz-Regular.ttf"
)

for font in "${DOWNLOAD_SCRIPT_FONTS[@]}"; do
  echo "  - $font"
done
echo ""

# Fonts that ACTUALLY exist in sources/
echo -e "${BLUE}2. Fonts that ACTUALLY exist in sources/:${NC}"
ACTUAL_FONTS=()
if [ -d "sources" ]; then
  while IFS= read -r font; do
    ACTUAL_FONTS+=("$(basename "$font")")
    echo -e "  ${GREEN}✓${NC} $(basename "$font")"
  done < <(find sources -name "*.ttf" -type f | sort)
else
  echo -e "${RED}  sources/ directory not found${NC}"
fi
echo ""

# Fonts that are MISSING
echo -e "${BLUE}3. Fonts that are MISSING:${NC}"
ALL_EXPECTED=("${SHOULD_EXIST[@]}" "${DOWNLOAD_SCRIPT_FONTS[@]}")
MISSING_COUNT=0

for font in "${ALL_EXPECTED[@]}"; do
  if [ ! -f "sources/$font" ]; then
    echo -e "  ${RED}✗${NC} $font"
    MISSING_COUNT=$((MISSING_COUNT + 1))
  fi
done

if [ $MISSING_COUNT -eq 0 ]; then
  echo -e "  ${GREEN}None - all expected fonts are present${NC}"
fi
echo ""

# Fonts configured in convert-fonts.sh
echo -e "${BLUE}4. Fonts configured in convert-fonts.sh:${NC}"
CONVERT_FONTS=(
  "VT323-Regular.ttf"
  "C64-Regular.ttf"
  "Terminus.ttf"
  "Unscii-8.ttf"
  "Funscii.ttf"
  "CP437.ttf"
  "TomThumb.ttf"
)

for font in "${CONVERT_FONTS[@]}"; do
  if [ -f "sources/$font" ]; then
    echo -e "  ${GREEN}✓${NC} $font (exists)"
  else
    echo -e "  ${RED}✗${NC} $font (missing)"
  fi
done
echo ""

# Fonts that exist but are NOT in convert script
echo -e "${BLUE}5. Fonts that exist but NOT in convert-fonts.sh:${NC}"
NOT_IN_CONVERT=0

for font in "${ACTUAL_FONTS[@]}"; do
  found=0
  for convert_font in "${CONVERT_FONTS[@]}"; do
    if [ "$font" = "$convert_font" ]; then
      found=1
      break
    fi
  done
  
  if [ $found -eq 0 ]; then
    echo -e "  ${YELLOW}⚠${NC}  $font"
    NOT_IN_CONVERT=$((NOT_IN_CONVERT + 1))
  fi
done

if [ $NOT_IN_CONVERT -eq 0 ]; then
  echo -e "  ${GREEN}None - all existing fonts are configured${NC}"
fi
echo ""

# Summary
echo -e "${BLUE}=== Summary ===${NC}"
echo -e "Expected fonts: ${#ALL_EXPECTED[@]}"
echo -e "Actual fonts: ${#ACTUAL_FONTS[@]}"
echo -e "Missing fonts: ${RED}${MISSING_COUNT}${NC}"
echo -e "Not in convert script: ${YELLOW}${NOT_IN_CONVERT}${NC}"
