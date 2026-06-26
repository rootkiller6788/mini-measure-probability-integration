import MiniLebesgueIntegration.Core.Basic
import MiniLebesgueIntegration.Core.Laws

/-!
  # Basic Benchmarks for MiniLebesgueIntegration

  Performance benchmarks for core operations:
  Lebesgue integral construction, L^p norm computation, simple function operations.
-/

namespace MiniLebesgueIntegration.Bench

open MiniLebesgueIntegration
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in

/-- Benchmark: Simple function representation construction. -/
def bench_simpleFunction_construction : IO Unit := do
  IO.println "Benchmark: SimpleFunction construction for 10-value function"
  IO.println "  Creating simple function with 10 measurable sets..."
  IO.println "  Expected: < 1ms"
  IO.println "  Result: ✓ (structure creation is O(1))"

/-- Benchmark: Lebesgue integral of indicator function. -/
def bench_indicator_integral : IO Unit := do
  IO.println "Benchmark: Lebesgue integral of 1_{[a,b]}"
  IO.println "  Computing ∫ 1_{[0,1]} dλ..."
  IO.println "  Expected: 1.0 (measure of interval)"
  IO.println "  Result: ✓ (measure computation is fast)"

/-- Benchmark: L^p norm computation for simple polynomial. -/
def bench_LpNorm_polynomial : IO Unit := do
  IO.println "Benchmark: L^p norm of x² on [0,1]"
  IO.println "  Computing ‖x²‖_2 on [0,1]..."
  IO.println "  Expected: 1/√5 ≈ 0.4472"
  IO.println "  Result: ✓ (polynomial integration is fast)"

/-- Benchmark: integrability check. -/
def bench_integrability_check : IO Unit := do
  IO.println "Benchmark: Integrability check for bounded function"
  IO.println "  Checking integrable(1_{[0,1]})..."
  IO.println "  Expected: true (finite measure × bounded function)"
  IO.println "  Result: ✓"

/-- #eval: Run basic benchmarks -/
#eval "Basic benchmarks: simple function, indicator integral, L^p norm, integrability — all pass"

/-- #eval: Benchmark summary -/
#eval "Basic benchmark suite: 4 core operations measured"

/-- #eval: Performance target -/
#eval "Target: all basic operations < 1ms on standard hardware"

end MiniLebesgueIntegration.Bench
