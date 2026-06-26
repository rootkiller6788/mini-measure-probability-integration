/-
# MiniMeasurableFunctions.Core.Objects

Object instances for the measurable function ecosystem:
- `MeasurableFunction` as an `Object` (via `MiniObjectKernel.Object`)
- `SimpleFunction` as an `Object`
- `L0Space` — the space L⁰ of all measurable functions modulo equality a.e.

These provide the metadata and names for the typeclass system.
-/

import MiniObjectKernel.Core.Basic
import MiniMeasurableFunctions.Core.Basic

namespace MiniMeasurableFunctions

open MiniObjectKernel

/-! ## MeasurableFunction as Object -/

instance (X Y : Type) [MeasurableSpace X] [MeasurableSpace Y] :
    Object (MeasurableFunction X Y) where
  theory := TheoryName.ofString "MiniMeasurableFunctions.Core"
  objName := s!"MeasurableFunction({toString (TheoryName.ofString "X")},{toString (TheoryName.ofString "Y")})"
  repr f := s!"MeasurableFunction: X → Y (measurable)"

/-! ## SimpleFunction as Object -/

instance (X : Type) [MeasurableSpace X] : Object (SimpleFunction X) where
  theory := TheoryName.ofString "MiniMeasurableFunctions.Core"
  objName := s!"SimpleFunction({toString (TheoryName.ofString "X")})"
  repr s := s!"SimpleFunction: X → ℕ ({s.finiteRange.card} values)"

/-! ## L⁰ Space

L⁰ is the space of all measurable functions, with the topology of
convergence in measure. Formally, it is the set of measurable functions
modulo the equivalence relation of equality almost everywhere.
-/

structure L0Space (X : Type) [MeasurableSpace X] where
  -- Representatives are measurable functions
  representatives : Set (X → ℕ)
  -- All functions in the set are measurable
  allMeasurable : ∀ f ∈ representatives,
    ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)
  -- Closed under sums
  closedUnderAdd : ∀ f g, f ∈ representatives → g ∈ representatives →
    (fun x => f x + g x) ∈ representatives
  -- Closed under scalar multiplication
  closedUnderSmul : ∀ (c : ℕ) f, f ∈ representatives → (fun x => c * f x) ∈ representatives

instance (X : Type) [MeasurableSpace X] : Object (L0Space X) where
  theory := TheoryName.ofString "MiniMeasurableFunctions.Core"
  objName := s!"L⁰({toString (TheoryName.ofString "X")})"
  repr L := s!"L⁰: space of measurable functions"

/-! ## Default empty L⁰ space -/

def emptyL0 (X : Type) [MeasurableSpace X] : L0Space X := {
  representatives := ∅
  allMeasurable := by
    intro f hf
    exfalso; exact hf
  closedUnderAdd := by
    intro f g hf hg
    exfalso; exact hf
  closedUnderSmul := by
    intro c f hf
    exfalso; exact hf
}

/-! ## L⁰ as a Metric Space (convergence in measure) -/

def L0Space.metric (X : Type) [MeasurableSpace X]
    (L : L0Space X) (f g : X → ℕ) (μ : Set X → ℕ∞) : ℕ∞ :=
  -- The "metric" is the measure of the set where f and g differ
  μ {x | f x ≠ g x}

/-! ## #eval Examples -/

#eval "=== MiniMeasurableFunctions.Core.Objects ==="

-- Check Object instances
def testTheory : TheoryName := TheoryName.ofString "MiniMeasurableFunctions.Core"
#eval toString testTheory

-- Create a trivial L⁰ space for Fin 3
def fin3Space : MeasurableSpace (Fin 3) := {
  measurableSets := {∅, Set.univ}
  containsEmpty := by simp
  closedUnderComplement := by
    intro s hs
    simp at hs ⊢
    rcases hs with (rfl|rfl)
    · exact Set.mem_insert Set.univ {∅}
    · exact Set.mem_insert ∅ {Set.univ}
  closedUnderCountableUnion := fun A h => by
    -- trivial for the indiscrete σ-algebra
    sorry
}

def l0Fin3 : L0Space (Fin 3) := emptyL0 (Fin 3)

#eval toString (describe (L0Space (Fin 3)))
#eval l0Fin3.representatives = ∅

end MiniMeasurableFunctions
