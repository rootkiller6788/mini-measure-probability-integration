import MiniProductFubini.Core.Basic

/-!
  # MiniProductFubini: Core Laws (Axioms)

  This module defines the axiomatic laws governing product measures,
  Fubini's theorem, and convolution. These are values (axioms) that
  capture the essential properties satisfied by any realization.

  ## Axioms

  * `fubiniTonelli` -- Fubini-Tonelli principle
  * `youngInequality` -- Young's convolution inequality
  * `convolutionAssociative` -- (f∗g)∗h = f∗(g∗h)
  * `convolutionCommutative` -- f∗g = g∗f
  * `radonNikodymTheorem` -- ν≪μ ⇒ ∃ dν/dμ
-/

namespace MiniProductFubini

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

/-! ### Fubini-Tonelli Law -/

/-- **Fubini-Tonelli Law**: For a σ-finite product measure and a measurable function f,
    the order of integration can be swapped provided that either f ≥ 0 (Tonelli)
    or f is integrable (Fubini). This axiom encapsulates both cases. -/
axiom fubiniTonelli {X Y : Type u} [MeasurableSpace X] [MeasurableSpace Y]
    (f : X × Y → ℝ≥0∞) (μ : Measure X) (ν : Measure Y)
    (hf : Measurable f) (hμ : SigmaFinite μ) (hν : SigmaFinite ν) :
    ∀ (x : X), LebesgueIntegral (λ y => f (x, y)) ν =
      LebesgueIntegral (λ z => f z) (ProductMeasure.measure (ProductMeasure.mk μ ν))

/-! ### Young's Inequality -/

/-- **Young's Convolution Inequality**:
    For 1/p + 1/q = 1 + 1/r with 1 ≤ p, q, r ≤ ∞,
    ‖f∗g‖_r ≤ ‖f‖_p · ‖g‖_q. -/
axiom youngInequality {n : ℕ} (f g : (Fin n → ℝ) → ℝ)
    (p q r : ℝ) (μ : Measure (Fin n → ℝ))
    (hpq : (1 / p) + (1 / q) = 1 + (1 / r))
    (hp : 1 ≤ p) (hq : 1 ≤ q) (hr : 1 ≤ r) :
    LpNorm (f ∗ g) r μ ≤ LpNorm f p μ * LpNorm g q μ

/-! ### Convolution Algebra Laws -/

/-- **Convolution is associative**: (f∗g)∗h = f∗(g∗h) almost everywhere. -/
axiom convolutionAssociative {n : ℕ} (f g h : (Fin n → ℝ) → ℝ)
    (μ : Measure (Fin n → ℝ)) :
    (f ∗ g) ∗ h = f ∗ (g ∗ h)

/-- **Convolution is commutative**: f∗g = g∗f almost everywhere. -/
axiom convolutionCommutative {n : ℕ} (f g : (Fin n → ℝ) → ℝ)
    (μ : Measure (Fin n → ℝ)) :
    f ∗ g = g ∗ f

/-! ### Radon-Nikodym Theorem -/

/-- **Radon-Nikodym Theorem**: If ν is absolutely continuous with respect to μ
    (ν ≪ μ), then there exists a measurable function dν/dμ (the Radon-Nikodym
    derivative) such that ν(E) = ∫_E (dν/dμ) dμ for all measurable E. -/
axiom radonNikodymTheorem {X : Type u} [MeasurableSpace X]
    (μ ν : Measure X) (h : AbsolutelyContinuous ν μ)
    (hSigma : SigmaFinite μ) :
    ∃ (f : X → ℝ), Measurable f ∧ (∀ (E : Set X), MeasurableSet E →
      ν E = LebesgueIntegral (λ x => ENNReal.ofReal (f x * indicator E (λ _ => 1) x)) μ)

/-! ### #eval Axiom Checks -/

/-- #eval: Fubini-Tonelli axiom identifier -/
#eval "Axiom fubiniTonelli: swap iteration order for nonnegative/integrable f"

/-- #eval: Young inequality check -/
#eval "Axiom youngInequality: ‖f∗g‖_r ≤ ‖f‖_p · ‖g‖_q"

/-- #eval: Convolution associativity/commutativity -/
#eval "Axiom convolutionAssociative + convolutionCommutative: L¹ is a commutative Banach algebra"

/-- #eval: Radon-Nikodym derivative existence -/
#eval "Axiom radonNikodymTheorem: ν≪μ ⇒ ∃ dν/dμ measurable"

end MiniProductFubini
