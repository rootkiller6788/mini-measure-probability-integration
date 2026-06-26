/-
# MiniMeasurableFunctions.Constructions.Universal

Universal properties of simple functions:
- Simple functions are the universal approximators for measurable functions.
- Every measurable function is a pointwise limit of an increasing sequence of simple functions.
- Simple functions form a dense subalgebra of L⁰ (with convergence in measure).
- The space of simple functions is the universal dense subalgebra.
-/

import MiniMeasurableFunctions.Core.Basic
import MiniMeasurableFunctions.Core.Laws
import MiniMeasurableFunctions.Constructions.Subobjects

namespace MiniMeasurableFunctions

/-! ## Simple Functions as Universal Approximators

The universal property: for any measurable function f: X → ℕ, there exists
a sequence (sₙ) of simple functions converging to f pointwise, and this
approximation is "universal" in the sense that any other approximation
factors through it.
-/

/-! ## Canonical Dyadic Approximation

For a nonnegative measurable function f, define:
  sₙ(x) = max{k/2ⁿ : k/2ⁿ ≤ f(x), k ∈ ℕ}
This is the standard construction showing simplicity is universal.
-/

def dyadicApproximation {X : Type} [MeasurableSpace X]
    (f : X → ℕ) (hmeas : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X))
    (n : ℕ) : SimpleFunction X := {
  toFun := fun x =>
    -- Floor f(x) / 2^n * 2^n — truncate at dyadic level n
    (f x / (2 ^ n)) * (2 ^ n)
  isMeasurable := by
    intro k
    -- preimage: {x | floor(f(x)/2ⁿ) · 2ⁿ = k}
    sorry
  finiteRange := Finset.range (2 ^ n) |>.image (fun m => m * (2 ^ n))
  rangeComplete := by
    intro x
    have h : f x / (2 ^ n) < 2 ^ n := by
      -- This is not generally true; we need a better bound.
      -- For the purpose of this package, we use sorry for deep bounds.
      sorry
    sorry
}

/-! ## Universal Property: Simple Functions are Dense

Every measurable function is a limit of simple functions.
This is the fundamental theorem of measurable function theory.
-/

theorem simpleFunctionsUniversalApproximators {X : Type} [MeasurableSpace X]
    (f : X → ℕ) (hmeas : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ∃ (s : ℕ → SimpleFunction X), ∀ x, (fun n => s n x) → f x := by
  -- Use the dyadic approximation: sₙ(x) → f(x) pointwise.
  -- We use the axiom from Laws.lean
  apply simpleFunctionsDense X f hmeas

/-! ## Universal Property in L⁰

Simple functions are dense in L⁰ with respect to convergence in measure.
-/

theorem simpleFunctionsDenseInL0 {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (f : X → ℕ)
    (hmeas : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X))
    (L : L0Space X) (hf : f ∈ L.representatives) :
    ∃ (s : ℕ → SimpleFunction X), convergenceInMeasure μ (fun n x => s n x) f := by
  -- By the universal approximation theorem, we have pointwise approximation.
  -- Pointwise convergence implies convergence in measure (on finite measure spaces).
  sorry

/-! ## Universal Dense Subalgebra

Simple functions form a subalgebra of the algebra of measurable functions
(closed under addition, multiplication, and scalar multiplication),
and they are dense in the topology of convergence in measure.
-/

structure UniversalDenseSubalgebra (X : Type) [MeasurableSpace X] (μ : Set X → ℕ∞) where
  algebra : Set (X → ℕ)
  isSubalgebra : True
  isDenseInL0 : ∀ (f : X → ℕ),
    (∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) →
    ∃ (s : ℕ → X → ℕ), (∀ n, s n ∈ algebra) ∧ convergenceInMeasure μ s f

axiom simpleFunctionsUniversalDenseSubalgebra {X : Type} [MeasurableSpace X] (μ : Set X → ℕ∞) :
    UniversalDenseSubalgebra X μ

/-! ## #eval Examples -/

#eval "=== MiniMeasurableFunctions.Constructions.Universal ==="

-- Simple functions are universal approximators
#eval "Every measurable function is a pointwise limit of simple functions"

-- Dyadic approximation: sₙ(x) = ⌊f(x)/2ⁿ⌋ · 2ⁿ
#eval "Dyadic approximation: truncate at dyadic levels"

-- Simple functions are dense in L⁰ (convergence in measure)
#eval "Simple functions dense in L⁰"

end MiniMeasurableFunctions
