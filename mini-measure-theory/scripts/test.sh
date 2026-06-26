#!/bin/bash
# Test script for mini-measure-theory
set -e

echo "Testing mini-measure-theory..."
echo "=============================="

# Run all test files
echo ""
echo "--- Smoke Tests ---"
lake env lean --run Test/Smoke.lean

echo ""
echo "--- Example Tests ---"
lake env lean --run Test/Examples.lean

echo ""
echo "--- Regression Tests ---"
lake env lean --run Test/Regression.lean

echo ""
echo "--- Benchmark: Core Coverage ---"
lake env lean --run Benchmark/CoreCoverage.lean

echo ""
echo "--- Benchmark: Princeton MAT 575 ---"
lake env lean --run Benchmark/Princeton.lean

echo ""
echo "--- Benchmark: Cambridge Part III ---"
lake env lean --run Benchmark/CambridgePartIII.lean

echo ""
echo "--- Benchmark: Harvard Math 212a ---"
lake env lean --run Benchmark/Harvard.lean

echo ""
echo "--- Benchmark: MIT 18.675 ---"
lake env lean --run Benchmark/MIT.lean

echo ""
echo "--- Benchmark: Oxford Part C ---"
lake env lean --run Benchmark/OxfordPartC.lean

echo ""
echo "=============================="
echo "All tests complete!"
