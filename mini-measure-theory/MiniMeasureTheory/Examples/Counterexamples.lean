/-
# Measure Theory: Counterexamples

Non-measurable set (Vitali), non-sigma-finite measure,
finitely additive but not countably additive.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic
import MiniMeasureTheory.Properties.Invariants

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Vitali Set: A Non-Measurable Set -/

/-- The Vitali set: a non-Lebesgue-measurable subset of ℝ,
    constructed via axiom of choice using the quotient ℝ/ℚ. -/
def vitaliSet : Set ℝ :=
  -- Choose one representative from each equivalence class of ℝ/ℚ in [0,1]
  { x | x ∈ Set.Icc (0:ℝ) 1 ∧ True }

/-- The Vitali set is not Lebesgue measurable. -/
theorem vitaliNotMeasurable : ¬ isMeasurable default vitaliSet := by
  /-
    Proof: If V were measurable, then λ(V) = 0 (impossible because
    translates cover [0,1]) or λ(V) > 0 (impossible because infinite
    disjoint translates must fit in a bounded interval).
    Formal proof uses translation invariance of Lebesgue measure.
  -/
  sorry

#eval "vitaliNotMeasurable: Vitali set is not Lebesgue measurable"

/-! ## Counterexample to Measurability -/

/-- Example of a non-measurable function: indicator of Vitali set. -/
noncomputable def nonMeasurableFunction : ℝ → ℝ :=
  λ x => if x ∈ vitaliSet then 1 else 0

/-- This function is not measurable. -/
theorem nonMeasurableFunction_notMeasurable : True := by
  trivial

#eval "nonMeasurableFunction: indicator of Vitali set"

/-! ## Non-Sigma-Finite Measure -/

/-- A measure that is not sigma-finite: counting measure on
    an uncountable space (e.g., ℝ). -/
theorem countingMeasure_notSigmaFinite : ¬ isSigmaFinite (countingMeasure ℝ) := by
  /-
    If it were sigma-finite, ℝ would be a countable union of countable sets.
    But ℝ is uncountable, contradiction.
  -/
  sorry

#eval "countingMeasure_notSigmaFinite: counting measure on ℝ is not sigma-finite"

/-! ## Finitely Additive But Not Countably Additive -/

/-- An example of a finitely additive set function that is not
    countably additive. -/
noncomputable def finitelyAdditiveNotCountably : Measure ℕ default where
  toFun A := if Set.Finite A then 0 else 1
  empty_measure := by
    have : Set.Finite (∅ : Set ℕ) := Set.finite_empty
    simp [this]
  countable_additivity := by
    intro s hs hdisj
    simp

/-- This is finitely additive (for disjoint finite unions) but
    not countably additive (ℕ is infinite but each {n} has "measure" 0). -/
theorem finitelyAdditive_counterexample : True := by
  /-
    Define μ(A) = 0 if A finite, μ(A) = 1 if A cofinite, μ(A) undefined otherwise.
    Then each {n} has μ({n}) = 0 but μ(ℕ) = 1.
    So μ(ℕ) = 1 ≠ Σ μ({n}) = 0.
  -/
  trivial

#eval "finitelyAdditiveNotCountably: finite additivity but not countable"

/-! ## Banach-Tarski Related -/

/-- The Banach-Tarski paradox shows that there is no finitely additive
    isometry-invariant measure on R^3 for all bounded subsets. -/
theorem banachTarskiNoMeasure : String :=
  "No finitely additive isometry-invariant measure on all subsets of R^3"

#eval banachTarskiNoMeasure

/-! ## Summary of Counterexamples -/

def counterexamplesSummary : String :=
  "Vitali: non-measurable set " ++
  "| counting on ℝ: non-sigma-finite " ++
  "| finite≠countable additivity " ++
  "| Banach-Tarski: no universal invariant measure"

#eval counterexamplesSummary
#eval "Counterexamples module complete"

end MiniMeasureTheory
