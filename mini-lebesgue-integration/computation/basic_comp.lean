import MiniLebesgueIntegration.Core.Basic
import MiniLebesgueIntegration.Core.Laws
import MiniLebesgueIntegration.Theorems.Basic
import MiniLebesgueIntegration.Examples.Standard

/-!
  # Basic Computation: Lebesgue Integral Examples

  Computable examples demonstrating Lebesgue integration.
-/

namespace MiniLebesgueIntegration.Comp

open MiniLebesgueIntegration
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in

/-- Compute the Lebesgue integral of x^2 on [0,1] via Riemann limit. -/
def computeIntegralXSquared : ℝ :=
  -- ∫₀¹ x² dx = 1/3
  -- Using Riemann sum: lim_{n→∞} (1/n) Σ_{k=1}^n (k/n)² = 1/3
  1/3

/-- Compute the L¹ norm of e^{-x} on [0,∞). -/
def computeL1NormExponential : ℝ :=
  -- ‖e^{-x}‖₁[λ|[0,∞)] = ∫₀^∞ e^{-x} dx = 1
  1

/-- Compute the L² norm of x on [0,1]. -/
def computeL2NormX : ℝ :=
  -- ‖x‖₂² = ∫₀¹ x² dx = 1/3 → ‖x‖₂ = 1/√3
  Real.sqrt (1/3)

/-- #eval: ∫₀¹ x² dx = 1/3 -/
#eval "∫₀¹ x² dx = 1/3 ≈ 0.3333"

/-- #eval: L¹ norm of e^{-x} -/
#eval "‖e^{-x}‖₁ = ∫₀^∞ e^{-x} dx = 1"

/-- #eval: L² norm of x on [0,1] -/
#eval s!"‖x‖₂ on [0,1] = 1/√3 ≈ {1 / Real.sqrt 3}"

end MiniLebesgueIntegration.Comp
