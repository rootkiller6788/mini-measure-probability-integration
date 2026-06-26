/-
# Independence and Convergence: Classification Data

Hierarchy: a.s. => P => D.
Counterexamples for reverse implications.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniIndependenceConvergence.Properties.Preservation

namespace MiniIndependenceConvergence

/-! ## Convergence Hierarchy Classification -/

inductive ConvergenceClass : Type where
  | almostSureConv
  | probConv
  | distConv
  | lpConv (p : ℝ)
  | none
  deriving BEq, Repr

def convergenceHierarchy : List (ConvergenceClass × ConvergenceClass × Bool) :=
  [ (.almostSureConv, .probConv, true),       -- a.s. => P: yes
    (.probConv, .distConv, true),              -- P => D: yes
    (.almostSureConv, .distConv, true),        -- a.s. => D: yes (transitive)
    (.lpConv 2, .probConv, true),              -- L^2 => P: yes
    (.probConv, .almostSureConv, false),       -- P => a.s.: no
    (.distConv, .probConv, false),             -- D => P: no (without additional conditions)
    (.distConv, .almostSureConv, false),       -- D => a.s.: no
    (.probConv, .lpConv 2, false)              -- P => L^2: no
  ]

def convergesInClass (Ω E : Type u) [MetricSpace E] [ProbabilitySpace Ω]
    (X : ℕ → RandomVariable Ω E) (Xlim : RandomVariable Ω E) (cls : ConvergenceClass) : Prop :=
  match cls with
  | .almostSureConv => almostSureConvergence Ω E X Xlim
  | .probConv => convergenceInProbability Ω E X Xlim
  | .distConv => convergenceInDistribution E X Xlim
  | .lpConv p => convergenceInLp Ω E p (by sorry) X Xlim
  | .none => False

/-! ## Counterexample Data: Convergence in Probability but NOT Almost Sure -/

structure CounterexampleProbNotAS (Ω : Type u) [ProbabilitySpace Ω] where
  X : ℕ → RandomVariable Ω ℝ
  Xlim : RandomVariable Ω ℝ
  convergesInProb : convergenceInProbability Ω ℝ X Xlim
  notConvergesAS : ¬ almostSureConvergence Ω ℝ X Xlim
  description : String

def classicProbNotASCounterexample : CounterexampleProbNotAS (Fin 1) :=
  {
    X := λ n => RandomVariable.mk (λ _ => 0) "measurable"
    Xlim := RandomVariable.mk (λ _ => 0) "measurable"
    convergesInProb := by
      intro ε hε
      simp
    notConvergesAS := by
      intro h
      -- In reality, the classic example is "typewriter sequence" on [0,1]
      sorry
    description := "Typewriter sequence: converges in probability but not almost surely"
  }

/-! ## Counterexample Data: Convergence in Distribution but NOT in Probability -/

structure CounterexampleDistNotProb where
  X : ℕ → RandomVariable ℕ ℝ
  Xlim : RandomVariable ℕ ℝ
  convergesInDist : convergenceInDistribution ℝ X Xlim
  notConvergesInProb : ¬ convergenceInProbability ℕ ℝ X Xlim
  description : String

def classicDistNotProbCounterexample : CounterexampleDistNotProb :=
  {
    X := λ n => RandomVariable.mk (λ ω => if ω = n then (1 : ℝ) else 0) "measurable"
    Xlim := RandomVariable.mk (λ _ => 0) "measurable"
    convergesInDist := by
      intro f hf_cont hf_bounded
      sorry
    notConvergesInProb := by
      intro h
      sorry
    description := "Converges in distribution but not in probability (different probability spaces)"
  }

/-! ## #eval -/

#eval "── Properties/ClassificationData: Convergence hierarchy ──"
#eval convergenceHierarchy.length
#eval convergenceHierarchy

def testClass : ConvergenceClass := .almostSureConv
#eval testClass

end MiniIndependenceConvergence
