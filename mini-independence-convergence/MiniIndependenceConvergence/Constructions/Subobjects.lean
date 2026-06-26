/-
# Independence and Convergence: Subobjects

Exchangeable sequences, stationary sequences, mixing sequences.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniIndependenceConvergence.Constructions.Quotients

namespace MiniIndependenceConvergence

/-! ## Stationary Sequence -/

structure StationarySequence (Ω E : Type u) [ProbabilitySpace Ω] where
  vars : ℕ → RandomVariable Ω E
  stationary : ∀ (k n : ℕ) (B : Set (Fin k → E)),
    inst.prob {ω | (λ i : Fin k => (vars (i.val)).map ω) ∈ B} =
    inst.prob {ω | (λ i : Fin k => (vars (i.val + n)).map ω) ∈ B}

/-! ## Mixing Sequence -/

structure MixingSequence (Ω E : Type u) [ProbabilitySpace Ω] extends StationarySequence Ω E where
  mixing : ∀ (A B : Set E),
    Filter.Tendsto (λ n => |inst.prob ((vars 0).map⁻¹' A ∩ (vars n).map⁻¹' B) -
      inst.prob ((vars 0).map⁻¹' A) * inst.prob ((vars n).map⁻¹' B)|)
      Filter.atTop (nhds 0)

/-! ## Strong Mixing -/

structure StrongMixingSequence (Ω E : Type u) [ProbabilitySpace Ω] extends StationarySequence Ω E where
  alphaMixingCoefficient (n : ℕ) : ℝ
  strongMixing : Filter.Tendsto (λ n => alphaMixingCoefficient n) Filter.atTop (nhds 0)
  alphaBound : ∀ (A : σ ((vars k) | k ≤ 0)) (B : σ ((vars k) | k ≥ n)),
    |inst.prob (A ∩ B) - inst.prob A * inst.prob B| ≤ alphaMixingCoefficient n

/-! ## Ergodicity Condition -/

def ergodicSequence (Ω E : Type u) [ProbabilitySpace Ω]
    (X : ℕ → RandomVariable Ω E) : Prop :=
  ∀ A, (∀ n, (X n).map⁻¹' A = A) → inst.prob A = 0 ∨ inst.prob A = 1

/-! ## Subsequence Independence -/

structure IndependentSubsequence (Ω E : Type u) [ProbabilitySpace Ω]
    (X : ℕ → RandomVariable Ω E) where
  indices : ℕ → ℕ
  strictlyIncreasing : ∀ m n, m < n → indices m < indices n
  independent : ∀ i j, i ≠ j → IndependentRVs Ω E E (X (indices i)) (X (indices j))

def IndependentSubsequence.existsInfinite : Prop :=
  ∀ (Ω E : Type u) [ProbabilitySpace Ω] (X : ℕ → RandomVariable Ω E),
    ∃ (sub : IndependentSubsequence Ω E X), True

/-! ## Martingale Difference Sequence -/

structure MartingaleDifferenceSequence (Ω : Type u) [ProbabilitySpace Ω] where
  vars : ℕ → RandomVariable Ω ℝ
  filtration : ℕ → SigmaAlgebra Ω
  adapted : ∀ n, True -- X_n is F_n measurable (stubbed)
  martingaleDifference : ∀ n, True -- E[X_{n+1} | F_n] = 0 (stubbed)

/-! ## #eval -/

#eval "── Constructions/Subobjects: Stationary, Mixing, Ergodic sequences ──"
#eval "StationarySequence, MixingSequence, MartingaleDifferenceSequence defined"
#eval "StrongMixingSequence with alpha-mixing coefficient defined"

end MiniIndependenceConvergence
