/-
# MiniStochasticProcesses

Stochastic processes theory formalized on the MiniMathKernel ecosystem.

## Sub-packages
- `Core`         — StochasticProcess, MarkovChain, BrownianMotion, PoissonProcess, StationaryProcess, ErgodicProcess
- `Morphisms`    — ProcessMap, RandomTimeChange, processTransformation, MarkovKernel
- `Constructions` — Product processes, quotient by stationarity, Levy processes, Brownian as universal limit
- `Properties`   — stationaryDistribution, reversibleMeasure, mixingTime, ergodicAverage, preservation
- `Theorems`     — Strong Markov property, reflection principle, law of iterated logarithm, Kolmogorov continuity, Birkhoff ergodic theorem
- `Examples`     — Simple random walk, two-state Markov chain, Brownian/Poisson properties, counterexamples
- `Bridges`      — ToAlgebra (Markov semigroups, generators), ToTopology (Wiener measure, Skorokhod), ToGeometry (manifolds), ToComputation (MCMC, Gillespie)
-/

import MiniStochasticProcesses.Core.Basic
import MiniStochasticProcesses.Core.Laws
import MiniStochasticProcesses.Core.Objects
import MiniStochasticProcesses.Morphisms.Hom
import MiniStochasticProcesses.Morphisms.Iso
import MiniStochasticProcesses.Morphisms.Equiv
import MiniStochasticProcesses.Constructions.Products
import MiniStochasticProcesses.Constructions.Quotients
import MiniStochasticProcesses.Constructions.Subobjects
import MiniStochasticProcesses.Constructions.Universal
import MiniStochasticProcesses.Properties.Invariants
import MiniStochasticProcesses.Properties.Preservation
import MiniStochasticProcesses.Properties.ClassificationData
import MiniStochasticProcesses.Theorems.Basic
import MiniStochasticProcesses.Theorems.Classification
import MiniStochasticProcesses.Theorems.Main
import MiniStochasticProcesses.Theorems.UniversalProperties
import MiniStochasticProcesses.Examples.Standard
import MiniStochasticProcesses.Examples.Counterexamples
import MiniStochasticProcesses.Bridges.ToAlgebra
import MiniStochasticProcesses.Bridges.ToTopology
import MiniStochasticProcesses.Bridges.ToGeometry
import MiniStochasticProcesses.Bridges.ToComputation
