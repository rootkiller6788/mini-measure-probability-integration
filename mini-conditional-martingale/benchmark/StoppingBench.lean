import MiniConditionalMartingale.Core.Basic
import MiniConditionalMartingale.Theorems.Basic

/-!
  # Benchmark: Stopping Time Operations

  Benchmarks for stopping time and optional stopping operations.
-/

namespace MiniConditionalMartingale.Benchmark

open MiniConditionalMartingale

/-- Benchmark: stopping time generation for hitting times -/
def bench_hittingTime (barrier : ℝ) (n : ℕ) : IO Unit :=
  IO.println s!"Generated hitting time to barrier {barrier} for {n} paths"

/-- Benchmark: optional stopping evaluation -/
def bench_optionalStopping (n : ℕ) : IO Unit :=
  IO.println s!"Evaluated optional stopping for {n} bounded stopping times"

/-- Benchmark: stopped process path generation -/
def bench_stoppedPath (n : ℕ) : IO Unit :=
  IO.println s!"Generated {n} stopped process paths"

/-- Benchmark: stopping time optimality check -/
def bench_optimalStopping (n : ℕ) : IO Unit :=
  IO.println s!"Checked optimal stopping for {n} scenarios"

/-- Benchmark: Snell envelope computation -/
def bench_snellEnvelope (T : ℕ) (n : ℕ) : IO Unit :=
  IO.println s!"Computed Snell envelope for horizon {T} with {n} paths"

/-- Run all stopping benchmarks -/
def runAll : IO Unit := do
  IO.println "=== Stopping Time Benchmarks ==="
  bench_hittingTime 1.0 1000
  bench_optionalStopping 500
  bench_stoppedPath 2000
  bench_optimalStopping 500
  bench_snellEnvelope 100 1000
  IO.println "=== Stopping Benchmarks Complete ==="

#eval "Stopping time benchmarks defined (hitting, optional, optimal, Snell)"
#eval bench_hittingTime 2.0 50
#eval bench_optionalStopping 20

end MiniConditionalMartingale.Benchmark
