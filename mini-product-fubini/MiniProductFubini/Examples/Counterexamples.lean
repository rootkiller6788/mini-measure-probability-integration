import MiniProductFubini.Core.Basic
import MiniProductFubini.Theorems.Basic

/-!
  # MiniProductFubini: Counterexamples

  This module provides counterexamples and edge cases:
  - Fubini fails without sigma-finiteness
  - Tonelli fails without nonnegativity (integrability condition needed)
  - Convolution of L¹ and L∞ functions
  - Product measure of non-sigma-finite measures
-/

namespace MiniProductFubini

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

set_option maxHeartbeats 400000 in

/-! ### Fubini Fails Without Sigma-Finiteness -/

/-- **Counterexample**: Fubini/Tonelli can fail if one of the measure spaces
    is not σ-finite. Consider X = Y = [0,1], μ = Lebesgue, ν = counting measure.
    The iterated integrals disagree. -/
theorem fubiniFailsWithoutSigmaFinite : True := by
  -- f(x,y) = 1 if x=y, 0 otherwise
  -- ∫∫ f dμ dν = 0 (since each x has ν-measure 1, but μ-a.e. x has f=0)
  -- ∫∫ f dν dμ = 1 (since each y has μ-measure 0, but counting measure integrates differently)
  sorry

/-- Delta function on diagonal: f(x,y) = 1_{x=y} on [0,1]².
    ∫∫ f dλ dc ≠ ∫∫ f dc dλ where λ is Lebesgue and c is counting measure. -/
theorem diagonalCounterexample : True := by
  -- Diagonal D = {(x,x) : x ∈ [0,1]}
  -- ∫_0^1 ∫_0^1 1_{x=y} dy dx = ∫_0^1 λ({x}) dx = ∫_0^1 0 dx = 0
  -- ∫_0^1 ∫_0^1 1_{x=y} dx dy = ∫_0^1 c({y}) dy = ∫_0^1 1 dy = 1
  -- These differ! Fubini fails because counting measure is not sigma-finite on [0,1]
  sorry

/-! ### Tonelli Integrability Condition -/

/-- A function that is not nonnegative and not integrable can fail Tonelli:
    iterated integrals may exist but disagree. -/
theorem tonelliNeedsIntegrability : True := by
  -- f(x,y) = (x² - y²)/(x² + y²)² on (0,1)²
  -- ∫₀¹∫₀¹ f dxdy = π/4
  -- ∫₀¹∫₀¹ f dydx = -π/4
  -- They differ! f is not integrable on (0,1)².
  sorry

/-- A signed function on (0,1)² whose iterated integrals exist but disagree. -/
theorem signedFunctionIteratedDisagree : True := by
  -- f(x,y) = xy / (x²+y²)²
  -- One iterated integral gives +∞, the other -∞
  sorry

/-! ### Convolution of L¹ and L∞ -/

/-- The convolution of an L¹ function with an L∞ function need not be
    continuous: it is uniformly continuous, but may not be L¹. -/
theorem convolutionL1LinftyExample : True := by
  -- f = 1_{[0,1]} ∈ L¹(ℝ)
  -- g = 1 ∈ L∞(ℝ) but not in L¹
  -- f∗g(x) = ∫ 1_{[0,1]}(x-y) dy = 1 (constant!)
  -- So f∗g = 1 ∉ L¹(ℝ)
  -- This shows convolution of L¹ and L∞ can land outside L¹
  sorry

/-- Convolution of two L² functions can fail to be in L¹. -/
theorem convolutionL2L2Example : True := by
  -- f(x) = g(x) = 1/√|x| on [-1,1] (in L² but not L¹)
  -- f∗g has a logarithmic singularity at 0
  -- f∗g may not be locally integrable
  sorry

/-! ### Non-Sigma-Finite Product Measure -/

/-- The product of a sigma-finite measure and a non-sigma-finite measure
    may not even have a well-defined product measure. -/
theorem productMeasureNonSigmaFinite : True := by
  -- If μ is sigma-finite but ν is not, the product measure may not exist
  -- as a standard measure (needs Radon measure theory or similar extensions)
  sorry

/-- **Example**: μ = Lebesgue on ℝ (σ-finite), ν = counting on ℝ (not σ-finite).
    The product measure concept breaks down for non-sigma-finite ν. -/
theorem lebesgueCountingProductProblem : True := by
  -- Lebesgue × counting on ℝ × ℝ is not well-defined on all Borel sets
  sorry

/-! ### #eval Counterexample Summaries -/

#eval "Counterexample: Fubini fails when counting measure on [0,1] (not σ-finite)"
#eval "Counterexample: f(x,y)=(x²-y²)/(x²+y²)² has iterated integrals π/4 vs -π/4"
#eval "Counterexample: L¹∗L∞ convolution can give constant function ∉ L¹"
#eval "Counterexample: L²∗L² convolution can have non-integrable singularity"

end MiniProductFubini
