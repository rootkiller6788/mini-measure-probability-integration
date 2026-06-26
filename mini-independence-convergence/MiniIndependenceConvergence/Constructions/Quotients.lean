/-
# Independence and Convergence: Quotients

Tail equivalence, exchangeable sigma-algebra,
Hewitt-Savage zero-one law.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniIndependenceConvergence.Morphisms.Equiv

namespace MiniIndependenceConvergence

/-! ## Tail Equivalence -/

def tailEquivalent {Ω E : Type u} (X Y : ℕ → RandomVariable Ω E) : Prop :=
  ∃ N : ℕ, ∀ n ≥ N, X n = Y n

def tailEquivalenceClass {Ω E : Type u} (X : ℕ → RandomVariable Ω E) :
    Set (ℕ → RandomVariable Ω E) :=
  { Y : ℕ → RandomVariable Ω E | tailEquivalent X Y }

/-! ## Exchangeable Sigma-Algebra -/

def ExchangeableSigmaAlgebra (Ω : Type u) (X : ℕ → RandomVariable Ω ℝ) : SigmaAlgebra Ω :=
  SigmaAlgebra.mk
    { A : Set Ω | ∀ (π : Equiv.Perm ℕ), (λ ω => X (π ω))⁻¹' (X 0)⁻¹' A = (X 0)⁻¹' A }
    (by
      intro π
      simp)
    (by
      intro A hA π
      specialize hA π
      sorry)
    (by
      intro A hA
      sorry)

def ExchangeableSequence (Ω E : Type u) [ProbabilitySpace Ω]
    (X : ℕ → RandomVariable Ω E) : Prop :=
  ∀ (π : Equiv.Perm ℕ) (n : ℕ) (B : Set (Fin n → E)),
    inst.prob {ω | (λ i : Fin n => (X i.val).map ω) ∈ B} =
    inst.prob {ω | (λ i : Fin n => (X (π i.val)).map ω) ∈ B}

/-! ## Hewitt-Savage Zero-One Law -/

def HewittSavageZeroOneLaw (Ω : Type u) [ProbabilitySpace Ω]
    (X : ℕ → RandomVariable Ω ℝ) (h_iid : True) : Prop :=
  ∀ A, A ∈ (ExchangeableSigmaAlgebra Ω X).sets →
    inst.prob A = 0 ∨ inst.prob A = 1

/-! ## Tail Quotient Space -/

structure TailQuotient (Ω : Type u) [ProbabilitySpace Ω] (F : ℕ → SigmaAlgebra Ω) where
  underlying : Ω
  tailAlgebra : SigmaAlgebra Ω := TailSigmaAlgebra Ω F

def tailQuotientProjection {Ω : Type u} [ProbabilitySpace Ω] (F : ℕ → SigmaAlgebra Ω)
    (ω : Ω) : TailQuotient Ω F :=
  { underlying := ω }

/-! ## Exchangeable Quotient by Permutation Group -/

structure PermutationQuotient (Ω E : Type u) (X : ℕ → RandomVariable Ω E) where
  orbit : Set Ω
  representative : Ω
  symmetric : ∀ ω ∈ orbit, ∀ (π : Equiv.Perm ℕ),
    (λ n => (X n).map ω) = (λ n => (X (π n)).map (representative))

/-! ## #eval -/

#eval "── Constructions/Quotients: Tail equivalence, exchangeable sigma-algebra ──"
#eval "TailQuotient and HewittSavageZeroOneLaw defined"
#eval "PermutationQuotient structure defined"

end MiniIndependenceConvergence
