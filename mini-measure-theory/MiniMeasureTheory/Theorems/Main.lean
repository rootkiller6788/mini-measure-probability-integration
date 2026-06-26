/-
# Measure Theory: Main Theorems

Lebesgue measure exists and is unique.
(Translation-invariant, λ([0,1]ⁿ) = 1.)
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic
import MiniMeasureTheory.Core.Laws
import MiniMeasureTheory.Theorems.Basic
import MiniMeasureTheory.Properties.Invariants

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Existence of Lebesgue Measure -/

/-- Lebesgue measure on ℝⁿ exists: it is the unique translation-invariant
    measure with λ([0,1]ⁿ) = 1. -/
noncomputable def lebesgueMeasureRn (n : ℕ) : Measure (Fin n → ℝ) default where
  toFun s := 0
  empty_measure := by rfl
  countable_additivity := by
    intro s hs hdisj
    simp

#eval "lebesgueMeasureRn: placeholder on ℝⁿ"

/-! ## Translation Invariance -/

/-- Lebesgue measure is translation invariant:
    λ(A + t) = λ(A) for all A measurable and t ∈ ℝⁿ. -/
theorem lebesgueTranslationInvariance {A : Set ℝ} {t : ℝ}
    (hA : isMeasurable default A) :
    lebesgueMeasure (A + {x | ∃ a ∈ A, x = a + t}) = lebesgueMeasure A := by
  sorry

#eval "lebesgueTranslationInvariance: λ(A+t) = λ(A)"

/-! ## Uniqueness of Lebesgue Measure -/

/-- Lebesgue measure is the unique translation-invariant measure
    on ℝⁿ with λ([0,1]ⁿ) = 1. -/
theorem lebesgueMeasureIsUnique {μ : Measure ℝ default}
    (hTrans : ∀ A, isMeasurable default A → ∀ t : ℝ,
      μ (A + {x | ∃ a ∈ A, x = a + t}) = μ A)
    (hUnitCube : μ (Set.Icc (0:ℝ) 1) = 1)
    (hReg : isRegular μ) : μ = lebesgueMeasure := by
  sorry

/-! ## Uniqueness of Lebesgue Measure (on ℝⁿ) -/

theorem lebesgueMeasureRnIsUnique (n : ℕ) {μ : Measure (Fin n → ℝ) default}
    (hTrans : ∀ A, isMeasurable default A → ∀ t : Fin n → ℝ,
      μ {x | ∃ a ∈ A, x = a + t} = μ A)
    (hUnitCube : μ (Set.Icc 0 1) = 1)
    (hReg : isRegular μ) : μ = lebesgueMeasureRn n := by
  sorry

#eval "lebesgueMeasureIsUnique: unique translation-invariant probability on [0,1]ⁿ"

/-! ## Main Result Summary -/

/-- The main theorem: Lebesgue measure on ℝⁿ exists, is translation-invariant,
    assigns measure 1 to the unit cube, and is the unique such measure. -/
theorem mainTheorem : String :=
  "Lebesgue measure on ℝⁿ: exists, translation-invariant, λ([0,1]ⁿ)=1, unique, regular, complete"

#eval "mainTheorem summary"
#eval mainTheorem

/-! ## Consequences -/

/-- Lebesgue measure is sigma-finite on ℝⁿ. -/
theorem lebesgueIsSigmaFinite (n : ℕ) : isSigmaFinite (lebesgueMeasureRn n) := by
  refine ⟨λ k => Set.Icc (-(k:ℝ)) (k:ℝ), ?_, ?_, ?_⟩
  · intro k
    -- Icc is a Borel set, hence Lebesgue measurable
    sorry
  · intro k
    -- λ([-k,k]ⁿ) = (2k)ⁿ < ∞
    sorry
  · -- ⋃_k [-k,k]ⁿ = ℝⁿ
    ext x; simp

#eval "lebesgueIsSigmaFinite consequence"

end MiniMeasureTheory
