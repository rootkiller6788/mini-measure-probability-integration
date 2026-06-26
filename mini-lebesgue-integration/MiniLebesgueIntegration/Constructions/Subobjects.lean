import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic

/-!
  # MiniLebesgueIntegration: Constructions — Subobjects

  Important subspaces of L^p spaces:
  - L¹ ∩ L^∞ (intersection)
  - L¹ + L^∞ (sum)
  - Dense subspaces: C_c (compactly supported continuous), smooth functions, step functions
-/

namespace MiniLebesgueIntegration

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

variable {α : Type u} [MeasurableSpace α] {μ : Measure α}

/-- The intersection L¹ ∩ L^∞: functions that are both integrable and essentially bounded. -/
def L1InterLinfSpace (μ : Measure α) : Set (α → ℝ) :=
  {f | integrable f μ ∧ LinfNorm f μ < ∞}

/-- L¹ ∩ L^∞ embeds continuously into every L^p for 1 ≤ p ≤ ∞. -/
theorem L1InterLinf_in_Lp (f : α → ℝ) (p : ℝ) (hp : 1 ≤ p) (hpFin : p ≤ ∞)
    (hf : f ∈ L1InterLinfSpace μ) : isLp f p μ := by
  sorry

/-- The sum L¹ + L^∞: functions expressible as f₁ + f_∞ with f₁ ∈ L¹, f_∞ ∈ L^∞. -/
def L1PlusLinfSpace (μ : Measure α) : Set (α → ℝ) :=
  {f | ∃ (f1 f_inf : α → ℝ), integrable f1 μ ∧ LinfNorm f_inf μ < ∞ ∧ f = f1 + f_inf}

/-- L¹ + L^∞ contains all L^p for 1 ≤ p ≤ ∞. -/
theorem Lp_subset_L1PlusLinf (p : ℝ) (hp : 1 ≤ p) (hpFin : p ≤ ∞)
    (f : α → ℝ) (hf : isLp f p μ) : f ∈ L1PlusLinfSpace μ := by
  sorry

/-- Step functions (finite linear combinations of characteristic functions) are dense in L^p
    for 1 ≤ p < ∞. -/
theorem stepFunctions_dense_in_Lp (p : ℝ) (hp : 1 ≤ p) (hpFin : p < ∞)
    (μ : Measure α) [SigmaFinite μ] :
    Dense (λ f : α → ℝ => SimpleFunction α) (LpSpace α p μ) := by
  sorry

/-- Compactly supported continuous functions C_c(α) are dense in L^p(μ) for Radon measures
    and 1 ≤ p < ∞. -/
theorem compactlySupportedContinuous_dense_in_Lp (p : ℝ) (hp : 1 ≤ p) (hpFin : p < ∞)
    (μ : Measure α) [h : RegularMeasure μ] :
    Dense (λ f : α → ℝ => Continuous f ∧ HasCompactSupport f) (LpSpace α p μ) := by
  sorry

/-- Smooth functions C^∞_c are dense in L^p on ℝⁿ for 1 ≤ p < ∞. -/
theorem smoothFunctions_dense_in_Lp (p : ℝ) (hp : 1 ≤ p) (hpFin : p < ∞)
    (n : ℕ) (μ : Measure (Fin n → ℝ)) [h : IsLebesgueMeasure μ] :
    Dense (λ f : (Fin n → ℝ) → ℝ => ContDiff ℝ ⊤ f ∧ HasCompactSupport f)
      (LpSpace (Fin n → ℝ) p μ) := by
  sorry

/-- Simple functions are dense in L^p for 1 ≤ p < ∞ on σ-finite spaces. -/
structure SimpleFunctionDensity (p : ℝ) (μ : Measure α) where
  /-- For any L^p function and ε > 0, there exists a simple function within ε -/
  approx : ∀ (f : LpSpace α p μ) (ε : ℝ) (hε : 0 < ε),
    ∃ (s : SimpleFunction α),
    LpNorm (s.toFun - f.representative) p μ < ε

/-- #eval: L¹ ∩ L^∞ as important subspace -/
#eval "L¹ ∩ L^∞: functions with both integrability and essential boundedness"

/-- #eval: L¹ + L^∞ containing all L^p -/
#eval "L¹ + L^∞: all functions decomposable as integrable + bounded parts"

/-- #eval: Density results -/
#eval "C_c is dense in L^p (1 ≤ p < ∞) for Radon measures on locally compact Hausdorff spaces"

end MiniLebesgueIntegration
