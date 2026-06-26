/-
# Independence and Convergence: Equivalences

Equivalent characterizations of independence,
tail sigma-algebra equivalences.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniObjectKernel.Morphisms.Equivalence

namespace MiniIndependenceConvergence

/-! ## Equivalent Characterizations of Independence -/

def independenceCharacterizations (Ω : Type u) [ProbabilitySpace Ω] : List String :=
  [ "P(A ∩ B) = P(A)P(B) for all A, B",
    "Conditional probability P(A|B) = P(A) when P(B) > 0",
    "sigma-algebras generated are independent",
    "Joint distribution factors as product of marginals",
    "Characteristic functions factor: φ_{X+Y}(t) = φ_X(t)φ_Y(t)" ]

def IndependenceCharacterizationEquivalence (Ω : Type u) [ProbabilitySpace Ω]
    (A B : Event Ω) : Prop :=
  -- These are all equivalent for events
  IndependentEvents Ω A B ↔
  (inst.prob B.set > 0 → inst.prob (A.set ∩ B.set) / inst.prob B.set = inst.prob A.set)

/-! ## Pairwise vs Mutual Independence -/

def pairwiseIndependence (Ω : Type u) [ProbabilitySpace Ω] (fam : ℕ → Event Ω) : Prop :=
  ∀ i j, i ≠ j → IndependentEvents Ω (fam i) (fam j)

def mutualIndependence (Ω : Type u) [ProbabilitySpace Ω] (fam : ℕ → Event Ω) : Prop :=
  ∀ (J : Finset ℕ), inst.prob (⋂ j ∈ J, (fam j).set) = ∏ j ∈ J, inst.prob (fam j).set

def pairwiseImpliesMutualCounterexample : Prop :=
  ∃ (Ω : Type u) [ProbabilitySpace Ω] (fam : ℕ → Event Ω),
    pairwiseIndependence Ω fam ∧ ¬ mutualIndependence Ω fam

/-! ## Tail Sigma-Algebra Equivalence -/

def tailSigmaAlgebraEq (Ω : Type u) (F G : ℕ → SigmaAlgebra Ω) : Prop :=
  (TailSigmaAlgebra Ω F).sets = (TailSigmaAlgebra Ω G).sets

def tailSigmaAlgebraTrivialProps (Ω : Type u) [ProbabilitySpace Ω]
    (F : ℕ → SigmaAlgebra Ω) : List Prop :=
  [ ∀ n, (F n).sets ⊆ (TailSigmaAlgebra Ω F).sets,
    -- intersection over larger n gives smaller sigma-algebra
    (⋂ n, (F n).sets) ⊆ (TailSigmaAlgebra Ω F).sets ]

/-! ## Exchangeable Sigma-Algebra vs Tail Sigma-Algebra -/

def exchangeableSigmaAlgebra (Ω : Type u) (X : ℕ → RandomVariable Ω ℝ) : SigmaAlgebra Ω :=
  SigmaAlgebra.mk
    Set.univ
    (by simp)
    (by
      intro A hA
      simp)
    (by
      intro A hA
      simp)

def exchangeableVsTail (Ω : Type u) [ProbabilitySpace Ω]
    (X : ℕ → RandomVariable Ω ℝ) : Prop :=
  (TailSigmaAlgebra Ω (λ n => exchangeableSigmaAlgebra Ω X)).sets ⊆
    (exchangeableSigmaAlgebra Ω X).sets

/-! ## Equivalence Chains -/

structure EquivalenceChain (α : Type u) (R : α → α → Prop) where
  nodes : List α
  edges : List (α × α)
  chain : ∀ (a b : α), (a, b) ∈ edges → R a b

def convergenceModeEquivalences : List (ConvergenceMode × ConvergenceMode × String) :=
  [ (.almostSure, .inProbability, "under uniform integrability"),
    (.inLp 2, .inL1, "on finite measure spaces"),
    (.inProbability, .inDistribution, "always holds"),
    (.almostSure, .inDistribution, "via Skorokhod") ]

/-! ## #eval -/

#eval "── Morphisms/Equiv: Independence characterizations, tail sigma-algebra ──"
#eval independenceCharacterizations (Fin 2)
#eval "pairwiseIndependence vs mutualIndependence defined"
#eval "exchangeableSigmaAlgebra defined"
#eval convergenceModeEquivalences.length

end MiniIndependenceConvergence
