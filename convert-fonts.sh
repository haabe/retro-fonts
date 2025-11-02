#!/bin/bash

# Font Conversion Script
# Converts TTF fonts to WOFF2 and WOFF formats with Latin subsetting

# Exit on any error
set -e

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Activate virtual environment if it exists
if [ -d "venv" ] && [ -f "venv/bin/activate" ]; then
  echo -e "${BLUE}Activating virtual environment...${NC}"
  source venv/bin/activate
  echo -e "${GREEN}✓ Virtual environment activated${NC}"
  echo ""
fi

# Error handling function
error_exit() {
  echo -e "${RED}ERROR: $1${NC}" >&2
  exit 1
}

# Warning function
warning() {
  echo -e "${YELLOW}WARNING: $1${NC}" >&2
}

# Check if required tools are installed
check_dependencies() {
  echo -e "${BLUE}Checking dependencies...${NC}"
  
  # Check for Python
  if ! command -v python3 &> /dev/null; then
    error_exit "Python 3 is not installed. Please install Python 3 first."
  fi
  
  # Check for pyftsubset (fonttools)
  if ! command -v pyftsubset &> /dev/null; then
    echo -e "${RED}ERROR: pyftsubset (fonttools) is not installed.${NC}" >&2
    echo ""
    echo "To install dependencies, run the setup script:"
    echo -e "  ${YELLOW}./setup.sh${NC}"
    echo ""
    echo "Or install manually:"
    echo -e "  ${YELLOW}pip install fonttools brotli${NC}"
    exit 1
  fi
  
  # Check if brotli module is available
  if ! python3 -c "import brotli" 2>/dev/null; then
    echo -e "${RED}ERROR: brotli module is not installed.${NC}" >&2
    echo ""
    echo "To install dependencies, run the setup script:"
    echo -e "  ${YELLOW}./setup.sh${NC}"
    echo ""
    echo "Or install manually:"
    echo -e "  ${YELLOW}pip install brotli${NC}"
    exit 1
  fi
  
  echo -e "${GREEN}✓ All dependencies are installed${NC}"
  echo ""
}

# Validate that source file exists
validate_source_file() {
  local input=$1
  
  if [ ! -f "$input" ]; then
    error_exit "Source file not found: $input"
  fi
  
  # Check if file is readable
  if [ ! -r "$input" ]; then
    error_exit "Source file is not readable: $input"
  fi
  
  # Check if file has content (not empty)
  if [ ! -s "$input" ]; then
    error_exit "Source file is empty: $input"
  fi
}

# Verify output files were created successfully
verify_output_files() {
  local output_dir=$1
  local output_name=$2
  
  local woff2_file="${output_dir}/${output_name}.woff2"
  local woff_file="${output_dir}/${output_name}.woff"
  
  # Check WOFF2 file
  if [ ! -f "$woff2_file" ]; then
    error_exit "Failed to create WOFF2 file: $woff2_file"
  fi
  
  if [ ! -s "$woff2_file" ]; then
    error_exit "WOFF2 file is empty: $woff2_file"
  fi
  
  # Check WOFF file
  if [ ! -f "$woff_file" ]; then
    error_exit "Failed to create WOFF file: $woff_file"
  fi
  
  if [ ! -s "$woff_file" ]; then
    error_exit "WOFF file is empty: $woff_file"
  fi
}

# Function to convert a font file
# Arguments:
#   $1 - Input TTF file path (e.g., "sources/VT323-Regular.ttf")
#   $2 - Output directory (e.g., "vt323")
#   $3 - Output filename base (e.g., "VT323-Regular")
convert_font() {
  local input=$1
  local output_dir=$2
  local output_name=$3
  
  echo -e "${BLUE}Converting ${output_name}...${NC}"
  
  # Validate source file exists
  validate_source_file "$input"
  
  # Create output directory if it doesn't exist
  mkdir -p "$output_dir" || error_exit "Failed to create output directory: $output_dir"
  
  # Convert to WOFF2 with Latin subset
  if ! pyftsubset "$input" \
    --output-file="${output_dir}/${output_name}.woff2" \
    --flavor=woff2 \
    --layout-features='*' \
    --unicodes=U+0020-007E,U+00A0-00FF \
    --desubroutinize \
    --no-hinting 2>&1; then
    error_exit "Failed to convert $input to WOFF2 format"
  fi
  
  # Convert to WOFF with Latin subset
  if ! pyftsubset "$input" \
    --output-file="${output_dir}/${output_name}.woff" \
    --flavor=woff \
    --layout-features='*' \
    --unicodes=U+0020-007E,U+00A0-00FF \
    --desubroutinize \
    --no-hinting 2>&1; then
    error_exit "Failed to convert $input to WOFF format"
  fi
  
  # Verify output files were created successfully
  verify_output_files "$output_dir" "$output_name"
  
  # Display file sizes
  local woff2_size=$(du -h "${output_dir}/${output_name}.woff2" | cut -f1)
  local woff_size=$(du -h "${output_dir}/${output_name}.woff" | cut -f1)
  echo -e "${GREEN}✓ Created ${output_name}.woff2 (${woff2_size}) and ${output_name}.woff (${woff_size})${NC}"
}

# Check dependencies before starting
check_dependencies

# Convert all fonts
echo -e "${BLUE}Starting font conversion...${NC}"
echo ""

convert_font "sources/VT323-Regular.ttf" "vt323" "VT323-Regular"
convert_font "sources/C64-Regular.ttf" "c64" "C64-Regular"
convert_font "sources/C64_TrueType_v1.2.1-STYLE/fonts/C64_Pro-STYLE.ttf" "c64" "C64-Pro"
convert_font "sources/C64_TrueType_v1.2.1-STYLE/fonts/C64_Pro_Mono-STYLE.ttf" "c64" "C64-Pro-Mono"
convert_font "sources/C64_TrueType_v1.2.1-STYLE/legacy_fonts/C64_Elite_Mono_v1.0-STYLE.ttf" "c64" "C64-Elite-Mono"
convert_font "sources/Terminus.ttf" "terminus" "Terminus"
convert_font "sources/TerminusTTF-Bold-4.49.3.ttf" "terminus" "Terminus-Bold"
convert_font "sources/TerminusTTF-Bold-Italic-4.49.3.ttf" "terminus" "Terminus-BoldItalic"
convert_font "sources/Unscii-8.ttf" "unscii" "Unscii-8"
convert_font "sources/AmstradCPC-Regular.ttf" "amstrad-cpc" "AmstradCPC-Regular"
convert_font "sources/TomThumb.ttf" "tom-thumb" "TomThumb"
convert_font "sources/Topaz-Regular.ttf" "topaz" "Topaz-Regular"

echo ""
echo -e "${GREEN}Font Conversion Complete!${NC}"
echo ""

# Display total size summary
echo -e "${BLUE}Total Size Summary:${NC}"
total_woff2=0
total_woff=0

for dir in vt323 c64 terminus unscii amstrad-cpc tom-thumb topaz; do
  if [ -d "$dir" ]; then
    # macOS-compatible: use stat to get file size in bytes
    while IFS= read -r file; do
      if [ -f "$file" ]; then
        size=$(stat -f%z "$file" 2>/dev/null || echo 0)
        total_woff2=$((total_woff2 + size))
      fi
    done < <(find "$dir" -name "*.woff2")
    
    while IFS= read -r file; do
      if [ -f "$file" ]; then
        size=$(stat -f%z "$file" 2>/dev/null || echo 0)
        total_woff=$((total_woff + size))
      fi
    done < <(find "$dir" -name "*.woff")
  fi
done

# Convert bytes to KB
total_woff2_kb=$((total_woff2 / 1024))
total_woff_kb=$((total_woff / 1024))

echo -e "Total WOFF2 size: ${GREEN}${total_woff2_kb}KB${NC}"
echo -e "Total WOFF size: ${GREEN}${total_woff_kb}KB${NC}"
