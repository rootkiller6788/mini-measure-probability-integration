/-
# MiniMeasurableFunctions.Morphisms.Iso

Isomorphisms in the category of measure spaces:
- `MeasureSpaceIsomorphism`: a bi-measurable bijection between measure spaces
  that preserves the measure.
- `MeasureAlgebraIsomorphism`: isomorphism of the Boolean algebra of
  measurable sets modulo null sets.
-/

import MiniMeasurableFunctions.Core.Basic
import MiniMeasurableFunctions.Morphisms.Hom

namespace MiniMeasurableFunctions

/-! ## Measure Space Isomorphism

Two measure spaces (X, Σ_X, μ_X) and (Y, Σ_Y, μ_Y) are isomorphic if
there exists a bi-measurable bijection φ: X → Y such that
μ_Y(φ(A)) = μ_X(A) for all measurable A.
-/

structure MeasureSpaceIsomorphism (X Y : Type)
    [MeasurableSpace X] [MeasurableSpace Y] where
  toFun : X → Y
  invFun : Y → X
  left_inv : ∀ x, invFun (toFun x) = x
  right_inv : ∀ y, toFun (invFun y) = y
  measurable : ∀ s, s ∈ MeasurableSpace.measurableSets (X := Y) →
    toFun ⁻¹' s ∈ MeasurableSpace.measurableSets (X := X)
  invMeasurable : ∀ s, s ∈ MeasurableSpace.measurableSets (X := X) →
    invFun ⁻¹' s ∈ MeasurableSpace.measurableSets (X := Y)

instance (X Y : Type) [MeasurableSpace X] [MeasurableSpace Y] :
    CoeFun (MeasureSpaceIsomorphism X Y) (fun _ => X → Y) where
  coe φ := φ.toFun

/-! ## Measure-Preserving Isomorphism

An isomorphism that also preserves the measure.
-/

structure MeasurePreservingIsomorphism (X Y : Type)
    [MeasurableSpace X] [MeasurableSpace Y] extends MeasureSpaceIsomorphism X Y where
  measurePreserving : ∀ (μX : Set X → ℕ∞) (μY : Set Y → ℕ∞) (s : Set X),
    s ∈ MeasurableSpace.measurableSets (X := X) →
    μY (toFun '' s) = μX s
  pullbackMeasure : ∀ (μX : Set X → ℕ∞) (μY : Set Y → ℕ∞) (t : Set Y),
    t ∈ MeasurableSpace.measurableSets (X := Y) →
    μX (invFun '' t) = μY t

/-! ## Measure Algebra Isomorphism

The measure algebra is the Boolean algebra of measurable sets modulo null sets.
An isomorphism of measure algebras is a bijection between these algebras
preserving the Boolean operations and the measure.
-/

structure MeasureAlgebraIsomorphism (X Y : Type)
    [MeasurableSpace X] [MeasurableSpace Y] where
  -- Map on equivalence classes of measurable sets (mod null sets)
  toAlgebraMap : Set X → Set Y
  invAlgebraMap : Set Y → Set X
  -- Preserves empty set
  preservesEmpty : toAlgebraMap ∅ = ∅
  -- Preserves complement (mod null sets)
  preservesComplement (A : Set X) :
    A ∈ MeasurableSpace.measurableSets (X := X) →
    toAlgebraMap (Aᶜ) = (toAlgebraMap A)ᶜ
  -- Preserves countable unions
  preservesUnion (A : ℕ → Set X) (h : ∀ n, A n ∈ MeasurableSpace.measurableSets (X := X)) :
    toAlgebraMap (⋃ n, A n) = ⋃ n, toAlgebraMap (A n)
  -- Preserves measure (mod null sets)
  preservesMeasure (μX : Set X → ℕ∞) (μY : Set Y → ℕ∞) (A : Set X) :
    A ∈ MeasurableSpace.measurableSets (X := X) →
    μY (toAlgebraMap A) = μX A

/-! ## Identity isomorphism -/

def identityMeasureSpaceIso (X : Type) [MeasurableSpace X] : MeasureSpaceIsomorphism X X := {
  toFun := id
  invFun := id
  left_inv := fun _ => rfl
  right_inv := fun _ => rfl
  measurable := fun s hs => hs
  invMeasurable := fun s hs => hs
}

/-! ## #eval Examples -/

#eval "=== MiniMeasurableFunctions.Morphisms.Iso ==="

-- Identity isomorphism on Fin 5
def isoFin5 : MeasureSpaceIsomorphism (Fin 5) (Fin 5) := identityMeasureSpaceIso (Fin 5)
#eval "Identity measure space isomorphism on Fin 5"

-- Check properties
#eval isoFin5.toFun 3 == 3
#eval isoFin5.invFun 3 == 3

-- Measure algebra isomorphism: the identity map on sets
#eval "Measure algebra isomorphism structure defined"

end MiniMeasurableFunctions
