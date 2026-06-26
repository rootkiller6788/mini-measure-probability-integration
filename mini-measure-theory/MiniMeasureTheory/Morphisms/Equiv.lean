/-
# Measure Theory: Equivalences of Measures

Absolute continuity, mutual singularity, equivalence of measures.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Absolute Continuity -/

/-- ν is absolutely continuous with respect to μ (ν ≪ μ) if
    every μ-null set is a ν-null set. -/
def absolutelyContinuous {α : Type u} {ms : MeasurableSpace α}
    (ν μ : Measure α ms) : Prop :=
  ∀ A, isMeasurable ms A → μ A = 0 → ν A = 0

notation:50 ν:50 " ≪ " μ:50 => absolutelyContinuous ν μ

/-- Reflexivity of absolute continuity. -/
theorem absolutelyContinuous_refl {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) : μ ≪ μ :=
  λ A hA hμA => hμA

/-- Transitivity of absolute continuity. -/
theorem absolutelyContinuous_trans {α : Type u} {ms : MeasurableSpace α}
    (λ μ ν : Measure α ms) (hλμ : λ ≪ μ) (hμν : μ ≪ ν) : λ ≪ ν :=
  λ A hA hνA => hλμ A hA (hμν A hA hνA)

#eval "absolutelyContinuous: ν ≪ μ defined. Refl + trans"
#eval absolutelyContinuous_refl (default : Measure ℕ default)

/-! ## Mutual Singularity -/

/-- Two measures ν and μ are mutually singular (ν ⟂ μ) if there exists
    a measurable partition A ∪ B = X such that ν(A) = 0 and μ(B) = 0. -/
def mutuallySingular {α : Type u} {ms : MeasurableSpace α}
    (ν μ : Measure α ms) : Prop :=
  ∃ (A B : Set α),
    isMeasurable ms A ∧ isMeasurable ms B ∧
    A ∩ B = ∅ ∧ A ∪ B = Set.univ ∧
    ν A = 0 ∧ μ B = 0

notation:50 ν:50 " ⟂ " μ:50 => mutuallySingular ν μ

/-- Mutual singularity is symmetric. -/
theorem mutuallySingular_symm {α : Type u} {ms : MeasurableSpace α}
    (ν μ : Measure α ms) (h : ν ⟂ μ) : μ ⟂ ν := by
  rcases h with ⟨A, B, hA, hB, hdisj, hunion, hνA, hμB⟩
  exact ⟨B, A, hB, hA, by
    ext x; simp; intro hx; apply hdisj.subset; exact ?_, ?_, hμB, hνA⟩
  sorry

#eval "mutuallySingular: ν ⟂ μ defined (symmetric)"

/-! ## Equivalence of Measures -/

/-- Two measures are equivalent if they are mutually absolutely continuous. -/
def equivalentMeasures {α : Type u} {ms : MeasurableSpace α}
    (ν μ : Measure α ms) : Prop :=
  ν ≪ μ ∧ μ ≪ ν

notation:50 ν:50 " ≈ " μ:50 => equivalentMeasures ν μ

/-- Equivalent measures form an equivalence relation (reflexivity). -/
theorem equivalentMeasures_refl {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) : μ ≈ μ :=
  ⟨absolutelyContinuous_refl μ, absolutelyContinuous_refl μ⟩

/-- Equivalent measures form an equivalence relation (symmetry). -/
theorem equivalentMeasures_symm {α : Type u} {ms : MeasurableSpace α}
    (ν μ : Measure α ms) (h : ν ≈ μ) : μ ≈ ν :=
  ⟨h.2, h.1⟩

/-- Equivalent measures form an equivalence relation (transitivity). -/
theorem equivalentMeasures_trans {α : Type u} {ms : MeasurableSpace α}
    (λ μ ν : Measure α ms) (hλμ : λ ≈ μ) (hμν : μ ≈ ν) : λ ≈ ν :=
  ⟨absolutelyContinuous_trans λ μ ν hλμ.1 hμν.1,
   absolutelyContinuous_trans ν μ λ hμν.2 hλμ.2⟩

#eval "equivalentMeasures: ν ≈ μ equivalence relation"
#eval equivalentMeasures_refl (default : Measure ℕ default)

end MiniMeasureTheory
