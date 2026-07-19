#!/bin/bash

# Generate documentation for wirestead library
# This script automates the documentation generation process

set -e  # Exit on any error

echo "🔧 Setting up documentation generation..."

# Check if Doxygen is installed
if ! command -v doxygen &> /dev/null; then
    echo "❌ Doxygen is not installed!"
    echo "Please install Doxygen first:"
    echo "  Ubuntu/Debian: sudo apt install doxygen"
    echo "  CentOS/RHEL: sudo yum install doxygen"
    echo "  Windows: Download from https://www.doxygen.nl/download.html"
    exit 1
fi

echo "✅ Doxygen found: $(doxygen --version)"

mkdir -p build/doxygen

# Check if Doxyfile exists
if [ ! -f "doxygen/Doxyfile" ]; then
    echo "❌ Doxyfile not found!"
    echo "Please run this script from the project root directory."
    exit 1
fi

if ! command -v python3 &> /dev/null; then
    echo "❌ python3 is required to read the project version from external/wirestead/CMakeLists.txt"
    exit 1
fi

PROJECT_VERSION=$(python3 - <<'PY'
import pathlib
import re

cmake_lists = pathlib.Path("external/wirestead/CMakeLists.txt")
if not cmake_lists.exists():
    print("")
    raise SystemExit
match = re.search(
    r"^\s*VERSION\s+([0-9]+(?:\.[0-9]+){1,3})",
    cmake_lists.read_text(),
    re.MULTILINE,
)
print(match.group(1) if match else "")
PY
)

if [ -z "$PROJECT_VERSION" ]; then
    echo "⚠️ Could not find project version in external/wirestead/CMakeLists.txt, defaulting to 0.0.0"
    PROJECT_VERSION="0.0.0"
fi

echo "📦 Using project version: $PROJECT_VERSION"
echo "📚 Generating documentation..."

# Generate documentation
PROJECT_NUMBER="$PROJECT_VERSION" doxygen doxygen/Doxyfile

# Check if documentation was generated successfully
if [ -d "build/doxygen/html" ] && [ -f "build/doxygen/html/index.html" ]; then
    echo "✅ Documentation generated successfully!"
    echo "📖 Open build/doxygen/html/index.html in your browser to view the documentation"
    echo ""
    echo "📊 Documentation statistics:"
    echo "   - HTML files: $(find build/doxygen/html -name "*.html" | wc -l)"
    echo "   - Total size: $(du -sh build/doxygen/html | cut -f1)"
    echo ""
    echo "🌐 You can serve the documentation locally with:"
    echo "   cd build/doxygen/html && python3 -m http.server 8000"
    echo "   Then open http://localhost:8000 in your browser"
else
    echo "❌ Documentation generation failed!"
    echo "Check the doxygen output above for errors."
    exit 1
fi

echo "🎉 Documentation generation complete!"
