/-
# MiniConditionalMartingale: Package Overview

## What is MiniConditionalMartingale?

`mini-conditional-martingale` is a Lean 4 lake package implementing
the fundamentals of conditional expectation and discrete-time martingale theory.
It is part of the `mini-everything-math` project, a modular
formalization of modern mathematics.

## Dependencies

This package depends on:
- `mini-object-kernel` — typeclass foundation (Object, etc.)
- `mini-measure-theory` — σ-algebras, measures, measure spaces
- `mini-probability-theory` — probability spaces, random variables
- `mini-lebesgue-integration` — Lebesgue integral, L^p spaces

## Package Structure

```
mini-conditional-martingale/
├── lakefile.lean                     # Lake package configuration
├── MiniConditionalMartingale.lean    # Root module (imports all)
├── Main.lean                         # Executable entry point
│
├── MiniConditionalMartingale/
│   ├── Core/
│   │   ├── Basic.lean        # Conditional expectation, martingale defs
│   │   ├── Laws.lean         # Key laws and theorems
│   │   └── Objects.lean      # Theory registrations
│   ├── Morphisms/
│   │   ├── Hom.lean          # Martingale transforms
│   │   ├── Iso.lean          # Equivalent measures (Girsanov)
│   │   └── Equiv.lean        # Doob-Meyer equivalence
│   ├── Constructions/
│   │   ├── Products.lean     # Product filtrations
│   │   ├── Quotients.lean    # Tail equivalence, reversed
│   │   ├── Subobjects.lean   # Bounded/L^p/UI martingales
│   │   └── Universal.lean    # Snell envelope
│   ├── Properties/
│   │   ├── Invariants.lean       # Quadratic, predictable variation
│   │   ├── Preservation.lean     # Optional stopping, convexity
│   │   └── ClassificationData.lean # Regular/closed/reversed
│   ├── Theorems/
│   │   ├── Basic.lean            # OST, Doob maximal, convergence
│   │   ├── Classification.lean   # UI = closed, class (D)
│   │   ├── Main.lean            # Convergence, BDG inequalities
│   │   └── UniversalProperties.lean # Snell envelope properties
│   ├── Examples/
│   │   ├── Standard.lean         # Random walk, exponential, Brownian
│   │   └── Counterexamples.lean  # Double-or-nothing, OST fails
│   └── Bridges/
│       ├── ToAlgebra.lean        # Ito integral, Wiener chaos
│       ├── ToTopology.lean       # Convergence topologies
│       ├── ToGeometry.lean       # Manifold martingales
│       └── ToComputation.lean    # Simulation, MC, LS algorithm
│
├── test/                 # Unit tests
├── benchmark/            # Performance benchmarks
├── computation/          # Monte Carlo and simulation
├── docs/                 # Documentation modules
└── scripts/              # Build and CI scripts
```

## Key Concepts

### Conditional Expectation
- `E[X | 𝒢]` — unique 𝒢-measurable RV satisfying ∫_G E[X|𝒢] = ∫_G X
- Properties: linearity, tower, pull-out, independence
- `P(A | 𝒢) = E[1_A | 𝒢]` — conditional probability

### Martingales
- `X_n` where `E[X_{n+1} | F_n] = X_n` for all n
- Submartingale: `E[X_{n+1} | F_n] ≥ X_n`
- Supermartingale: `E[X_{n+1} | F_n] ≤ X_n`

### Stopping Times
- `τ` where `{τ ≤ n} ∈ F_n` for all n
- Optional Stopping: `E[X_τ] = E[X_0]` for bounded τ
- Snell envelope: smallest supermartingale dominating a process

### Key Theorems
1. Doob's Decomposition: X = M + A
2. Optional Stopping Theorem
3. Doob's Maximal Inequality
4. Martingale Convergence Theorem
5. Burkholder-Davis-Gundy Inequalities

## Usage

```lean
import MiniConditionalMartingale

open MiniConditionalMartingale
```

## Status

This is a "mini" package: full definitions with deep proofs left as `sorry`.
The focus is on correct API design and realistic type theory.
-/

#eval "MiniConditionalMartingale Overview: conditional expectation + martingale theory"
