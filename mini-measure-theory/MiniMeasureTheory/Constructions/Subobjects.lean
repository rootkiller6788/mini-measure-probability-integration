/-
# Measure Theory: Subobject Constructions

Sub-sigma algebra, trace measure μ|_A, restricted measure.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Sub-Sigma Algebra -/

/-- A sub-sigma algebra: a sigma algebra Σ' ⊆ Σ on the same space. -/
structure SubSigmaAlgebra (α : Type u) (ms : MeasurableSpace α) where
  carrier : Set (Set α)
  sigmaAlgebra : SigmaAlgebra α
  sub : sigmaAlgebra.carrier ⊆ ms.sigmaAlgebra.carrier
  empty_mem : ∅ ∈ sigmaAlgebra.carrier := by
    have := sigmaAlgebra.empty_mem; exact this
  compl_mem : ∀ s, s ∈ sigmaAlgebra.carrier → (∅ : Set α)ᶜ ∩ sᶜ ∈ sigmaAlgebra.carrier :=
    λ s h => sigmaAlgebra.compl_mem s h
  countable_union_mem : ∀ (s : ℕ → Set α), (∀ n, s n ∈ sigmaAlgebra.carrier) → (⋃ n, s n) ∈ sigmaAlgebra.carrier :=
    λ s h => sigmaAlgebra.countable_union_mem s h

#eval "SubSigmaAlgebra: sub-sigma algebra defined"

/-! ## Trace Measure -/

/-- The trace measure μ|_A of μ on a measurable set A:
    (μ|_A)(B) = μ(B ∩ A) for measurable B. -/
noncomputable def traceMeasure {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) (A : Set α) (hA : isMeasurable ms A) : Measure α ms where
  toFun B := μ (B ∩ A)
  empty_measure := by simp [μ.empty_measure]
  countable_additivity := by
    intro s hs hdisj
    have h_union : (⋃ n, s n) ∩ A = ⋃ n, (s n ∩ A) := by
      ext x; simp
    rw [h_union]
    have hdisj' : ∀ i j, i ≠ j → (s i ∩ A) ∩ (s j ∩ A) = ∅ := by
      intro i j hij
      ext x; simp
      intro hx1 hx2A hx1j hx2A'
      have h := hdisj i j hij
      have : x ∈ s i ∩ s j := ⟨hx1, hx1j⟩
      rw [h] at this
      exact this
    exact μ.countable_additivity (λ n => s n ∩ A) (λ n => by
      -- need to show measurable
      sorry
    ) hdisj'

#eval "traceMeasure: μ restricted to A (μ|_A)"

/-! ## Restricted Measure -/

/-- Restrict a measure to a sub-sigma algebra. -/
noncomputable def restrictToSigmaAlgebra {α : Type u}
    {ms : MeasurableSpace α} (μ : Measure α ms)
    (sub : SubSigmaAlgebra α ms) : Measure α { sigmaAlgebra := sub.sigmaAlgebra } where
  toFun s := μ s
  empty_measure := μ.empty_measure
  countable_additivity := by
    intro s hs hdisj
    apply μ.countable_additivity s
    · intro n
      apply sub.sub
      exact hs n
    · exact hdisj

#eval "restrictToSigmaAlgebra: restrict measure to sub-sigma algebra"

/-! ## Measurable Subset Measure -/

/-- Given a measurable subset A ⊆ α, the entire measure restricted to A
    as a measure on A (viewed as its own type). -/
noncomputable def onMeasurableSubset {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) (A : Set α) (hA : isMeasurable ms A) :
    Measure A { sigmaAlgebra := by
      -- define the trace sigma algebra on subtype A
      exact {
        carrier := { (s : Set A) | isMeasurable ms (Subtype.val '' s) }
        empty_mem := by
          have : Subtype.val '' (∅ : Set A) = ∅ := by simp
          rw [this]
          exact ms.sigmaAlgebra.empty_mem
        compl_mem := by
          intro s hs
          sorry
        countable_union_mem := by
          intro s hs
          sorry
      }
    } where
  toFun s := μ (Subtype.val '' s)
  empty_measure := by simp [μ.empty_measure]
  countable_additivity := by
    intro s hs hdisj
    sorry

#eval "onMeasurableSubset: measure on the subtype A"
#eval "restrictToSigmaAlgebra is well-defined"

end MiniMeasureTheory
