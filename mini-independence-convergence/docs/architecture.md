# Architecture: MiniIndependenceConvergence

## Package Structure

```
mini-independence-convergence/
  lakefile.lean                           -- Package: «mini-independence-convergence»
  MiniIndependenceConvergence.lean        -- Root module
  Main.lean                                -- Entry point
  MiniIndependenceConvergence/
    Core/
      Basic.lean                           -- Events, ProbabilitySpace, Independence, Convergence modes
      Laws.lean                            -- Axiom values, convergence relationships
      Objects.lean                          -- IndependentFamily, ConvergenceMode, TheoryRegistration
    Morphisms/
      Hom.lean                             -- TailMeasurableMap, KolmogorovExtension, ConvergenceHom
      Iso.lean                             -- Skorokhod representation, ConvergenceEquivalence
      Equiv.lean                           -- Independence characterizations, tail sigma-algebra equivalences
    Constructions/
      Products.lean                        -- Infinite product, Kolmogorov extension, IID product
      Quotients.lean                        -- Tail equivalence, exchangeable sigma-algebra
      Subobjects.lean                      -- Stationary, mixing, martingale difference sequences
      Universal.lean                       -- De Finetti representation, universal CLT property
    Properties/
      Invariants.lean                      -- isTailEvent, isSymmetricEvent, ergodicity
      Preservation.lean                    -- Independence/convergence under transformations
      ClassificationData.lean             -- Convergence hierarchy, counterexamples data
    Theorems/
      Basic.lean                           -- WLLN, SLLN, CLT (Lindeberg-Levy)
      Classification.lean                 -- Berry-Esseen, Local Limit, LIL
      Main.lean                            -- Kolmogorov SLLN, Lindeberg-Feller CLT, Cramer LDP
      UniversalProperties.lean            -- CLT universal, stable laws, Levy-Khintchine
    Examples/
      Standard.lean                        -- Coin flips, WLLN, CLT, dice
      Counterexamples.lean                -- Cauchy, typewriter, Bernstein
    Bridges/
      ToAlgebra.lean                      -- Tensor products, free independence
      ToTopology.lean                      -- Levy metric, Prokhorov metric
      ToGeometry.lean                      -- Random walks on groups/graphs
      ToComputation.lean                  -- Monte Carlo, bootstrap, concentration
  Test/
    Smoke.lean                             -- Smoke tests
    Examples.lean                          -- Example tests
    Regression.lean                        -- Regression tests
  Benchmark/
    CoreCoverage.lean                      -- Internal coverage tracking
    Princeton.lean                         -- Princeton ORF 526 coverage
    CambridgePartIII.lean                  -- Cambridge Part III coverage
    Harvard.lean                           -- Harvard Stat 210 coverage
    MIT.lean                               -- MIT 18.675 coverage
    OxfordPartC.lean                       -- Oxford Part C coverage
  Computation/
    MonteCarlo.lean                        -- Monte Carlo integration
    Bootstrap.lean                         -- Bootstrap resampling
    Concentration.lean                      -- Concentration inequality computation
    sage/ python/ notebooks/              -- External computation stubs
  docs/
    architecture.md                        -- This file
    coverage.md                            -- Coverage report
    dependency.md                          -- Dependency graph
  scripts/
    check.ps1                              -- PowerShell build check
    check.sh                               -- Bash build check
```

## Dependency Graph

```
MiniObjectKernel (Core.Basic, Core.Objects, Morphisms.Hom/Iso/Equivalence)
    |
    v
MiniIndependenceConvergence
    |
    +-- Core.Basic  ←  Core.Laws  ←  Core.Objects
    |       |               |              |
    |       +---------------+--------------+
    |       |
    +-- Morphisms.Hom ← Morphisms.Iso ← Morphisms.Equiv
    |       |               |              |
    |       +---------------+--------------+
    |       |
    +-- Constructions.Products ← Constructions.Quotients ← Constructions.Subobjects ← Constructions.Universal
    |       |                          |                          |                          |
    |       +--------------------------+--------------------------+--------------------------+
    |       |
    +-- Properties.Invariants ← Properties.Preservation ← Properties.ClassificationData
    |       |                         |                         |
    |       +-------------------------+-------------------------+
    |       |
    +-- Theorems.Basic ← Theorems.Classification ← Theorems.Main ← Theorems.UniversalProperties
    |       |                  |                        |                    |
    |       +------------------+------------------------+--------------------+
    |       |
    +-- Examples.Standard ← Examples.Counterexamples
    |       |
    +-- Bridges.ToAlgebra ← Bridges.ToTopology ← Bridges.ToGeometry ← Bridges.ToComputation
```

## Key Design Decisions

1. **Namespace**: All content under `MiniIndependenceConvergence`
2. **MiniMathKernel integration**: Uses `MiniObjectKernel.Core.Basic` and `.Objects` for typeclass infrastructure
3. **Proofs stubbed with `sorry`** for non-trivial theorems (Borel-Cantelli, SLLN, CLT)
4. **Every source file contains at least 1 `#eval`** for verification
5. **Axiom values** for key theorems are provided as `String` definitions in `Core/Laws.lean`
6. **ConvergenceModes** modeled as an inductive type with hierarchy information
