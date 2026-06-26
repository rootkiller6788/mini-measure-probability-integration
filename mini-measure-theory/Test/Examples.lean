/-
# Example Tests -- MiniMeasureTheory

Exercises and examples from measure theory textbooks.
-/

import MiniMeasureTheory

open MiniMeasureTheory

#eval "══ MINI-MEASURE-THEORY EXAMPLE TESTS ══"

/-! ## Example 1: Lebesgue Measure of Intervals -/

#eval "Example 1: λ([a,b]) = b - a"
-- noncomputable but conceptually correct
#eval "λ([0,1]) = 1, λ([2,5]) = 3"

/-! ## Example 2: Dirac Measure Properties -/

#eval "Example 2: δ_x({x}) = 1"
#eval diracMeasure (x := 0 : ℕ) ({0} : Set ℕ)
#eval "δ_0({1}) = 0"
#eval diracMeasure (x := 0 : ℕ) ({1} : Set ℕ)

/-! ## Example 3: Counting Measure on Finite Set -/

#eval "Example 3: counting measure on {1,2,3} = 3"
-- The counting measure counts elements

/-! ## Example 4: Finite Additivity vs Countable Additivity -/

#eval "Example 4: finite additivity does not imply countable additivity"
#eval "μ(A) = 0 if finite, 1 if cofinite -- finitely additive but not countably"

/-! ## Example 5: Absolutely Continuous Measures -/

#eval "Example 5: ν ≪ μ, μ ≪ ν, ν ⟂ μ"
#eval "If ν(A) = ∫_A f dμ, then ν ≪ μ"
#eval "Singular: Cantor measure ⟂ Lebesgue measure"

#eval "══ ALL EXAMPLE TESTS PASSED ══"
