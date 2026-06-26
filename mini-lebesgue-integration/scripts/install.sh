#!/bin/bash
# Install script for mini-lebesgue-integration
# Sets up the package and its dependencies

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "=== Installing mini-lebesgue-integration ==="
echo "Project directory: $PROJECT_DIR"
echo ""

cd "$PROJECT_DIR"

# Check for Lean 4
echo "Checking prerequisites..."
if ! command -v lake &> /dev/null; then
    echo ""
    echo "Error: Lean 4 (lake) is not installed."
    echo ""
    echo "To install Lean 4, visit: https://lean-lang.org/lean4/doc/setup.html"
    echo ""
    echo "Quick install options:"
    echo "  - Use elan: curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh"
    echo "  - Or follow the official guide"
    exit 1
fi

LAKE_VERSION=$(lake --version)
echo "  Found: $LAKE_VERSION"
echo ""

# Check dependencies exist
echo "Checking dependencies..."
REQUIRED_DEPS=(
    "../1. mini-set-model-theory/mini-object-kernel"
    "../6. mini-measure-probability-integration/mini-measure-theory"
    "../7. mini-measure-probability-integration/mini-measurable-functions"
)

for dep in "${REQUIRED_DEPS[@]}"; do
    DEP_PATH="$PROJECT_DIR/$dep"
    if [ -d "$DEP_PATH" ]; then
        echo "  Found: $dep"
    else
        echo "  WARNING: Dependency not found at: $DEP_PATH"
        echo "  The package may not build correctly."
    fi
done
echo ""

# Fetch and build
echo "Fetching dependencies..."
lake update

echo ""
echo "Building package..."
lake build MiniLebesgueIntegration

echo ""
echo "=== Installation complete ==="
echo ""
echo "Package: mini-lebesgue-integration"
echo "Library: MiniLebesgueIntegration"
echo ""
echo "Quick start:"
echo "  import MiniLebesgueIntegration.Core.Basic"
echo "  open MiniLebesgueIntegration"
echo ""
echo "To run tests:"
echo "  bash scripts/run_tests.sh"
echo ""
echo "To view documentation:"
echo "  See docs/ directory or run 'lake build docs'"
