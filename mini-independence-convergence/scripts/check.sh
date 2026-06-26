#!/bin/bash
# Shell build check for mini-independence-convergence
echo "=== MiniIndependenceConvergence Build Check ==="

# Check lake is available
if ! command -v lake &> /dev/null; then
    echo "ERROR: lake not found. Install Lean 4."
    exit 1
fi

echo "lake found at: $(which lake)"

# Count lean source files
count=$(find . -name "*.lean" -not -path "*/lake-packages/*" | wc -l)
echo "Found $count .lean files"

# Check directory structure
expected_dirs=(
    "MiniIndependenceConvergence/Core"
    "MiniIndependenceConvergence/Morphisms"
    "MiniIndependenceConvergence/Constructions"
    "MiniIndependenceConvergence/Properties"
    "MiniIndependenceConvergence/Theorems"
    "MiniIndependenceConvergence/Examples"
    "MiniIndependenceConvergence/Bridges"
    "Test"
    "Benchmark"
    "Computation"
    "docs"
    "scripts"
)

for dir in "${expected_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "  [OK] $dir"
    else
        echo "  [MISSING] $dir"
    fi
done

# Run lake build
echo ""
echo "Running lake build..."
lake build 2>&1
if [ $? -eq 0 ]; then
    echo "BUILD SUCCESS"
else
    echo "BUILD FAILED (may have errors for stubbed proofs)"
fi

echo ""
echo "=== Check Complete ==="
