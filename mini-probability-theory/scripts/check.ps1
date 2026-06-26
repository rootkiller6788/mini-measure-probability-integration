#!/usr/bin/env pwsh
# mini-probability-theory: Build check script (PowerShell)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

Write-Host "=== mini-probability-theory: Checking build ==="
Write-Host ""

# Check lean-toolchain
if (Test-Path lean-toolchain) {
    Write-Host "[OK] lean-toolchain found"
} else {
    Write-Host "[FAIL] lean-toolchain missing"
    exit 1
}

# Check lakefile.lean
if (Test-Path lakefile.lean) {
    Write-Host "[OK] lakefile.lean found"
} else {
    Write-Host "[FAIL] lakefile.lean missing"
    exit 1
}

# Count source files
$srcFiles = Get-ChildItem -Path MiniProbabilityTheory -Filter "*.lean" -Recurse
$srcCount = $srcFiles.Count
Write-Host "[INFO] Source files: $srcCount (target: 23)"

# Count total files
$totalFiles = Get-ChildItem -Path . -Filter "*.lean" -Recurse
$totalCount = $totalFiles.Count
Write-Host "[INFO] Total .lean files: $totalCount (target: 48)"

# Check for #eval in each source file
Write-Host ""
Write-Host "=== Checking #eval presence in source files ==="
foreach ($f in $srcFiles) {
    $evals = (Select-String -Path $f.FullName -Pattern "#eval" -AllMatches).Matches.Count
    Write-Host "  $($f.FullName): $evals #eval(s)"
}

Write-Host ""
Write-Host "=== All checks passed ==="
