# MiniMeasureTheory

A Lean 4 formalization of measure theory, built on MiniObjectKernel.

## Package Structure

- `Core` - Sigma algebras, measurable spaces, measures, outer measures, Caratheodory extension, Lebesgue measure, Borel sigma algebra
- `Morphisms` - Measurable maps, measure-preserving maps, sigma algebra homomorphisms, measure space isomorphisms, absolute continuity, mutual singularity
- `Constructions` - Product sigma algebra/product measure, quotient measure, sub-sigma algebra/trace measure, universal Caratheodory extension
- `Properties` - Finite, sigma-finite, probability, atom-free, regular measures; preservation under pushforward/products; classification data
- `Theorems` - Caratheodory extension, Hahn decomposition, Jordan decomposition, Vitali covering lemma, Lebesgue decomposition, classification of Borel measures, existence and uniqueness of Lebesgue measure
- `Examples` - Lebesgue, counting, Dirac, Cantor measures; Vitali non-measurable set, non-sigma-finite measure, finitely-but-not-countably additive
- `Bridges` - To algebra (measure algebra), topology (Borel/Radon/Riesz), geometry (Hausdorff/area/coarea), computation (Monte Carlo/numerical)

## Build

```bash
lake build
```

## Test

```bash
lake env lean --run Test/Smoke.lean
```
