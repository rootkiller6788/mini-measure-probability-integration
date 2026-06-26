import MiniConditionalMartingale.Core.Basic

/-!
  # MiniConditionalMartingale: Constructions (Subobjects)

  This module studies important subclasses of martingales:
  bounded martingales, L^p martingales, and uniformly integrable martingales.

  ## Main Definitions

  * `boundedMartingale` -- martingale with uniformly bounded increments
  * `LpMartingale` -- martingale with finite L^p norm for all n
  * `uniformlyIntegrableMartingale` -- the family {X_n} is uniformly integrable
  * `closedMartingale` -- martingale of the form X_n = E[Y | F_n] for some Y
-/

namespace MiniConditionalMartingale

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

set_option maxHeartbeats 400000 in

variable {α : Type u} [MeasurableSpace α]

/-! ## Bounded Martingale -/

/-- A martingale is bounded if ∃ M such that |X_n(ω)| ≤ M for all n, ω. -/
def boundedMartingale (X : ℕ → α → ℝ) (ℱ : Filtration α) (μ : Measure α default) : Prop :=
  Martingale X ℱ μ ∧ ∃ M : ℝ, ∀ n x, |X n x| ≤ M

/-- Bounded martingales converge almost surely. -/
theorem boundedMartingale_converges (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (h : boundedMartingale X ℱ μ) :
    ∃ X_∞ : α → ℝ, ∀ᵉ x, ?_ := by
  sorry

/-! ## L^p Martingale -/

/-- A martingale is L^p-bounded (1 < p < ∞) if sup_n ‖X_n‖_p < ∞. -/
def LpMartingale (X : ℕ → α → ℝ) (ℱ : Filtration α) (μ : Measure α default)
    (p : ℝ) (hp : 1 < p) : Prop :=
  Martingale X ℱ μ ∧ ∃ C : ℝ, ∀ n, ‖X n‖p[μ] ≤ C

/-- L^p-bounded martingales (p > 1) converge in L^p. -/
theorem LpMartingale_converges_in_Lp (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (p : ℝ) (hp : 1 < p) (h : LpMartingale X ℱ μ p hp) :
    ∃ X_∞ : α → ℝ, lim n → ∞, ‖X n - X_∞‖p[μ] = 0 := by
  sorry

/-! ## Uniformly Integrable Martingale -/

/-- A family {X_n} is uniformly integrable if
    sup_n E[|X_n| · 1_{|X_n| > M}] → 0 as M → ∞. -/
def uniformlyIntegrable (X : ℕ → α → ℝ) (μ : Measure α default) : Prop :=
  ∀ ε > 0, ∃ M : ℝ, ∀ n, ∫ (λ x => |X n x| * (if |X n x| > M then 1 else 0)) d μ < ε

/-- A uniformly integrable martingale is exactly a closed martingale:
    X_n = E[Y | F_n] for some integrable Y. -/
theorem ui_martingale_is_closed (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (h : Martingale X ℱ μ) (h_ui : uniformlyIntegrable X μ) :
    ∃ Y : α → ℝ, integrable Y μ ∧ ∀ n x, X n x = (E[Y | ℱ.sigmaAt n] μ).toFun x := by
  sorry

/-- A uniformly integrable martingale converges a.s. and in L^1. -/
theorem ui_martingale_converges (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (h : Martingale X ℱ μ) (h_ui : uniformlyIntegrable X μ) :
    ∃ X_∞ : α → ℝ,
      integrable X_∞ μ ∧
      (∀ᵉ x, lim n → ∞, X n x = X_∞ x) ∧
      (lim n → ∞, ‖X n - X_∞‖₁[μ] = 0) := by
  sorry

/-- #eval: Bounded martingale condition: |X_n| ≤ M for all n a.s. -/
#eval "Bounded martingale: |X_n| ≤ 10 for all n is bounded"

/-- #eval: L^2-bounded martingales converge in L^2 -/
#eval "L^2 martingale: sup_n E[X_n²] < ∞ ⟹ X_n → X_∞ in L^2"

/-- #eval: Uniform integrability is the key condition for L^1 convergence -/
#eval "UI martingale: X_n = E[Y|F_n] ⟹ X_n → X_∞ a.s. and in L^1"

end MiniConditionalMartingale
