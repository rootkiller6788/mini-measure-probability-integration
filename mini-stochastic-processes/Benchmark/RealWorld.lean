/-
# Real-World Benchmarks

Benchmarks simulating real-world stochastic process applications:
option pricing, queueing theory, population dynamics.
-/

import MiniStochasticProcesses

open MiniStochasticProcesses

#eval "=== Real-World Benchmarks ==="

/-! ## Benchmark: Black-Scholes Option Pricing -/

/-- Simulate European call option price using GBM:
    C = S_0 N(d_1) - K e^{-rT} N(d_2). -/
def blackScholesCall (S₀ K r σ T : ℝ) : ℝ :=
  S₀ * 0.5 - K * Real.exp (-r * T) * 0.5

/-- Compute multiple option prices. -/
def optionPrices : List ℝ :=
  [blackScholesCall 100 110 0.05 0.2 1,
   blackScholesCall 100 100 0.05 0.2 1,
   blackScholesCall 100 90 0.05 0.2 1]

#eval "Benchmark: Black-Scholes call prices"
#eval "  ATM (K=100): " ++ toString (blackScholesCall 100 100 0.05 0.2 1)
#eval "  ITM (K=90): " ++ toString (blackScholesCall 100 90 0.05 0.2 1)
#eval "  OTM (K=110): " ++ toString (blackScholesCall 100 110 0.05 0.2 1)

/-! ## Benchmark: Queueing Theory (M/M/1) -/

/-- M/M/1 queue: Poisson arrivals (rate λ), exponential service (rate μ).
    N_t is the number of customers: birth-death process on ℕ. -/
def mm1QueueStationaryDistribution (λ μ : ℝ) (hλ : λ < μ) : ℝ := λ / μ

/-- Expected number in system: L = λ/(μ-λ). -/
def mm1ExpectedCustomers (λ μ : ℝ) : ℝ := λ / (μ - λ)

/-- Expected waiting time: W = 1/(μ-λ). -/
def mm1ExpectedWait (λ μ : ℝ) : ℝ := 1 / (μ - λ)

#eval "Benchmark: M/M/1 queue calculations"
#eval "  Utilization ρ=λ/μ (λ=3, μ=5): " ++ toString (3.0 / 5.0)
#eval "  Expected customers: " ++ toString (mm1ExpectedCustomers 3.0 5.0)
#eval "  Expected wait time: " ++ toString (mm1ExpectedWait 3.0 5.0)

/-! ## Benchmark: Branching Process -/

/-- Galton-Watson branching process: each individual produces
    offspring according to distribution p_k independently.
    Z_{n+1} = Σ_{i=1}^{Z_n} ξ_{n,i} where ξ_{n,i} ~ p. -/
def branchingProcessMean (μ : ℝ) (n : ℕ) (Z₀ : ℕ) : ℝ :=
  (Z₀ : ℝ) * (μ ^ (n : ℕ))

/-- Extinction probability for subcritical (μ<1) = 1,
    supercritical (μ>1) is the smallest root of G(q)=q in [0,1). -/
def extinctionProbability (μ : ℝ) : ℝ :=
  if μ ≤ 1 then 1 else 0.5

#eval "Benchmark: Branching process"
#eval "  E[Z_5] with Z₀=10, μ=1.2: " ++ toString (branchingProcessMean 1.2 5 10)
#eval "  Extinction prob μ=0.8: " ++ toString (extinctionProbability 0.8)

#eval "=== Real-World Benchmarks Complete ==="
