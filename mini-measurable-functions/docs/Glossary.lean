/-
# docs/Glossary

Glossary of measurable function concepts defined in this package.

## Core Concepts

- **MeasurableSpace X**: A type X equipped with a σ-algebra Σ of measurable sets.
  Properties: contains ∅, closed under complement and countable unions.

- **MeasurableFunction f**: f: X → Y such that f⁻¹(B) ∈ Σ_X for all B ∈ Σ_Y.
  Notation: f ∈ M(X, Y).

- **SimpleFunction φ**: A measurable function with finite range {c₁, ..., cₖ}.
  φ = Σᵢ cᵢ · 1_{Aᵢ} where Aᵢ = {x | φ(x) = cᵢ} are measurable.

- **almostEverywhere (a.e.)**: A property P(x) holds a.e. if μ{x | ¬P(x)} = 0.

- **convergenceAlmostEverywhere**: fₙ → f a.e. if fₙ(x) → f(x) for almost every x.

- **convergenceInMeasure**: fₙ → f in measure if ∀ ε > 0, μ{x | |fₙ(x) - f(x)| ≥ ε} → 0.

- **convergenceAlmostUniformly**: ∀ δ > 0, ∃ A with μ(A) < δ such that
  fₙ → f uniformly on X \ A (Egorov's conclusion).

## Morphisms

- **MeasurePreservingMap T**: T: X → X measurable, μ(T⁻¹(A)) = μ(A) for all A ∈ Σ.

- **ErgodicMap T**: Measure-preserving map with T⁻¹(A) = A ⇒ μ(A) = 0 or μ(Aᶜ) = 0.

- **MeasureSpaceIsomorphism**: Bi-measurable bijection, possibly measure-preserving.

- **MeasureAlgebraIsomorphism**: Isomorphism of Boolean algebras Σ/𝒩.

## Constructions

- **Product σ-algebra**: Σ_{X×Y} = σ({A × B | A ∈ Σ_X, B ∈ Σ_Y}).

- **L⁰ = L0Space**: Space of measurable functions modulo a.e. equality.
  Complete metric space under convergence in measure (Ky Fan metric).

- **BoundedMeasurableFunction**: f with sup_x |f(x)| < ∞.

- **IntegrableFunction**: f with ∫ |f| dμ < ∞.

## Properties

- **distribution f_*μ**: Pushforward measure: (f_*μ)(B) = μ(f⁻¹(B)).

- **essentialSup f**: inf{M | μ{f > M} = 0}.

- **Baire hierarchy**: Classification of Borel functions by transfinite iteration
  of pointwise limit (Baire class α < ω₁).

- **Borel hierarchy**: Σ⁰_α (countable unions from below), Π⁰_α (complements),
  Δ⁰_α = Σ⁰_α ∩ Π⁰_α.

## Theorems

- **Egorov**: a.e. convergence + finite measure ⇒ almost uniform convergence.

- **Lusin**: Measurable f on ℝ equals a continuous g except on a set of arbitrarily
  small measure.

- **Fubini for measurability**: Jointly measurable ⇒ sections measurable.

- **Main**: Every measurable function is the pointwise limit of simple functions.

## Bridges

- **ToAlgebra**: L∞ = bounded measurable / null functions = abelian von Neumann algebra.

- **ToTopology**: Measurable selections (Kuratowski-Ryll-Nardzewski).

- **ToGeometry**: Rectifiable sets, coarea/area formulas, BV functions.

- **ToComputation**: Algorithms for checking measurability, Monte Carlo integration.
-/

#eval "=== Glossary ==="
#eval "See file comments for full glossary of MiniMeasurableFunctions concepts"
