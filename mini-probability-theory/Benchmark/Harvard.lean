/-
# Harvard Statistics 210/211: Probability Theory

Benchmark: Harvard Statistics 210 (Probability I) and 211 (Probability II)
course topics. Covers measure-theoretic probability and statistical inference.
-/

import MiniProbabilityTheory

namespace MiniProbabilityTheory.Harvard

/-! ## Probability I: Measure Theory Foundations -/

#eval "Probability space as measure space"
#eval "Random variables as measurable functions"
#eval "Expectation as Lebesgue integral"
#eval "Radon-Nikodym theorem and conditional expectation"

/-! ## Probability II: Limit Theorems -/

#eval "Law of large numbers (weak and strong)"
#eval "Central limit theorem and Berry-Esseen"
#eval "Characteristic function methods"
#eval "Convergence in distribution, probability, L^p, a.s."

/-! ## Distribution Theory -/

#eval "Common families: Normal, χ², t, F, Gamma, Beta"
#eval "Exponential family of distributions"
#eval "Sufficiency and completeness"
#eval "Moment generating functions"

/-! ## Information Theory -/

#eval "Shannon entropy H(X) = -∫ f log f"
#eval "Mutual information I(X;Y)"
#eval "Fisher information and Cramer-Rao bound"
#eval "KL divergence and exponential families"

/-! ## Computational Methods -/

#eval "Monte Carlo integration: O(1/√n) error"
#eval "Inverse CDF sampling method"
#eval "Rejection sampling"
#eval "Importance sampling"
#eval "MCMC: Metropolis-Hastings"

/-! ## Advanced Topics -/

#eval "Martingales and optional stopping"
#eval "Brownian motion as Gaussian process"
#eval "Empirical processes and Glivenko-Cantelli"
#eval "Bootstrap and resampling methods"

end MiniProbabilityTheory.Harvard
