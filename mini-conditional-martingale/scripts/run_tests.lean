import MiniConditionalMartingale.Test.Basic
import MiniConditionalMartingale.Test.Theorems
import MiniConditionalMartingale.Test.Examples

/-!
  # Test Runner Script

  Runs all test suites for the mini-conditional-martingale package.
  Run via `lake exec scripts/run_tests.lean`.
-/

namespace MiniConditionalMartingale.Scripts

open MiniConditionalMartingale.Test

/-- Run all test suites and report results. -/
def runAllTests : IO Unit := do
  IO.println "=========================================="
  IO.println "  MiniConditionalMartingale Test Suite"
  IO.println "=========================================="
  IO.println ""

  IO.println "--- Basic Definition Tests ---"
  let basicResults := Basic.runAll
  let basicPassed := basicResults.filter (λ (_, b) => b) |>.length
  IO.println s!"  Passed: {basicPassed}/{basicResults.length}"

  IO.println ""
  IO.println "--- Theorems Tests ---"
  IO.println "  Optional Stopping: " ++ toString Theorems.test_optionalStopping
  IO.println "  Doob Maximal: " ++ toString Theorems.test_doobMaximal
  IO.println "  Doob Upcrossing: " ++ toString Theorems.test_doobUpcrossing
  IO.println "  Martingale Convergence: " ++ toString Theorems.test_martingaleConvergence
  IO.println "  Levy Zero-One: " ++ toString Theorems.test_levyZeroOne
  IO.println "  BDG Inequality: " ++ toString Theorems.test_bdgInequality
  IO.println "  Snell Envelope: " ++ toString Theorems.test_snellEnvelopeOptimal

  IO.println ""
  IO.println "--- Example Tests ---"
  IO.println "  Random Walk: " ++ toString Examples.test_randomWalk_exists
  IO.println "  Exponential Martingale: " ++ toString Examples.test_exponentialMartingale
  IO.println "  Brownian Motion: " ++ toString Examples.test_brownianMotion
  IO.println "  Double-or-Nothing: " ++ toString Examples.test_doubleOrNothing
  IO.println "  OST Fails: " ++ toString Examples.test_optionalStoppingFails

  IO.println ""
  IO.println "=========================================="
  IO.println "  Test Suite Complete"
  IO.println "=========================================="

/-- Main entry point. -/
def main : IO Unit := runAllTests

#eval "Test runner: run with `lake exec scripts/run_tests.lean`"
#eval runAllTests

end MiniConditionalMartingale.Scripts
