/-
# MiniProbabilityTheory: Computation / Algorithms

Sampling algorithms, integration methods, and numerical probability.
-/

import MiniProbabilityTheory

namespace MiniProbabilityTheory.Algorithms

/-! ## Sampling Algorithms -/

#eval "Box-Muller: normal sampling from uniform"
#eval "Polar method (Marsaglia): avoid trig functions"
#eval "Inverse CDF: F^{-1}(U) ~ F"
#eval "Rejection sampling: accept/reject with proposal"
#eval "Importance sampling: weighted Monte Carlo"

/-! ## Numerical Integration -/

#eval "Monte Carlo: (1/n)∑f(X_i) → E[f(X)], error O(1/√n)"
#eval "Quasi-Monte Carlo: low-discrepancy sequences"
#eval "Gaussian quadrature for smooth integrands"

/-! ## MCMC Algorithms -/

#eval "Metropolis-Hastings: general MCMC kernel"
#eval "Gibbs sampling: conditional distributions"
#eval "Hamiltonian Monte Carlo (HMC): physics-inspired"
#eval "Slice sampling: uniform under the curve"

/-! ## Distribution Fitting -/

#eval "Maximum likelihood estimation (MLE)"
#eval "Method of moments"
#eval "EM algorithm for mixture models"
#eval "Bayesian posterior sampling"

/-! ## Random Number Generation -/

#eval "Linear congruential generators (LCG)"
#eval "Mersenne Twister (MT19937)"
#eval "Cryptographic randomness (entropy sources)"

/-! ## Convergence Diagnostics -/

#eval "Gelman-Rubin statistic (R-hat)"
#eval "Effective sample size (ESS)"
#eval "Trace plots and autocorrelation"
#eval "Burn-in and thinning"

end MiniProbabilityTheory.Algorithms
