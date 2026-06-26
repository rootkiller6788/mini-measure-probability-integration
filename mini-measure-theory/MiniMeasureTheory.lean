/-
# MiniMeasureTheory

Measure theory formalization built on MiniObjectKernel.

## Sub-packages
- `Core`         — SigmaAlgebra, MeasurableSpace, Measure, OuterMeasure, CaratheodoryExtension, LebesgueMeasure, BorelSigmaAlgebra
- `Morphisms`    — MeasurableMap, MeasurePreservingMap, SigmaAlgebraHomomorphism, MeasureSpaceIso, AbsolutelyContinuous, MutuallySingular
- `Constructions` — Product sigma algebra, product measure, quotient measure, sub-sigma algebra, trace measure, Caratheodory universal
- `Properties`   — IsFinite, IsSigmaFinite, IsProbabilityMeasure, IsAtomFree, IsRegular, preservation, classification data
- `Theorems`     — Caratheodory extension, Hahn decomposition, Jordan decomposition, Vitali covering lemma, Lebesgue decomposition, classification of Borel measures, existence and uniqueness of Lebesgue measure
- `Examples`     — Lebesgue, counting, Dirac, Cantor measures; non-measurable set, non-sigma-finite measure, finitely additive counterexample
- `Bridges`      — ToAlgebra (measure algebra modulo null sets), ToTopology (Radon measures, Riesz), ToGeometry (Hausdorff, area, coarea), ToComputation (Monte Carlo)
-/

import MiniMeasureTheory.Core.Basic
import MiniMeasureTheory.Core.Laws
import MiniMeasureTheory.Core.Objects
import MiniMeasureTheory.Morphisms.Hom
import MiniMeasureTheory.Morphisms.Iso
import MiniMeasureTheory.Morphisms.Equiv
import MiniMeasureTheory.Constructions.Products
import MiniMeasureTheory.Constructions.Quotients
import MiniMeasureTheory.Constructions.Subobjects
import MiniMeasureTheory.Constructions.Universal
import MiniMeasureTheory.Properties.Invariants
import MiniMeasureTheory.Properties.Preservation
import MiniMeasureTheory.Properties.ClassificationData
import MiniMeasureTheory.Theorems.Basic
import MiniMeasureTheory.Theorems.Classification
import MiniMeasureTheory.Theorems.Main
import MiniMeasureTheory.Theorems.UniversalProperties
import MiniMeasureTheory.Examples.Standard
import MiniMeasureTheory.Examples.Counterexamples
import MiniMeasureTheory.Bridges.ToAlgebra
import MiniMeasureTheory.Bridges.ToTopology
import MiniMeasureTheory.Bridges.ToGeometry
import MiniMeasureTheory.Bridges.ToComputation
