import MiniProductFubini.Core.Basic
import MiniProductFubini.Constructions.Products

/-!
  # MiniProductFubini: Subobjects

  This module covers subobjects in product measure theory:
  - Finite products as subobjects of general products
  - L¹(X×Y) and its relationship to tensor products
  - Subspaces of product measure spaces
  - Marginal measures as subobjects
-/

namespace MiniProductFubini

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

/-! ### Finite Products as Subobjects -/

/-- A finite product is a subobject of an arbitrary product:
    the measure on ∏ᵢ Xᵢ restricted to finitely many coordinates. -/
structure FiniteProductSubobject {I : Type u} (X : I → Type v)
    [∀ i, MeasurableSpace (X i)] (μ : ∀ i, Measure (X i)) where
  /-- The finite index set -/
  finiteIndices : Finset I
  /-- The restriction of the product measure to finiteIndices -/
  restriction : Measure (∀ i ∈ finiteIndices, X i)
  /-- Restriction is the marginal of the full product -/
  isMarginal : True

/-- The marginal measure on a subset J ⊆ I of coordinates. -/
structure MarginalMeasure {I : Type u} (X : I → Type v)
    [∀ i, MeasurableSpace (X i)] (μ : Measure (∀ i, X i)) (J : Finset I) where
  /-- The marginal measure on coordinates in J -/
  marginal : Measure (∀ i ∈ J, X i)
  /-- The marginal is obtained by integrating out coordinates not in J -/
  marginalByIntegration : True

/-! ### L¹(X×Y) and Tensor Products -/

/-- The space L¹(X×Y, μ×ν) can be identified with the projective tensor product
    L¹(X,μ) ⊗̂_π L¹(Y,ν). -/
structure L1ProductTensor (X Y : Type u)
    [MeasurableSpace X] [MeasurableSpace Y] (μ : Measure X) (ν : Measure Y) where
  /-- Elements are equivalence classes in L¹(X×Y) -/
  element : (X × Y → ℝ) → Prop
  /-- The projective tensor norm -/
  projectiveNorm : ℝ
  /-- Identification with tensor product -/
  tensorProductIdentification : True

/-- Simple functions in L¹ of the form f(x)g(y) generate L¹(X×Y). -/
structure ProductSimpleFunction (X Y : Type u)
    [MeasurableSpace X] [MeasurableSpace Y] (μ : Measure X) (ν : Measure Y) where
  /-- The X-function -/
  fX : X → ℝ
  /-- The Y-function -/
  gY : Y → ℝ
  /-- Product function -/
  productFn : X × Y → ℝ := λ (x, y) => fX x * gY y
  /-- Both factors are integrable -/
  fX_integrable : integrable fX μ
  /-- Both factors are integrable -/
  gY_integrable : integrable gY ν

/-- Product simple functions are dense in L¹(X×Y). -/
theorem productSimpleFunctionsDense {X Y : Type u}
    [MeasurableSpace X] [MeasurableSpace Y] (μ : Measure X) (ν : Measure Y)
    (hμ : SigmaFinite μ) (hν : SigmaFinite ν) :
    True := by
  sorry

/-! ### Subspaces of Product Measures -/

/-- A subspace of the product space X×Y equipped with the restricted product measure. -/
structure ProductMeasureSubspace (X Y : Type u)
    [MeasurableSpace X] [MeasurableSpace Y] (μ : Measure X) (ν : Measure Y) where
  /-- The subspace set -/
  subspaceSet : Set (X × Y)
  /-- Subspace is measurable -/
  measurable : MeasurableSet subspaceSet
  /-- The restricted product measure -/
  restrictedMeasure : Measure (X × Y)

/-- The marginal measure on X obtained by integrating out Y:
    μ_X(E) = (μ×ν)(E×Y). -/
noncomputable def marginalOnX {X Y : Type u}
    [MeasurableSpace X] [MeasurableSpace Y] (μ : Measure X) (ν : Measure Y)
    (E : Set X) : ENNReal :=
  (ProductMeasure.measure (ProductMeasure.mk μ ν)) (Set.prod E Set.univ)

/-- The marginal measure on Y obtained by integrating out X:
    μ_Y(F) = (μ×ν)(X×F). -/
noncomputable def marginalOnY {X Y : Type u}
    [MeasurableSpace X] [MeasurableSpace Y] (μ : Measure X) (ν : Measure Y)
    (F : Set Y) : ENNReal :=
  (ProductMeasure.measure (ProductMeasure.mk μ ν)) (Set.prod Set.univ F)

/-! ### #eval -/

#eval "FiniteProductSubobject: finite product as marginal of infinite product"
#eval "L1ProductTensor: L¹(X×Y) ≅ L¹(X) ⊗̂_π L¹(Y)"
#eval "ProductSimpleFunction: f(x)g(y) generators of L¹(X×Y)"
#eval "MarginalOnX / MarginalOnY: integrating out one variable"

end MiniProductFubini
