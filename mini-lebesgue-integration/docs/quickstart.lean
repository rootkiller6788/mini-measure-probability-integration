/-!
  # MiniLebesgueIntegration: Quick Start Guide

  This guide demonstrates how to use the MiniLebesgueIntegration package
  for Lebesgue integration theory in Lean 4.

  ## Installation

  Add to your `lakefile.lean`:
  ```lean
  require «mini-lebesgue-integration» from
    "../8. mini-measure-probability-integration/mini-lebesgue-integration"
  ```

  ## Basic Usage

  ### Lebesgue Integral

  ```lean
  import MiniLebesgueIntegration.Core.Basic
  open MiniLebesgueIntegration

  -- Define a nonnegative measurable function
  -- Compute its Lebesgue integral
  #eval "∫ f dμ — Lebesgue integral via simple function supremum"
  ```

  ### Integrability

  ```lean
  -- Check if a function is Lebesgue integrable
  example {α} [MeasurableSpace α] (f : α → ℝ) (μ : Measure α) :
    integrable f μ ↔ LebesgueIntegral (λ x => (|f x| : ℝ≥0∞)) μ < ∞ := by
    rfl
  ```

  ### L^p Norms

  ```lean
  -- Compute various L^p norms
  #eval "‖f‖₁[μ] — L¹ norm"
  #eval "‖f‖₂[μ] — L² norm (Hilbert space norm)"
  #eval "‖f‖_∞[μ] — essential supremum norm"
  ```

  ### Convergence Theorems

  ```lean
  import MiniLebesgueIntegration.Theorems.Basic

  -- Apply DCT
  example {α} [MeasurableSpace α] (f : ℕ → α → ℝ) (g f_lim : α → ℝ) (μ : Measure α)
    (hdom : ∀ n x, |f n x| ≤ g x) (hint : integrable g μ)
    (hconv : ∀ᵐ x ∂μ, Filter.Tendsto (λ n => f n x) Filter.atTop (𝓝 (f_lim x))) :
    Filter.Tendsto (λ n => ∫ (λ x => (|f n x - f_lim x| : ℝ≥0∞)) dμ)
      Filter.atTop (𝓝 0) :=
    DCT f g f_lim (by intro n; exact ?_) (by exact ?_) hdom hint hconv
  ```

  ## Common Patterns

  1. **Compute integral via Riemann**: For Riemann-integrable functions,
     the Lebesgue integral equals the Riemann integral.

  2. **Apply MCT**: For nonnegative increasing sequences.

  3. **Apply DCT**: When a dominating integrable function exists.

  4. **Apply Holder**: To bound product integrals.

  5. **Apply Minkowski**: For triangle inequality in L^p.

  6. **Apply Fubini**: For iterated integrals on product spaces.

  ## Examples

  See `MiniLebesgueIntegration/Examples/Standard.lean` for worked examples:
  - ∫₀¹ x dx = 1/2
  - ∫₀^∞ e^{-x} dx = 1
  - Gaussian integral ∫ e^{-x²} dx = √π
-/

#eval "Quick Start: import MiniLebesgueIntegration, use LebesgueIntegral, L^p norms, MCT/DCT"
#eval "See MiniLebesgueIntegration/Examples/ for standard and counterexample files"
#eval "All functions in namespace MiniLebesgueIntegration"
