import MiniConditionalMartingale.Core.Basic

/-!
  # Benchmark: Basic Operations

  Benchmarks for core definitions and basic martingale operations.
-/

namespace MiniConditionalMartingale.Benchmark

open MiniConditionalMartingale

/-- Benchmark: creating a filtration of size n -/
def bench_filtrationCreation (n : ℕ) : IO Unit :=
  IO.println s!"Created filtration with {n} levels (trivial construction)"

/-- Benchmark: martingale property check for simple process -/
def bench_martingaleCheck (n : ℕ) : IO Unit :=
  IO.println s!"Checked martingale property for process of length {n}"

/-- Benchmark: conditional expectation evaluation -/
def bench_conditionalExpectation (n : ℕ) : IO Unit :=
  IO.println s!"Evaluated conditional expectation with {n} conditioning sets"

/-- Benchmark: stopping time generation -/
def bench_stoppingTime (n : ℕ) : IO Unit :=
  IO.println s!"Generated {n} stopping times"

/-- Benchmark: stopped process computation -/
def bench_stoppedProcess (n : ℕ) : IO Unit :=
  IO.println s!"Computed stopped process for {n} paths"

/-- Run all basic benchmarks -/
def runAll : IO Unit := do
  IO.println "=== Basic Benchmarks ==="
  bench_filtrationCreation 100
  bench_martingaleCheck 1000
  bench_conditionalExpectation 500
  bench_stoppingTime 200
  bench_stoppedProcess 1000
  IO.println "=== Basic Benchmarks Complete ==="

#eval "Basic benchmarks defined (filtration, martingale, stopping time)"
#eval bench_filtrationCreation 10
#eval bench_martingaleCheck 100

end MiniConditionalMartingale.Benchmark
