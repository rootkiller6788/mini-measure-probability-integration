#!/bin/bash
# Build script for mini-lebesgue-integration
# Builds the entire Lake package and all dependencies

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "=== Building mini-lebesgue-integration ==="
echo "Project directory: $PROJECT_DIR"

cd "$PROJECT_DIR"

# Check if lake is available
if ! command -v lake &> /dev/null; then
    echo "Error: 'lake' command not found. Please install Lean 4."
    exit 1
fi

# Update dependencies
echo ""
echo "Step 1: Updating dependencies..."
lake update

# Build the package
echo ""
echo "Step 2: Building MiniLebesgueIntegration..."
lake build MiniLebesgueIntegration

# Build tests
echo ""
echo "Step 3: Building tests..."
lake build test

# Build benchmarks
echo ""
echo "Step 4: Building benchmarks..."
lake build benchmark

# Build computation modules
echo ""
echo "Step 5: Building computation modules..."
lake build computation

echo ""
echo "=== Build complete ==="
echo "Package: mini-lebesgue-integration"
echo "Library: MiniLebesgueIntegration"
echo "Status: SUCCESS"
