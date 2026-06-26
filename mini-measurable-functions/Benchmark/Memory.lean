/-
# Benchmark.Memory

Memory usage benchmarks for measurable function data structures:
- SimpleFunction memory footprint
- L0Quotient memory usage
- MeasureAlgebraIsomorphism size
-/

import MiniMeasurableFunctions

namespace MiniMeasurableFunctions.Benchmark

open MiniMeasurableFunctions

-- Approximate memory: SimpleFunction stores a finite range and level sets
def estimateSimpleFunctionMemory (rangeSize : ℕ) (domainSize : ℕ) : ℕ :=
  rangeSize * domainSize  -- rough estimate

-- L0Quotient memory: stores the equivalence relation data
def estimateL0QuotientMemory (numFunctions : ℕ) : ℕ :=
  numFunctions * numFunctions  -- O(n²) for equivalence relation

-- Measure algebra isomorphism memory
def estimateMeasureAlgebraMemory (numSets : ℕ) : ℕ :=
  numSets * numSets  -- stores mapping between algebras

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniMeasurableFunctions — Benchmark.Memory"
  IO.println "═══════════════════════════════════════"
  IO.println s!"SimpleFunction memory (10, 100): {estimateSimpleFunctionMemory 10 100}"
  IO.println s!"L0Quotient memory (1000): {estimateL0QuotientMemory 1000}"
  IO.println s!"MeasureAlgebra memory (500): {estimateMeasureAlgebraMemory 500}"
  IO.println "Benchmark: memory estimation completed"

#eval main ()

end MiniMeasurableFunctions.Benchmark
