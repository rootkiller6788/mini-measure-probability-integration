/-
# Cambridge Part III: Advanced Probability

Benchmark: Cambridge Part III Advanced Probability course topics.
Covers: Measure-theoretic foundations, conditional expectation,
martingales, Brownian motion, stochastic calculus.
-/

import MiniProbabilityTheory

namespace MiniProbabilityTheory.CambridgePartIII

/-! ## Measure-Theoretic Probability Foundations -/

#eval "ProbabilitySpace as measure space with total mass 1"
#eval "RandomVariable as measurable function Ω→ℝ"
#eval "Distribution as pushforward measure"
#eval "CDF, PDF via Radon-Nikodym"

/-! ## Conditional Expectation -/

#eval "Conditional expectation E[X|G] as Radon-Nikodym derivative"
#eval "Tower property: E[E[X|G₂]|G₁] = E[X|G₁] for G₁⊆G₂"
#eval "Regular conditional probability kernel"

/-! ## Martingales -/

#eval "Martingale: E[M_{n+1}|F_n] = M_n"
#eval "Doob's optional stopping theorem"
#eval "Martingale convergence theorem"

/-! ## Limit Theorems -/

#eval "Strong Law of Large Numbers: (1/n)∑X_i → μ a.s."
#eval "Central Limit Theorem: (∑X_i-nμ)/√(nσ²) → N(0,1)"
#eval "Law of Iterated Logarithm"

/-! ## Weak Convergence -/

#eval "Portmanteau theorem: equivalent conditions"
#eval "Prokhorov metric and tightness"
#eval "Characteristic function continuity (Levy)"

/-! ## Brownian Motion -/

#eval "Kolmogorov extension theorem for constructing Brownian motion"
#eval "Brownian motion: continuous sample paths, independent increments"
#eval "Donsker's invariance principle: random walk → BM"

end MiniProbabilityTheory.CambridgePartIII
