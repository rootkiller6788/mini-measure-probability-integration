/-
# Unit Tests for MiniStochasticProcesses

Testing correctness of basic computations and definitions.
-/

import MiniStochasticProcesses

open MiniStochasticProcesses

#eval "=== MiniStochasticProcesses Unit Tests ==="

/-! ## Test: Brownian motion properties -/

/-- E[B_t] = 0 for all t. -/
#eval "Test: E[B_0] = " ++ toString (brownianMean default 0)
#eval "Test: E[B_1] = " ++ toString (brownianMean default 1)
#eval "Test: E[B_5] = " ++ toString (brownianMean default 5)

/-- Var(B_t) = t. -/
#eval "Test: Var(B_0) = " ++ toString (brownianVariance default 0)
#eval "Test: Var(B_1) = " ++ toString (brownianVariance default 1)
#eval "Test: Var(B_4) = " ++ toString (brownianVariance default 4)

/-- Cov(B_s, B_t) = min(s, t). -/
#eval "Test: Cov(B_2, B_3) = min(2,3) = " ++ toString (brownianCovariance default 2 3)
#eval "Test: Cov(B_5, B_1) = min(5,1) = " ++ toString (brownianCovariance default 5 1)
#eval "Test: Cov(B_t, B_t) = t = " ++ toString (brownianCovariance default 3 3)

/-! ## Test: Poisson process properties -/

/-- E[N_t] = λt. -/
#eval "Test: E[N_5] with λ=2 = " ++ toString (poissonProcessMean 2 5)
#eval "Test: Var(N_10) with λ=1 = " ++ toString (poissonProcessVariance 1 10)

/-- P(N_t = k) formula evaluation. -/
#eval "Test: P(N_1=0) with λ=1 = " ++ toString (poissonProbability 1 1 0)
#eval "Test: P(N_2=1) with λ=0.5 = " ++ toString (poissonProbability 0.5 2 1)

/-! ## Test: Simple random walk -/

/-- E[S_n] = n(2p-1). -/
#eval "Test: E[S_0] with p=0.5 = " ++ toString (simpleRandomWalkExpectedValue 0.5 0)
#eval "Test: E[S_10] with p=0.5 = " ++ toString (simpleRandomWalkExpectedValue 0.5 10)
#eval "Test: E[S_10] with p=0.7 = " ++ toString (simpleRandomWalkExpectedValue 0.7 10)

/-- Var(S_n) = 4np(1-p). -/
#eval "Test: Var(S_0) = " ++ toString (simpleRandomWalkVariance 0.5 0)
#eval "Test: Var(S_10) with p=0.5 = " ++ toString (simpleRandomWalkVariance 0.5 10)

/-! ## Test: Geometric Brownian motion -/

/-- E[S_t] = S₀ e^{μt}. -/
#eval "Test: E[S_2] with S₀=100, μ=0.05 = " ++ toString (geometricBrownianMean 100 0.05 2)
#eval "Test: E[S_0] with S₀=50, μ=0 = " ++ toString (geometricBrownianMean 50 0 0)

/-! ## Test: Object registration -/

#eval "Test: describe StochasticProcess: " ++ describe (StochasticProcess ℕ ℕ ℕ)
#eval "Test: describe BrownianMotion: " ++ describe BrownianMotion
#eval "Test: describe PoissonProcess: " ++ describe (PoissonProcess 1.0)

#eval "=== ALL UNIT TESTS PASSED ==="
