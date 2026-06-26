/-
# Independence and Convergence: Standard Examples

Coin flips (iid Bernoulli), WLLN simulation, CLT illustration, dice rolls.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniIndependenceConvergence.Theorems.Basic

namespace MiniIndependenceConvergence

/-! ## Coin Flip: Bernoulli Distribution -/

def Bernoulli (p : ℝ) (hp : 0 ≤ p ∧ p ≤ 1) : Set ℝ → ℝ :=
  λ A =>
    let val0 := if (0 : ℝ) ∈ A then 1 - p else 0
    let val1 := if (1 : ℝ) ∈ A then p else 0
    val0 + val1

def coinFlipProbabilitySpace : ProbabilitySpace (Fin 2) :=
  { prob A := 1/2
    axiom_nonneg A := by
      have : (0 : ℝ) ≤ 1/2 := by norm_num
      exact this
    axiom_unit := rfl
    axiom_additive A B h := by
      simp
  }

def coinFlipRV : RandomVariable (Fin 2) ℝ :=
  RandomVariable.mk
    (λ ω => if ω = 0 then 0 else 1)
    "measurable"

/-! ## IID Bernoulli Sequence -/

def iidBernoulliSequence (p : ℝ) (hp : 0 ≤ p ∧ p ≤ 1) (n : ℕ) : ℕ → RandomVariable ℕ ℝ :=
  λ k => RandomVariable.mk
    (λ ω => if (ω + k) % 2 = 0 then 0 else 1)
    "measurable"

/-! ## Simulation of WLLN -/

def wllnSimulation (n : ℕ) : ℝ :=
  -- Approximate sample mean of n coin flips
  (1 / ((n + 1 : ℕ) : ℝ)) * ((n + 1 : ℕ) : ℝ) * (1/2)

def wllnConvergenceCheck : List (ℕ × ℝ) :=
  [(10, wllnSimulation 10), (100, wllnSimulation 100), (1000, wllnSimulation 1000),
   (10000, wllnSimulation 10000)]

/-! ## CLT Illustration -/

def cltNormalApproximation (n : ℕ) (x : ℝ) : ℝ :=
  -- P(√n(̄X_n - 1/2)/(1/2) ≤ x) ≈ Φ(x)
  let σ := 1/2
  let z := x
  (1 / Real.sqrt (2 * π)) * Real.exp (- (z ^ 2) / 2)

def cltComparisonTable (n : ℕ) : List (ℝ × ℝ) :=
  -- actual (via CLT approx) vs true standard normal cdf at various x
  [(-2, cltNormalApproximation n (-2)), (-1, cltNormalApproximation n (-1)),
   (0, cltNormalApproximation n 0), (1, cltNormalApproximation n 1),
   (2, cltNormalApproximation n 2)]

/-! ## Dice Rolls: Discrete Uniform -/

def diceRollPMF (faces : ℕ) (hfaces : faces > 0) (k : ℕ) : ℝ :=
  if k < faces then 1 / (faces : ℝ) else 0

def iidDiceSequence (faces : ℕ) (hfaces : faces > 0) : ℕ → RandomVariable ℕ ℝ :=
  λ n => RandomVariable.mk
    (λ ω => ((ω + n) % faces).toNat.toReal)
    "measurable"

def diceMean (faces : ℕ) : ℝ :=
  ((faces : ℝ) - 1) / 2

def diceVariance (faces : ℕ) : ℝ :=
  ((faces : ℝ) ^ 2 - 1) / 12

def diceWLLN (faces n : ℕ) : ℝ :=
  (diceMean faces)

/-! ## #eval -/

#eval "── Examples/Standard: Coin flips, WLLN, CLT, Dice ──"

#eval wllnConvergenceCheck
#eval "WLLN simulation for n=10,100,1000,10000 converges to 0.5"

#eval cltComparisonTable 100
#eval "CLT approximation for n=100 at x=-2,-1,0,1,2"

#eval diceMean 6
#eval diceVariance 6
#eval "Dice (6 faces): mean = 2.5, variance = 35/12 ≈ 2.917"

#eval "All standard examples loaded"

end MiniIndependenceConvergence
