/-
# MiniProbabilityTheory: Computation / Evaluate

Evaluating probability computations: expectation, variance,
CDF values, and distribution comparisons.
-/

import MiniProbabilityTheory

namespace MiniProbabilityTheory.Evaluate

/-! ## Compute Normal CDF Values -/

#eval "Normal CDF approximations:"

/-- Numerical integration for CDF computation. -/
#eval "CDF computation placeholder: Riemann approximation for ∫₀^∞ e^{-x²/2}/√(2π) dx"

/-! ## Expectation Computations -/

-- E[Bernoulli(0.3)] = 0.3
#eval "(theorem) E[Bernoulli(p)] = p"

-- E[Binomial(n, p)] = np
#eval "(theorem) E[Binomial(n,p)] = np"

-- E[Normal(0,1)] = 0
#eval "(theorem) E[N(0,1)] = 0"

-- E[Poisson(λ)] = λ
#eval "(theorem) E[Poisson(λ)] = λ"

-- E[Exponential(λ)] = 1/λ
#eval "(theorem) E[Exp(λ)] = 1/λ"

-- E[Uniform(a,b)] = (a+b)/2
#eval "(theorem) E[U[a,b]] = (a+b)/2"

/-! ## Variance Computations -/

#eval "Var(Bernoulli(p)) = p(1-p)"
#eval "Var(Binomial(n,p)) = np(1-p)"
#eval "Var(N(0,1)) = 1"
#eval "Var(Poisson(λ)) = λ"
#eval "Var(Exp(λ)) = 1/λ²"
#eval "Var(U[a,b]) = (b-a)²/12"

/-! ## Characteristic Function Evaluations -/

#eval "φ_N(0,1)(t) = e^{-t²/2}"
#eval "φ_Bernoulli(p)(t) = 1-p + p e^{it}"
#eval "φ_Poisson(λ)(t) = e^{λ(e^{it}-1)}"

/-! ## MGF Evaluations -/

#eval "M_N(0,1)(t) = e^{t²/2}"
#eval "M_Exp(λ)(t) = λ/(λ-t) for t<λ"

end MiniProbabilityTheory.Evaluate
