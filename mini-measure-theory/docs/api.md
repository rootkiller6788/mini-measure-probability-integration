# MiniMeasureTheory API Reference

## Core Types

| Type | Description |
|------|-------------|
| `SigmaAlgebra α` | Collection of sets closed under complement, countable union |
| `MeasurableSpace α` | A type equipped with a sigma algebra |
| `Measure α ms` | Countably additive function on a sigma algebra, μ(∅)=0 |
| `MeasureSpace α` | Type with measurable space + measure |
| `OuterMeasure α` | Monotone, countably subadditive set function |
| `PreMeasure α` | Additive function on an algebra of sets |

## Morphisms

| Type | Description |
|------|-------------|
| `MeasurableMap α β ms_α ms_β` | Map with measurable preimages of measurable sets |
| `MeasurePreservingMap α β ms_α ms_β μ ν` | Measurable map with μ(f⁻¹B) = ν(B) |
| `SigmaAlgebraHomomorphism α β σ_α σ_β` | Structure-preserving map between sigma algebras |
| `MeasureSpaceIso α β ms_α ms_β μ ν` | Invertible measure-preserving map |

## Relations

| Predicate | Notation | Meaning |
|-----------|----------|---------|
| `absolutelyContinuous ν μ` | ν ≪ μ | μ(A)=0 ⇒ ν(A)=0 |
| `mutuallySingular ν μ` | ν ⟂ μ | Exists partition A∪B where ν(A)=μ(B)=0 |
| `equivalentMeasures ν μ` | ν ≈ μ | ν ≪ μ ∧ μ ≪ ν |

## Constructions

| Construction | Description |
|-------------|-------------|
| `productSigmaAlgebra` | Product sigma algebra on α×β |
| `productMeasure` | Product measure μ×ν |
| `quotientSigmaAlgebra` | Quotient sigma algebra via π |
| `quotientMeasure` | Pushforward to quotient |
| `traceMeasure` | Restriction μ\|_A |
| `restrictToSigmaAlgebra` | Restrict to sub-sigma algebra |
| `caratheodoryExtension` | Carathéodory extension from outer measure |
| `Completion` | Completion by adding null subsets |

## Properties

| Property | Description |
|----------|-------------|
| `isFinite μ` | μ(whole space) < ∞ |
| `isSigmaFinite μ` | Space is countable union of finite-measure sets |
| `isProbabilityMeasure μ` | μ(whole space) = 1 |
| `isAtomFree μ` | No atoms (minimal positive measure sets) |
| `isRegular μ` | Inner + outer regular |
| `isTight μ` | Mass concentrates on compacts |
| `isComplete μ` | All subsets of null sets are measurable |

## Key Theorems

| Theorem | Description |
|---------|-------------|
| `caratheodoryExtension` | Outer measure → complete measure |
| `hahnDecompositionTheorem` | Partition into positive + negative sets |
| `jordanDecomposition` | Signed measure = μ+ - μ- |
| `vitaliCoveringLemma` | Disjoint ball cover up to null sets |
| `lebesgueDecomposition` | μ = μ_ac + μ_sing |
| `classificationOfBorelMeasures` | Discrete + abs.cont + singular continuous |
| `lebesgueMeasureIsUnique` | Unique translation-invariant measure on ℝⁿ |
| `rieszRepresentation` | Measures = dual of C_c(X) |
