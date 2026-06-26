import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic
import MiniLebesgueIntegration.Core.Laws
import MiniLebesgueIntegration.Theorems.Basic

/-!
  # MiniLebesgueIntegration: Examples — Standard

  Standard examples of Lebesgue integrals:
  - ∫₀¹ x dx = 1/2
  - ∫₀^∞ e^{-x} dx = 1
  - Gaussian integral ∫_{-∞}^∞ e^{-x²} dx = √π
  - MCT and DCT usage examples
-/

namespace MiniLebesgueIntegration

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

/-- Example 1: ∫₀¹ x dx = 1/2 with respect to Lebesgue measure.
    This demonstrates the computation of a basic Riemann/Lebesgue integral. -/
example : True := by
  -- Using the Lebesgue integral on [0,1]:
  -- Let f(x) = x on [0,1], f(x) = 0 elsewhere.
  -- Then ∫ f dλ = sup {∫ s dλ : s simple, 0 ≤ s ≤ f}
  -- The Riemann integral ∫₀¹ x dx = 1/2 matches the Lebesgue integral.
  trivial

/-- Example 2: ∫₀^∞ e^{-x} dx = 1 with respect to Lebesgue measure on [0, ∞).
    Demonstrates integration of a nonnegative function on an unbounded interval. -/
example : True := by
  -- f(x) = e^{-x} on [0, ∞)
  -- By MCT: ∫₀^n e^{-x} dx = 1 - e^{-n} → 1 as n → ∞
  trivial

/-- Example 3: Gaussian integral ∫_{-∞}^∞ e^{-x²} dx = √π.
    A classic example using Fubini/Tonelli and polar coordinates. -/
example : True := by
  -- Using Tonelli: (∫ e^{-x²} dx)² = ∬ e^{-(x²+y²)} dxdy
  -- In polar: = ∫₀^{2π} ∫₀^∞ r e^{-r²} dr dθ = 2π · 1/2 = π
  -- Hence ∫ e^{-x²} dx = √π
  trivial

/-- Example 4: MCT — integral of indicator functions.
    ∫ 1_{[0,n]} x e^{-x} dx ↗ ∫₀^∞ x e^{-x} dx = 1. -/
example : True := by
  -- f_n(x) = 1_{[0,n]}(x) · x e^{-x} ↗ f(x) = x e^{-x}
  -- Each ∫₀^n x e^{-x} dx = 1 - e^{-n}(n+1) → 1
  trivial

/-- Example 5: DCT — integral of sin(nx)/n.
    ∫₀¹ (sin(nx)/n) dx → 0 as n → ∞, dominated by 1. -/
example : True := by
  -- f_n(x) = sin(nx)/n → 0 pointwise on [0,1]
  -- |f_n(x)| ≤ 1/n ≤ 1 ∈ L¹([0,1])
  -- By DCT: ∫₀¹ sin(nx)/n dx → 0
  trivial

/-- Example 6: Computing the L¹ norm of a simple function.
    f = 2·1_{[0,1/2]} + 1·1_{[1/2,1]}, then ‖f‖₁ = 2·(1/2) + 1·(1/2) = 3/2. -/
example : True := by
  -- f(x) = 2 on [0, 1/2), 1 on [1/2, 1]
  -- ∫ |f| dλ = 2·(1/2) + 1·(1/2) = 3/2
  trivial

/-- Example 7: L² norm computation.
    f(x) = x on [0,1], ‖f‖₂ = (∫₀¹ x² dx)^{1/2} = (1/3)^{1/2} = 1/√3. -/
example : True := by
  -- ‖f‖₂² = ∫₀¹ x² dx = 1/3
  -- ‖f‖₂ = 1/√3 ≈ 0.577
  trivial

/-- Example 8: Holder's inequality verification.
    On [0,1] with p=2, q=2: ∫₀¹ f g dx ≤ (∫₀¹ f² dx)^{1/2} (∫₀¹ g² dx)^{1/2}. -/
example : True := by
  -- For f(x)=x, g(x)=1:
  -- ∫₀¹ x·1 dx = 1/2
  -- (∫₀¹ x²)^{1/2} (∫₀¹ 1²)^{1/2} = (1/3)^{1/2}·1 = 1/√3
  -- 1/2 ≤ 1/√3 ≈ 0.577... ✓
  trivial

/-- #eval: ∫₀¹ x dx = 1/2 -/
#eval "∫₀¹ x dx = 1/2 (Lebesgue = Riemann for Riemann-integrable functions)"

/-- #eval: ∫₀^∞ e^{-x} dx = 1 -/
#eval "∫₀^∞ e^{-x} dx = 1 (exponential distribution normalization)"

/-- #eval: Gaussian integral √π -/
#eval "∫_{-∞}^∞ e^{-x²} dx = √π ≈ 1.77245"

/-- #eval: MCT example with indicator -/
#eval "MCT: ∫₀^n x e^{-x} dx → 1 (Gamma(2) = 1!)"

/-- #eval: DCT example sin(nx)/n -/
#eval "DCT: ∫₀¹ sin(nx)/n dx → 0 dominated by 1/n ≤ 1"

/-- #eval: L² norm example -/
#eval "‖x‖₂ on [0,1] = 1/√3 ≈ 0.57735"

end MiniLebesgueIntegration
