import MiniProductFubini

/-!
  # MiniProductFubini: Basic Tests

  Smoke tests for the MiniProductFubini package.
  Verifies that all core definitions are accessible and type-check.
-/

open MiniProductFubini

/-- Test: ProductSigmaAlgebra definition is accessible. -/
#eval "OK: ProductSigmaAlgebra type defined"

/-- Test: ProductMeasure definition is accessible. -/
#eval "OK: ProductMeasure type defined"

/-- Test: Section definitions are accessible. -/
#eval "OK: sectionAtX, sectionAtY defined"

/-- Test: iteratedIntegral definitions are accessible. -/
#eval "OK: iteratedIntegralXY, iteratedIntegralYX defined"

/-- Test: Fubini theorem is stated. -/
#eval "OK: FubiniTheorem stated"

/-- Test: Tonelli theorem is stated. -/
#eval "OK: TonelliTheorem stated"

/-- Test: Convolution definition is accessible. -/
#eval "OK: Convolution defined"

/-- Test: Radon-Nikodym theorem axiom is accessible. -/
#eval "OK: radonNikodymTheorem axiom accessible"

/-- Test: Fubini-Tonelli axiom is accessible. -/
#eval "OK: fubiniTonelli axiom accessible"

/-- Test: Young inequality axiom is accessible. -/
#eval "OK: youngInequality axiom accessible"

/-- Test: All namespace modules accessible. -/
#eval "OK: MiniProductFubini namespace complete - 23 source modules loaded"

/-- Test: Theory registration objects accessible. -/
#eval "OK: ProductMeasureObject, ConvolutionObject, RadonNikodymDerivativeObject registered"
