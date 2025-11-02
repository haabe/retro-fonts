#!/bin/bash

# Font Download Automation Script
# Downloads source TTF fonts from various upstream repositories

set -e  # Exit on error

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Create sources directory if it doesn't exist
mkdir -p sources

echo -e "${BLUE}=== Font Download Automation ===${NC}\n"

# Function to download VT323 from Google Fonts
download_vt323() {
  echo -e "${BLUE}Downloading VT323...${NC}"
  
  local url="https://github.com/google/fonts/raw/main/ofl/vt323/VT323-Regular.ttf"
  local output="sources/VT323-Regular.ttf"
  
  curl -L -o "$output" "$url"
  
  # Verify file exists and has valid size
  if [ -f "$output" ] && [ -s "$output" ]; then
    local size=$(du -h "$output" | cut -f1)
    echo -e "${GREEN}✓ Downloaded VT323-Regular.ttf ($size)${NC}"
  else
    echo -e "${RED}✗ Failed to download VT323${NC}"
    exit 1
  fi
}

# Function to download and extract Terminus
download_terminus() {
  echo -e "${BLUE}Downloading Terminus...${NC}"
  
  local url="https://files.ax86.net/terminus-ttf/files/latest.zip"
  local zip_file="sources/terminus-latest.zip"
  local output="sources/Terminus.ttf"
  
  # Download zip archive
  curl -L -o "$zip_file" "$url"
  
  # Extract TTF file (terminus-ttf contains TerminusTTF-4.49.3.ttf or similar)
  unzip -j "$zip_file" "*.ttf" -d sources/ 2>/dev/null || true
  
  # Find the extracted TTF and rename it
  local extracted=$(find sources/ -name "TerminusTTF*.ttf" -o -name "terminus*.ttf" | head -1)
  
  if [ -n "$extracted" ]; then
    mv "$extracted" "$output"
    # Clean up zip file
    rm -f "$zip_file"
    
    local size=$(du -h "$output" | cut -f1)
    echo -e "${GREEN}✓ Downloaded and extracted Terminus.ttf ($size)${NC}"
  else
    echo -e "${RED}✗ Failed to extract Terminus TTF${NC}"
    rm -f "$zip_file"
    exit 1
  fi
}

# Function to extract C64 font from existing zip
extract_c64() {
  echo -e "${BLUE}Extracting C64 font...${NC}"
  
  local zip_file="sources/C64_TrueType_v1.2.1-STYLE.zip"
  local output="sources/C64-Regular.ttf"
  
  # Check if zip file exists
  if [ ! -f "$zip_file" ]; then
    echo -e "${RED}✗ C64 zip file not found at $zip_file${NC}"
    echo -e "${BLUE}  Please download manually from https://style64.org/c64-truetype${NC}"
    return 1
  fi
  
  # Extract the C64_Pro_Mono-STYLE.ttf file
  unzip -j "$zip_file" "*/fonts/C64_Pro_Mono-STYLE.ttf" -d sources/ 2>/dev/null || true
  
  # Rename to standardized name
  if [ -f "sources/C64_Pro_Mono-STYLE.ttf" ]; then
    mv sources/C64_Pro_Mono-STYLE.ttf "$output"
    local size=$(du -h "$output" | cut -f1)
    echo -e "${GREEN}✓ Extracted C64-Regular.ttf ($size)${NC}"
  else
    echo -e "${RED}✗ Failed to extract C64 font from zip${NC}"
    return 1
  fi
}

# Function to download repository-based fonts
download_repo_fonts() {
  echo -e "${BLUE}Downloading repository-based fonts...${NC}"
  
  # Unscii
  echo -e "${BLUE}  Cloning Unscii repository...${NC}"
  if [ -d "temp-unscii" ]; then
    rm -rf temp-unscii
  fi
  git clone --depth 1 https://github.com/viznut/unscii.git temp-unscii
  cp temp-unscii/fontfiles/unscii-8.ttf sources/Unscii-8.ttf
  rm -rf temp-unscii
  
  if [ -f "sources/Unscii-8.ttf" ]; then
    local size=$(du -h sources/Unscii-8.ttf | cut -f1)
    echo -e "${GREEN}  ✓ Extracted Unscii-8.ttf ($size)${NC}"
  fi
  
  # Tom Thumb
  echo -e "${BLUE}  Cloning Tom Thumb TTF repository...${NC}"
  if [ -d "temp-tom-thumb" ]; then
    rm -rf temp-tom-thumb
  fi
  git clone --depth 1 https://github.com/gheja/tom-thumb-ttf.git temp-tom-thumb
  
  # Look for TTF file
  if [ -f "temp-tom-thumb/TomThumb.ttf" ]; then
    cp temp-tom-thumb/TomThumb.ttf sources/TomThumb.ttf
  elif [ -f "temp-tom-thumb/tom-thumb.ttf" ]; then
    cp temp-tom-thumb/tom-thumb.ttf sources/TomThumb.ttf
  else
    # Find any TTF file in the repository
    local tomthumb_ttf=$(find temp-tom-thumb -name "*.ttf" | head -1)
    if [ -n "$tomthumb_ttf" ]; then
      cp "$tomthumb_ttf" sources/TomThumb.ttf
    fi
  fi
  rm -rf temp-tom-thumb
  
  if [ -f "sources/TomThumb.ttf" ]; then
    local size=$(du -h sources/TomThumb.ttf | cut -f1)
    echo -e "${GREEN}  ✓ Extracted TomThumb.ttf ($size)${NC}"
  fi
  
  # Amstrad CPC
  echo -e "${BLUE}  Cloning Amstrad CPC repository...${NC}"
  if [ -d "temp-amstrad-cpc" ]; then
    rm -rf temp-amstrad-cpc
  fi
  git clone --depth 1 https://github.com/damianvila/font-cpc464.git temp-amstrad-cpc
  
  # Look for TTF file in the repository
  if [ -f "temp-amstrad-cpc/font-cpc464.ttf" ]; then
    cp temp-amstrad-cpc/font-cpc464.ttf sources/AmstradCPC-Regular.ttf
  elif [ -f "temp-amstrad-cpc/cpc464.ttf" ]; then
    cp temp-amstrad-cpc/cpc464.ttf sources/AmstradCPC-Regular.ttf
  else
    # Find any TTF file in the repository
    local amstrad_ttf=$(find temp-amstrad-cpc -name "*.ttf" | head -1)
    if [ -n "$amstrad_ttf" ]; then
      cp "$amstrad_ttf" sources/AmstradCPC-Regular.ttf
    fi
  fi
  rm -rf temp-amstrad-cpc
  
  if [ -f "sources/AmstradCPC-Regular.ttf" ]; then
    local size=$(du -h sources/AmstradCPC-Regular.ttf | cut -f1)
    echo -e "${GREEN}  ✓ Extracted AmstradCPC-Regular.ttf ($size)${NC}"
  fi
  
  # Amiga Topaz
  echo -e "${BLUE}  Cloning Amiga fonts repository...${NC}"
  if [ -d "temp-amiga" ]; then
    rm -rf temp-amiga
  fi
  git clone --depth 1 https://github.com/rewtnull/amigafonts.git temp-amiga
  
  # Look for Topaz font (the classic Amiga font) in ttf directory
  if [ -f "temp-amiga/ttf/Topaz_a500_v1.0.ttf" ]; then
    cp temp-amiga/ttf/Topaz_a500_v1.0.ttf sources/Topaz-Regular.ttf
  elif [ -f "temp-amiga/ttf/TopazPlus_a500_v1.0.ttf" ]; then
    cp temp-amiga/ttf/TopazPlus_a500_v1.0.ttf sources/Topaz-Regular.ttf
  else
    # Find any Topaz font in the repository
    local topaz_ttf=$(find temp-amiga -iname "*topaz*.ttf" | head -1)
    if [ -n "$topaz_ttf" ]; then
      cp "$topaz_ttf" sources/Topaz-Regular.ttf
    fi
  fi
  rm -rf temp-amiga
  
  if [ -f "sources/Topaz-Regular.ttf" ]; then
    local size=$(du -h sources/Topaz-Regular.ttf | cut -f1)
    echo -e "${GREEN}  ✓ Extracted Topaz-Regular.ttf ($size)${NC}"
  fi
}

# Main execution
echo -e "${BLUE}Starting font downloads...${NC}\n"

# Download VT323
download_vt323
echo ""

# Download Terminus
download_terminus
echo ""

# Extract C64 (if zip exists)
extract_c64
echo ""

# Download repository-based fonts
download_repo_fonts
echo ""

# Summary
echo -e "${GREEN}=== Download Summary ===${NC}"
echo "Downloaded fonts:"
ls -lh sources/*.ttf 2>/dev/null | awk '{print "  " $9 " (" $5 ")"}'
echo ""
echo -e "${GREEN}✓ Font download complete!${NC}"
