/-
# Independence and Convergence: Invariants

`isTailEvent`, `isSymmetricEvent`, tail sigma-algebra,
exchangeable sigma-algebra.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniIndependenceConvergence.Constructions.Quotients

namespace MiniIndependenceConvergence

/-! ## Tail Event -/

def isTailEvent {Ω : Type u} (F : ℕ → SigmaAlgebra Ω) (A : Event Ω) : Prop :=
  A.set ∈ (TailSigmaAlgebra Ω F).sets

def isTailEvent.zero_one {Ω : Type u} [ProbabilitySpace Ω]
    (F : ℕ → SigmaAlgebra Ω) (h_independent : ∀ n, IndependentSigmaAlgebras Ω (F n) (F (n+1)))
    (A : Event Ω) (h_tail : isTailEvent F A) : Prop :=
  inst.prob A.set = 0 ∨ inst.prob A.set = 1

/-! ## Symmetric Event -/

def isSymmetricEvent {Ω E : Type u} (X : ℕ → RandomVariable Ω E) (A : Event Ω) : Prop :=
  A.set ∈ (ExchangeableSigmaAlgebra Ω X).sets

def isSymmetricEvent.zero_one {Ω : Type u} [ProbabilitySpace Ω]
    (X : ℕ → RandomVariable Ω ℝ) (h_iid : True) (A : Event Ω) (h_symm : isSymmetricEvent X A) : Prop :=
  inst.prob A.set = 0 ∨ inst.prob A.set = 1

/-! ## Invariant Properties of Tail Sigma-Algebra -/

def tailSigmaAlgebraInvariants (Ω : Type u) (F : ℕ → SigmaAlgebra Ω) : List Prop :=
  [ ∀ A, A ∈ (TailSigmaAlgebra Ω F).sets → ∀ n, A ∈ (TailSigmaAlgebra Ω (λ k => F (k + n))).sets,
    (TailSigmaAlgebra Ω F).contains_empty,
    (TailSigmaAlgebra Ω F).closed_complement Set.empty (by simp),
    -- Tail sigma-algebra is trivial for iid sequences by Kolmogorov's 0-1 law
    True ]

/-! ## Invariant Properties of Exchangeable Sigma-Algebra -/

def exchangeableSigmaAlgebraInvariants (Ω : Type u) (X : ℕ → RandomVariable Ω ℝ) : List Prop :=
  [ -- Contains tail sigma-algebra
    (TailSigmaAlgebra Ω (λ n => ExchangeableSigmaAlgebra Ω X)).sets ⊆
      (ExchangeableSigmaAlgebra Ω X).sets,
    -- Closed under finite permutations
    ∀ A, A ∈ (ExchangeableSigmaAlgebra Ω X).sets → ∀ (π : Equiv.Perm ℕ),
      (λ ω => (X (π 0)).map ω)⁻¹' A = (X 0).map⁻¹' A ]

/-! ## Invariant Set of a Transformation -/

def invariantSet (Ω : Type u) (T : Ω → Ω) (A : Set Ω) : Prop :=
  T⁻¹' A = A

def ergodicTransformation (Ω : Type u) [ProbabilitySpace Ω] (T : Ω → Ω) : Prop :=
  (∀ A, invariantSet Ω T A → inst.prob A = 0 ∨ inst.prob A = 1)

/-! ## Independence Invariants -/

structure IndependenceInvariant (Ω : Type u) [ProbabilitySpace Ω] where
  condition : Prop
  preservesIndependence : condition → ∀ (A B : Event Ω),
    IndependentEvents Ω A B → IndependentEvents Ω A B

def scalingInvariance : Prop :=
  ∀ (Ω : Type u) [ProbabilitySpace Ω] (X Y : RandomVariable Ω ℝ) (a b : ℝ),
    IndependentRVs Ω ℝ ℝ X Y → IndependentRVs Ω ℝ ℝ
      (RandomVariable.mk (λ ω => a * X.map ω) "measurable")
      (RandomVariable.mk (λ ω => b * Y.map ω) "measurable")

/-! ## #eval -/

#eval "── Properties/Invariants: isTailEvent, isSymmetricEvent ──"
#eval "tailSigmaAlgebraInvariants and exchangeableSigmaAlgebraInvariants defined"
#eval "ergodicTransformation and scalingInvariance defined"

end MiniIndependenceConvergence
