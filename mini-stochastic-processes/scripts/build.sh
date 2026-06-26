#!/usr/bin/env bash
set -euo pipefail

echo "========================================="
echo "  Building MiniStochasticProcesses"
echo "========================================="
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

echo "[1/3] Fetching dependencies..."
lake update

echo ""
echo "[2/3] Building library..."
lake build

echo ""
echo "[3/3] Running smoke tests..."
lake env lean --run Test/Smoke.lean

echo ""
echo "========================================="
echo "  Build Complete"
echo "========================================="
