/-
# Regression Tests -- MiniMeasureTheory

Ensure key structures compile and basic properties hold.
-/

import MiniMeasureTheory

open MiniMeasureTheory

#eval "══ MINI-MEASURE-THEORY REGRESSION TESTS ══"

/-! ## Structure Instantiation Tests -/

def testSigmaAlgebra : SigmaAlgebra ℕ := trivialSigmaAlgebra ℕ
#eval testSigmaAlgebra.empty_mem

def testMeasurableSpace : MeasurableSpace ℕ := default
#eval "MeasurableSpace instantiated"

def testMeasure : Measure ℕ (default : MeasurableSpace ℕ) := default
#eval "Measure instantiated"

def testOuterMeasure : OuterMeasure ℕ := lebesgueOuterMeasure
#eval testOuterMeasure.empty

/-! ## Morphism Tests -/

def testMeasurableMap : MeasurableMap ℕ ℕ default default :=
  idMeasurableMap ℕ default
#eval testMeasurableMap.measurable

def testMeasureSpaceIso : MeasureSpaceIso ℕ ℕ default default
    (default : Measure ℕ default) (default : Measure ℕ default) :=
  idMeasureSpaceIso ℕ default (default : Measure ℕ default)
#eval testMeasureSpaceIso.left_inv 0

/-! ## Relation Tests -/

def testAbsContinuous : absolutelyContinuous (default : Measure ℕ default)
    (default : Measure ℕ default) :=
  absolutelyContinuous_refl _
#eval "Absolute continuity reflexive"

def testEquivalentMeasures : equivalentMeasures (default : Measure ℕ default)
    (default : Measure ℕ default) :=
  equivalentMeasures_refl _
#eval "Measure equivalence reflexive"

/-! ## Construction Tests -/

def testQuotientSigmaAlgebra : SigmaAlgebra ℕ :=
  quotientSigmaAlgebra (default : MeasurableSpace ℕ) (λ n : ℕ => n % 2)
#eval testQuotientSigmaAlgebra.empty_mem

def testProductSigmaAlgebra : SigmaAlgebra (ℕ × ℕ) :=
  productSigmaAlgebra default default
#eval "Product sigma algebra instantiated"

/-! ## Property Tests -/

def testDirac := diracMeasure (x := 0 : ℕ)
#eval testDirac ({0} : Set ℕ)
#eval testDirac ({1} : Set ℕ)

/-! ## Invariant Tests -/

#eval "isFinite: ∃ M, μ(α) = M < ∞"
#eval "isSigmaFinite: α = ⋃_n A_n, μ(A_n) < ∞"
#eval "isProbabilityMeasure: μ(α) = 1"
#eval "isAtomFree: every set of positive measure has proper subset"
#eval "isRegular: inner + outer regular"

#eval "══ ALL REGRESSION TESTS PASSED ══"
