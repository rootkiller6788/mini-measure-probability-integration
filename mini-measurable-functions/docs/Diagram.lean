/-
# docs/Diagram

Dependency diagram for the mini-measurable-functions package.

## Module Hierarchy

```
MiniMeasurableFunctions
├── Core/
│   ├── Basic.lean           ← MeasurableFunction, SimpleFunction, convergence modes
│   ├── Laws.lean            ← Algebraic closure, Egorov/Lusin axioms
│   └── Objects.lean         ← Object instances, L⁰ space
│
├── Morphisms/
│   ├── Hom.lean             ← MeasurePreservingMap, ErgodicMap
│   ├── Iso.lean             ← MeasureSpaceIsomorphism, MeasureAlgebraIsomorphism
│   └── Equiv.lean           ← a.e. equivalence, convergence mode equivalence
│
├── Constructions/
│   ├── Products.lean        ← Product of measurable functions, joint measurability
│   ├── Quotients.lean       ← L⁰ = M / ~, Ky Fan metric
│   ├── Subobjects.lean      ← Bounded, nonnegative, integrable functions
│   └── Universal.lean       ← Simple functions as universal approximators
│
├── Properties/
│   ├── Invariants.lean      ← Distribution, essentialSup, essentialInf
│   ├── Preservation.lean    ← Measurability preserved under limits, composition, algebra
│   └── ClassificationData.lean ← Baire/Borel/Lebesgue hierarchies, σ-ideals
│
├── Theorems/
│   ├── Basic.lean           ← Egorov, Lusin, Fubini (sorry for deep proofs)
│   ├── Classification.lean  ← Baire classification, Lebesgue approximate continuity
│   ├── Main.lean            ← measurable = limit of simple functions
│   └── UniversalProperties.lean ← Simple functions = universal dense subalgebra
│
├── Examples/
│   ├── Standard.lean        ← Indicator of ℚ, step, continuous, Cantor
│   └── Counterexamples.lean ← Non-measurable, Egorov without finite measure
│
└── Bridges/
    ├── ToAlgebra.lean       ← Ring of bounded measurable, L∞, von Neumann
    ├── ToTopology.lean      ← Egorov/Lusin topological character, measurable selections
    ├── ToGeometry.lean      ← Rectifiable sets, coarea/area formulas, BV functions
    └── ToComputation.lean   ← Checking measurability, numerical integration, Monte Carlo
```

## Dependency Graph

```
Core.Basic ← Core.Laws ← Core.Objects
    ↓            ↓           ↓
Morphisms.* ← Constructions.* ← Properties.*
    ↓            ↓                ↓
Theorems.* ← Examples.* ← Bridges.*
    ↓
  Test.*   Benchmark.*   Computation.*
```

## External Dependencies

- `MiniObjectKernel` (Object typeclass, TheoryName)
- `MiniMeasureTheory` (measure space definitions)
-/

#eval "=== Dependency Diagram ==="
#eval "See file comments for dependency structure"
