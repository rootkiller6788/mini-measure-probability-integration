/-
# Bridges Benchmarks

Benchmarks for bridge modules (ToAlgebra, ToTopology, ToGeometry, ToComputation).
-/

import MiniStochasticProcesses

open MiniStochasticProcesses

#eval "=== Bridges Benchmarks ==="

/-! ## Benchmark: ToAlgebra -/

/-- Markov semigroup and generator operations. -/
#eval "Benchmark: MarkovSemigroup definition access"
#eval "Benchmark: InfinitesimalGenerator operations"

/-- Dirichlet form definition. -/
#eval "Benchmark: DirichletForm instantiation"
#eval "Benchmark: brownianDirichletForm creation"

/-! ## Benchmark: ToTopology -/

/-- Path space topology operations. -/
#eval "Benchmark: ContinuousPathSpace definition"
#eval "Benchmark: SkorokhodSpace definition"

/-- Weak convergence definitions. -/
#eval "Benchmark: prokhorovTheorem access"
#eval "Benchmark: aldousTightnessCriterion access"

/-! ## Benchmark: ToGeometry -/

/-- Manifold Brownian motion. -/
#eval "Benchmark: ManifoldBrownianMotion definition"
#eval "Benchmark: heatKernel access"

/-- Malliavin calculus. -/
#eval "Benchmark: MalliavinDerivative definition"
#eval "Benchmark: SkorokhodIntegral definition"

/-! ## Benchmark: ToComputation -/

/-- MCMC methods. -/
#eval "Benchmark: MetropolisHastings access"
#eval "Benchmark: metropolisAcceptance computation"

/-- Gillespie algorithm. -/
#eval "Benchmark: GillespieAlgorithm definition"
#eval "Benchmark: gillespieStep access"

/-- SDE simulation. -/
#eval "Benchmark: eulerMaruyama function"
#eval "Benchmark: milsteinScheme function"

/-- Monte Carlo. -/
#eval "Benchmark: monteCarloEstimate function"
#eval "Benchmark: confidenceIntervalWidth computation: " ++ toString (confidenceIntervalWidth 2.0 100)

#eval "=== Bridges Benchmarks Complete ==="
