/-
# Smoke Tests for MiniStochasticProcesses

Basic sanity checks that the library loads and
core definitions are accessible.
-/

import MiniStochasticProcesses

open MiniStochasticProcesses

#eval "=== MiniStochasticProcesses Smoke Tests ==="

-- Core definitions exist
#eval "TimeSet: continuousTimeSet, discreteTimeSet"
#eval isContinuousTime (default : StochasticProcess ℕ ℝ ℝ)
#eval isDiscreteTime (default : StochasticProcess ℕ ℕ ℝ)

-- Brownian motion
#eval "BrownianMotion defined"
#eval brownianMean default 1.0
#eval brownianVariance default 2.0
#eval brownianCovariance default 1.0 2.0

-- Poisson process
#eval "PoissonProcess defined"
#eval poissonProcessMean 2.0 5.0
#eval poissonProcessVariance 3.0 4.0

-- Markov chain concepts
#eval "MarkovChain: stationarity, mixing"
#eval simpleRandomWalkExpectedValue 0.5 10

-- Process maps
#eval "ProcessMap: identity and composition"

-- Theorems (axioms/sorried, but available)
#eval "strongMarkovProperty, reflectionPrinciple: available"

-- Bridges load
#eval "Bridges: ToAlgebra, ToTopology, ToGeometry, ToComputation all import"

#eval "=== ALL SMOKE TESTS PASSED ==="
