/-
# Core Coverage Benchmark

Complete coverage of probability theory core concepts:
Probability spaces, random variables, distributions, expectation,
conditional probability, limit theorems, and stochastic processes.
-/

import MiniProbabilityTheory

namespace MiniProbabilityTheory.CoreCoverage

/-! ## Probability Spaces -/

#eval "ProbabilitySpace: (Ω, F, P) with P(Ω)=1"
#eval "Product probability space: Ω₁⊗Ω₂"
#eval "Countable product space for sequences"

/-! ## Random Variables -/

#eval "RandomVariable: measurable Ω→ℝ"
#eval "Equality in distribution: X≗Y"
#eval "Almost sure equality: X≗ₐₛY"
#eval "Independence characterization"

/-! ## Distributions -/

#eval "Absolutely continuous / discrete / singular decomposition"
#eval "Normal, Exponential, Poisson, Binomial, Gamma, Beta"
#eval "Chi-squared, Student's t, Cauchy, Pareto, Uniform"
#eval "Mixture distributions"

/-! ## Expectation and Variance -/

#eval "Linearity of expectation"
#eval "Variance formula: Var(X)=E[X²]-(E[X])²"
#eval "Markov and Chebyshev inequalities"
#eval "Cauchy-Schwarz: E[XY]²≤E[X²]E[Y²]"
#eval "Jensen inequality"

/-! ## Conditional Probability -/

#eval "Conditional probability P(A|B)=P(A∩B)/P(B)"
#eval "Bayes theorem"
#eval "Law of total probability"
#eval "Conditional expectation as Radon-Nikodym derivative"

/-! ## Limit Theorems -/

#eval "Weak Law of Large Numbers"
#eval "Strong Law of Large Numbers"
#eval "Central Limit Theorem"
#eval "Berry-Esseen bound O(1/√n)"
#eval "Glivenko-Cantelli: empirical CDF→true CDF"

/-! ## Transform Methods -/

#eval "Characteristic function: φ_X(t)=E[e^{itX}]"
#eval "Uniqueness of characteristic function"
#eval "Moment generating function"
#eval "Probability generating function"
#eval "Cumulant generating function"

/-! ## Metrics on Distributions -/

#eval "Total variation distance"
#eval "Wasserstein distance (Earth Mover)"
#eval "Kullback-Leibler divergence"
#eval "Hellinger distance"
#eval "Prokhorov metric"

/-! ## Stochastic Processes -/

#eval "Kolmogorov extension theorem"
#eval "De Finetti theorem: exchangeability = conditional i.i.d."
#eval "Markov chains (MCMC)"
#eval "Brownian motion construction"

end MiniProbabilityTheory.CoreCoverage
