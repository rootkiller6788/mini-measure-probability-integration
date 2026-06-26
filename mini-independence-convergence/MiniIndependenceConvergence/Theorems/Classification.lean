/-
# Independence and Convergence: Classification Theorems

Berry-Esseen theorem (CLT convergence rate).
Local limit theorems.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniIndependenceConvergence.Theorems.Basic

namespace MiniIndependenceConvergence

/-! ## Berry-Esseen Theorem -/

def BerryEsseenTheorem : Prop :=
  ∀ (X : ℕ → RandomVariable ℕ ℝ),
    IIDSequence ℕ ℝ X →
    (∃ μ, (∫ ω, (X 0).map ω) = μ) →
    (∃ σ² > 0, (∫ ω, ((X 0).map ω - μ) ^ 2) = σ²) →
    (∃ ρ, (∫ ω, |(X 0).map ω - μ| ^ 3) = ρ) → -- finite third absolute moment
    ∃ C > 0, ∀ n : ℕ, ∀ x : ℝ,
      |inst.prob {ω | (Real.sqrt ((n+1 : ℕ) : ℝ)) •
        (((∑ i : Fin (n+1), (X i.val).map ω) / ((n+1 : ℕ) : ℝ)) - μ) / Real.sqrt σ² ≤ x} -
        (∫_ (-∞) x, λ t => Real.exp (-(t ^ 2) / 2) / Real.sqrt (2 * π))| ≤
      C * ρ / (σ² ^ (3/2) * Real.sqrt ((n+1 : ℕ) : ℝ))

def berryEsseenBound : String :=
  "The optimal constant is C = 0.4748 (proved by Shevtsova, 2013)"

/-! ## Local Limit Theorem -/

def LocalLimitTheorem : Prop :=
  ∀ (X : ℕ → RandomVariable ℕ ℤ), -- integer-valued
    IIDSequence ℕ ℤ X →
    (∃ μ, (∫ ω, (X 0).map ω) = μ) →
    (∃ σ² > 0, (∫ ω, ((X 0).map ω - μ) ^ 2) = σ²) →
    -- aperiodicity condition
    (∀ k : ℤ,
      Filter.Tendsto (λ n =>
        Real.sqrt ((n+1 : ℕ) : ℝ) * σ² •
          inst.prob {ω | (∑ i : Fin (n+1), (X i.val).map ω) = k} -
        Real.exp (-((k - ((n+1:ℕ):ℝ) • μ) ^ 2) / (2 * ((n+1:ℕ):ℝ) * σ²)) /
          Real.sqrt (2 * π * σ²))
        Filter.atTop (nhds 0))

/-! ## Convergence Rate Classification -/

inductive ConvergenceRate : Type where
  | n1over2pow     -- O(n^{-1/2}) - CLT rate
  | n1over2log_n   -- O(n^{-1/2} log n) - LIL rate
  | nPow (α : ℝ)   -- O(n^{-α})
  | exponential    -- O(e^{-cn})
  deriving Repr

def convergenceRateFor (thm : String) : ConvergenceRate :=
  match thm with
  | "CLT" => .n1over2pow
  | "BerryEsseen" => .n1over2pow
  | "WLLN" => .nPow 1
  | "SLLN" => .nPow 1
  | "LIL" => .n1over2log_n
  | _ => .nPow 0

/-! ## Law of the Iterated Logarithm -/

def lawOfIteratedLogarithm : Prop :=
  ∀ (X : ℕ → RandomVariable ℕ ℝ),
    IIDSequence ℕ ℝ X →
    (∃ μ, (∫ ω, (X 0).map ω) = μ) →
    (∃ σ² > 0, (∫ ω, ((X 0).map ω - μ) ^ 2) = σ²) →
    inst.prob {ω |
      limsup (λ n => ((∑ i : Fin n, (X i.val).map ω) - (n : ℝ) • μ) /
        (Real.sqrt (2 * (n : ℝ) * σ² * Real.log (Real.log (n : ℝ))))) = 1 ∧
      liminf (λ n => ((∑ i : Fin n, (X i.val).map ω) - (n : ℝ) • μ) /
        (Real.sqrt (2 * (n : ℝ) * σ² * Real.log (Real.log (n : ℝ))))) = -1} = 1

/-! ## #eval -/

#eval "── Theorems/Classification: Berry-Esseen, Local Limit, LIL ──"
#eval berryEsseenBound
#eval convergenceRateFor "CLT"
#eval convergenceRateFor "BerryEsseen"
#eval convergenceRateFor "WLLN"

end MiniIndependenceConvergence
