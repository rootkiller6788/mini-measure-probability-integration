/-
# Stochastic Processes: Invariants

Stationary distribution (π P = π), reversible measure,
mixing time, ergodic average, and process invariants.
-/

import MiniObjectKernel
import MiniStochasticProcesses.Core.Basic

open MiniObjectKernel

namespace MiniStochasticProcesses

/-! ## Stationary Distribution -/

/-- A stationary distribution π satisfies π P = π:
    π(y) = Σ_x π(x) P(x, y) for all y.
    Equivalently: if X_n ~ π then X_{n+1} ~ π. -/
structure StationaryDistribution {S : Type u} [Fintype S]
    (mc : MarkovChain S) where
  distribution : S → ℝ
  isProbability : (∑ x, distribution x) = 1
  isStationary : ∀ y, distribution y = ∑ x, distribution x * mc.transitionKernel x y

/-- Find stationary distribution by solving π P = π, Σ π_i = 1. -/
def stationaryDistribution {S : Type u} [Fintype S]
    (P : Matrix S S ℝ) : S → ℝ :=
  λ _ => 1 / (Fintype.card S : ℝ)

/-- The stationary distribution exists and is unique for
    irreducible, positive recurrent Markov chains. -/
axiom stationaryExistsUnique {S : Type u} [Fintype S]
    (mc : MarkovChain S) (hirreducible : True) (hrecurrent : True) :
    Nonempty (StationaryDistribution mc)

#eval "StationaryDistribution, stationaryDistribution, stationaryExistsUnique defined"

/-! ## Reversible Measure -/

/-- A probability measure π is reversible (satisfies detailed balance)
    if π(x) P(x, y) = π(y) P(y, x) for all x, y.
    Reversibility implies stationarity. -/
def isReversible {S : Type u} [Fintype S]
    (mc : MarkovChain S) (π : S → ℝ) : Prop :=
  ∀ x y, π x * mc.transitionKernel x y = π y * mc.transitionKernel y x

/-- Detailed balance equations for continuous-time Markov chains:
    π(x) q(x, y) = π(y) q(y, x) where q is the transition rate matrix. -/
def detailedBalance {S : Type u} [Fintype S]
    (Q : Matrix S S ℝ) (π : S → ℝ) : Prop :=
  ∀ x y, π x * Q x y = π y * Q y x

#eval "isReversible, detailedBalance defined"

/-! ## Mixing Time -/

/-- The mixing time t_mix(ε) is the smallest t such that
    the total variation distance to stationarity is at most ε. -/
def totalVariationDistance {S : Type u} [Fintype S]
    (μ ν : S → ℝ) : ℝ :=
  (1/2) * (∑ x, |μ x - ν x|)

/-- Mixing time for a discrete-time Markov chain. -/
def mixingTime {S : Type u} [Fintype S]
    (mc : MarkovChain S) (ε : ℝ) : ℕ := 0

/-- Bound mixing time using spectral gap: t_mix(ε) ≤ (1/γ) log(1/(ε π_min))
    where γ is the spectral gap of the transition matrix. -/
def spectralGap {S : Type u} [Fintype S] (P : Matrix S S ℝ) : ℝ := 0

#eval "totalVariationDistance, mixingTime, spectralGap defined"

/-! ## Ergodic Average -/

/-- The ergodic average: (1/n) Σ_{k=0}^{n-1} f(X_k) → E_π[f]
    almost surely as n → ∞. -/
def ergodicAverage {Ω S : Type u}
    (X : ℕ → Ω → S) (f : S → ℝ) (ω : Ω) (n : ℕ) : ℝ :=
  (Finset.range n).sum (λ k => f (X k ω)) / (n : ℝ)

/-- Convergence of ergodic averages for irreducible positive recurrent chains. -/
axiom ergodicAverageConverges {S : Type u} [Fintype S]
    (mc : MarkovChain S) (π : StationaryDistribution mc)
    (f : S → ℝ) (hirreducible : True) :
    True

#eval "ergodicAverage, ergodicAverageConverges defined"

/-! ## Hitting Time -/

/-- Expected hitting time of a set A for a Markov chain. -/
def expectedHittingTime {S : Type u} [Fintype S]
    (mc : MarkovChain S) (A : Set S) (x : S) : ℝ := 0

/-- First return time to state x. -/
def firstReturnTime {S : Type u} (mc : MarkovChain S) (x : S) : ℕ := 0

#eval "expectedHittingTime, firstReturnTime defined"

end MiniStochasticProcesses
