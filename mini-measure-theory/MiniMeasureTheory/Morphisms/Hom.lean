/-
# Measure Theory: Morphisms (Homomorphisms)

Measurable maps, measure-preserving maps, sigma algebra homomorphisms.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Measurable Map -/

/-- A measurable map between measurable spaces:
    preimage of every measurable set is measurable. -/
structure MeasurableMap (α β : Type u)
    (ms_α : MeasurableSpace α) (ms_β : MeasurableSpace β) where
  toFun : α → β
  measurable : ∀ s, isMeasurable ms_β s → isMeasurable ms_α (toFun ⁻¹' s)

instance measurableMapCoeFun {α β : Type u} {ms_α : MeasurableSpace α} {ms_β : MeasurableSpace β} :
    CoeFun (MeasurableMap α β ms_α ms_β) (λ _ => α → β) where
  coe := MeasurableMap.toFun _

/-- The identity measurable map. -/
def idMeasurableMap (α : Type u) (ms : MeasurableSpace α) : MeasurableMap α α ms ms where
  toFun := id
  measurable := by
    intro s hs
    simp [hs]

/-- Composition of measurable maps. -/
def compMeasurableMap {α β γ : Type u}
    {ms_α : MeasurableSpace α} {ms_β : MeasurableSpace β} {ms_γ : MeasurableSpace γ}
    (g : MeasurableMap β γ ms_β ms_γ) (f : MeasurableMap α β ms_α ms_β) :
    MeasurableMap α γ ms_α ms_γ where
  toFun := g.toFun ∘ f.toFun
  measurable := by
    intro s hs
    rw [Set.preimage_comp]
    apply f.measurable
    apply g.measurable
    exact hs

#eval "MeasurableMap defined: identity and composition"
#eval (idMeasurableMap ℕ default).measurable

/-! ## Measure-Preserving Map -/

/-- A measure-preserving map: measurable map with μ(f⁻¹(B)) = ν(B). -/
structure MeasurePreservingMap (α β : Type u)
    (ms_α : MeasurableSpace α) (ms_β : MeasurableSpace β)
    (μ : Measure α ms_α) (ν : Measure β ms_β) extends MeasurableMap α β ms_α ms_β where
  measure_preserving : ∀ s, isMeasurable ms_β s → μ (toFun ⁻¹' s) = ν s

/-- The identity is measure-preserving. -/
def idMeasurePreserving (α : Type u) (ms : MeasurableSpace α) (μ : Measure α ms) :
    MeasurePreservingMap α α ms ms μ μ :=
  { idMeasurableMap α ms with
    measure_preserving := λ s hs => by simp }

#eval "MeasurePreservingMap defined"

/-! ## Sigma Algebra Homomorphism -/

/-- A sigma algebra homomorphism: a map between sigma algebras
    that preserves complements and countable unions.
    (This is a morphism in the category of sigma algebras.) -/
structure SigmaAlgebraHomomorphism (α β : Type u)
    (σ_α : SigmaAlgebra α) (σ_β : SigmaAlgebra β) where
  mapCarrier : Set (Set α) → Set (Set β)
  preserves_empty : mapCarrier ∅ = ∅
  preserves_complement : ∀ s, mapCarrier (σ_α.carrier \ s) = σ_β.carrier \ mapCarrier s
  preserves_countable_union : ∀ (s : ℕ → Set α),
    mapCarrier (σ_α.carrier → ⋃ n, s n) | _ => sorry

/-- The trivial sigma algebra homomorphism. -/
def trivialSigmaAlgebraHom {α β : Type u} (σ_α : SigmaAlgebra α) (σ_β : SigmaAlgebra β) :
    SigmaAlgebraHomomorphism α β σ_α σ_β where
  mapCarrier _ := ∅
  preserves_empty := rfl
  preserves_complement := λ s => by simp
  preserves_countable_union := λ s => by
    intro h
    simp

#eval "SigmaAlgebraHomomorphism defined"
#eval (trivialSigmaAlgebraHom (trivialSigmaAlgebra ℕ) (trivialSigmaAlgebra ℕ)).preserves_empty

end MiniMeasureTheory
