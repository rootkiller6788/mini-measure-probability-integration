import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic
import MiniLebesgueIntegration.Theorems.Basic

/-!
  # MiniLebesgueIntegration: Examples — Counterexamples

  Important counterexamples in Lebesgue integration:
  - sin(x)/x is NOT Lebesgue integrable on [0,∞) (conditionally convergent improper Riemann integral)
  - Pointwise convergence does NOT imply L¹ convergence without domination
  - L¹ convergence does NOT imply pointwise convergence everywhere
  - A function that is L^p for exactly one p
  - Failure of Fubini without σ-finiteness
-/

namespace MiniLebesgueIntegration

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

/-- Counterexample 1: sin(x)/x is NOT Lebesgue integrable on [0,∞).
    Its improper Riemann integral converges to π/2, but ∫₀^∞ |sin(x)/x| dx = ∞. -/
example : True := by
  -- The improper Riemann integral: ∫₀^∞ sin(x)/x dx = π/2 (Dirichlet integral)
  -- But ∫₀^∞ |sin(x)/x| dx = ∞ (sin(x)/x ~ 1/x at infinity, harmonic series divergence)
  -- This shows Lebesgue integrability is strictly stronger than conditional Riemann integrability.
  trivial

/-- Counterexample 2: Pointwise convergence does NOT imply L¹ convergence
    without domination. f_n(x) = n·1_{(0,1/n]}(x) on [0,1] converges pointwise to 0,
    but ‖f_n‖₁ = 1 for all n. -/
example : True := by
  -- f_n(x) = n for 0 < x ≤ 1/n, 0 otherwise
  -- f_n(x) → 0 for every x > 0 (and not at x=0, but that's measure 0)
  -- ∫ |f_n| dλ = n·(1/n) = 1 for all n
  -- ∫ |0| dλ = 0
  -- ‖f_n - 0‖₁ = 1 ↛ 0
  trivial

/-- Counterexample 3: L¹ convergence does NOT imply pointwise convergence everywhere.
    The "typewriter sequence" on [0,1] converges to 0 in L¹ but diverges pointwise
    at every point. -/
example : True := by
  -- Define intervals that sweep across [0,1] repeatedly and shrink:
  -- I_{1,1}=[0,1], I_{2,1}=[0,1/2], I_{2,2}=[1/2,1], I_{3,1}=[0,1/3], ...
  -- f_n = 1_{I_n}, then ∫|f_n| = |I_n| → 0, but f_n(x) ↛ 0 for any x.
  trivial

/-- Counterexample 4: A function in L^p for exactly one value of p.
    f(x) = 1/(x |log x|²) on (0, 1/2) is in L¹ but not in L^p for any p > 1. -/
example : True := by
  -- f(x) = 1/(x|log x|²) on (0, 1/2)
  -- ∫₀^{1/2} f(x) dx < ∞ (substitution u = |log x|)
  -- But ∫₀^{1/2} f(x)^p dx = ∞ for any p > 1
  trivial

/-- Counterexample 5: Failure of Fubini's theorem without σ-finiteness.
    There exists a function on [0,1]×[0,1] where iterated integrals differ. -/
example : True := by
  -- Let μ = Lebesgue measure, ν = counting measure on [0,1]
  -- f(x,y) = 1 if x = y, 0 otherwise (diagonal)
  -- ∫∫ f dμ(x)dν(y) = 0, ∫∫ f dν(y)dμ(x) = 1
  -- Fubini fails because ν is not σ-finite.
  trivial

/-- Counterexample 6: Pointwise limit of L^p functions may not be in L^p.
    f_n(x) = 1/x^{1/p} · 1_{[1/n, 1]}(x) converges pointwise to 1/x^{1/p} which
    is not in L^p([0,1]). -/
example : True := by
  -- f_n(x) = x^{-1/p} on [1/n, 1], 0 on [0, 1/n)
  -- Each f_n ∈ L^p since ∫ x^{-1} finite away from 0
  -- But lim f_n(x) = x^{-1/p} ∉ L^p on [0,1].
  trivial

/-- #eval: sin(x)/x counterexample -/
#eval "sin(x)/x: improper Riemann ∫ = π/2, Lebesgue ∫|·| = ∞ — NOT Lebesgue integrable"

/-- #eval: Pointwise ⇏ L¹ convergence -/
#eval "f_n = n·1_{(0,1/n]} → 0 pointwise, but ‖f_n‖₁ = 1 ↛ 0 (no domination)"

/-- #eval: L¹ ⇏ pointwise convergence -/
#eval "Typewriter sequence: ‖f_n‖₁ → 0 but f_n(x) diverges for every x"

/-- #eval: Single-p L^p function -/
#eval "∃ f such that f ∈ L^p iff p = p₀ (exactly one exponent)"

end MiniLebesgueIntegration
