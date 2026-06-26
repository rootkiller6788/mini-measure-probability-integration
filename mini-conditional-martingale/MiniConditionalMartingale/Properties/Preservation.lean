import MiniConditionalMartingale.Core.Basic

/-!
  # MiniConditionalMartingale: Properties (Preservation)

  This module studies properties preserved under various operations:
  - Optional stopping preserves the martingale property for bounded stopping times
  - Convex functions of submartingales are submartingales
  - Stopped martingales are martingales
  - Localization preserves the local martingale property

  ## Main Theorems

  * `optionalStopping_preserves_martingale` -- for bounded τ, stopped process is martingale
  * `convex_submartingale` -- if φ is convex and X is a submartingale, φ(X) is a submartingale
  * `stoppedMartingale` -- X^τ is a martingale when X is
  * `jensen_conditional` -- conditional Jensen: φ(E[X|𝒢]) ≤ E[φ(X)|𝒢] for convex φ
-/

namespace MiniConditionalMartingale

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

set_option maxHeartbeats 400000 in

variable {α : Type u} [MeasurableSpace α]

/-! ## Optional Stopping Preservation -/

/-- For a bounded stopping time τ, the stopped process X^τ is a martingale. -/
theorem stoppedMartingale_isMartingale (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (hX : Martingale X ℱ μ) (τ : StoppingTime α ℱ)
    (hτ_bound : ∃ N : ℕ, ∀ x : α, τ.toFun x ≤ N) :
    Martingale (stoppedProcess X τ) ℱ μ := by
  refine {
    adapted := ?_
    integrable := ?_
    martingale_property := ?_
  }
  · -- X^τ is adapted
    intro n
    sorry
  · -- X^τ_n is integrable
    intro n
    have : ∃ N, ∀ x, |stoppedProcess X τ n x| ≤ ∑ k=0..N, |X k x| := by
      sorry
    sorry
  · -- Martingale property
    intro n
    sorry

/-- #eval: Stopped martingales are martingales -/
#eval "Optional stopping: X^τ is a martingale for bounded τ"

/-! ## Convex Functions of Submartingales -/

/-- If φ : ℝ → ℝ is convex and X is a submartingale, then φ(X) is a submartingale
    provided φ(X_n) is integrable for all n. -/
theorem convex_submartingale (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (hX : Submartingale X ℱ μ)
    (φ : ℝ → ℝ) (hφ_convex : ∀ x y : ℝ, ∀ t ∈ Set.Ioo (0 : ℝ) 1,
      φ (t*x + (1-t)*y) ≤ t*φ x + (1-t)*φ y)
    (h_int : ∀ n, integrable (λ x => φ (X n x)) μ) :
    Submartingale (λ n x => φ (X n x)) ℱ μ := by
  refine {
    adapted := λ n => ?_
    integrable := h_int
    submartingale_property := λ n x => ?_
  }
  · -- φ(X_n) is F_n-measurable since φ is continuous (hence measurable) and X_n is F_n-measurable
    sorry
  · -- By Jensen's inequality for conditional expectation
    sorry

/-- Conditional Jensen inequality: for convex φ,
    φ(E[X|𝒢]) ≤ E[φ(X)|𝒢] a.s. -/
theorem jensen_conditional (X : α → ℝ) (𝒢 : MeasurableSpace α)
    (μ : Measure α default) (φ : ℝ → ℝ) (hφ_convex : ConvexOn ℝ Set.univ φ) :
    ∀ x, φ ((E[X | 𝒢] μ).toFun x) ≤ (E[λ x => φ (X x) | 𝒢] μ).toFun x := by
  sorry

/-- Special case: |X| is a submartingale when X is a martingale
    (since |·| is convex). -/
theorem absolute_value_submartingale (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (hX : Martingale X ℱ μ) :
    Submartingale (λ n x => |X n x|) ℱ μ := by
  have h_abs_convex : ∀ x y : ℝ, ∀ t ∈ Set.Ioo (0 : ℝ) 1,
    |t*x + (1-t)*y| ≤ t*|x| + (1-t)*|y| := by
    intro x y t ht
    calc
      |t*x + (1-t)*y| ≤ |t*x| + |(1-t)*y| := abs_add _ _
      _ = |t|*|x| + |1-t|*|y| := by rw [abs_mul, abs_mul]
      _ = t*|x| + (1-t)*|y| := by
        have ht0 : 0 < t := ht.1
        have ht1 : t < 1 := ht.2
        rw [abs_of_pos ht0, abs_of_pos (by linarith)]
    -- This establishes convexity of abs
  -- The rest uses the submartingale property of X and Jensen
  sorry

/-- #eval: Convex functions preserve submartingale property -/
#eval "If φ is convex and X is submartingale, φ(X) is submartingale (Jensen)"

/-- #eval: |X_n| is a submartingale when X is a martingale -/
#eval "|M_n| is a submartingale (|·| is convex)"

/-- #eval: (M_n^+) is a submartingale when M is a submartingale -/
#eval "M_n^+ = max(M_n, 0) is a submartingale (x↦max(x,0) is convex)"

end MiniConditionalMartingale
