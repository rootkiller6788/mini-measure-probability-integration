import MiniConditionalMartingale.Core.Basic

/-!
  # MiniConditionalMartingale: Properties (Invariants)

  This module defines the key invariants of martingales:
  quadratic variation, predictable variation (angle bracket), and cross variation.

  ## Main Definitions

  * `quadraticVariation` -- [X]_n = Σ_{k=1}^n (X_k - X_{k-1})²
  * `predictableVariation` -- ⟨X⟩_n = Σ_{k=1}^n E[(X_k - X_{k-1})² | F_{k-1}]
  * `crossVariation` -- ⟨X,Y⟩_n = Σ_{k=1}^n E[(X_k - X_{k-1})(Y_k - Y_{k-1}) | F_{k-1}]
  * `angleBracket` -- ⟨X,Y⟩ = predictable covariation
  * `squareBracket` -- [X,Y] = quadratic covariation
-/

namespace MiniConditionalMartingale

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

set_option maxHeartbeats 400000 in

variable {α : Type u} [MeasurableSpace α]

/-! ## Quadratic Variation (Square Bracket) -/

/-- The quadratic variation [X]_n = Σ_{k=1}^n (X_k - X_{k-1})². -/
noncomputable def quadraticVariation (X : ℕ → α → ℝ) : ℕ → α → ℝ :=
  λ n x => match n with
  | 0 => 0
  | n'+1 => ∑ k in Finset.Icc 1 (n'+1), (X k x - X (k-1) x) ^ 2

/-- Notation for quadratic variation. -/
notation "[" X "]" => quadraticVariation X

/-- The quadratic covariation [X,Y]_n = Σ_{k=1}^n (X_k - X_{k-1})(Y_k - Y_{k-1}). -/
noncomputable def quadraticCovariation (X Y : ℕ → α → ℝ) : ℕ → α → ℝ :=
  λ n x => match n with
  | 0 => 0
  | n'+1 => ∑ k in Finset.Icc 1 (n'+1), (X k x - X (k-1) x) * (Y k x - Y (k-1) x)

/-- Notation for quadratic covariation. -/
notation "[" X "," Y "]" => quadraticCovariation X Y

/-! ## Predictable Variation (Angle Bracket) -/

/-- The predictable variation (angle bracket) ⟨X⟩_n for a square-integrable
    martingale X: ⟨X⟩_0 = 0, ⟨X⟩_n = Σ_{k=1}^n E[(ΔX_k)² | F_{k-1}]. -/
noncomputable def predictableVariation (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) : ℕ → α → ℝ :=
  λ n x => match n with
  | 0 => 0
  | n'+1 => ∑ k in Finset.Icc 1 (n'+1),
    (E[λ x => (X k x - X (k-1) x) ^ 2 | ℱ.sigmaAt (k-1)] μ).toFun x

/-- Notation for angle bracket (predictable variation). -/
notation "⟨" X "⟩" => predictableVariation X _ _

/-- The predictable covariation ⟨X,Y⟩_n. -/
noncomputable def predictableCovariation (X Y : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) : ℕ → α → ℝ :=
  λ n x => match n with
  | 0 => 0
  | n'+1 => ∑ k in Finset.Icc 1 (n'+1),
    (E[λ x => (X k x - X (k-1) x) * (Y k x - Y (k-1) x) | ℱ.sigmaAt (k-1)] μ).toFun x

/-- Notation for angle bracket covariation. -/
notation "⟨" X "," Y "⟩" => predictableCovariation X Y _ _

/-! ## Properties of Quadratic Variation -/

/-- For a martingale X with bounded increments, X_n² - [X]_n is a martingale. -/
theorem square_minus_quadratic_is_martingale (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (hX : Martingale X ℱ μ) :
    Martingale (λ n x => (X n x)^2 - [X] n x) ℱ μ := by
  sorry

/-- The Doob decomposition of a submartingale X_n²: X_n² = M_n + A_n
    where M is a martingale and A = [X] (for bounded martingales). -/
theorem doobDecomposition_square (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (hX : Martingale X ℱ μ)
    (h_bdd : ∃ M, ∀ n x, |X n x| ≤ M) :
    Martingale (λ n x => (X n x)^2 - [X] n x) ℱ μ := by
  sorry

/-- ⟨X⟩ is the compensator of [X]: [X]_n - ⟨X⟩_n is a martingale. -/
theorem angle_bracket_is_compensator (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (hX : Martingale X ℱ μ)
    (h_sq_int : ∀ n, integrable (λ x => (X n x)^2) μ) :
    Martingale (λ n x => [X] n x - ⟨X⟩ n x) ℱ μ := by
  sorry

/-- #eval: Quadratic variation sums squared increments -/
#eval "[X]_n = Σ_{k=1}^n (ΔX_k)² -- quadratic variation"

/-- #eval: For Brownian motion W, [W]_t = t and ⟨W⟩_t = t -/
#eval "[W]_t = t = ⟨W⟩_t for Brownian motion"

/-- #eval: Cross variation decomposition: [X+Y] = [X] + [Y] + 2[X,Y] -/
#eval "[X+Y]_n = [X]_n + [Y]_n + 2[X,Y]_n"

end MiniConditionalMartingale
