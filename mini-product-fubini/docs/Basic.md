# MiniProductFubini - Basic Documentation

## Overview

`mini-product-fubini` is a Lean 4 Lake package providing the theory of product measures and Fubini's theorem. It builds on the mini-everything-math ecosystem (mini-object-kernel, mini-measure-theory, mini-measurable-functions, mini-lebesgue-integration).

## Package Structure

```
mini-product-fubini/
  lakefile.lean          - package configuration
  Main.lean              - entry point
  MiniProductFubini/
    Core/                - fundamental definitions (3 files)
    Morphisms/           - category theory (3 files)
    Constructions/       - product constructions (4 files)
    Properties/          - invariants and preservation (3 files)
    Theorems/            - main theorems (4 files)
    Examples/            - examples (2 files)
    Bridges/             - connections to other areas (4 files)
  Test/                  - test files (3 files)
  Benchmark/             - benchmarks (6 files)
  Computation/           - computational methods (6 files)
  docs/                  - documentation (3 files)
  scripts/               - build scripts (2 files)
```

## Core Definitions

### Product Sigma-Algebra
- `ProductSigmaAlgebra X Y` - Σ_X ⊗ Σ_Y, the product sigma-algebra
- `MeasurableRectangle` - A×B with A ∈ Σ_X, B ∈ Σ_Y

### Product Measure
- `ProductMeasure μ ν` - μ×ν on X×Y
- Rectangle rule: (μ×ν)(A×B) = μ(A)·ν(B)

### Sections and Iterated Integrals
- `sectionAtX`, `sectionAtY` - sections of sets
- `functionSectionX`, `functionSectionY` - sections of functions
- `iteratedIntegralXY` - ∫_X∫_Y f dν dμ
- `iteratedIntegralYX` - ∫_Y∫_X f dμ dν

### Convolution
- `Convolution f g` - (f∗g)(x) = ∫ f(x-y)g(y) dy
- `ConvolutionTheorem` - ‖f∗g‖₁ ≤ ‖f‖₁·‖g‖₁

## Main Theorems

1. **Fubini's Theorem**: For integrable f, iterated = product integral
2. **Tonelli's Theorem**: For nonnegative measurable f, iterated = product integral
3. **Radon-Nikodym Theorem**: ν ≪ μ ⇒ ∃ dν/dμ
4. **Lebesgue Decomposition**: ν = ν_ac + ν_sing
5. **Hahn Decomposition**: X = P ⊔ N for signed measures
6. **Jordan Decomposition**: ν = ν⁺ - ν⁻

## Axioms

- `fubiniTonelli` - Fubini-Tonelli principle
- `youngInequality` - Young's convolution inequality
- `convolutionAssociative` - (f∗g)∗h = f∗(g∗h)
- `convolutionCommutative` - f∗g = g∗f
- `radonNikodymTheorem` - Radon-Nikodym derivative existence

## Building

```powershell
cd mini-product-fubini
lake build
```

## Testing

```powershell
lake env lean --run Test/Basic.lean
lake env lean --run Test/Properties.lean
lake env lean --run Test/Comprehensive.lean
```
