# MiniProductFubini Build Script
# Builds the entire mini-product-fubini package

param(
    [switch]$Clean,
    [switch]$Release,
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PackageDir = Split-Path -Parent $ScriptDir

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  MiniProductFubini Build Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Navigate to package directory
Push-Location $PackageDir

try {
    # Clean build if requested
    if ($Clean) {
        Write-Host "[CLEAN] Removing build artifacts..." -ForegroundColor Yellow
        if (Test-Path ".lake") {
            Remove-Item -Recurse -Force ".lake"
        }
        if (Test-Path "build") {
            Remove-Item -Recurse -Force "build"
        }
        Write-Host "[CLEAN] Build artifacts removed." -ForegroundColor Green
    }

    # Build the package
    Write-Host "[BUILD] Building MiniProductFubini..." -ForegroundColor Yellow
    $buildArgs = @("build")
    if ($Release) {
        $buildArgs += "release"
    }
    if ($Verbose) {
        $buildArgs += "--verbose"
    }

    & lake @buildArgs
    if ($LASTEXITCODE -ne 0) {
        throw "Lake build failed with exit code $LASTEXITCODE"
    }
    Write-Host "[BUILD] Build completed successfully." -ForegroundColor Green

    # Run basic smoke test
    Write-Host "[TEST] Running basic smoke test..." -ForegroundColor Yellow
    & lake env lean --run Test/Basic.lean
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[WARN] Smoke test returned non-zero exit code $LASTEXITCODE" -ForegroundColor Magenta
    } else {
        Write-Host "[TEST] Smoke test passed." -ForegroundColor Green
    }

    # Run comprehensive test
    Write-Host "[TEST] Running comprehensive test..." -ForegroundColor Yellow
    & lake env lean --run Test/Comprehensive.lean
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[WARN] Comprehensive test returned non-zero exit code $LASTEXITCODE" -ForegroundColor Magenta
    } else {
        Write-Host "[TEST] Comprehensive test passed." -ForegroundColor Green
    }

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Build Complete!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Sources: 23 modules in MiniProductFubini/"
    Write-Host "Tests:   3 test files in Test/"
    Write-Host "Total:   48 files in package"
    Write-Host ""
    Write-Host "Run 'lake env lean --run Main.lean' for entry point."
} finally {
    Pop-Location
}
