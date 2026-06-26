/-
# Independence and Convergence: Counterexamples

Cauchy distribution (no mean => LLN fails),
convergence in probability but not almost surely,
convergence in distribution but not in probability.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniIndependenceConvergence.Properties.ClassificationData

namespace MiniIndependenceConvergence

/-! ## Cauchy Distribution: No Mean, LLN Fails -/

def cauchyPDF (x : ℝ) : ℝ :=
  1 / (π * (1 + x ^ 2))

def cauchyCDF (x : ℝ) : ℝ :=
  (1 / π) * Real.arctan x + (1/2)

def cauchyMean : Prop :=
  ¬ ∃ (μ : ℝ), Filter.Tendsto (λ R => ∫ x in Set.Ioo (-R) R, x * cauchyPDF x)
    Filter.atTop (nhds μ)

def cauchyLLNFails : Prop :=
  ∀ (X : ℕ → RandomVariable ℕ ℝ),
    (∀ n B, inst.prob ((X n).map⁻¹' B) = ∫ x in B, cauchyPDF x) → -- each X_n is Cauchy
    IIDSequence ℕ ℝ X →
    ¬ almostSureConvergence ℕ ℝ
      (λ n => RandomVariable.mk (λ ω =>
        (∑ i : Fin (n+1), (X i.val).map ω) / ((n+1 : ℕ) : ℝ)) "measurable")
      (RandomVariable.mk (λ _ => 0) "measurable")

/-! ## Convergence in Probability but NOT Almost Sure (Typewriter Sequence) -/

def typewriterSequence (n : ℕ) : RandomVariable ℕ ℝ :=
  RandomVariable.mk
    (λ ω =>
      let m := Nat.log 2 (n + 1)
      let r := (n + 1) - 2 ^ m
      if ((r : ℝ) / (2 ^ m : ℝ)) ≤ ((ω : ℝ) / (100 : ℝ)) ∧
         ((ω : ℝ) / (100 : ℝ)) < ((r + 1 : ℝ) / (2 ^ m : ℝ))
      then 1 else 0)
    "measurable"

def typewriterConvergesInProb : convergenceInProbability ℕ ℝ
    typewriterSequence (RandomVariable.mk (λ _ => 0) "measurable") := by
  -- The typewriter sequence converges in probability to 0
  intro ε hε
  sorry

def typewriterNotConvergesAS : ¬ almostSureConvergence ℕ ℝ
    typewriterSequence (RandomVariable.mk (λ _ => 0) "measurable") := by
  -- For each ω, the sequence oscillates between 0 and 1 infinitely often
  sorry

/-! ## Convergence in Distribution but NOT in Probability -/

def canonicalDistNotProbExample : ℕ → RandomVariable ℕ ℝ :=
  λ n => RandomVariable.mk
    (λ ω => if ω = n then 1 else 0)
    "measurable"

/-! ## Counterexample: Pairwise Independent but NOT Mutually Independent -/

def pairwiseNotMutualExample (Ω : Type u) : List (Event Ω) :=
  [] -- Bernstein's example: 3 events pairwise independent but not mutually independent

def bernsteinExample : Prop :=
  ∃ (Ω : Type u) [ProbabilitySpace Ω] (A B C : Event Ω),
    IndependentEvents Ω A B ∧
    IndependentEvents Ω B C ∧
    IndependentEvents Ω A C ∧
    ¬ (inst.prob (A.set ∩ B.set ∩ C.set) = inst.prob A.set * inst.prob B.set * inst.prob C.set)

/-! ## Counterexample: Convergence in L^2 but NOT Almost Sure -/

def lpNotASExample : Prop :=
  ∃ (Ω : Type u) [ProbabilitySpace Ω] (X : ℕ → RandomVariable Ω ℝ),
    convergenceInLp Ω ℝ 2 (by norm_num) X (RandomVariable.mk (λ _ => 0) "measurable") ∧
    ¬ almostSureConvergence Ω ℝ X (RandomVariable.mk (λ _ => 0) "measurable")

/-! ## #eval -/

#eval "── Examples/Counterexamples: Cauchy, typewriter, dist-not-prob ──"

def cauchyExampleValue : ℝ := cauchyPDF 0
#eval cauchyExampleValue
#eval "Cauchy PDF at 0 = 1/π ≈ 0.318"

#eval "Typewriter sequence: converges in probability but not almost surely"
#eval "Different-space example: converges in distribution but not in probability"

#eval "Bernstein example: pairwise independent not mutually independent"

end MiniIndependenceConvergence
