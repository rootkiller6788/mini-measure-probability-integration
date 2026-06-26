# Dependencies: MiniIndependenceConvergence

## External Dependencies

```
mini-object-kernel (MiniObjectKernel)
    Path: ../../0. mini-math-kernel/mini-object-kernel
    Used by: Core/Basic.lean, Core/Objects.lean, Morphisms/Hom.lean, Morphisms/Iso.lean, Morphisms/Equiv.lean
    Provides: TheoryName, Object typeclass, Embedding, Iso, EqChain

mini-measure-theory (MiniMeasureTheory)
    Path: ../mini-measure-theory
    Used by: (referenced but not directly imported — measure-theoretic stubs are local)
    Provides: Measure, SigmaAlgebra basics, MeasurableSpace

mini-probability-theory (MiniProbabilityTheory)
    Path: ../mini-probability-theory
    Used by: (referenced but not directly imported — probability stubs are local)
    Provides: ProbabilitySpace axioms (re-implemented locally for self-containment)
```

## Internal Dependencies

```
Core/Basic.lean
  -> MiniObjectKernel.Core.Basic, MiniObjectKernel.Core.Objects

Core/Laws.lean
  -> Core/Basic.lean

Core/Objects.lean
  -> Core/Basic.lean, Core/Laws.lean

Morphisms/Hom.lean
  -> Core/Basic.lean, Core/Objects.lean, MiniObjectKernel.Morphisms.Hom

Morphisms/Iso.lean
  -> Core/Basic.lean, Core/Objects.lean, MiniObjectKernel.Morphisms.Iso

Morphisms/Equiv.lean
  -> Core/Basic.lean, Core/Objects.lean, MiniObjectKernel.Morphisms.Equivalence

Constructions/Products.lean
  -> Core/Basic.lean, Core/Objects.lean

Constructions/Quotients.lean
  -> Core/Basic.lean, Core/Objects.lean, Morphisms/Equiv.lean

Constructions/Subobjects.lean
  -> Core/Basic.lean, Core/Objects.lean, Constructions/Quotients.lean

Constructions/Universal.lean
  -> Core/Basic.lean, Core/Objects.lean, Constructions/Products.lean

Properties/Invariants.lean
  -> Core/Basic.lean, Core/Objects.lean, Constructions/Quotients.lean

Properties/Preservation.lean
  -> Core/Basic.lean, Core/Objects.lean, Properties/Invariants.lean

Properties/ClassificationData.lean
  -> Core/Basic.lean, Core/Objects.lean, Properties/Preservation.lean

Theorems/Basic.lean
  -> Core/Basic.lean, Core/Objects.lean, Properties/Preservation.lean

Theorems/Classification.lean
  -> Core/Basic.lean, Core/Objects.lean, Theorems/Basic.lean

Theorems/Main.lean
  -> Core/Basic.lean, Core/Objects.lean, Theorems/Basic.lean, Theorems/Classification.lean

Theorems/UniversalProperties.lean
  -> Core/Basic.lean, Core/Objects.lean, Theorems/Basic.lean, Theorems/Classification.lean

Examples/Standard.lean
  -> Core/Basic.lean, Core/Objects.lean, Theorems/Basic.lean

Examples/Counterexamples.lean
  -> Core/Basic.lean, Core/Objects.lean, Properties/ClassificationData.lean

Bridges/ToAlgebra.lean
  -> Core/Basic.lean, Core/Objects.lean

Bridges/ToTopology.lean
  -> Core/Basic.lean, Core/Objects.lean, Theorems/Basic.lean

Bridges/ToGeometry.lean
  -> Core/Basic.lean, Core/Objects.lean, Theorems/Basic.lean

Bridges/ToComputation.lean
  -> Core/Basic.lean, Core/Objects.lean, Theorems/Basic.lean, Theorems/Classification.lean
```

## Lake Build Order

1. Core/Basic.lean (no internal deps)
2. Core/Laws.lean (-> Basic)
3. Core/Objects.lean (-> Basic, Laws)
4. Morphisms/* (-> Core)
5. Properties/Invariants (-> Core, Quotients)
6. Constructions/* (-> Core, Morphisms, Properties)
7. Theorems/* (-> Core, Constructions, Properties)
8. Examples/* (-> Core, Theorems)
9. Bridges/* (-> Core, Theorems)
