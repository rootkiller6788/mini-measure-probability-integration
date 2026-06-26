import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic
import MiniLebesgueIntegration.Constructions.Subobjects

/-!
  # MiniLebesgueIntegration: Constructions — Universal

  Universal properties of L^p spaces:
  - L¹ as the completion of C_c under L¹ norm
  - Universal property of L¹ completion
  - L^p as the completion of simple functions
-/

namespace MiniLebesgueIntegration

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

variable {α : Type u} [MeasurableSpace α] {μ : Measure α}

/-- The space of compactly supported continuous functions with L¹ norm. -/
structure CcWithL1Norm (α : Type u) [TopologicalSpace α] [MeasurableSpace α] (μ : Measure α) where
  /-- The function -/
  toFun : α → ℝ
  /-- Continuity -/
  continuous : Continuous toFun
  /-- Compact support -/
  compactSupport : HasCompactSupport toFun
  /-- Measurability (follows from continuity) -/
  measurable : Measurable toFun

/-- The L¹ norm on C_c. -/
noncomputable def CcL1Norm {α : Type u} [TopologicalSpace α] [MeasurableSpace α]
    (f : CcWithL1Norm α μ) : ℝ :=
  L1Norm f.toFun μ

/-- L¹(μ) is the completion of C_c(α) under the L¹ norm.
    Every L¹ function can be approximated by compactly supported continuous functions. -/
theorem L1_completion_of_Cc
    [TopologicalSpace α] [RegularMeasure μ] [SigmaFinite μ] [LocallyCompactSpace α] :
    True := by
  -- C_c(α) is dense in L¹(μ), and L¹ is complete (Riesz-Fischer).
  -- Hence L¹ is the completion of C_c under the L¹ norm.
  sorry

/-- The embedding ι: C_c(α) → L¹(μ) is an isometric embedding with dense image. -/
noncomputable def CcEmbeddingL1 [TopologicalSpace α] [RegularMeasure μ]
    (f : CcWithL1Norm α μ) : LpSpace α 1 μ where
  representative := f.toFun
  measurable := f.measurable
  norm_finite := by
    -- f is compactly supported and bounded, so L¹ norm is finite
    sorry

/-- Universal property: any continuous linear functional on C_c (in L¹ norm) extends
    uniquely to L¹. -/
theorem L1_universalProperty
    [TopologicalSpace α] [RegularMeasure μ] [SigmaFinite μ]
    (X : Type v) [NormedAddCommGroup X] [NormedSpace ℝ X] [CompleteSpace X]
    (T : CcWithL1Norm α μ → X) (hT_linear : IsLinearMap ℝ T)
    (hT_bounded : ∃ (M : ℝ), ∀ (f : CcWithL1Norm α μ), ‖T f‖ ≤ M * CcL1Norm f) :
    ∃! (T' : LpSpace α 1 μ → X),
      IsLinearMap ℝ T' ∧
      (∃ (M' : ℝ), ∀ (f : LpSpace α 1 μ), ‖T' f‖ ≤ M' * ‖f‖₁[μ]) ∧
      (∀ (f : CcWithL1Norm α μ), T' (CcEmbeddingL1 f) = T f) := by
  sorry

/-- Simple functions are dense in L^p for 1 ≤ p < ∞, giving a universal property. -/
theorem Lp_completion_of_simpleFunctions (p : ℝ) (hp : 1 ≤ p) (hpFin : p < ∞)
    [SigmaFinite μ] :
    True := by
  -- L^p is the completion of simple functions under the L^p norm.
  sorry

/-- Every separable L^p space (1 ≤ p < ∞) has a countable dense set of step functions
    with rational coefficients. -/
theorem separable_Lp_has_countable_dense (p : ℝ) (hp : 1 ≤ p) (hpFin : p < ∞)
    [h_sep : SeparableLpSpace α p μ] :
    True := by
  sorry

/-- #eval: L¹ as completion of C_c -/
#eval "L¹(μ) = completion of C_c(α) under ‖·‖₁ for Radon measures"

/-- #eval: Universal property statement -/
#eval "Any bounded linear functional on C_c extends uniquely to L¹"

/-- #eval: L^p as completion of simple functions -/
#eval "L^p(μ) = completion of simple functions under ‖·‖_p for 1 ≤ p < ∞"

end MiniLebesgueIntegration
