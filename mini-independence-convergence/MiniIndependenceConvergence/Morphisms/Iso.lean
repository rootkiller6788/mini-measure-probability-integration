/-
# Independence and Convergence: Isomorphisms

Equivalence of convergence types under conditions.
Skorokhod representation theorem:
convergence in distribution = almost sure convergence on a different space.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniObjectKernel.Morphisms.Iso

namespace MiniIndependenceConvergence

/-! ## Equivalence of Convergence Types -/

structure ConvergenceEquivalence (Ω E : Type u) [MetricSpace E] [ProbabilitySpace Ω] where
  mode1 : ConvergenceMode
  mode2 : ConvergenceMode
  condition : Prop
  equivalenceProof : condition → (∀ (X : ℕ → RandomVariable Ω E) (Y : RandomVariable Ω E),
    (match mode1 with
     | .almostSure => almostSureConvergence Ω E X Y
     | .inProbability => convergenceInProbability Ω E X Y
     | .inLp p => convergenceInLp Ω E p (by sorry) X Y
     | .inDistribution => convergenceInDistribution E X Y
     | .inL1 => convergenceInLp Ω E 1 (by norm_num) X Y
     | .inL2 => convergenceInLp Ω E 2 (by norm_num) X Y) ↔
    (match mode2 with
     | .almostSure => almostSureConvergence Ω E X Y
     | .inProbability => convergenceInProbability Ω E X Y
     | .inLp p => convergenceInLp Ω E p (by sorry) X Y
     | .inDistribution => convergenceInDistribution E X Y
     | .inL1 => convergenceInLp Ω E 1 (by norm_num) X Y
     | .inL2 => convergenceInLp Ω E 2 (by norm_num) X Y))

/-! ## Skorokhod Representation Theorem -/

def SkorokhodRepresentation (E : Type u) [MetricSpace E] : Prop :=
  ∀ (μ_n : ℕ → ProbabilityMeasure E) (μ : ProbabilityMeasure E),
    (∀ (f : E → ℝ), Continuous f → Bounded f →
      Filter.Tendsto (λ n => ∫ x, f x ∂ (μ_n n)) Filter.atTop (nhds (∫ x, f x ∂ μ))) →
    ∃ (Ω' : Type u) [ProbabilitySpace Ω'] (X_n : ℕ → RandomVariable Ω' E)
      (X : RandomVariable Ω' E),
      (∀ ω, Filter.Tendsto (λ n => (X_n n).map ω) Filter.atTop (nhds (X.map ω))) ∧
      (∀ n B, inst.prob ((X_n n).map⁻¹' B) = probMeasureToProb (μ_n n) B) ∧
      (∀ B, inst.prob (X.map⁻¹' B) = probMeasureToProb μ B)

structure ProbabilityMeasure (E : Type u) [MeasurableSpace E] where
  measure : Set E → ℝ
  isProbability : measure Set.univ = 1

def probMeasureToProb {E : Type u} [MeasurableSpace E] (μ : ProbabilityMeasure E) (B : Set E) : ℝ :=
  μ.measure B

/-! ## Equivalence of Convergence in Distribution -/

def convergenceInDistributionViaSkorokhod (E : Type u) [MetricSpace E]
    (X : ℕ → RandomVariable ℕ E) (Xlim : RandomVariable ℕ E) : Prop :=
  ∃ (Ω' : Type u) [ProbabilitySpace Ω'] (X' : ℕ → RandomVariable Ω' E)
    (Xlim' : RandomVariable Ω' E),
    (∀ ω, Filter.Tendsto (λ n => (X' n).map ω) Filter.atTop (nhds (Xlim'.map ω))) ∧
    (∀ n, ∀ (f : E → ℝ), Continuous f → Bounded f → ∫ ω, f ((X' n).map ω) = ∫ ω, f ((X n).map ω)) ∧
    (∀ (f : E → ℝ), Continuous f → Bounded f → ∫ ω, f (Xlim'.map ω) = ∫ ω, f (Xlim.map ω))

/-! ## Independent Events Iso -/

structure IndependenceIso (Ω₁ Ω₂ : Type u) [ProbabilitySpace Ω₁] [ProbabilitySpace Ω₂] where
  eventMap : Event Ω₁ → Event Ω₂
  invEventMap : Event Ω₂ → Event Ω₁
  preservesProbability : ∀ A, inst.prob (A.set) = inst.prob ((eventMap A).set)
  preservesIndependence : ∀ A B, IndependentEvents Ω₁ A B ↔ IndependentEvents Ω₂ (eventMap A) (eventMap B)

/-! ## #eval -/

#eval "── Morphisms/Iso: ConvergenceEquivalence, SkorokhodRepresentation ──"
#eval "Skorokhod representation theorem statement defined"

def sampleMeasure : ProbabilityMeasure ℝ where
  measure B := 0
  isProbability := by
    simp

#eval "ProbabilityMeasure defined"

end MiniIndependenceConvergence
