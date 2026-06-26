#!/usr/bin/env bash
set -euo pipefail

echo "========================================="
echo "  Cleaning MiniStochasticProcesses"
echo "========================================="
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

echo "[1/2] Cleaning Lake build artifacts..."
lake clean

echo ""
echo "[2/2] Removing .lake directory..."
rm -rf .lake

echo ""
echo "========================================="
echo "  Clean Complete"
echo "========================================="
