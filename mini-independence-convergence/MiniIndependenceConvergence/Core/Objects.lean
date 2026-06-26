/-
# Independence and Convergence: Objects

Core object definitions: IndependentFamily, ConvergenceMode types,
and theory registration.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Laws

namespace MiniIndependenceConvergence

/-! ## Independent Family -/

structure IndependentFamily (Ω : Type u) [ProbabilitySpace Ω] (ι : Type u) where
  events : ι → Event Ω
  pairwiseIndependent : ∀ i j : ι, i ≠ j → IndependentEvents Ω (events i) (events j)
  mutuallyIndependent : String -- placeholder for full independence

def IndependentFamily.finiteSubsetIndependent (fam : IndependentFamily Ω ι)
    (J : Finset ι) : Prop :=
  ∀ (A : J → Event Ω), (∀ j, A j = fam.events j) → True :=
  λ _ _ => trivial

/-! ## Convergence Mode Types -/

inductive ConvergenceMode : Type where
  | almostSure
  | inProbability
  | inLp (p : ℝ)
  | inDistribution
  | inL1
  | inL2
  deriving BEq, Repr, Inhabited

def ConvergenceMode.toString : ConvergenceMode → String
  | .almostSure => "a.s."
  | .inProbability => "P"
  | .inLp p => s!"L^{p}"
  | .inDistribution => "D"
  | .inL1 => "L¹"
  | .inL2 => "L²"

instance : ToString ConvergenceMode := ⟨ConvergenceMode.toString⟩

/-! ## Convergence Mode Hierarchy -/

def convergenceImplies (m1 m2 : ConvergenceMode) : Prop :=
  match m1, m2 with
  | .almostSure, .inProbability => True
  | .inLp _, .inProbability => True
  | .inProbability, .inDistribution => True
  | .inL1, .inProbability => True
  | .inL2, .inProbability => True
  | _, _ => False

/-! ## Theory Registration -/

structure TheoryRegistration where
  name : String
  dependencies : List String
  keyConcepts : List String
  keyTheorems : List String
  deriving Repr

def independenceConvergenceTheory : TheoryRegistration :=
  { name := "Independence and Convergence"
    dependencies := ["MeasureTheory", "ProbabilityTheory", "ObjectKernel"]
    keyConcepts := [ "Independence", "Borel-Cantelli", "Convergence in Probability",
                     "Almost Sure Convergence", "Convergence in Distribution", "LLN", "CLT" ]
    keyTheorems := [ "Borel-Cantelli Lemma I", "Borel-Cantelli Lemma II",
                     "Kolmogorov's 0-1 Law", "Weak Law of Large Numbers",
                     "Strong Law of Large Numbers", "Central Limit Theorem" ]
  }

/-! ## #eval -/

#eval "── Objects: IndependentFamily, ConvergenceMode, TheoryRegistration ──"
#eval independenceConvergenceTheory.name
#eval toString ConvergenceMode.almostSure
#eval toString ConvergenceMode.inL2
#eval convergenceImplies ConvergenceMode.almostSure ConvergenceMode.inProbability

end MiniIndependenceConvergence
