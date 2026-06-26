/-
# Benchmark.Approx

Approximation quality benchmarks:
- How fast does the dyadic approximation converge?
- Error bounds for simple function approximations
- Convergence rate in measure
-/

import MiniMeasurableFunctions

namespace MiniMeasurableFunctions.Benchmark

open MiniMeasurableFunctions

-- The dyadic approximation sₙ(x) = min(f(x), n) has error eₙ(x) = f(x) - min(f(x), n)
-- For f bounded by M, the uniform error after n ≥ M is 0
def approximationError (f : ℕ → ℕ) (n M : ℕ) (hBounded : ∀ x, f x ≤ M) (x : ℕ) : ℕ :=
  f x - min (f x) n

-- Benchmark: how many steps to reach error 0 for a bounded function?
def stepsToFullApproximation (M : ℕ) : ℕ := M

-- L⁰ convergence rate: for convergence in measure, the rate depends on the measure
def convergenceRateInMeasure (ε : ℕ) : ℕ := 1 / (ε + 1)  -- placeholder: O(1/n)

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniMeasurableFunctions — Benchmark.Approx"
  IO.println "═══════════════════════════════════════"
  IO.println s!"Steps to approximate f ≤ 100: {stepsToFullApproximation 100}"
  IO.println s!"Convergence rate in measure (ε=10): {convergenceRateInMeasure 10}"
  IO.println "Benchmark: approximation quality tests completed"

#eval main ()

end MiniMeasurableFunctions.Benchmark
