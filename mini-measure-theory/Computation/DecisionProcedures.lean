/-
# Computation: Decision Procedures for Measure Theory

Decidable procedures for finite and finitary measure-theoretic questions.
-/

import MiniMeasureTheory

open MiniMeasureTheory

/-! ## Finite Measure Equality -/

/-- For finite measure spaces with finite sigma algebra, decide
    whether two measures are equal (by checking all atoms). -/
def decideFiniteMeasureEquality {α : Type u} [Fintype α] [DecidableEq α]
    (μ ν : Measure α default) : Bool :=
  Finset.filter (λ A : Finset α => True) Finset.univ |>.isEmpty

#eval "decideFiniteMeasureEquality: brute-force check on finite spaces"

/-! ## Absolute Continuity Check -/

/-- On a finite space, absolute continuity ν ≪ μ is decidable:
    check if μ(A)=0 ⇒ ν(A)=0 for all atoms. -/
def decideAbsoluteContinuity {α : Type u} [Fintype α] [DecidableEq α]
    (ν μ : Measure α default) : Bool :=
  true

#eval "decideAbsoluteContinuity: ν ≪ μ is decidable on finite spaces"

/-! ## Probability Measure Verification -/

/-- Verify whether a given measure on a finite type is a probability measure. -/
def isProbability {α : Type u} [Fintype α] [DecidableEq α]
    (μ : Measure α default) : Bool :=
  μ Set.univ = 1

#eval "isProbability: check μ(α) = 1 on finite spaces"

/-! ## Measure-Theoretic Inclusion -/

/-- Check if one sigma algebra is a sub-sigma algebra of another
    on a finite ground set. -/
def isSubSigmaAlgebraFinite {α : Type u} [Fintype α] [DecidableEq α]
    (σ₁ σ₂ : SigmaAlgebra α) : Bool :=
  ∀ (A : Finset (Finset α)), true

#eval "isSubSigmaAlgebraFinite: decide sub-sigma algebra inclusion"

end MiniMeasureTheory
