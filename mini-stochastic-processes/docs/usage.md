# Usage Guide

## Importing the Library

```lean
import MiniStochasticProcesses
open MiniStochasticProcesses
```

## Basic Examples

### Simple Random Walk

```lean
#eval simpleRandomWalkExpectedValue 0.5 10
-- E[S_10] = 10*(2*0.5 - 1) = 0

#eval simpleRandomWalkVariance 0.5 10
-- Var(S_10) = 4*10*0.5*0.5 = 10
```

### Brownian Motion

```lean
#eval brownianMean default 2.0    -- E[B_2] = 0
#eval brownianVariance default 3.0 -- Var(B_3) = 3
#eval brownianCovariance default 1.0 2.0 -- Cov = min(1,2) = 1
```

### Poisson Process

```lean
#eval poissonProcessMean 2.0 5.0  -- E[N_5] = 2*5 = 10
#eval poissonProcessVariance 3.0 4.0 -- Var = 3*4 = 12
#eval poissonProbability 1.0 2.0 3 -- P(N_2 = 3) with λ=1
```

### Geometric Brownian Motion

```lean
#eval geometricBrownianMean 100 0.05 2
-- E[S_2] = 100 * e^(0.05*2) = 100 * e^0.1
```

## Markov Chain Computations

```lean
-- Stationary distribution of two-state chain
def π0 := twoStateStationaryDistribution 0.3 0.3 (by norm_num) 0

-- Metropolis-Hastings acceptance probability
def α := metropolisAcceptance π q x y
```

## Object Registration

All process types are registered in the MiniObjectKernel theory graph:

```lean
#eval describe (StochasticProcess ℕ ℕ ℕ)  -- "[MiniStochasticProcesses] StochasticProcess(...)"
#eval describe BrownianMotion             -- "[MiniStochasticProcesses.Brownian] BrownianMotion"
#eval describe (PoissonProcess 1.0)       -- "[MiniStochasticProcesses.Poisson] PoissonProcess(λ=1.0)"
```

## Running Tests

```bash
lake env lean --run Test/Smoke.lean
lake env lean --run Test/Unit.lean
lake env lean --run Test/Integration.lean
```

## Running Benchmarks

```bash
lake env lean --run Benchmark/Core.lean
lake env lean --run Benchmark/Theorems.lean
lake env lean --run Benchmark/Bridges.lean
lake env lean --run Benchmark/RealWorld.lean
```
