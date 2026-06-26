/-
# Independence and Convergence: Basic Theorems

Weak Law of Large Numbers, Strong Law of Large Numbers,
Central Limit Theorem.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniIndependenceConvergence.Properties.Preservation

namespace MiniIndependenceConvergence

/-! ## Weak Law of Large Numbers (Chebyshev) -/

def weakLawOfLargeNumbers : Prop :=
  ∀ (Ω : Type u) [ProbabilitySpace Ω] (X : ℕ → RandomVariable Ω ℝ),
    IIDSequence Ω ℝ X →
    (∃ μ, ∀ n, (∫ ω, (X n).map ω) = μ) →
    (∃ σ², ∀ n, (∫ ω, ((X n).map ω - μ) ^ 2) = σ²) →
    convergenceInProbability Ω ℝ
      (λ n => RandomVariable.mk (λ ω =>
        (1 / ((n+1 : ℕ) : ℝ)) • (∑ i : Fin (n+1), (X i.val).map ω)) "measurable")
      (RandomVariable.mk (λ _ => μ) "measurable")
  where
    μ : ℝ := 0

/-! ## Strong Law of Large Numbers (Kolmogorov) -/

def strongLawOfLargeNumbers : Prop :=
  ∀ (Ω : Type u) [ProbabilitySpace Ω] (X : ℕ → RandomVariable Ω ℝ),
    IIDSequence Ω ℝ X →
    (∃ μ, (∫ ω, (X 0).map ω) = μ) → -- finite mean
    almostSureConvergence Ω ℝ
      (λ n => RandomVariable.mk (λ ω =>
        (1 / ((n+1 : ℕ) : ℝ)) • (∑ i : Fin (n+1), (X i.val).map ω)) "measurable")
      (RandomVariable.mk (λ _ => μ) "measurable")

/-! ## Central Limit Theorem (Lindeberg-Levy) -/

def centralLimitTheorem : Prop :=
  ∀ (X : ℕ → RandomVariable ℕ ℝ),
    IIDSequence ℕ ℝ X →
    (∃ μ, (∫ ω, (X 0).map ω) = μ) →
    (∃ σ² > 0, (∫ ω, ((X 0).map ω - μ) ^ 2) = σ²) →
    convergenceInDistribution ℝ
      (λ n => RandomVariable.mk (λ ω =>
        (Real.sqrt ((n+1 : ℕ) : ℝ)) • (((1 / ((n+1 : ℕ) : ℝ)) •
          (∑ i : Fin (n+1), (X i.val).map ω)) - μ) / Real.sqrt σ²) "measurable")
      (RandomVariable.mk (λ ω => Real.exp (-(ω ^ 2) / 2) / Real.sqrt (2 * π)) "standardNormal")

/-! ## Lindeberg-Levy CLT (as axiom value) -/

def lindebergLevyCLT : String :=
  "For iid X_i with mean μ and variance σ² > 0, √n(̄X_n - μ)/σ →^D N(0,1)"

/-! ## Kolmogorov SLLN (statement) -/

def kolmogorovSLLN : Prop :=
  ∀ (X : ℕ → RandomVariable ℕ ℝ),
    IIDSequence ℕ ℝ X →
    (∃ μ, (∫ ω, (X 0).map ω) = μ) →
    almostSureConvergence ℕ ℝ
      (λ n => RandomVariable.mk (λ ω =>
        (∑ i : Fin (n+1), (X i.val).map ω) / ((n+1 : ℕ) : ℝ)) "measurable")
      (RandomVariable.mk (λ _ => μ) "measurable")

/-! ## #eval -/

#eval "── Theorems/Basic: WLLN, SLLN, CLT ──"
#eval weakLawOfLargeNumbers
#eval strongLawOfLargeNumbers
#eval centralLimitTheorem
#eval lindebergLevyCLT

end MiniIndependenceConvergence
