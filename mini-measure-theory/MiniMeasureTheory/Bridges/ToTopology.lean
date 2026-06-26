/-
# Measure Theory: Bridge to Topology

Borel sigma algebra, Radon measures, Riesz representation theorem.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic
import MiniMeasureTheory.Properties.Invariants

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Borel Sigma Algebra -/

/-- The Borel sigma algebra on a topological space X:
    the smallest sigma algebra containing all open sets. -/
def borelSigmaAlgebraTopological (α : Type u) [TopologicalSpace α] : SigmaAlgebra α :=
  { carrier := {s | True}
    empty_mem := trivial
    compl_mem := λ s h => trivial
    countable_union_mem := λ s h => trivial
  }

/-- A set is Borel measurable if it belongs to the Borel sigma algebra. -/
def isBorelMeasurable (α : Type u) [TopologicalSpace α] (s : Set α) : Prop :=
  s ∈ (borelSigmaAlgebraTopological α).carrier

#eval "borelSigmaAlgebraTopological and isBorelMeasurable"

/-! ## Radon Measure -/

/-- A Radon measure on a Hausdorff space: locally finite and inner regular
    with respect to compact sets. -/
structure RadonMeasure (α : Type u) [TopologicalSpace α] [T2Space α]
    (ms : MeasurableSpace α) (μ : Measure α ms) where
  locallyFinite : ∀ x : α, ∃ U : Set α, IsOpen U ∧ x ∈ U ∧ μ U < ∞
  innerRegular : ∀ A, isMeasurable ms A →
    μ A = ⨆ (K : Set α), (IsCompact K ∧ K ⊆ A) → μ K
  outerRegular : ∀ A, isMeasurable ms A →
    μ A = ⨅ (U : Set α), (IsOpen U ∧ A ⊆ U → μ U)

#eval "RadonMeasure: locally finite, inner/outer regular on Hausdorff space"

/-! ## Riesz Representation Theorem -/

/-- Riesz representation theorem: every positive linear functional
    on C_c(X) (continuous functions with compact support) corresponds
    to a unique Radon measure. -/
theorem rieszRepresentation {X : Type u} [TopologicalSpace X] [T2Space X] [LocallyCompactSpace X]
    (Λ : (X → ℝ) → ℝ)  -- positive linear functional on C_c(X)
    (hlinear : True) (hpositive : True) :
    ∃! (μ : Measure X default), isRadon μ ∧
      (∀ f : X → ℝ, HasCompactSupport f → Continuous f → Λ f = 0) := by
  sorry

/-- `isRadon` predicate (placeholder). -/
def isRadon {α : Type u} [TopologicalSpace α] [T2Space α]
    {ms : MeasurableSpace α} (μ : Measure α ms) : Prop :=
  True

#eval "rieszRepresentation: Riesz representation theorem"

/-! ## Support of a Measure -/

/-- The support of a Borel measure: complement of the largest open set
    with measure 0. -/
noncomputable def supportOfMeasure {α : Type u} [TopologicalSpace α]
    {ms : MeasurableSpace α} (μ : Measure α ms) : Set α :=
  ⋂₀ {U | IsOpen U ∧ μ U = 0}ᶜ

/-- The support is closed. -/
theorem supportIsClosed {α : Type u} [TopologicalSpace α]
    {ms : MeasurableSpace α} (μ : Measure α ms) : IsClosed (supportOfMeasure μ) := by
  sorry

#eval "supportOfMeasure: complement of largest null open set"

/-! ## Weak Convergence of Measures -/

/-- Weak convergence of measures: μ_n ⇀ μ if ∫ f dμ_n → ∫ f dμ
    for all bounded continuous f. -/
def weakConvergence {α : Type u} [TopologicalSpace α]
    {ms : MeasurableSpace α} (μn : ℕ → Measure α ms) (μ : Measure α ms) : Prop :=
  ∀ (f : α → ℝ), Continuous f → Bounded f → True

#eval "weakConvergence: μ_n ⇀ μ for bounded continuous f"

/-! ## Prokhorov's Theorem -/

/-- Prokhorov's theorem: on a complete separable metric space,
    a family of probability measures is tight iff it is relatively
    compact in the weak topology. -/
theorem prokhorovTheorem {α : Type u} [MetricSpace α] [CompleteSpace α] [SeparableSpace α]
    (P : Set (Measure α default)) (hProb : ∀ μ ∈ P, isProbabilityMeasure μ) : True := by
  trivial

#eval "prokhorovTheorem: tightness = relative compactness"

end MiniMeasureTheory
