import MiniConditionalMartingale.Benchmark.BasicBench
import MiniConditionalMartingale.Benchmark.ConvergenceBench
import MiniConditionalMartingale.Benchmark.StoppingBench
import MiniConditionalMartingale.Benchmark.SimulationBench
import MiniConditionalMartingale.Benchmark.TransformBench

/-!
  # Full Benchmark Suite

  Runs all benchmarks in sequence for comprehensive performance profiling.
-/

namespace MiniConditionalMartingale.Benchmark

open MiniConditionalMartingale

/-- Run the full benchmark suite -/
def runAll : IO Unit := do
  IO.println "======================================"
  IO.println "  MiniConditionalMartingale Benchmarks"
  IO.println "======================================"
  IO.println ""
  BasicBench.runAll
  IO.println ""
  ConvergenceBench.runAll
  IO.println ""
  StoppingBench.runAll
  IO.println ""
  SimulationBench.runAll
  IO.println ""
  TransformBench.runAll
  IO.println ""
  IO.println "======================================"
  IO.println "  All Benchmarks Complete"
  IO.println "======================================"

/-- Quick sanity check on all benchmark categories -/
def sanityCheck : IO Unit := do
  IO.println "Benchmark sanity check..."
  BasicBench.bench_filtrationCreation 1
  ConvergenceBench.bench_convergenceRate 1
  StoppingBench.bench_hittingTime 0 1
  SimulationBench.bench_randomWalkPath 1 1
  TransformBench.bench_quadraticVariation (λ _ _ => 0) 1
  IO.println "All benchmark categories operational."

#eval "Full benchmark suite defined (all 5 categories)"
#eval sanityCheck

end MiniConditionalMartingale.Benchmark
