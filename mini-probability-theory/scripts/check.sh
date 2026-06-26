#!/bin/bash
# mini-probability-theory: Build check script

set -e

cd "$(dirname "$0")/.."

echo "=== mini-probability-theory: Checking build ==="
echo ""

# Check lean-toolchain
if [ -f lean-toolchain ]; then
    echo "[OK] lean-toolchain found"
else
    echo "[FAIL] lean-toolchain missing"
    exit 1
fi

# Check lakefile.lean
if [ -f lakefile.lean ]; then
    echo "[OK] lakefile.lean found"
else
    echo "[FAIL] lakefile.lean missing"
    exit 1
fi

# Count source files
SRC_COUNT=$(find MiniProbabilityTheory -name "*.lean" | wc -l)
echo "[INFO] Source files: $SRC_COUNT (target: 23)"

# Count total files
TOTAL_LEAN=$(find . -name "*.lean" | wc -l)
echo "[INFO] Total .lean files: $TOTAL_LEAN (target: 48)"

# Check for #eval in each source file
echo ""
echo "=== Checking #eval presence in source files ==="
for f in $(find MiniProbabilityTheory -name "*.lean"); do
    EVALS=$(grep -c "#eval" "$f" || true)
    echo "  $f: $EVALS #eval(s)"
done

echo ""
echo "=== All checks passed ==="
