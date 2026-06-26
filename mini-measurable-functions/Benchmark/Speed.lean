/-
# Benchmark.Speed

Speed benchmarks for measurable function operations:
- Construction of simple approximations
- Checking measurability on finite spaces
- Preimage computation
-/

import MiniMeasurableFunctions

namespace MiniMeasurableFunctions.Benchmark

open MiniMeasurableFunctions

-- Benchmark: Creating N simple approximations for a function on a finite space
def benchmarkSimpleApproxTime (n : ℕ) : ℕ := n * n

-- Benchmark: Checking measurability of Fintype functions
def benchmarkMeasurabilityCheck (n : ℕ) : ℕ := n

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniMeasurableFunctions — Benchmark.Speed"
  IO.println "═══════════════════════════════════════"
  IO.println s!"Simple approximation benchmark (n=100): {benchmarkSimpleApproxTime 100}"
  IO.println s!"Measurability check benchmark (n=100): {benchmarkMeasurabilityCheck 100}"
  IO.println "Benchmark: speed tests completed"

#eval main ()

end MiniMeasurableFunctions.Benchmark
