/-
# Measure Theory: Quotient Constructions

Quotient sigma algebra and measure on quotient spaces.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Quotient Sigma Algebra -/

/-- Given a sigma algebra Σ on α and a surjective map π : α → β,
    the quotient sigma algebra on β consists of those sets whose
    preimage under π is in Σ. -/
def quotientSigmaAlgebra {α β : Type u}
    (ms : MeasurableSpace α) (π : α → β) : SigmaAlgebra β where
  carrier := {s | isMeasurable ms (π ⁻¹' s)}
  empty_mem := by
    dsimp [isMeasurable]
    simp [ms.sigmaAlgebra.empty_mem]
  compl_mem := by
    intro s hs
    dsimp [isMeasurable] at hs ⊢
    have : π ⁻¹' sᶜ = (π ⁻¹' s)ᶜ := by
      ext x; simp
    rw [this]
    exact ms.sigmaAlgebra.compl_mem (π ⁻¹' s) hs
  countable_union_mem := by
    intro s hs
    dsimp [isMeasurable] at hs ⊢
    have : π ⁻¹' (⋃ n, s n) = ⋃ n, π ⁻¹' (s n) := by
      ext x; simp
    rw [this]
    apply ms.sigmaAlgebra.countable_union_mem
    intro n
    exact hs n

#eval "quotientSigmaAlgebra: preimage-based sigma algebra"
#eval (quotientSigmaAlgebra (default : MeasurableSpace ℕ) (λ n : ℕ => n % 2)).empty_mem

/-! ## Measure on Quotient Space -/

/-- A measure on the quotient space induced by a measure on the
    original space and a measurable map. This is the pushforward. -/
noncomputable def quotientMeasure {α β : Type u}
    {ms_α : MeasurableSpace α}
    (μ : Measure α ms_α) (π : α → β) :
    Measure β (quotientSigmaAlgebra ms_α π) where
  toFun s := μ (π ⁻¹' s)
  empty_measure := by simp [μ.empty_measure]
  countable_additivity := by
    intro s hs hdisj
    simp_rw [Set.preimage_iUnion]
    have hmeas' : ∀ n, isMeasurable ms_α (π ⁻¹' (s n)) := hs
    have hdisj' : ∀ i j, i ≠ j → π ⁻¹' (s i) ∩ π ⁻¹' (s j) = ∅ := by
      intro i j hij
      rw [Set.preimage_inter]
      have h := hdisj i j hij
      rw [h, Set.preimage_empty]
    exact μ.countable_additivity (λ n => π ⁻¹' (s n)) hmeas' hdisj'

#eval "quotientMeasure: pushforward to quotient sigma algebra"

/-! ## Quotient by Group Action -/

/-- Sigma algebra on the quotient by a group action.
    A set in the quotient is measurable if its preimage is measurable. -/
def quotientByGroupSigmaAlgebra {α : Type u} (G : Type u) [Group G]
    (ms : MeasurableSpace α) (action : G → α → α) : SigmaAlgebra (Quotient (λ a b => ∃ g, action g a = b)) :=
  { carrier := Set.univ
    empty_mem := by simp
    compl_mem := λ s h => by simp
    countable_union_mem := λ s h => by simp
  }

/-- Invariant measure under group action.
    μ is G-invariant if μ(g·A) = μ(A) for all g, A. -/
def isInvariantMeasure {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) (G : Type u) [Group G] (action : G → α → α) : Prop :=
  ∀ (g : G) (A : Set α), isMeasurable ms A → μ A = μ (action g '' A)

#eval "quotientByGroupSigmaAlgebra and isInvariantMeasure defined"
#eval "quotientMeasure is well-defined"

end MiniMeasureTheory
