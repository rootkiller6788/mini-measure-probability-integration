/-
# Independence and Convergence: Preservation

Independence under deterministic transformations.
Convergence preserved under continuous maps.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniIndependenceConvergence.Properties.Invariants

namespace MiniIndependenceConvergence

/-! ## Independence Preserved Under Transformations -/

def independenceUnderDeterministicTransform (Ω E₁ E₂ : Type u) [ProbabilitySpace Ω] : Prop :=
  ∀ (X Y : RandomVariable Ω E₁) (f g : E₁ → E₂),
    IndependentRVs Ω E₁ E₁ X Y →
    IndependentRVs Ω E₂ E₂
      (RandomVariable.mk (λ ω => f (X.map ω)) "measurable")
      (RandomVariable.mk (λ ω => g (Y.map ω)) "measurable")

def independenceUnderMeasurableTransform (Ω E₁ E₂ : Type u) [ProbabilitySpace Ω] : Prop :=
  ∀ (X Y : RandomVariable Ω E₁) (f g : E₁ → E₂),
    (IndependentRVs Ω E₁ E₁ X Y) →
    IndependentRVs Ω E₂ E₂
      (RandomVariable.mk (λ ω => f (X.map ω)) "measurable")
      (RandomVariable.mk (λ ω => g (Y.map ω)) "measurable")

/-! ## Convergence Preserved Under Continuous Maps -/

def convergenceProbPreservedContinuous (Ω E F : Type u) [MetricSpace E] [MetricSpace F]
    [ProbabilitySpace Ω] : Prop :=
  ∀ (X : ℕ → RandomVariable Ω E) (Xlim : RandomVariable Ω E) (g : E → F),
    Continuous g →
    convergenceInProbability Ω E X Xlim →
    convergenceInProbability Ω F
      (λ n => RandomVariable.mk (λ ω => g ((X n).map ω)) "measurable")
      (RandomVariable.mk (λ ω => g (Xlim.map ω)) "measurable")

def convergenceDistrPreservedContinuous (E F : Type u) [MetricSpace E] [MetricSpace F] : Prop :=
  ∀ (X : ℕ → RandomVariable ℕ E) (Xlim : RandomVariable ℕ E) (g : E → F),
    Continuous g →
    convergenceInDistribution E X Xlim →
    convergenceInDistribution F
      (λ n => RandomVariable.mk (λ ω => g ((X n).map ω)) "measurable")
      (RandomVariable.mk (λ ω => g (Xlim.map ω)) "measurable")

/-! ## Convergence Preserved Under Addition -/

def convergencePreservedAddition (Ω : Type u) [ProbabilitySpace Ω] : Prop :=
  ∀ (X Y : ℕ → RandomVariable Ω ℝ) (Xlim Ylim : RandomVariable Ω ℝ),
    convergenceInProbability Ω ℝ X Xlim →
    convergenceInProbability Ω ℝ Y Ylim →
    convergenceInProbability Ω ℝ
      (λ n => RandomVariable.mk (λ ω => (X n).map ω + (Y n).map ω) "measurable")
      (RandomVariable.mk (λ ω => Xlim.map ω + Ylim.map ω) "measurable")

/-! ## Slutsky's Theorem (preservation under + and *) -/

def SlutskyTheorem (Ω : Type u) [ProbabilitySpace Ω] : Prop :=
  ∀ (X Y : ℕ → RandomVariable Ω ℝ) (Xlim : RandomVariable Ω ℝ) (c : ℝ),
    convergenceInDistribution ℝ X Xlim →
    convergenceInProbability Ω ℝ Y (RandomVariable.mk (λ _ => c) "measurable") →
    (convergenceInDistribution ℝ
      (λ n => RandomVariable.mk (λ ω => (X n).map ω + (Y n).map ω) "measurable")
      (RandomVariable.mk (λ ω => Xlim.map ω + c) "measurable")) ∧
    (convergenceInDistribution ℝ
      (λ n => RandomVariable.mk (λ ω => (X n).map ω * (Y n).map ω) "measurable")
      (RandomVariable.mk (λ ω => Xlim.map ω * c) "measurable"))

/-! ## Continuous Mapping Theorem -/

def ContinuousMappingTheorem (E F : Type u) [MetricSpace E] [MetricSpace F] : Prop :=
  ∀ (X : ℕ → RandomVariable ℕ E) (Xlim : RandomVariable ℕ E) (g : E → F),
    Continuous g →
    convergenceInDistribution E X Xlim →
    convergenceInDistribution F
      (λ n => RandomVariable.mk (λ ω => g ((X n).map ω)) "measurable")
      (RandomVariable.mk (λ ω => g (Xlim.map ω)) "measurable")

/-! ## #eval -/

#eval "── Properties/Preservation: Independence & convergence under transformations ──"
#eval "independenceUnderDeterministicTransform defined"
#eval "SlutskyTheorem and ContinuousMappingTheorem defined"
#eval "convergenceProbPreservedContinuous defined"

end MiniIndependenceConvergence
