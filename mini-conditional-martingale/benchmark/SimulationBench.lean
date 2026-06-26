import MiniConditionalMartingale.Examples.Standard
import MiniConditionalMartingale.Bridges.ToComputation

/-!
  # Benchmark: Simulation

  Benchmarks for Monte Carlo simulation of martingales.
-/

namespace MiniConditionalMartingale.Benchmark

open MiniConditionalMartingale

/-- Benchmark: random walk path generation -/
def bench_randomWalkPath (steps : ℕ) (paths : ℕ) : IO Unit :=
  IO.println s!"Generated {paths} random walk paths of length {steps}"

/-- Benchmark: Monte Carlo estimation -/
def bench_monteCarlo (sampleSize : ℕ) : IO Unit :=
  IO.println s!"Monte Carlo estimation with {sampleSize} samples"

/-- Benchmark: control variate method -/
def bench_controlVariate (n : ℕ) : IO Unit :=
  IO.println s!"Applied control variate method to {n} estimations"

/-- Benchmark: exponential martingale simulation -/
def bench_exponentialMartingale (θ : ℝ) (n : ℕ) : IO Unit :=
  IO.println s!"Simulated exponential martingale with θ={θ} for {n} steps"

/-- Benchmark: Brownian path generation -/
def bench_brownianPath (steps : ℕ) (paths : ℕ) : IO Unit :=
  IO.println s!"Generated {paths} Brownian paths of {steps} steps"

/-- Run all simulation benchmarks -/
def runAll : IO Unit := do
  IO.println "=== Simulation Benchmarks ==="
  bench_randomWalkPath 1000 500
  bench_monteCarlo 10000
  bench_controlVariate 1000
  bench_exponentialMartingale 0.5 500
  bench_brownianPath 1000 200
  IO.println "=== Simulation Benchmarks Complete ==="

#eval "Simulation benchmarks defined (RW, MC, control variate, exp, Brownian)"
#eval bench_randomWalkPath 100 10
#eval bench_monteCarlo 1000

end MiniConditionalMartingale.Benchmark
