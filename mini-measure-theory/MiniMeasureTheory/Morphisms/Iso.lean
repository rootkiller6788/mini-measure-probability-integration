/-
# Measure Theory: Isomorphisms

Measure space isomorphisms and isomorphic measure spaces.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic
import MiniMeasureTheory.Morphisms.Hom

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Measure Space Isomorphism -/

/-- A measure space isomorphism is an invertible measure-preserving map
    whose inverse is also measurable and measure-preserving. -/
structure MeasureSpaceIso (α β : Type u)
    (ms_α : MeasurableSpace α) (ms_β : MeasurableSpace β)
    (μ : Measure α ms_α) (ν : Measure β ms_β) extends
    MeasurePreservingMap α β ms_α ms_β μ ν where
  invFun : β → α
  left_inv : ∀ x, invFun (toFun x) = x
  right_inv : ∀ y, toFun (invFun y) = y
  inv_measurable : ∀ s, isMeasurable ms_α s → isMeasurable ms_β (invFun ⁻¹' s)

/-- The identity measure space isomorphism. -/
def idMeasureSpaceIso (α : Type u) (ms : MeasurableSpace α) (μ : Measure α ms) :
    MeasureSpaceIso α α ms ms μ μ :=
  { idMeasurePreserving α ms μ with
    invFun := id
    left_inv := λ _ => rfl
    right_inv := λ _ => rfl
    inv_measurable := λ s hs => by simpa using hs }

#eval "MeasureSpaceIso defined: identity isomorphism"
#eval (idMeasureSpaceIso ℕ default (default : Measure ℕ default)).left_inv 42

/-! ## Isomorphic Measure Spaces -/

/-- Two measure spaces are isomorphic if there exists a measure space
    isomorphism between them. -/
def isomorphicMeasureSpaces (α β : Type u)
    (ms_α : MeasurableSpace α) (ms_β : MeasurableSpace β)
    (μ : Measure α ms_α) (ν : Measure β ms_β) : Prop :=
  Nonempty (MeasureSpaceIso α β ms_α ms_β μ ν)

notation α " ≅[" μ "] " β " via " ν => isomorphicMeasureSpaces α β _ _ μ ν

/-- Being isomorphic as measure spaces is an equivalence relation (reflexivity). -/
theorem isomorphicRefl (α : Type u) (ms : MeasurableSpace α) (μ : Measure α ms) :
    isomorphicMeasureSpaces α α ms ms μ μ :=
  ⟨idMeasureSpaceIso α ms μ⟩

/-- Being isomorphic as measure spaces is symmetric. -/
theorem isomorphicSymm (α β : Type u)
    (ms_α : MeasurableSpace α) (ms_β : MeasurableSpace β)
    (μ : Measure α ms_α) (ν : Measure β ms_β)
    (h : isomorphicMeasureSpaces α β ms_α ms_β μ ν) :
    isomorphicMeasureSpaces β α ms_β ms_α ν μ := by
  rcases h with ⟨iso⟩
  refine ⟨{
    toMeasurableMap := ?_
    measure_preserving := by
      intro s hs
      sorry
    invFun := iso.toFun
    left_inv := iso.right_inv
    right_inv := iso.left_inv
    inv_measurable := iso.measurable
  }⟩
  sorry

#eval "isomorphicMeasureSpaces: reflexive"
#eval isomorphicRefl ℕ default (default : Measure ℕ default)

end MiniMeasureTheory
