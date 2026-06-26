import MiniConditionalMartingale.Scripts.Build
import MiniConditionalMartingale.Scripts.RunTests
import MiniConditionalMartingale.Scripts.CheckDeps

/-!
  # CI Script

  Continuous integration script that runs all checks:
  1. Verify imports
  2. Check dependencies
  3. Run tests
  4. Report results
-/

namespace MiniConditionalMartingale.Scripts

/-- Staged CI pipeline. -/
def runCI : IO UInt32 := do
  let mut exitCode : UInt32 := 0

  IO.println "════════════════════════════════════════════"
  IO.println "  MiniConditionalMartingale CI Pipeline"
  IO.println "════════════════════════════════════════════"
  IO.println ""

  -- Stage 1: Verify imports
  IO.println "[1/3] Verifying imports..."
  try
    Build.verifyImports
    IO.println "  PASS: All imports verified."
  catch e =>
    IO.println s!"  FAIL: Import verification failed: {e}"
    exitCode := 1

  -- Stage 2: Check dependencies
  IO.println ""
  IO.println "[2/3] Checking dependencies..."
  try
    CheckDeps.checkCoreDeps
    CheckDeps.checkCrossImports
    IO.println "  PASS: Dependency checks passed."
  catch e =>
    IO.println s!"  FAIL: Dependency check failed: {e}"
    exitCode := 1

  -- Stage 3: Run tests
  IO.println ""
  IO.println "[3/3] Running tests..."
  try
    RunTests.runAllTests
    IO.println "  PASS: All tests passed."
  catch e =>
    IO.println s!"  FAIL: Tests failed: {e}"
    exitCode := 1

  IO.println ""
  IO.println "════════════════════════════════════════════"
  if exitCode == 0 then
    IO.println "  CI Pipeline: SUCCESS"
  else
    IO.println "  CI Pipeline: FAILURE"
  IO.println "════════════════════════════════════════════"

  pure exitCode

/-- Main entry point for CI. -/
def main : IO UInt32 := runCI

#eval "CI script: run with `lake exec scripts/ci.lean`"
#eval "CI pipeline stages: [1] Verify imports [2] Check deps [3] Run tests"

end MiniConditionalMartingale.Scripts
