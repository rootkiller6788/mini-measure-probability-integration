/-
# MiniIndependenceConvergence

Independence and convergence theory in probability.

## Sub-packages
- `Core`         — Independent events/algebras/variables, iid, Borel-Cantelli, Kolmogorov 0-1, convergence modes
- `Morphisms`    — Tail-field measurable maps, Skorokhod representation, equivalent characterizations
- `Constructions` — Infinite product of probability spaces, tail equivalence, exchangeable sequences, de Finetti
- `Properties`   — IsTailEvent, IsSymmetricEvent, independence under transformations, convergence hierarchy
- `Theorems`     — Weak/Strong LLN, CLT, Berry-Esseen, Lindeberg-Feller, large deviations
- `Examples`     — Coin flips, WLLN simulation, CLT illustration; Cauchy counterexample, convergence counterexamples
- `Bridges`      — ToAlgebra (tensor products, free independence), ToTopology (Levy metric), ToGeometry (random walks), ToComputation (Monte Carlo bounds)
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Laws
import MiniIndependenceConvergence.Core.Objects
import MiniIndependenceConvergence.Morphisms.Hom
import MiniIndependenceConvergence.Morphisms.Iso
import MiniIndependenceConvergence.Morphisms.Equiv
import MiniIndependenceConvergence.Constructions.Products
import MiniIndependenceConvergence.Constructions.Quotients
import MiniIndependenceConvergence.Constructions.Subobjects
import MiniIndependenceConvergence.Constructions.Universal
import MiniIndependenceConvergence.Properties.Invariants
import MiniIndependenceConvergence.Properties.Preservation
import MiniIndependenceConvergence.Properties.ClassificationData
import MiniIndependenceConvergence.Theorems.Basic
import MiniIndependenceConvergence.Theorems.Classification
import MiniIndependenceConvergence.Theorems.Main
import MiniIndependenceConvergence.Theorems.UniversalProperties
import MiniIndependenceConvergence.Examples.Standard
import MiniIndependenceConvergence.Examples.Counterexamples
import MiniIndependenceConvergence.Bridges.ToAlgebra
import MiniIndependenceConvergence.Bridges.ToTopology
import MiniIndependenceConvergence.Bridges.ToGeometry
import MiniIndependenceConvergence.Bridges.ToComputation
