# mini-probability-theory: Dependency Map

## External Dependencies

```
mini-object-kernel          (MiniMathKernel: Object typeclass, TheoryName)
mini-measure-theory         (Measure, MeasurableSpace, pushforwardMeasure, AbsolutelyContinuous, SingularMeasure)
mini-lebesgue-integration   (LebesgueMeasure, ∫ integral notation, RadonNikodymDerivative)
```

## Internal Dependency Graph

```
Core/Basic.lean              (no internal deps - imports external packages only)
  |
  +-- Core/Laws.lean         (depends on Core/Basic)
  +-- Core/Objects.lean      (depends on Core/Basic)
  |
  +-- Morphisms/Hom.lean     (depends on Core/Basic)
  +-- Morphisms/Iso.lean     (depends on Core/Basic)
  +-- Morphisms/Equiv.lean   (depends on Core/Basic)
  |
  +-- Constructions/Products.lean     (depends on Core/Basic)
  +-- Constructions/Quotients.lean    (depends on Core/Basic, Constructions/Products)
        +-- Constructions/Subobjects.lean  (depends on Core/Basic)
        +-- Constructions/Universal.lean   (depends on Core/Basic, Constructions/Products)
  |
  +-- Properties/Invariants.lean          (depends on Core/Basic)
  +-- Properties/Preservation.lean        (depends on Core/Basic)
  +-- Properties/ClassificationData.lean  (depends on Core/Basic, Constructions/Subobjects)
  |
  +-- Theorems/Basic.lean              (depends on Core/Basic, Properties/Preservation)
  +-- Theorems/Classification.lean     (depends on Core/Basic, Properties/Invariants)
  +-- Theorems/Main.lean               (depends on Core/Basic, Constructions/Products, Constructions/Universal)
  +-- Theorems/UniversalProperties.lean (depends on Core/Basic, Core/Laws, Properties/Invariants)
  |
  +-- Examples/Standard.lean        (depends on Core/Basic, Core/Laws, Properties/ClassificationData, Properties/Invariants)
  +-- Examples/Counterexamples.lean (depends on Core/Basic, Core/Laws, Properties/ClassificationData, Properties/Invariants)
  |
  +-- Bridges/ToAlgebra.lean        (depends on Core/Basic, Core/Laws)
  +-- Bridges/ToTopology.lean       (depends on Core/Basic, Theorems/Basic)
  +-- Bridges/ToGeometry.lean       (depends on Core/Basic, Properties/Invariants)
  +-- Bridges/ToComputation.lean    (depends on Core/Basic, Properties/ClassificationData)
```

## Import Structure

All source files import `MiniObjectKernel` plus their internal dependencies.
The top-level `MiniProbabilityTheory.lean` imports all source files for convenience.
Tests and benchmarks import `MiniProbabilityTheory` (the top-level module).
