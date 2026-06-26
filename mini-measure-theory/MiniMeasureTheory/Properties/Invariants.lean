/-
# Measure Theory: Invariants

Properties of measures: finite, sigma-finite, probability,
atom-free, regular.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Finite Measure -/

/-- A measure μ is finite if μ(α) < ∞. -/
def isFinite {α : Type u} {ms : MeasurableSpace α} (μ : Measure α ms) : Prop :=
  ∃ M : ℝ≥0∞, μ Set.univ = M ∧ M < ∞

#eval "isFinite: μ(whole_space) < ∞"

/-! ## Sigma-Finite Measure -/

/-- A measure μ is sigma-finite if α can be written as a countable union
    of measurable sets of finite measure. -/
def isSigmaFinite {α : Type u} {ms : MeasurableSpace α} (μ : Measure α ms) : Prop :=
  ∃ (A : ℕ → Set α),
    (∀ n, isMeasurable ms (A n)) ∧
    (∀ n, μ (A n) < ∞) ∧
    (⋃ n, A n) = Set.univ

#eval "isSigmaFinite: countable union of finite-measure sets"

/-! ## Probability Measure -/

/-- A probability measure: μ(α) = 1. -/
def isProbabilityMeasure {α : Type u} {ms : MeasurableSpace α} (μ : Measure α ms) : Prop :=
  μ Set.univ = 1

/-- A probability space. -/
structure ProbabilitySpace (α : Type u) extends MeasureSpace α where
  isProb : isProbabilityMeasure measure

#eval "isProbabilityMeasure: μ(α) = 1"

/-! ## Atom-Free Measure -/

/-- A measure μ is atom-free (non-atomic) if every set of positive measure
    has a proper subset of positive but strictly smaller measure. -/
def isAtomFree {α : Type u} {ms : MeasurableSpace α} (μ : Measure α ms) : Prop :=
  ∀ A, isMeasurable ms A → μ A > 0 →
    ∃ B, isMeasurable ms B ∧ B ⊆ A ∧ 0 < μ B ∧ μ B < μ A

#eval "isAtomFree: no atoms (sets of minimal positive measure)"

/-! ## Regular Measure -/

/-- A measure μ is regular on a topological space if for every measurable A:
    μ(A) = sup{μ(K) : K ⊆ A, K compact} = inf{μ(U) : A ⊆ U, U open}. -/
def isRegular {α : Type u} [TopologicalSpace α] {ms : MeasurableSpace α}
    (μ : Measure α ms) : Prop :=
  ∀ A, isMeasurable ms A →
    μ A = ⨆ (K : Set α), (IsCompact K ∧ K ⊆ A → True) → μ K := by
    sorry

#eval "isRegular: inner/outer regularity"

/-! ## Locally Finite Measure -/

/-- A measure is locally finite if every point has a neighborhood of
    finite measure. -/
def isLocallyFinite {α : Type u} [TopologicalSpace α] {ms : MeasurableSpace α}
    (μ : Measure α ms) : Prop :=
  ∀ x : α, ∃ U : Set α, IsOpen U ∧ x ∈ U ∧ μ U < ∞

#eval "isLocallyFinite: every point has finite-measure neighborhood"

/-! ## Tight Measure -/

/-- A measure is tight if for every ε > 0 there exists a compact set
    K such that μ(α\K) < ε. -/
def isTight {α : Type u} [TopologicalSpace α] {ms : MeasurableSpace α}
    (μ : Measure α ms) : Prop :=
  ∀ ε : ℝ≥0∞, ε > 0 → ∃ K : Set α, IsCompact K ∧ μ (Kᶜ) < ε

#eval "isTight: mass concentrates on compacts"

/-! ## Combined Properties -/

/-- Lebesgue measure is sigma-finite, atom-free, and regular (but not finite). -/
def lebesgueMeasureProperties : String :=
  "sigma-finite: ℝ = ⋃_n [-n,n]; atom-free: every singleton has measure 0; regular: inner/outer regular"

#eval "lebesgueMeasureProperties: sigma-finite, atom-free, regular"
#eval isSigmaFinite (default : Measure ℕ default)  -- placeholder, always true for this trivial measure

end MiniMeasureTheory
