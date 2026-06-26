# PowerShell build check for mini-independence-convergence
Write-Host "=== MiniIndependenceConvergence Build Check ===" -ForegroundColor Cyan

# Check lake is available
$lakePath = Get-Command lake -ErrorAction SilentlyContinue
if (-not $lakePath) {
    Write-Host "ERROR: lake not found. Install Lean 4." -ForegroundColor Red
    exit 1
}

Write-Host "lake found at: $($lakePath.Source)" -ForegroundColor Green

# Count lean source files
$leanFiles = Get-ChildItem -Recurse -Filter "*.lean" | Where-Object { $_.FullName -notmatch "lake-packages" }
$count = ($leanFiles | Measure-Object).Count
Write-Host "Found $count .lean files" -ForegroundColor Green

# Check directory structure
$expectedDirs = @(
    "MiniIndependenceConvergence\Core",
    "MiniIndependenceConvergence\Morphisms",
    "MiniIndependenceConvergence\Constructions",
    "MiniIndependenceConvergence\Properties",
    "MiniIndependenceConvergence\Theorems",
    "MiniIndependenceConvergence\Examples",
    "MiniIndependenceConvergence\Bridges",
    "Test",
    "Benchmark",
    "Computation",
    "docs",
    "scripts"
)

foreach ($dir in $expectedDirs) {
    if (Test-Path $dir) {
        Write-Host "  [OK] $dir" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $dir" -ForegroundColor Red
    }
}

# Run lake build (dry-run check)
Write-Host "`nRunning lake build check..." -ForegroundColor Cyan
$result = lake build 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "BUILD SUCCESS" -ForegroundColor Green
} else {
    Write-Host "BUILD FAILED (may have errors for stubbed proofs)" -ForegroundColor Yellow
}

Write-Host "`n=== Check Complete ===" -ForegroundColor Cyan
