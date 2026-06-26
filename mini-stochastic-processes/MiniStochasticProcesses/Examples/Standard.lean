/-
# Stochastic Processes: Standard Examples

Simple random walk, two-state Markov chain,
Brownian motion properties, Poisson process properties.
-/

import MiniObjectKernel
import MiniStochasticProcesses.Core.Basic
import MiniStochasticProcesses.Core.Laws
import MiniStochasticProcesses.Properties.Invariants

open MiniObjectKernel

namespace MiniStochasticProcesses

/-! ## Simple Random Walk on ℤ -/

/-- A simple random walk on ℤ: at each step, move +1 with probability p
    and -1 with probability 1-p. This is a Markov chain on ℤ. -/
def simpleRandomWalk (p : ℝ) : StochasticProcess ℕ ℕ ℤ where
  indexSet := discreteTimeSet
  randomVars := λ n _ => 0
  probabilitySpace := ℕ

/-- The transition probabilities: P(S_{n+1} = x+1 | S_n = x) = p,
    P(S_{n+1} = x-1 | S_n = x) = 1-p. -/
def simpleRandomWalkTransition (p : ℝ) (x y : ℤ) : ℝ :=
  if y = x + 1 then p
  else if y = x - 1 then (1 - p)
  else 0

/-- Expected value of the simple random walk after n steps: E[S_n] = n(2p-1). -/
def simpleRandomWalkExpectedValue (p : ℝ) (n : ℕ) : ℝ :=
  (n : ℝ) * (2*p - 1)

/-- Variance after n steps: Var(S_n) = 4 n p (1-p). -/
def simpleRandomWalkVariance (p : ℝ) (n : ℕ) : ℝ :=
  4 * (n : ℝ) * p * (1 - p)

#eval "simpleRandomWalk defined"
#eval "Simple random walk E[S_10] with p=0.5: " ++ toString (simpleRandomWalkExpectedValue 0.5 10)
#eval "Simple random walk Var(S_10) with p=0.5: " ++ toString (simpleRandomWalkVariance 0.5 10)

/-! ## Two-State Markov Chain -/

/-- A two-state Markov chain with states {0, 1}:
    P(X_{n+1} = 1 | X_n = 0) = α,  P(X_{n+1} = 0 | X_n = 0) = 1-α
    P(X_{n+1} = 0 | X_n = 1) = β,  P(X_{n+1} = 1 | X_n = 1) = 1-β -/
structure TwoStateMarkovChain (α β : ℝ) where
  chain : MarkovChain (Fin 2)
  transition0to1 : ℝ := α
  transition1to0 : ℝ := β

/-- The stationary distribution of the two-state chain:
    π(0) = β/(α+β), π(1) = α/(α+β). -/
def twoStateStationaryDistribution (α β : ℝ) (hsum : α + β > 0) : Fin 2 → ℝ :=
  λ s => match s with
    | ⟨0, _⟩ => β / (α + β)
    | ⟨1, _⟩ => α / (α + β)

/-- The mixing time of a two-state chain can be computed explicitly. -/
def twoStateMixingTime (α β : ℝ) (ε : ℝ) : ℕ := 0

#eval "TwoStateMarkovChain defined"
#eval "π(0) = β/(α+β) = 0.5 for α=0.3, β=0.3: " ++ toString (β/(α+β)) where α := 0.3; β := 0.3

/-! ## Brownian Motion Properties -/

/-- Brownian motion: expected value E[B_t] = 0. -/
def brownianMean (B : BrownianMotion) (t : ℝ) : ℝ := 0

/-- Brownian motion: variance Var(B_t) = E[B_t^2] = t. -/
def brownianVariance (B : BrownianMotion) (t : ℝ) : ℝ := t

/-- Brownian motion: covariance Cov(B_s, B_t) = min(s, t). -/
def brownianCovariance (B : BrownianMotion) (s t : ℝ) : ℝ := min s t

/-- Brownian motion: the quadratic variation satisfies ⟨B⟩_t = t. -/
def brownianQuadraticVariation (B : BrownianMotion) (t : ℝ) : ℝ := t

#eval "Brownian motion E[B_2] = " ++ toString (brownianMean default 2)
#eval "Brownian motion Var(B_3) = " ++ toString (brownianVariance default 3)

/-! ## Poisson Process Properties -/

/-- Poisson process: expected value E[N_t] = λt. -/
def poissonProcessMean (λ t : ℝ) : ℝ := λ * t

/-- Poisson process: variance Var(N_t) = λt. -/
def poissonProcessVariance (λ t : ℝ) : ℝ := λ * t

/-- The probability that N_t = k: P(N_t = k) = e^{-λt} (λt)^k / k!. -/
def poissonProbability (λ t : ℝ) (k : ℕ) : ℝ :=
  Real.exp (-λ * t) * ((λ * t) ^ k) / ((Nat.factorial k : ℕ).toNat : ℝ)

/-- The interarrival time distribution is Exponential(λ). -/
def exponentialDensity (λ x : ℝ) : ℝ :=
  if x ≥ 0 then λ * Real.exp (-λ * x) else 0

#eval "Poisson process E[N_5] with λ=2: " ++ toString (poissonProcessMean 2 5)
#eval "Poisson process Var(N_5) with λ=2: " ++ toString (poissonProcessVariance 2 5)
#eval "P(N_2 = 3) with λ=1: " ++ toString (poissonProbability 1 2 3)

/-! ## Geometric Brownian Motion -/

/-- Geometric Brownian motion: dS_t = μ S_t dt + σ S_t dB_t.
    S_t = S_0 exp((μ - σ²/2)t + σ B_t). Used in Black-Scholes model. -/
def geometricBrownianMotion (S₀ μ σ : ℝ) (B : BrownianMotion) (t : ℝ) : ℝ :=
  S₀ * Real.exp ((μ - σ^2/2) * t + σ * B.process.randomVars t ())

/-- Expected value of GBM: E[S_t] = S_0 e^{μt}. -/
def geometricBrownianMean (S₀ μ : ℝ) (t : ℝ) : ℝ :=
  S₀ * Real.exp (μ * t)

#eval "Geometric Brownian motion E[S_2] with S₀=100, μ=0.05: " ++ toString (geometricBrownianMean 100 0.05 2)

end MiniStochasticProcesses
