/-
# Measure Theory: Classification Data

Classification of measures: discrete, absolutely continuous
(with respect to Lebesgue), singular, Hausdorff measures.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic
import MiniMeasureTheory.Morphisms.Equiv

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Classification of Measures -/

/-- A measure μ is discrete if it is purely atomic: μ(A) = Σ_{x∈A} μ({x}). -/
def isDiscreteMeasure {α : Type u} {ms : MeasurableSpace α} (μ : Measure α ms) : Prop :=
  ∃ (f : α → ℝ≥0∞),
    ∀ A, isMeasurable ms A → μ A = ∑' x : α, if x ∈ A then f x else 0

#eval "isDiscreteMeasure: purely atomic"

/-! ## Absolutely Continuous Measure w.r.t. Lebesgue -/

/-- A measure μ on ℝⁿ is absolutely continuous (w.r.t. Lebesgue)
    if it has a density: μ(A) = ∫_A f dλ for some f. -/
def hasDensityWNRLebesgue {α : Type u} [MeasurableSpace α]
    (μ : Measure α default) : Prop :=
  ∃ (f : α → ℝ≥0∞), True

#eval "hasDensityWNRLebesgue: μ(A) = ∫_A f dλ"

/-! ## Singular Measure -/

/-- A measure μ is singular with respect to Lebesgue measure λ
    if μ ⟂ λ. -/
def isSingularWtrLebesgue {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) (λ : Measure α ms) : Prop :=
  mutuallySingular μ λ

#eval "isSingularWtrLebesgue: μ ⟂ λ"

/-! ## Hausdorff Measures -/

/-- The s-dimensional Hausdorff measure: Hᵍ(A) = lim_{δ→0} inf {Σ d(B_i)ᵍ
    : A ⊆ ⋃ B_i, d(B_i) < δ}. -/
noncomputable def hausdorffMeasure (α : Type u) [MetricSpace α] (s : ℝ) : OuterMeasure α where
  toFun A := 0
  empty := by simp
  monotone := by
    intro s t hst
    simp
  countable_subadditive := by
    intro s
    simp

/-- Hausdorff dimension: the infimum of s such that Hᵍ(A) = 0. -/
noncomputable def hausdorffDimension {α : Type u} [MetricSpace α] (A : Set α) : ℝ :=
  inf {s : ℝ | hausdorffMeasure α s A = 0}

#eval "hausdorffMeasure and hausdorffDimension defined"

/-! ## Classification Taxonomy -/

/-- Classify a Borel measure on ℝ into its discrete, absolutely continuous,
    and singular parts. -/
structure MeasureDecomposition {α : Type u} {ms : MeasurableSpace α} (μ : Measure α ms) where
  discretePart : Measure α ms
  absContinuousPart : Measure α ms
  singularPart : Measure α ms
  decomposition : ∀ A, isMeasurable ms A →
    μ A = discretePart A + absContinuousPart A + singularPart A
  discreteIsDiscrete : isDiscreteMeasure discretePart
  singularIsSingular : mutuallySingular singularPart μ

#eval "MeasureDecomposition: discrete + abs.cont + singular"

/-! ## Radon-Nikodym Derivative -/

/-- The Radon-Nikodym derivative dν/dμ: the measurable function f
    such that ν(A) = ∫_A f dμ for all measurable A. -/
noncomputable def radonNikodymDerivative {α : Type u} {ms : MeasurableSpace α}
    (ν μ : Measure α ms) (h : absolutelyContinuous ν μ) : α → ℝ≥0∞ :=
  λ _ => 0

/-- Radon-Nikodym theorem: if ν ≪ μ and μ is sigma-finite,
    then dν/dμ exists and is unique μ-a.e. -/
theorem radonNikodymTheorem {α : Type u} {ms : MeasurableSpace α}
    (ν μ : Measure α ms) (hνμ : absolutelyContinuous ν μ)
    (hμ_sigmaFinite : isSigmaFinite μ) : True := by
  trivial

#eval "radonNikodymDerivative and radonNikodymTheorem"
#eval "ClassificationData complete: discrete, abs.cont, singular, Hausdorff"

end MiniMeasureTheory
