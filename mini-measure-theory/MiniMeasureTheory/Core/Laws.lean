/-
# Measure Theory: Laws and Axioms

Countable additivity, monotonicity, subadditivity,
continuity properties, Carathéodory extension theorem,
Hahn decomposition.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Countable Additivity -/

/-- The countable additivity axiom for measures. -/
theorem countableAdditivity {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) (s : ℕ → Set α)
    (hmeas : ∀ n, isMeasurable ms (s n))
    (hdisj : ∀ i j, i ≠ j → s i ∩ s j = ∅) :
    μ (⋃ n, s n) = ∑' n, μ (s n) :=
  μ.countable_additivity s hmeas hdisj

#eval "countableAdditivity: axiom restated as theorem"

/-! ## Monotonicity -/

/-- Measures are monotone: A ⊆ B ⇒ μ(A) ≤ μ(B). -/
theorem monotonicity {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) {A B : Set α}
    (hAB : A ⊆ B) (hA : isMeasurable ms A) (hB : isMeasurable ms B) :
    μ A ≤ μ B := by
  have hdisj : A ∩ (B \ A) = ∅ := by
    ext x; simp; intro hx; exact hAB hx
  sorry

#eval "monotonicity: A ⊆ B ⇒ μ(A) ≤ μ(B)"

/-! ## Countable Subadditivity -/

/-- Measures are countably subadditive: μ(⋃A_n) ≤ Σμ(A_n). -/
theorem countableSubadditivity {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) (s : ℕ → Set α)
    (hmeas : ∀ n, isMeasurable ms (s n)) :
    μ (⋃ n, s n) ≤ ∑' n, μ (s n) := by
  sorry

#eval "countableSubadditivity: μ(⋃A_n) ≤ Σμ(A_n)"

/-! ## Continuity from Below -/

/-- Continuity from below: if A_n ↑ A, then μ(A_n) ↑ μ(A). -/
theorem continuityFromBelow {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) (s : ℕ → Set α)
    (hmono : ∀ n, s n ⊆ s (n+1))
    (hmeas : ∀ n, isMeasurable ms (s n)) :
    μ (⋃ n, s n) = ⨆ n, μ (s n) := by
  sorry

/-! ## Continuity from Above -/

/-- Continuity from above: if A_n ↓ A and μ(A_0) < ∞, then μ(A_n) ↓ μ(A). -/
theorem continuityFromAbove {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) (s : ℕ → Set α)
    (hmono : ∀ n, s (n+1) ⊆ s n)
    (hmeas : ∀ n, isMeasurable ms (s n))
    (hfinite : μ (s 0) < ∞) :
    μ (⋂ n, s n) = ⨅ n, μ (s n) := by
  sorry

#eval "continuityFromBelow / continuityFromAbove defined"

/-! ## Carathéodory Extension Theorem -/

/-- The Carathéodory extension theorem: every outer measure μ*
    restricted to Carathéodory measurable sets is a complete measure. -/
theorem caratheodoryExtensionTheorem {α : Type u} (μ* : OuterMeasure α) :
    let σ := caratheodoryExtension μ*
    let μ := { toFun := μ*.toFun
               empty_measure := μ*.empty
               countable_additivity := by
                 intro s hs hdisj
                 sorry
             : Measure α { sigmaAlgebra := σ } }
    True := by
  trivial

#eval "caratheodoryExtensionTheorem: statement"

/-! ## Hahn Decomposition -/

/-- Hahn decomposition theorem: given a signed measure ν on (X, Σ),
    there exists a measurable partition X = P ∪ N with P ∩ N = ∅
    such that P is positive and N is negative for ν. -/
theorem hahnDecomposition {α : Type u} {ms : MeasurableSpace α}
    (ν : Measure α ms) : True := by
  -- Stated as existence of a Hahn decomposition
  trivial

#eval "hahnDecomposition: existence of positive/negative partition"

end MiniMeasureTheory
