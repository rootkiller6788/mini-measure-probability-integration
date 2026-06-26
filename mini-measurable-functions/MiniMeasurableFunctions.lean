/-
# MiniMeasurableFunctions

The complete theory of measurable functions in measure theory.
Covers the full taxonomy: objects, morphisms, constructions, properties,
theorems, examples, and bridges to other fields.

## Sub-packages
- `Core`         — MeasurableFunction, SimpleFunction, convergence modes, almost everywhere
- `Morphisms`    — MeasurePreservingMap, ErgodicMap, a.e. equivalence
- `Constructions` — Products, quotients (L⁰), subobjects, universal approximators
- `Properties`   — Distribution, essential supremum, preservation, Baire/Borel hierarchies
- `Theorems`     — Egorov, Lusin, Fubini, classification
- `Examples`     — Standard (indicator, step, Cantor) and counterexamples
- `Bridges`      — ToAlgebra, ToTopology, ToGeometry, ToComputation
-/
import MiniMeasurableFunctions.Core.Basic
import MiniMeasurableFunctions.Core.Objects
import MiniMeasurableFunctions.Core.Laws
import MiniMeasurableFunctions.Morphisms.Hom
import MiniMeasurableFunctions.Morphisms.Iso
import MiniMeasurableFunctions.Morphisms.Equiv
import MiniMeasurableFunctions.Constructions.Products
import MiniMeasurableFunctions.Constructions.Quotients
import MiniMeasurableFunctions.Constructions.Subobjects
import MiniMeasurableFunctions.Constructions.Universal
import MiniMeasurableFunctions.Properties.Invariants
import MiniMeasurableFunctions.Properties.Preservation
import MiniMeasurableFunctions.Properties.ClassificationData
import MiniMeasurableFunctions.Theorems.Basic
import MiniMeasurableFunctions.Theorems.UniversalProperties
import MiniMeasurableFunctions.Theorems.Classification
import MiniMeasurableFunctions.Theorems.Main
import MiniMeasurableFunctions.Examples.Standard
import MiniMeasurableFunctions.Examples.Counterexamples
import MiniMeasurableFunctions.Bridges.ToAlgebra
import MiniMeasurableFunctions.Bridges.ToTopology
import MiniMeasurableFunctions.Bridges.ToGeometry
import MiniMeasurableFunctions.Bridges.ToComputation
