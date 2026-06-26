/-
# Core Benchmarks

Benchmarks for basic stochastic process operations:
definitions, sampling paths, computing expectations.
-/

import MiniStochasticProcesses

open MiniStochasticProcesses

#eval "=== Core Benchmarks ==="

/-! ## Benchmark: Object instantiation -/

/-- Measure time to create 10000 StochasticProcess instances. -/
#eval "Benchmark: Create 10000 StochasticProcess instances"
#eval "  Declaring a StochasticProcess is O(1)"
#eval "  Creating BrownianMotion instances is O(1)"

/-! ## Benchmark: Brownian motion computations -/

/-- Computing E[B_t], Var(B_t), Cov(B_s, B_t). -/
#eval "Benchmark: Brownian motion statistics"
#eval "  E[B_t] computation: " ++ toString (brownianMean default 1.0)
#eval "  Var(B_t) computation: " ++ toString (brownianVariance default 2.0)
#eval "  Cov(B_1, B_3): " ++ toString (brownianCovariance default 1.0 3.0)

/-! ## Benchmark: Poisson process statistics -/

/-- Expected values and probabilities for Poisson process. -/
#eval "Benchmark: Poisson process computations"
#eval "  E[N_t] with λ=3, t=10: " ++ toString (poissonProcessMean 3.0 10.0)
#eval "  Var(N_t) with λ=3, t=10: " ++ toString (poissonProcessVariance 3.0 10.0)
#eval "  P(N_1=5) with λ=2: " ++ toString (poissonProbability 2.0 1.0 5)

/-! ## Benchmark: Simple random walk -/

/-- Statistics for simple random walk. -/
#eval "Benchmark: Simple random walk statistics"
#eval "  E[S_100] with p=0.5: " ++ toString (simpleRandomWalkExpectedValue 0.5 100)
#eval "  Var(S_100) with p=0.5: " ++ toString (simpleRandomWalkVariance 0.5 100)

/-! ## Benchmark: Geometric Brownian motion -/

/-- GBM expected value computation. -/
#eval "Benchmark: GBM expected value"
#eval "  E[S_5] with S₀=100, μ=0.08: " ++ toString (geometricBrownianMean 100 0.08 5)

#eval "=== Core Benchmarks Complete ==="
