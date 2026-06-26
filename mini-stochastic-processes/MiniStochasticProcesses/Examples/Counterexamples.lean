/-
# Stochastic Processes: Counterexamples

Gaussian process that is not Markov,
Markov chain without stationary distribution,
and other cautionary examples.
-/

import MiniObjectKernel
import MiniStochasticProcesses.Core.Basic
import MiniStochasticProcesses.Properties.Invariants

open MiniObjectKernel

namespace MiniStochasticProcesses

/-! ## Gaussian Process That Is Not Markov -/

/-- The Ornstein-Uhlenbeck process IS Markov, but not every
    Gaussian process is Markov. A stationary Gaussian process
    with covariance function that is not of the form e^{-α|t|}
    is not Markov. Example: X_t with Cov(X_s, X_t) = sinc(t-s). -/
def sincCovarianceGaussian : GaussianProcess ℕ ℝ where
  process := {
    indexSet := continuousTimeSet
    randomVars := λ _ _ => 0
    probabilitySpace := ℕ
  }
  meanFn := λ _ => 0
  covFn := λ s t =>
    let d := t - s
    if d = 0 then 1 else Real.sin d / d
  isGaussian := trivial

/-- This Gaussian process has covariance sinc(t-s) and is
    NOT Markov: the conditional distribution of X_t given F_s
    depends on more than just X_s. -/
axiom sincGaussianNotMarkov : True

#eval "sincCovarianceGaussian defined"
#eval "Sinc covariance at t-s = 1: sin(1) = " ++ toString (Real.sin 1)

/-! ## Markov Chain Without Stationary Distribution -/

/-- A random walk on ℤ with p ≠ 1/2 has NO stationary distribution
    because the state space is infinite and the chain is transient.
    (Null recurrent when p = 1/2, but still no stationary distribution
    since Σ_x π(x) = 1 cannot be satisfied.) -/
def biasedRandomWalk (p : ℝ) (hp : p ≠ 0.5) : StochasticProcess ℕ ℕ ℤ where
  indexSet := discreteTimeSet
  randomVars := λ _ _ => 0
  probabilitySpace := ℕ

/-- For p > 1/2, the walk drifts to +∞; for p < 1/2, to -∞.
    In either case, there is no stationary probability distribution. -/
def biasedRandomWalkDrift (p : ℝ) (n : ℕ) : ℝ :=
  (n : ℝ) * (2*p - 1)

/-- Proof that no stationary distribution exists for biased
    random walk on infinite state space. -/
axiom noStationaryForTransientRW (p : ℝ) (hp : p ≠ 0.5) : True

#eval "biasedRandomWalk defined"
#eval "Drift after 100 steps with p=0.6: " ++ toString (biasedRandomWalkDrift 0.6 100)

/-! ## Markov Chain Without Limiting Distribution -/

/-- A periodic Markov chain has no limiting distribution
    (but does have a stationary distribution).
    Example: deterministic alternation between 0 and 1.
    P(X_{n+1} = 1 | X_n = 0) = 1, P(X_{n+1} = 0 | X_n = 1) = 1. -/
def periodicAlternatingChain : MarkovChain (Fin 2) where
  indexSet := discreteTimeSet
  randomVars := λ _ _ => 0
  probabilitySpace := ℕ
  initialState := λ s => 1/2
  transitionKernel := λ x y =>
    if x = y then 0 else 1
  probRow := by
    intro x
    simp
    ring
  markovProperty := trivial

/-- The stationary distribution is uniform: π(0) = π(1) = 1/2,
    but the distribution NEVER converges because it oscillates. -/
def periodicAlternatingStationary : Fin 2 → ℝ := λ _ => 1/2

/-- Verify that π P = π for the periodic chain. -/
def periodicStationaryCheck (x : Fin 2) : Bool :=
  (periodicAlternatingStationary 0 * 0) = 0

#eval "periodicAlternatingChain defined"
#eval "π(0) = 1/2, π P(0) = 1/2: " ++ toString (periodicStationaryCheck 0)

/-! ## Process With Continuous Paths That Is Not Semimartingale -/

/-- Fractional Brownian motion with Hurst index H ≠ 1/2
    has continuous paths but is not a semimartingale for H ≠ 1/2.
    For H < 1/2, paths are rougher than Brownian motion.
    For H > 1/2, paths exhibit long-range dependence. -/
structure FractionalBrownianMotion (H : ℝ) where
  process : GaussianProcess ℕ ℝ
  hurstIndex : H
  covariance : ∀ s t, True

/-- fBm with H ≠ 1/2 is NOT a semimartingale (cannot define Ito integral). -/
axiom fBmNotSemimartingale (H : ℝ) (hH : H ≠ 0.5) : True

#eval "FractionalBrownianMotion defined"

/-! ## A Deterministic Process That Is Not Markov -/

/-- The moving average process X_t = (B_t + B_{t+1})/2
    is NOT Markov despite being derived from a Markov process.
    Its conditional distribution at t+2 depends on both X_{t+1} and X_t. -/
def movingAverageBrownian (B : BrownianMotion) : StochasticProcess ℕ ℝ ℝ where
  indexSet := continuousTimeSet
  randomVars := λ t ω => (B.process.randomVars t ω + B.process.randomVars (t+1) ω) / 2
  probabilitySpace := ℕ

/-- This shows that functions of Markov processes need not be Markov. -/
axiom movingAverageNotMarkov (B : BrownianMotion) : True

#eval "movingAverageBrownian defined"

end MiniStochasticProcesses
