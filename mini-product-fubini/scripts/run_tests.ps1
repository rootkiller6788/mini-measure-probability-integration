# MiniProductFubini Test Runner
# Runs all test, benchmark, and computation files

param(
    [switch]$Benchmark,
    [switch]$Computation,
    [switch]$All
)

$ErrorActionPreference = "Continue"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PackageDir = Split-Path -Parent $ScriptDir

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  MiniProductFubini Test Runner" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Push-Location $PackageDir

$totalTests = 0
$passedTests = 0
$failedTests = 0

try {
    Write-Host "--- Test Files ---" -ForegroundColor Yellow
    $testFiles = @(
        "Test/Basic.lean",
        "Test/Properties.lean",
        "Test/Comprehensive.lean"
    )

    foreach ($testFile in $testFiles) {
        $totalTests++
        Write-Host "  Running $testFile..." -ForegroundColor Gray
        $result = & lake env lean --run $testFile 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "    PASSED" -ForegroundColor Green
            $passedTests++
        } else {
            Write-Host "    FAILED (exit code: $LASTEXITCODE)" -ForegroundColor Red
            if ($result) {
                Write-Host "    $result" -ForegroundColor Red
            }
            $failedTests++
        }
    }

    if ($Benchmark -or $All) {
        Write-Host ""
        Write-Host "--- Benchmark Files ---" -ForegroundColor Yellow
        $benchFiles = @(
            "Benchmark/Standard.lean",
            "Benchmark/Comparison.lean",
            "Benchmark/Profiling.lean",
            "Benchmark/LargeScale.lean",
            "Benchmark/Memory.lean",
            "Benchmark/Convolution.lean"
        )

        foreach ($benchFile in $benchFiles) {
            $totalTests++
            Write-Host "  Running $benchFile..." -ForegroundColor Gray
            $result = & lake env lean --run $benchFile 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Host "    PASSED" -ForegroundColor Green
                $passedTests++
            } else {
                Write-Host "    FAILED (exit code: $LASTEXITCODE)" -ForegroundColor Red
                $failedTests++
            }
        }
    }

    if ($Computation -or $All) {
        Write-Host ""
        Write-Host "--- Computation Files ---" -ForegroundColor Yellow
        $compFiles = @(
            "Computation/Basic.lean",
            "Computation/Advanced.lean",
            "Computation/Numerical.lean",
            "Computation/Algorithms.lean",
            "Computation/Optimization.lean",
            "Computation/GPU.lean"
        )

        foreach ($compFile in $compFiles) {
            $totalTests++
            Write-Host "  Running $compFile..." -ForegroundColor Gray
            $result = & lake env lean --run $compFile 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Host "    PASSED" -ForegroundColor Green
                $passedTests++
            } else {
                Write-Host "    FAILED (exit code: $LASTEXITCODE)" -ForegroundColor Red
                $failedTests++
            }
        }
    }

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Test Results" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Total:  $totalTests" -ForegroundColor White
    Write-Host "Passed: $passedTests" -ForegroundColor Green
    if ($failedTests -gt 0) {
        Write-Host "Failed: $failedTests" -ForegroundColor Red
    } else {
        Write-Host "Failed: $failedTests" -ForegroundColor Gray
    }
    Write-Host ""
    Write-Host "Use -Benchmark to run benchmarks, -Computation for computation files."
    Write-Host "Use -All to run everything."

    if ($failedTests -gt 0) {
        exit 1
    }
} finally {
    Pop-Location
}
