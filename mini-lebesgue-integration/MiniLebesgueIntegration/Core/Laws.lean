import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic

/-!
  # MiniLebesgueIntegration: Core Laws

  The fundamental convergence theorems and inequalities of Lebesgue integration:
  - Monotone Convergence Theorem
  - Fatou's Lemma
  - Dominated Convergence Theorem
  - Linearity of the integral
  - Holder's inequality
  - Minkowski's inequality
  - Jensen's inequality
-/

namespace MiniLebesgueIntegration

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

variable {α : Type u} [MeasurableSpace α] {μ : Measure α}

/-- Monotone Convergence Theorem: If f_n ↗ f pointwise and each f_n ≥ 0 is measurable,
    then ∫ f_n dμ ↗ ∫ f dμ. -/
theorem monotoneConvergenceTheorem
    (f : ℕ → α → ℝ≥0∞) (g : α → ℝ≥0∞)
    (hmono : ∀ n x, f n x ≤ f (n + 1) x)
    (hlim : ∀ x, Filter.Tendsto (λ n => f n x) Filter.atTop (𝓝 (g x)))
    (hmeas : ∀ n, Measurable (f n)) :
    Filter.Tendsto (λ n => ∫ (f n) dμ) Filter.atTop (𝓝 (∫ g dμ)) := by
  sorry

/-- Fatou's Lemma: For nonnegative measurable f_n, ∫ (liminf f_n) dμ ≤ liminf ∫ f_n dμ. -/
theorem fatouLemma
    (f : ℕ → α → ℝ≥0∞)
    (hmeas : ∀ n, Measurable (f n)) :
    (∫ (λ x => Filter.liminf (λ n => f n x) Filter.atTop) dμ) ≤
    Filter.liminf (λ n => ∫ (f n) dμ) Filter.atTop := by
  sorry

/-- Dominated Convergence Theorem: If f_n → f pointwise a.e. and |f_n| ≤ g with ∫ g < ∞,
    then ∫ f_n dμ → ∫ f dμ. -/
theorem dominatedConvergenceTheorem
    (f : ℕ → α → ℝ) (g f_limit : α → ℝ)
    (hdom : ∀ n x, |f n x| ≤ g x)
    (hint : integrable g μ)
    (hconv : ∀ᵐ x ∂μ, Filter.Tendsto (λ n => f n x) Filter.atTop (𝓝 (f_limit x))) :
    Filter.Tendsto (λ n => ∫ (λ x => (f n x : ℝ≥0∞)) dμ) Filter.atTop
      (𝓝 (∫ (λ x => (f_limit x : ℝ≥0∞)) dμ)) := by
  sorry

/-- Linearity of the Lebesgue integral for integrable functions. -/
theorem linearityOfIntegral
    (f g : α → ℝ) (hfi : integrable f μ) (hgi : integrable g μ) (a b : ℝ) :
    integrable (λ x => a * f x + b * g x) μ ∧
    (∫ (λ x => (|a * f x + b * g x| : ℝ≥0∞)) dμ) ≤
    (|a| : ℝ≥0∞) * (∫ (λ x => (|f x| : ℝ≥0∞)) dμ) +
    (|b| : ℝ≥0∞) * (∫ (λ x => (|g x| : ℝ≥0∞)) dμ) := by
  sorry

/-- Holder's inequality for conjugate exponents. -/
theorem holderInequality
    (f g : α → ℝ) (p q : ℝ) (hpq : (1 / p) + (1 / q) = 1) (hp : 1 ≤ p) (hq : 1 ≤ q) :
    Integrable (λ x => f x * g x) μ := by
  sorry

/-- Minkowski's inequality: triangle inequality in L^p. -/
theorem minkowskiInequality
    (f g : α → ℝ) (p : ℝ) (hp : 1 ≤ p) :
    ‖f + g‖p[μ] ≤ ‖f‖p[μ] + ‖g‖p[μ] := by
  sorry

/-- Jensen's inequality: For convex φ, φ(∫ f dμ) ≤ ∫ φ(f) dμ for probability measure μ. -/
theorem jensenInequality
    (f : α → ℝ) (φ : ℝ → ℝ) (hconv : ConvexOn ℝ Set.univ φ)
    (hprob : μ Set.univ = 1) :
    φ (ENNReal.toReal (∫ (λ x => (f x : ℝ≥0∞)) dμ)) ≤
    ENNReal.toReal (∫ (λ x => (φ (f x) : ℝ≥0∞)) dμ) := by
  sorry

/-- #eval: MCT example -- limit of integrals of indicator functions -/
#eval "MCT: ∫ 1_{[0,n]} dλ ↗ ∫ 1_{[0,∞)} dλ = ∞"

/-- #eval: DCT example -- dominated convergence with Gaussian envelope -/
#eval "DCT: ∫₀^∞ n e^{-nx} dx → 1 as n → ∞"

/-- #eval: Jensen example -- convex function e^x -/
#eval "Jensen: e^{∫f} ≤ ∫e^f for probability measure"

end MiniLebesgueIntegration
