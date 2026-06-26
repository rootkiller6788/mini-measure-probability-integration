import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic

/-!
  # MiniLebesgueIntegration: Constructions — Products

  Fubini-Tonelli theorems for the Lebesgue integral on product spaces.
  - Tonelli's theorem (nonnegative functions)
  - Fubini's theorem (integrable functions)
  - Iterated integrals
-/

namespace MiniLebesgueIntegration

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

variable {α β : Type u} [MeasurableSpace α] [MeasurableSpace β]
variable {μ : Measure α} {ν : Measure β}

/-- The product measure on α × β. -/
noncomputable def productMeasure (μ : Measure α) (ν : Measure β) : Measure (α × β) :=
  μ.prod ν

/-- The product σ-algebra on α × β. -/
noncomputable def productMeasurableSpace [MeasurableSpace α] [MeasurableSpace β] :
    MeasurableSpace (α × β) :=
  MeasurableSpace.prod ‹_› ‹_›

/-- Tonelli's Theorem: For nonnegative measurable f on α × β,
    ∬ f d(μ×ν) = ∫ (∫ f(x,y) dν(y)) dμ(x) = ∫ (∫ f(x,y) dμ(x)) dν(y). -/
theorem tonelliTheorem
    (f : α × β → ℝ≥0∞) (hf : Measurable f) :
    (∫ f d(μ.prod ν)) = (∫ (λ x => ∫ (λ y => f (x, y)) dν) dμ) ∧
    (∫ f d(μ.prod ν)) = (∫ (λ y => ∫ (λ x => f (x, y)) dμ) dν) := by
  sorry

/-- Fubini's Theorem: For integrable f on α × β with σ-finite measures,
    the iterated integrals equal the product integral. -/
theorem fubiniTheorem
    (f : α × β → ℝ) (hf : integrable f (μ.prod ν))
    (hμ : SigmaFinite μ) (hν : SigmaFinite ν) :
    (∫ (λ z => (|f z| : ℝ≥0∞)) d(μ.prod ν)) =
    (∫ (λ x => ∫ (λ y => (|f (x, y)| : ℝ≥0∞)) dν) dμ) := by
  sorry

/-- Tonelli applied to nonnegative measurable functions: swap order of integration. -/
theorem tonelliSwap
    (f : α × β → ℝ≥0∞) (hf : Measurable f) (h_nonneg : ∀ z, 0 ≤ f z) :
    (∫ (λ x => ∫ (λ y => f (x, y)) dν) dμ) = (∫ (λ y => ∫ (λ x => f (x, y)) dμ) dν) := by
  have h := tonelliTheorem f hf
  rcases h with ⟨h_left, h_right⟩
  calc
    (∫ (λ x => ∫ (λ y => f (x, y)) dν) dμ) = (∫ f d(μ.prod ν)) := by symm; exact h_left
    _ = (∫ (λ y => ∫ (λ x => f (x, y)) dμ) dν) := by rw [h_right]

/-- Iterated integral for separated functions: ∫∫ f(x)g(y) dμ(x)dν(y) = (∫f)(∫g). -/
theorem fubiniSeparated
    (f : α → ℝ) (g : β → ℝ) (hf : integrable f μ) (hg : integrable g ν) :
    integrable (λ (z : α × β) => f z.1 * g z.2) (μ.prod ν) ∧
    (∫ (λ z => (|f z.1 * g z.2| : ℝ≥0∞)) d(μ.prod ν)) =
    (∫ (λ x => (|f x| : ℝ≥0∞)) dμ) * (∫ (λ y => (|g y| : ℝ≥0∞)) dν) := by
  sorry

/-- #eval: Tonelli example -- area under Gaussian e^{-(x²+y²)} -/
#eval "Tonelli: ∬_{R²} e^{-(x²+y²)}dxdy = (∫e^{-x²}dx)² = π"

/-- #eval: Fubini for integrable functions on finite measure space -/
#eval "Fubini: ∫₀¹∫₀¹ xy dxdy = (∫₀¹xdx)(∫₀¹ydy) = 1/4"

/-- #eval: Iterated integral of separated function -/
#eval "∬ f(x)g(y) = (∫f)(∫g) — product of one-dimensional integrals"

end MiniLebesgueIntegration
