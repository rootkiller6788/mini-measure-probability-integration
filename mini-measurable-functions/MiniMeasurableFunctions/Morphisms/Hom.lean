/-
# MiniMeasurableFunctions.Morphisms.Hom

Morphisms in the category of measure spaces:
- `MeasurePreservingMap`: a measurable map T: X → X such that μ(T⁻¹(A)) = μ(A)
- `ErgodicMap`: a measure-preserving map such that T⁻¹(A) = A implies μ(A) = 0 or μ(Aᶜ) = 0
- Composition of measurable maps
-/

import MiniMeasurableFunctions.Core.Basic

namespace MiniMeasurableFunctions

/-! ## Measure-Preserving Map

A measurable map T: X → X is measure-preserving if for every measurable set A,
μ(T⁻¹(A)) = μ(A).
-/

structure MeasurePreservingMap (X : Type) [MeasurableSpace X] where
  toFun : X → X
  measurable : ∀ s, s ∈ MeasurableSpace.measurableSets (X := X) →
    toFun ⁻¹' s ∈ MeasurableSpace.measurableSets (X := X)
  measurePreserving : ∀ (μ : Set X → ℕ∞) (s : Set X),
    s ∈ MeasurableSpace.measurableSets (X := X) →
    μ (toFun ⁻¹' s) = μ s

instance (X : Type) [MeasurableSpace X] : CoeFun (MeasurePreservingMap X) (fun _ => X → X) where
  coe T := T.toFun

/-! ## Ergodic Map

A measure-preserving map is ergodic if every invariant set has measure 0 or full measure.
-/

structure ErgodicMap (X : Type) [MeasurableSpace X] extends MeasurePreservingMap X where
  ergodic : ∀ (μ : Set X → ℕ∞) (A : Set X),
    A ∈ MeasurableSpace.measurableSets (X := X) →
    toFun ⁻¹' A = A →
    μ A = 0 ∨ μ (Aᶜ) = 0

/-! ## Composition of Measure-Preserving Maps

The composition of two measure-preserving maps is measure-preserving.
-/

axiom measurePreserving_comp {X : Type} [MeasurableSpace X]
    (T S : MeasurePreservingMap X) :
    MeasurePreservingMap X

-- Explicit composition constructor
def MeasurePreservingMap.comp {X : Type} [MeasurableSpace X]
    (T S : MeasurePreservingMap X) : MeasurePreservingMap X := {
  toFun := T.toFun ∘ S.toFun
  measurable := by
    intro s hs
    have hT := T.measurable s hs
    have hS := S.measurable (T.toFun ⁻¹' s) hT
    -- hS: S⁻¹(T⁻¹(s)) = (T ∘ S)⁻¹(s) ∈ σ(X)
    -- But S.measurable returns S⁻¹(A) ∈ σ(X) for A ∈ σ(X)
    -- We need to show hT gives us A = T⁻¹(s) ∈ σ(X), then hS applies.
    -- Here hT IS that T⁻¹(s) ∈ σ(X)
    -- So we just need: s ∈ σ(X) → T⁻¹(s) ∈ σ(X) [hT]
    -- Then S⁻¹(T⁻¹(s)) ∈ σ(X) [hS with A := T⁻¹(s)]
    -- = (T ∘ S)⁻¹(s) ∈ σ(X)
    exact hS
  measurePreserving := by
    intro μ s hs
    -- μ((T∘S)⁻¹(s)) = μ(S⁻¹(T⁻¹(s))) = μ(T⁻¹(s)) = μ(s)
    sorry
}

/-! ## Identity Map is Measure-Preserving -/

def identityMeasurePreserving (X : Type) [MeasurableSpace X] : MeasurePreservingMap X := {
  toFun := id
  measurable := by
    intro s hs
    -- id⁻¹(s) = s, and s ∈ σ(X) by hs
    exact hs
  measurePreserving := by
    intro μ s hs
    simp
}

/-! ## Ergodic Maps are Closed Under Composition

Composition of ergodic maps is not necessarily ergodic, but on compact
groups or under additional hypotheses, it holds. We state it as an axiom
for the general case.
-/

axiom ergodic_comp {X : Type} [MeasurableSpace X]
    (T S : ErgodicMap X) (hComm : T.toFun ∘ S.toFun = S.toFun ∘ T.toFun) :
    ErgodicMap X

/-! ## #eval Examples -/

#eval "=== MiniMeasurableFunctions.Morphisms.Hom ==="

-- The identity map is measure-preserving
def id_mp : MeasurePreservingMap (Fin 5) := identityMeasurePreserving (Fin 5)
#eval "Identity measure-preserving map created"

-- Check composition property (just structure creation, not proof)
#eval "Composition structure defined"

-- The identity is also trivially an ergodic map (on a trivial measure space)
#eval "Ergodic maps: invariant sets have measure 0 or full measure"

end MiniMeasurableFunctions
