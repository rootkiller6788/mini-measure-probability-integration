#!/bin/bash
# Test runner script for mini-lebesgue-integration
# Runs all test files and reports results

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "=== Running mini-lebesgue-integration Tests ==="
echo "Project directory: $PROJECT_DIR"
echo ""

cd "$PROJECT_DIR"

# Check if lake is available
if ! command -v lake &> /dev/null; then
    echo "Error: 'lake' command not found. Please install Lean 4."
    exit 1
fi

PASSED=0
FAILED=0
TOTAL=0

run_test() {
    local test_name="$1"
    local test_path="$2"
    TOTAL=$((TOTAL + 1))
    echo -n "  [$TOTAL] $test_name ... "
    if lake env lean "$test_path" > /dev/null 2>&1; then
        echo "PASSED"
        PASSED=$((PASSED + 1))
    else
        echo "FAILED"
        FAILED=$((FAILED + 1))
    fi
}

echo "Test Suites:"
echo ""

# Basic tests
run_test "basic_tests" "test/basic_tests.lean"

# Integration tests
run_test "integration_tests" "test/integration_tests.lean"

# Theorem tests
run_test "theorem_tests" "test/theorem_tests.lean"

# Property tests
run_test "property_tests" "test/property_tests.lean"

echo ""
echo "=== Test Results ==="
echo "Total: $TOTAL"
echo "Passed: $PASSED"
echo "Failed: $FAILED"

if [ $FAILED -eq 0 ]; then
    echo ""
    echo "All tests passed!"
    exit 0
else
    echo ""
    echo "Some tests failed. Check output above for details."
    exit 1
fi
