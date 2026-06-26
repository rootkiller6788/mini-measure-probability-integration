/-
# Independence and Convergence: Laws

Axiom values for Borel-Cantelli lemmas, Kolmogorov zero-one law,
and convergence relationships.
-/

import MiniIndependenceConvergence.Core.Basic

namespace MiniIndependenceConvergence

/-! ## Borel-Cantelli Lemmas (axiom values) -/

def borelCantelli1 : String :=
  "For any events A_n, if sum of probabilities converges, then P(limsup A_n) = 0"

def borelCantelli2 : String :=
  "For independent events A_n, if sum of probabilities diverges, then P(limsup A_n) = 1"

/-! ## Kolmogorov Zero-One Law -/

def kolmogorovZeroOneLaw : String :=
  "Tail events of a sequence of independent sigma-algebras have probability 0 or 1"

/-! ## Convergence Relationships -/

def convergenceRelationships : String :=
  "Almost sure convergence => convergence in probability => convergence in distribution; L^p convergence => convergence in probability"

/-! ## Hierarchy Axiom Values -/

def asConvergenceImpliesProbConvergence : Prop :=
  ∀ (Ω E : Type u) [MetricSpace E] [ProbabilitySpace Ω] (X : ℕ → RandomVariable Ω E) (Y : RandomVariable Ω E),
    almostSureConvergence Ω E X Y → convergenceInProbability Ω E X Y

def lpConvergenceImpliesProbConvergence (p : ℝ) (h : p ≥ 1) : Prop :=
  ∀ (Ω E : Type u) [NormedAddCommGroup E] [ProbabilitySpace Ω] (X : ℕ → RandomVariable Ω E) (Y : RandomVariable Ω E),
    convergenceInLp Ω E p h X Y → convergenceInProbability Ω E X Y

def probConvergenceImpliesDistConvergence : Prop :=
  ∀ (E : Type u) [MetricSpace E] (X : ℕ → RandomVariable ℕ E) (Y : RandomVariable ℕ E),
    convergenceInProbability ℕ E X Y → convergenceInDistribution E X Y

/-! ## Independence Characterizations -/

def independenceProductCharacterization : String :=
  "X_1,...,X_n independent iff joint distribution = product of marginals"

def independenceSigmaAlgebraCharacterization : String :=
  "Sigma-algebras F,G independent iff P(A ∩ B) = P(A)P(B) for all A in F, B in G"

def kolmogorovExtensionLaw : String :=
  "Consistent finite-dimensional distributions extend uniquely to an infinite-dimensional probability measure"

/-! ## Law statements -/

def strongLawOfLargeNumbersStatement : String :=
  "For iid X_i with finite mean μ, (1/n)∑X_i → μ almost surely"

def centralLimitTheoremStatement : String :=
  "For iid X_i with finite variance, √n(̄X_n - μ)/σ → N(0,1) in distribution"

def lindebergFellerStatement : String :=
  "Lindeberg condition is necessary and sufficient for CLT under triangular array independence"

/-! ## #eval -/

#eval "── Laws defined: borelCantelli1, borelCantelli2, kolmogorovZeroOneLaw ──"
#eval borelCantelli1
#eval borelCantelli2
#eval kolmogorovZeroOneLaw
#eval convergenceRelationships

end MiniIndependenceConvergence
