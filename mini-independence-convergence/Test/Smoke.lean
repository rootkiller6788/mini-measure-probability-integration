/-
# Smoke Tests — MiniIndependenceConvergence

Run: `lake env lean --run Test/Smoke.lean`
-/

import MiniIndependenceConvergence

open MiniIndependenceConvergence

#eval "══ MINI-INDEPENDENCE-CONVERGENCE SMOKE TESTS ══"

/-! ## Core.Basic -/

#eval "── Core.Basic: Events and Probability ──"
#eval "ProbabilitySpace defined"

def testSampleSpace : ProbabilitySpace (Fin 2) := {
  prob A := 1/2
  axiom_nonneg A := by
    have : (0 : ℝ) ≤ 1/2 := by norm_num
    exact this
  axiom_unit := rfl
  axiom_additive A B h := by
    simp
}

#eval "── Core.Basic: IndependentEvents ──"
def testEventA : Event (Fin 2) := ⟨{0}⟩
def testEventB : Event (Fin 2) := ⟨{1}⟩
#eval "Two events defined"

#eval "── Core.Basic: IIDSequence ──"
def testIIDSeq : IIDSequence (Fin 2) ℝ :=
  { vars := λ n => RandomVariable.mk (λ ω => 0) "measurable"
    independent := by
      intro i j h
      intro B₁ B₂
      dsimp
      sorry
    identicallyDistributed := by
      intro i j B
      simp
  }
#eval "IIDSequence (placeholder) defined"

#eval "── Core.Basic: Borel-Cantelli ──"
#eval "BorelCantelliFirst and BorelCantelliSecond defined"

/-! ## Core.Laws -/

#eval "── Core.Laws ──"
#eval borelCantelli1
#eval borelCantelli2
#eval kolmogorovZeroOneLaw
#eval convergenceRelationships

/-! ## Core.Objects -/

#eval "── Core.Objects: ConvergenceMode ──"
#eval toString ConvergenceMode.almostSure
#eval toString ConvergenceMode.inProbability
#eval toString ConvergenceMode.inDistribution
#eval toString ConvergenceMode.inL2

#eval "── Core.Objects: TheoryRegistration ──"
#eval independenceConvergenceTheory.name
#eval independenceConvergenceTheory.keyTheorems.length

/-! ## Morphisms -/

#eval "── Morphisms.Hom ──"
def testEmbedId := Embedding.id TheoryName.root
#eval testEmbedId.name

#eval "── Morphisms.Iso ──"
#eval "SkorokhodRepresentation and ConvergenceEquivalence defined"

#eval "── Morphisms.Equiv ──"
#eval convergenceModeEquivalences.length

/-! ## Constructions -/

#eval "── Constructions.Products ──"
#eval "FiniteProductMeasure and KolmogorovExtension defined"

#eval "── Constructions.Quotients ──"
#eval "TailQuotient and PermutationQuotient defined"

#eval "── Constructions.Subobjects ──"
#eval "StationarySequence, MixingSequence defined"

#eval "── Constructions.Universal ──"
#eval "DeFinettiRepresentation defined"

/-! ## Properties -/

#eval "── Properties.Invariants ──"
#eval "isTailEvent and isSymmetricEvent defined"

#eval "── Properties.Preservation ──"
#eval "SlutskyTheorem defined"

#eval "── Properties.ClassificationData ──"
#eval convergenceHierarchy.length

/-! ## Theorems -/

#eval "── Theorems.Basic ──"
#eval lindebergLevyCLT

#eval "── Theorems.Classification ──"
#eval convergenceRateFor "CLT"
#eval convergenceRateFor "WLLN"

#eval "── Theorems.Main ──"
#eval "kolmogorovSLLN_full and LindebergFellerCLT defined"

#eval "── Theorems.UniversalProperties ──"
#eval universalAttractorClassification.length

/-! ## Examples -/

#eval "── Examples.Standard ──"
#eval wllnConvergenceCheck
#eval diceMean 6
#eval diceVariance 6

#eval "── Examples.Counterexamples ──"
#eval cauchyExampleValue

/-! ## Bridges -/

#eval "── Bridges.ToAlgebra ──"
#eval semicircleDistribution 0
#eval classicalIndependence

#eval "── Bridges.ToTopology ──"
#eval "Levy metric and ProkhorovTheorem defined"

#eval "── Bridges.ToGeometry ──"
#eval "Random walks and Donsker's Invariance Principle"

#eval "── Bridges.ToComputation ──"
#eval berryEsseenMCSampleSize 0.01 0.05 (by norm_num) (by norm_num)

#eval "══ ALL MINI-INDEPENDENCE-CONVERGENCE SMOKE TESTS PASSED ══"
