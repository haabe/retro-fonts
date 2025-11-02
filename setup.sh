#!/bin/bash

# Setup Script for Font Conversion Tools
# Creates a virtual environment and installs required dependencies

# Exit on any error
set -e

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Font Repository Setup${NC}"
echo -e "${BLUE}=====================${NC}"
echo ""

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
  echo -e "${RED}ERROR: Python 3 is not installed.${NC}"
  echo "Please install Python 3 first:"
  echo "  - macOS: brew install python3"
  echo "  - Ubuntu/Debian: sudo apt-get install python3 python3-venv"
  echo "  - Windows: Download from https://www.python.org/downloads/"
  exit 1
fi

PYTHON_VERSION=$(python3 --version)
echo -e "${GREEN}✓ Found ${PYTHON_VERSION}${NC}"
echo ""

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
  echo -e "${BLUE}Creating virtual environment...${NC}"
  python3 -m venv venv
  echo -e "${GREEN}✓ Virtual environment created${NC}"
else
  echo -e "${YELLOW}Virtual environment already exists${NC}"
fi
echo ""

# Activate virtual environment
echo -e "${BLUE}Activating virtual environment...${NC}"
source venv/bin/activate

# Upgrade pip
echo -e "${BLUE}Upgrading pip...${NC}"
pip install --upgrade pip --quiet
echo -e "${GREEN}✓ pip upgraded${NC}"
echo ""

# Install fonttools and brotli
echo -e "${BLUE}Installing fonttools and brotli...${NC}"
pip install fonttools brotli --quiet
echo -e "${GREEN}✓ fonttools and brotli installed${NC}"
echo ""

# Verify installation
echo -e "${BLUE}Verifying installation...${NC}"
if command -v pyftsubset &> /dev/null; then
  FONTTOOLS_VERSION=$(pip show fonttools | grep Version | cut -d' ' -f2)
  BROTLI_VERSION=$(pip show brotli | grep Version | cut -d' ' -f2)
  echo -e "${GREEN}✓ pyftsubset is available${NC}"
  echo -e "  fonttools version: ${FONTTOOLS_VERSION}"
  echo -e "  brotli version: ${BROTLI_VERSION}"
else
  echo -e "${RED}ERROR: pyftsubset command not found after installation${NC}"
  exit 1
fi
echo ""

echo -e "${GREEN}Setup Complete!${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "1. Activate the virtual environment:"
echo -e "   ${YELLOW}source venv/bin/activate${NC}"
echo ""
echo "2. Run the font conversion script:"
echo -e "   ${YELLOW}./convert-fonts.sh${NC}"
echo ""
echo "3. When done, deactivate the virtual environment:"
echo -e "   ${YELLOW}deactivate${NC}"
echo ""
