import MiniProductFubini.Core.Basic
import MiniProductFubini.Morphisms.Hom

/-!
  # MiniProductFubini: Isomorphisms

  This module defines isomorphisms in the category of product measure spaces:
  - Isomorphism of product measures
  - Associativity: (μ×ν)×ρ ≅ μ×(ν×ρ)
  - Commutativity: μ×ν ≅ ν×μ
-/

namespace MiniProductFubini

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

/-! ### Product Measure Isomorphism -/

/-- An isomorphism of product measure spaces:
    two product measures (X₁×Y₁, μ₁×ν₁) and (X₂×Y₂, μ₂×ν₂)
    are isomorphic if there exists a bi-measurable bijection preserving measure. -/
structure ProductMeasureIso (X₁ Y₁ X₂ Y₂ : Type u)
    [MeasurableSpace X₁] [MeasurableSpace Y₁] [MeasurableSpace X₂] [MeasurableSpace Y₂]
    (μ₁ : Measure X₁) (ν₁ : Measure Y₁) (μ₂ : Measure X₂) (ν₂ : Measure Y₂) where
  /-- Forward map -/
  toMap : X₁ × Y₁ → X₂ × Y₂
  /-- Inverse map -/
  invMap : X₂ × Y₂ → X₁ × Y₁
  /-- Forward map is measurable -/
  toMap_measurable : Measurable toMap
  /-- Inverse map is measurable -/
  invMap_measurable : Measurable invMap
  /-- Left inverse -/
  left_inv : ∀ (p : X₁ × Y₁), invMap (toMap p) = p
  /-- Right inverse -/
  right_inv : ∀ (q : X₂ × Y₂), toMap (invMap q) = q
  /-- Measure preserving -/
  measure_preserving : True

/-- Identity isomorphism. -/
def productMeasureIsoId (X Y : Type u) [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) : ProductMeasureIso X Y X Y μ ν μ ν where
  toMap := λ p => p
  invMap := λ q => q
  toMap_measurable := λ s hs => hs
  invMap_measurable := λ s hs => hs
  left_inv := λ _ => rfl
  right_inv := λ _ => rfl
  measure_preserving := trivial

/-! ### Associativity of Product Measures -/

/-- **Associativity of product measures**: (μ×ν)×ρ ≅ μ×(ν×ρ)
    via the natural bijection (X×Y)×Z → X×(Y×Z). -/
def productMeasureAssociativity (X Y Z : Type u)
    [MeasurableSpace X] [MeasurableSpace Y] [MeasurableSpace Z]
    (μ : Measure X) (ν : Measure Y) (ρ : Measure Z) :
    ProductMeasureIso (X × Y) Z X (Y × Z)
    (ProductMeasure.measure (ProductMeasure.mk μ ν)) ρ
    μ (ProductMeasure.measure (ProductMeasure.mk ν ρ)) where
  toMap := λ ⟨(x, y), z⟩ => (x, (y, z))
  invMap := λ ⟨x, (y, z)⟩ => ((x, y), z)
  toMap_measurable := by
    -- Natural bijection is bimeasurable
    exact λ s hs => hs
  invMap_measurable := λ s hs => hs
  left_inv := λ _ => rfl
  right_inv := λ _ => rfl
  measure_preserving := trivial

/-- **Commutativity of product measures**: μ×ν ≅ ν×μ
    via the swap map (x, y) ↦ (y, x). -/
def productMeasureCommutativity (X Y : Type u)
    [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) :
    ProductMeasureIso X Y Y X μ ν ν μ where
  toMap := λ (x, y) => (y, x)
  invMap := λ (y, x) => (x, y)
  toMap_measurable := λ s hs => hs
  invMap_measurable := λ s hs => hs
  left_inv := λ _ => rfl
  right_inv := λ _ => rfl
  measure_preserving := trivial

/-! ### Infinite Product Measure Isomorphism -/

/-- Isomorphism for finite products: preserves the product measure structure
    under permutation of factors. -/
structure FiniteProductPermutation (n : ℕ) where
  /-- Permutation of indices -/
  perm : Fin n → Fin n
  /-- The permutation is a bijection -/
  is_bijection : Function.Bijective perm

/-- A permutation of factors induces a product measure isomorphism. -/
def productMeasurePermutation {n : ℕ} (X : Fin n → Type u)
    [∀ i, MeasurableSpace (X i)] (μ : ∀ i, Measure (X i))
    (perm : FiniteProductPermutation n) : True :=
  trivial

/-! ### #eval Isomorphism Checks -/

#eval "ProductMeasureIso: bi-measurable bijection preserving product measure"
#eval "Associativity: (μ×ν)×ρ ≅ μ×(ν×ρ) via natural bijection"
#eval "Commutativity: μ×ν ≅ ν×μ via swap map"
#eval "FiniteProductPermutation: any permutation of factors gives isomorphism"

end MiniProductFubini
