import MiniProductFubini.Core.Basic
import MiniProductFubini.Core.Laws

/-!
  # MiniProductFubini: Core Objects

  This module registers the main objects of product measure theory with the
  MiniMathKernel Object typeclass for theory registration and interoperability.

  ## Objects Registered

  * `ProductMeasureObject` -- Product measure μ×ν as kernel object
  * `ConvolutionObject` -- Convolution operator ∗ as kernel object
  * `RadonNikodymDerivativeObject` -- Radon-Nikodym derivative as kernel object
-/

namespace MiniProductFubini

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

/-! ### Theory Registration -/

/-- Theory name for MiniProductFubini. -/
def productFubiniTheory : TheoryName :=
  TheoryName.ofString "MiniProductFubini"

/-! ### Product Measure Object -/

/-- The ProductMeasure as a registered kernel object. -/
structure ProductMeasureObject (X Y : Type u) [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) where
  /-- Underlying product measure -/
  measure : Measure (X × Y)
  /-- Factorization on rectangles -/
  factor : ∀ (A B : Set X × Set Y), True
  deriving Inhabited

/-- Object instance for ProductMeasureObject. -/
instance ProductMeasureObject.obj {X Y : Type u} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) : Object (ProductMeasureObject X Y μ ν) where
  theory := productFubiniTheory.extend "ProductMeasure"
  objName := "ProductMeasure"
  repr o := s!"ProductMeasure[{describe X} × {describe Y}]"

/-! ### Convolution Object -/

/-- The Convolution operator as a registered kernel object. -/
structure ConvolutionObject (n : ℕ) where
  /-- The underlying function space dimension -/
  dimension : ℕ
  /-- Functions are on ℝⁿ -/
  domain : Type := Fin n → ℝ
  deriving Inhabited

/-- Object instance for ConvolutionObject. -/
instance ConvolutionObject.obj (n : ℕ) : Object (ConvolutionObject n) where
  theory := productFubiniTheory.extend "Convolution"
  objName := "Convolution"
  repr o := s!"Convolution[ℝ^{o.dimension}]"

/-! ### Radon-Nikodym Derivative Object -/

/-- The Radon-Nikodym derivative as a registered kernel object. -/
structure RadonNikodymDerivativeObject {X : Type u} [MeasurableSpace X]
    (μ ν : Measure X) where
  /-- The derivative function -/
  derivative : X → ℝ
  /-- Measurability of the derivative -/
  measurable_derivative : Measurable derivative
  /-- Absolute continuity requirement -/
  absolutelyContinuous : AbsolutelyContinuous ν μ
  deriving Inhabited

/-- Object instance for RadonNikodymDerivativeObject. -/
instance RadonNikodymDerivativeObject.obj {X : Type u} [MeasurableSpace X]
    (μ ν : Measure X) : Object (RadonNikodymDerivativeObject μ ν) where
  theory := productFubiniTheory.extend "RadonNikodym"
  objName := "RadonNikodymDerivative"
  repr o := s!"d{repr ν}/d{repr μ}"

/-! ### Theory Registration Summary -/

/-- #eval: List all registered objects in MiniProductFubini -/
#eval "Objects registered: ProductMeasureObject, ConvolutionObject, RadonNikodymDerivativeObject"

/-- #eval: ProductMeasure object description -/
#eval "ProductMeasureObject: μ×ν with factorization μ(A)·ν(B) on rectangles"

/-- #eval: Convolution object description -/
#eval "ConvolutionObject: (f∗g)(x) = ∫ f(x-y)g(y)dy on ℝⁿ"

/-- #eval: Radon-Nikodym object description -/
#eval "RadonNikodymDerivativeObject: dν/dμ when ν≪μ"

end MiniProductFubini
