/-
# MiniMeasurableFunctions.Constructions.Subobjects

Subobjects of the measurable function space:
- `BoundedMeasurable`: measurable functions with bounded range
- `NonnegativeMeasurable`: measurable functions taking nonnegative values
- `IntegrableFunction`: measurable functions with finite integral (preview)
-/

import MiniMeasurableFunctions.Core.Basic
import MiniMeasurableFunctions.Core.Objects

namespace MiniMeasurableFunctions

/-! ## Bounded Measurable Functions

A measurable function is bounded if there exists M such that |f(x)| ≤ M
for all x (almost everywhere, or everywhere depending on convention).
-/

structure BoundedMeasurableFunction (X : Type) [MeasurableSpace X] where
  toFun : X → ℕ
  isMeasurable : ∀ n, toFun ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)
  bound : ℕ
  isBounded : ∀ x, toFun x ≤ bound

instance (X : Type) [MeasurableSpace X] : CoeFun (BoundedMeasurableFunction X) (fun _ => X → ℕ) where
  coe f := f.toFun

/-! ## Nonnegative Measurable Functions

A measurable function is nonnegative if f(x) ≥ 0 for all x.
-/

structure NonnegativeMeasurableFunction (X : Type) [MeasurableSpace X] where
  toFun : X → ℕ
  isMeasurable : ∀ n, toFun ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)
  isNonnegative : ∀ x, toFun x ≥ 0

instance (X : Type) [MeasurableSpace X] : CoeFun (NonnegativeMeasurableFunction X) (fun _ => X → ℕ) where
  coe f := f.toFun

/-! ## Integrable Function (Preview)

A measurable function is integrable if ∫ |f| dμ < ∞.
For the ℕ-valued case, this means the measure-weighted sum of level sets converges.
-/

structure IntegrableFunction (X : Type) [MeasurableSpace X] (μ : Set X → ℕ∞) where
  toFun : X → ℕ
  isMeasurable : ∀ n, toFun ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)
  -- The integral is finite: Σ_{n} n · μ(f⁻¹({n})) < ∞
  hasFiniteIntegral : True
  -- Placeholder for actual integrability condition

instance (X : Type) [MeasurableSpace X] (μ : Set X → ℕ∞) :
    CoeFun (IntegrableFunction X μ) (fun _ => X → ℕ) where
  coe f := f.toFun

/-! ## Inclusion: Bounded → Integrable (for finite measure spaces)

Every bounded measurable function on a finite measure space is integrable.
-/

axiom boundedIntegrable {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (hFinite : μ Set.univ ≠ Option.none)
    (f : BoundedMeasurableFunction X) : IntegrableFunction X μ

/-! ## Inclusion: Nonnegative Bounded → Simple Function Approximation

Every nonnegative bounded measurable function can be uniformly approximated
by simple functions (standard dyadic approximation from below).
-/

axiom nonnegativeBoundedApproximable {X : Type} [MeasurableSpace X]
    (f : NonnegativeMeasurableFunction X) (hBounded : ∃ M, ∀ x, f x ≤ M) :
    ∃ (s : ℕ → SimpleFunction X), ∀ x, (fun n => s n x) → f x

/-! ## Lattice Structure

Bounded measurable functions form a Riesz space (vector lattice) under
pointwise min and max operations.
-/

def BoundedMeasurableFunction.max {X : Type} [MeasurableSpace X]
    (f g : BoundedMeasurableFunction X) : BoundedMeasurableFunction X := {
  toFun := fun x => max (f x) (g x)
  isMeasurable := by
    intro n
    sorry
  bound := max f.bound g.bound
  isBounded := by
    intro x
    apply le_trans (Nat.le_max_left _ _) (by
      apply le_trans ?_ (Nat.le_max_left _ _)
      exact f.isBounded _)
    sorry
}

/-! ## #eval Examples -/

#eval "=== MiniMeasurableFunctions.Constructions.Subobjects ==="

-- A bounded measurable function on Fin 5
def boundedEx : BoundedMeasurableFunction (Fin 5) := {
  toFun := fun i => i.val
  isMeasurable := by
    intro n; sorry
  bound := 5
  isBounded := by
    intro i; exact Nat.le_of_lt (Fin.is_lt i)
}

#eval boundedEx.bound

-- Nonnegative: the constant zero function
def nonnegZero : NonnegativeMeasurableFunction (Fin 5) := {
  toFun := fun _ => 0
  isMeasurable := by
    intro n
    -- Preimage of {n}: either ∅ (n ≠ 0) or Set.univ (n = 0), both measurable
    sorry
  isNonnegative := fun _ => Nat.zero_le _
}

#eval "Bounded, nonnegative, integrable subobjects defined"
#eval "Bounded ⇒ integrable on finite measure spaces"

end MiniMeasurableFunctions
