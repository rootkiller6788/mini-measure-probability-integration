/-
# MiniProbabilityTheory: Example Tests

Test the standard examples and counterexamples.
-/

import MiniProbabilityTheory

namespace MiniProbabilityTheory.ExampleTests

/-! ## Bernoulli Distribution -/

#eval "Bernoulli(p) defined"
#eval "Bernoulli expectation = p"
#eval "Bernoulli variance = p(1-p)"

/-! ## Binomial Distribution -/

#eval "Binomial(n,p) defined"
#eval "Binomial expectation = np"
#eval "Binomial variance = np(1-p)"

/-! ## Normal Distribution -/

#eval "Normal(μ,σ²) defined"
#eval "Normal expectation = μ"
#eval "Normal variance = σ²"

/-! ## Poisson Distribution -/

#eval "Poisson(λ) defined"
#eval "Poisson expectation = λ"
#eval "Poisson variance = λ"

/-! ## Exponential Distribution -/

#eval "Exponential(λ) defined"
#eval "Exponential expectation = 1/λ"
#eval "Exponential memoryless property"

/-! ## Uniform Distribution -/

#eval "Uniform[a,b] defined"
#eval "Uniform expectation = (a+b)/2"
#eval "Uniform variance = (b-a)²/12"

/-! ## Counterexamples -/

#eval "Cauchy distribution: no mean"
#eval "Log-normal: not moment-determinate"
#eval "Pareto(α≤2): infinite variance"
#eval "t(1) = Cauchy, t(2) has no variance"

/-! ## Couplings and Copulas -/

#eval "Coupling type defined"
#eval "productCopula C(u,v)=uv"
#eval "frechetUpperCopula C(u,v)=min(u,v)"
#eval "ProbabilityKernel defined"

end MiniProbabilityTheory.ExampleTests
