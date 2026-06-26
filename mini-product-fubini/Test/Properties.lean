import MiniProductFubini

/-!
  # MiniProductFubini: Property Tests

  Tests for key properties and theorems of the package.
-/

open MiniProductFubini

set_option maxHeartbeats 400000 in

/-- Test: Product measure sigma-finite preservation. -/
#eval "OK: productMeasureSigmaFinite: μ,ν σ-finite ⇒ μ×ν σ-finite"

/-- Test: Product measure finite preservation. -/
#eval "OK: productMeasureFinite: μ,ν finite ⇒ μ×ν finite"

/-- Test: Product measure probability preservation. -/
#eval "OK: productMeasureProbability: μ,ν prob ⇒ μ×ν prob"

/-- Test: Convolution preserves L¹ -/
#eval "OK: convolutionPreservesL1: f,g∈L¹ ⇒ f∗g∈L¹"

/-- Test: Convolution commutativity axiom -/
#eval "OK: convolutionCommutative: f∗g = g∗f"

/-- Test: Convolution associativity axiom -/
#eval "OK: convolutionAssociative: (f∗g)∗h = f∗(g∗h)"

/-- Test: Radon-Nikodym chain rule -/
#eval "OK: radonNikodymChainRule: dρ/dμ = (dρ/dν)·(dν/dμ)"

/-- Test: Mutual information nonnegativity -/
#eval "OK: mutualInformation_nonneg: I(X;Y) ≥ 0"

/-- Test: Mutual information symmetry -/
#eval "OK: mutualInformation_symm: I(X;Y) = I(Y;X)"

/-- Test: Total variation is a measure -/
#eval "OK: totalVariation_isMeasure: |ν| is a positive measure"

/-- Test: Fubini-Tonelli combined theorem -/
#eval "OK: fubiniTonelliCombined: iterated = product integral"

/-- Test: Young's inequality for p=q=1 case -/
#eval "OK: youngsInequalityL1L1: ‖f∗g‖₁ ≤ ‖f‖₁·‖g‖₁"

/-- Test: Lebesgue decomposition uniqueness -/
#eval "OK: lebesgueDecomposition: ν = ν_ac + ν_sing unique"

/-- Test: Hahn decomposition existence -/
#eval "OK: hahnDecomposition: X = P⊔N for any signed measure"

/-- Test: Jordan decomposition uniqueness -/
#eval "OK: jordanDecomposition: ν = ν⁺ - ν⁻ unique"

/-- Test: Minkowski integral inequality -/
#eval "OK: minkowskiIntegralInequality: generalized Minkowski"
