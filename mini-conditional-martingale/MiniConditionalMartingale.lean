/-
# MiniConditionalMartingale

Conditional expectation and martingale theory in probability.

## Sub-packages
- `Core`         — Conditional expectation, filtrations, martingale definitions, stopping times
- `Morphisms`    — Martingale transforms (stochastic integrals), equivalent measures (Girsanov), Doob-Meyer decomposition
- `Constructions` — Product filtrations, reversed martingales, bounded/L^p/uniformly integrable martingales, Snell envelope
- `Properties`   — Quadratic/predictable/cross variation, optional stopping preservation, regularity, closure
- `Theorems`     — Optional stopping, Doob maximal/upcrossing, martingale convergence, Levy zero-one, BDG inequalities
- `Examples`     — Random walk, exponential martingale, Brownian motion; convergence counterexamples
- `Bridges`      — ToAlgebra (stochastic integrals), ToTopology (convergence), ToGeometry (manifolds), ToComputation (simulation)
-/

import MiniConditionalMartingale.Core.Basic
import MiniConditionalMartingale.Core.Laws
import MiniConditionalMartingale.Core.Objects
import MiniConditionalMartingale.Morphisms.Hom
import MiniConditionalMartingale.Morphisms.Iso
import MiniConditionalMartingale.Morphisms.Equiv
import MiniConditionalMartingale.Constructions.Products
import MiniConditionalMartingale.Constructions.Quotients
import MiniConditionalMartingale.Constructions.Subobjects
import MiniConditionalMartingale.Constructions.Universal
import MiniConditionalMartingale.Properties.Invariants
import MiniConditionalMartingale.Properties.Preservation
import MiniConditionalMartingale.Properties.ClassificationData
import MiniConditionalMartingale.Theorems.Basic
import MiniConditionalMartingale.Theorems.Classification
import MiniConditionalMartingale.Theorems.Main
import MiniConditionalMartingale.Theorems.UniversalProperties
import MiniConditionalMartingale.Examples.Standard
import MiniConditionalMartingale.Examples.Counterexamples
import MiniConditionalMartingale.Bridges.ToAlgebra
import MiniConditionalMartingale.Bridges.ToTopology
import MiniConditionalMartingale.Bridges.ToGeometry
import MiniConditionalMartingale.Bridges.ToComputation
