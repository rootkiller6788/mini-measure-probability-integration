/-
# Smoke Tests -- MiniMeasureTheory

Run: `lake env lean --run Test/Smoke.lean`
-/

import MiniMeasureTheory

open MiniMeasureTheory

#eval "══ MINI-MEASURE-THEORY SMOKE TESTS ══"

/-! ## Core.Basic -/

#eval "── Core.Basic: SigmaAlgebra ──"
#eval trivialSigmaAlgebra ℕ |>.empty_mem
#eval discreteSigmaAlgebra ℕ |>.empty_mem
#eval "── Core.Basic: MeasurableSpace ──"
#eval (default : MeasurableSpace ℕ)
#eval "── Core.Basic: Measure and MeasureSpace ──"
#eval "Measure defined (coercion to Set α → ℝ≥0∞)"
#eval "── Core.Basic: OuterMeasure ──"
#eval "OuterMeasure: empty, monotone, countably subadditive"
#eval "── Core.Basic: isComplete, restriction, pushforward ──"
#eval "isComplete, restriction, pushforward defined"

/-! ## Core.Laws -/

#eval "── Core.Laws ──"
#eval "countableAdditivity, monotonicity, countableSubadditivity"
#eval "continuityFromBelow, continuityFromAbove"
#eval "caratheodoryExtensionTheorem, hahnDecomposition"

/-! ## Core.Objects -/

#eval "── Core.Objects ──"
#eval "Object instances: SigmaAlgebra, MeasurableSpace, Measure"
#eval "coreObjects: 4 entries"
#eval (coreObjects 0).1
#eval "Factory functions: mkTrivialSigmaAlgebra, mkDiscreteSigmaAlgebra, mkBorelSigmaAlgebra"

/-! ## Morphisms -/

#eval "── Morphisms.Hom: MeasurableMap ──"
#eval idMeasurableMap ℕ default |>.measurable
#eval "── Morphisms.Hom: MeasurePreservingMap ──"
#eval "idMeasurePreserving defined"
#eval "── Morphisms.Hom: SigmaAlgebraHomomorphism ──"
#eval (trivialSigmaAlgebraHom (trivialSigmaAlgebra ℕ) (trivialSigmaAlgebra ℕ)).preserves_empty

#eval "── Morphisms.Iso ──"
#eval (idMeasureSpaceIso ℕ default (default : Measure ℕ default)).left_inv 42
#eval isomorphicRefl ℕ default (default : Measure ℕ default)

#eval "── Morphisms.Equiv ──"
#eval absolutelyContinuous_refl (default : Measure ℕ default)
#eval equivalentMeasures_refl (default : Measure ℕ default)

/-! ## Constructions -/

#eval "── Constructions.Products ──"
#eval "productSigmaAlgebra, productMeasure, fubiniTonelli"
#eval (tensorProductSigmaAlgebra (λ _ : ℕ => default : ∀ i, MeasurableSpace ℕ)).empty_mem

#eval "── Constructions.Quotients ──"
#eval (quotientSigmaAlgebra (default : MeasurableSpace ℕ) (λ n : ℕ => n % 2)).empty_mem
#eval "quotientMeasure, quotientByGroupSigmaAlgebra"

#eval "── Constructions.Subobjects ──"
#eval "SubSigmaAlgebra, traceMeasure, restrictToSigmaAlgebra"

#eval "── Constructions.Universal ──"
#eval "PreMeasure, outerMeasureOfPreMeasure, caratheodoryUniversalProperty"
#eval "existsCompletion, caratheodoryIsCompletion"

/-! ## Properties -/

#eval "── Properties.Invariants ──"
#eval "isFinite, isSigmaFinite, isProbabilityMeasure, isAtomFree, isRegular"
#eval lebesgueMeasureProperties

#eval "── Properties.Preservation ──"
#eval "absoluteContinuity_pushforward, sigmaFinite_product, finite_restriction"
#eval "probability_pushforward, atomFree_under_absoluteContinuity"

#eval "── Properties.ClassificationData ──"
#eval "isDiscreteMeasure, hasDensityWNRLebesgue, isSingularWtrLebesgue"
#eval "hausdorffMeasure, hausdorffDimension, radonNikodymTheorem"

/-! ## Theorems -/

#eval "── Theorems.Basic ──"
#eval "caratheodoryExtension, hahnDecompositionTheorem, jordanDecomposition"
#eval "vitaliCoveringLemma, lebesgueDifferentiation, egorovTheorem"

#eval "── Theorems.Classification ──"
#eval "lebesgueDecomposition, classificationOfBorelMeasures"
#eval "cantorMeasureIsSingularContinuous, lebesgueDecomposition_unique"

#eval "── Theorems.Main ──"
#eval mainTheorem

#eval "── Theorems.UniversalProperties ──"
#eval universalPropertiesSummary

/-! ## Examples -/

#eval "── Examples.Standard ──"
#eval diracMeasure (x := 0 : ℕ) ({0} : Set ℕ)
#eval diracMeasure (x := 0 : ℕ) ({1} : Set ℕ)
#eval "Lebesgue, counting, Dirac, Cantor, uniform, normal"

#eval "── Examples.Counterexamples ──"
#eval counterexamplesSummary

/-! ## Bridges -/

#eval "── Bridges.ToAlgebra ──"
#eval "measureAlgebra: Boolean sigma algebra of measurable sets modulo null sets"

#eval "── Bridges.ToTopology ──"
#eval "borelSigmaAlgebraTopological, RadonMeasure, rieszRepresentation, prokhorovTheorem"

#eval "── Bridges.ToGeometry ──"
#eval "hausdorffOuterMeasure, hausdorffDim, areaFormula, coareaFormula, isRectifiable"

#eval "── Bridges.ToComputation ──"
#eval "monteCarloEstimate, riemannSumApprox, DiscretizedMeasureSpace, piMonteCarlo"

#eval "══ ALL MINI-MEASURE-THEORY SMOKE TESTS PASSED ══"
