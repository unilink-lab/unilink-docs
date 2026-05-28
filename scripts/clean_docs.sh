#!/bin/bash

# Clean generated documentation
# This script removes all generated documentation files

set -e  # Exit on any error

echo "🧹 Cleaning documentation..."

# Remove generated HTML files
if [ -d "build/doxygen/html" ]; then
    echo "Removing build/doxygen/html/ directory..."
    rm -rf build/doxygen/html
fi

# Remove generated LaTeX files
if [ -d "build/doxygen/latex" ]; then
    echo "Removing build/doxygen/latex/ directory..."
    rm -rf build/doxygen/latex
fi

# Remove generated RTF files
if [ -d "build/doxygen/rtf" ]; then
    echo "Removing build/doxygen/rtf/ directory..."
    rm -rf build/doxygen/rtf
fi

# Remove generated XML files
if [ -d "build/doxygen/xml" ]; then
    echo "Removing build/doxygen/xml/ directory..."
    rm -rf build/doxygen/xml
fi

# Remove generated man pages
if [ -d "build/doxygen/man" ]; then
    echo "Removing build/doxygen/man/ directory..."
    rm -rf build/doxygen/man
fi

echo "✅ Documentation cleaned successfully!"
echo "Run './scripts/generate_docs.sh' to regenerate documentation."
