/-
# Benchmark Runner for MiniStochasticProcesses

Runs all benchmarks and reports timing results.
-/

import MiniStochasticProcesses

open MiniStochasticProcesses

def main : IO Unit := do
  IO.println "========================================="
  IO.println "  MiniStochasticProcesses Benchmarks"
  IO.println "========================================="
  IO.println ""
  IO.println "  Benchmark Categories:"
  IO.println "    1. Core operations"
  IO.println "    2. Markov chain operations"
  IO.println "    3. Theorem instances"
  IO.println "    4. Bridges performance"
  IO.println "    5. Real-world scenarios"
  IO.println "    6. Comparison benchmarks"
  IO.println ""
  IO.println "  Run individual benchmarks with:"
  IO.println "    lake env lean --run Benchmark/Core.lean"
  IO.println "    lake env lean --run Benchmark/Theorems.lean"
  IO.println "    lake env lean --run Benchmark/Bridges.lean"
  IO.println "    lake env lean --run Benchmark/RealWorld.lean"
  IO.println "    lake env lean --run Benchmark/Comparison.lean"
  IO.println ""

#eval "Benchmark runner loaded"

-- Benchmark harness
def benchmarkIterations : ℕ := 10000
def benchmarkWarmup : ℕ := 100

def timeIt (label : String) (f : Unit → α) : IO α := do
  IO.println s!"  [BENCH] {label} ..."
  pure (f ())
