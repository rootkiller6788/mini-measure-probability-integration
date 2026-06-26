#!/bin/bash
# Build script for mini-measure-theory
set -e

echo "Building mini-measure-theory..."
echo "================================"

# First build the dependency mini-object-kernel
echo ""
echo "[1/3] Building mini-object-kernel..."
(cd "../../../0. mini-math-kernel/mini-object-kernel" && lake build)

# Build mini-measure-theory
echo ""
echo "[2/3] Building mini-measure-theory library..."
lake build

# Run smoke tests
echo ""
echo "[3/3] Running smoke tests..."
lake env lean --run Test/Smoke.lean

echo ""
echo "================================"
echo "Build and smoke tests complete!"
