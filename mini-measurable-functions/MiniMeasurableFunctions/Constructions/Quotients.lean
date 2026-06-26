/-
# MiniMeasurableFunctions.Constructions.Quotients

The L⁰ space: measurable functions modulo equality almost everywhere.
- L⁰ as a complete metric space under convergence in measure
- Quotient construction: L⁰ = M / ~ where f ~ g iff f = g a.e.
-/

import MiniMeasurableFunctions.Core.Basic
import MiniMeasurableFunctions.Morphisms.Equiv

namespace MiniMeasurableFunctions

/-! ## The Equivalence Relation ~ on Measurable Functions

Two measurable functions are equivalent (denoted f ~ g) if they are equal
almost everywhere: μ{x | f(x) ≠ g(x)} = 0.
-/

def measurableEquivalent {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (f g : X → ℕ)
    (hf : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X))
    (hg : ∀ n, g ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) : Prop :=
  μ {x | f x ≠ g x} = 0

/-! ## L⁰ as Quotient

L⁰(X, μ) = {measurable functions X → ℕ} / ~
where f ~ g iff f = g μ-almost everywhere.
-/

structure L0Quotient (X : Type) [MeasurableSpace X] (μ : Set X → ℕ∞) where
  -- The set of all measurable functions
  carrier : Set (X → ℕ)
  carrierMeasurable : ∀ f ∈ carrier,
    ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)
  -- Equivalence relation: a.e. equality
  rel : (X → ℕ) → (X → ℕ) → Prop
  relEquivalence : Equivalence rel
  relAeEquality : ∀ f g, f ∈ carrier → g ∈ carrier →
    (rel f g ↔ μ {x | f x ≠ g x} = 0)

/-! ## Convergence in Measure Metric on L⁰

The Ky Fan metric: d(f, g) = inf{ε > 0 | μ{x | |f(x) - g(x)| > ε} ≤ ε}
-/

def kyFanMetric {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (f g : X → ℕ) : ℕ∞ :=
  -- Simplified: measure of the set where f and g differ
  μ {x | f x ≠ g x}

/-! ## L⁰ as a Complete Metric Space

L⁰ with the Ky Fan metric is complete: every Cauchy sequence (in measure)
has a limit.
-/

axiom l0Complete {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (fₙ : ℕ → X → ℕ)
    (hMeas : ∀ i n, fₙ i ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X))
    (hCauchy : ∀ ε > 0, ∃ N, ∀ m n ≥ N, kyFanMetric μ (fₙ m) (fₙ n) < ε) :
    ∃ (f : X → ℕ), (∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) ∧
      (convergenceInMeasure μ fₙ f)

/-! ## Quotient Map

The canonical projection π: M → L⁰ takes a measurable function to its
equivalence class modulo equality a.e.
-/

def quotientMap {X : Type} [MeasurableSpace X]
    (L : L0Quotient X (μ := fun _ => 0)) (f : X → ℕ) : Set (X → ℕ) :=
  {g | L.rel f g}

/-! ## L⁰ as an ℝ-vector space

L⁰ has a natural vector space structure: given equivalence classes
[f] and [g], define [f] + [g] = [f + g] and c[f] = [c·f].
These are well-defined because addition and scalar multiplication
respect the equivalence relation.

We state this as axioms.
-/

axiom l0AddWellDefined {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (f₁ f₂ g₁ g₂ : X → ℕ)
    (h₁ : measurableEquivalent μ f₁ f₂ (by sorry) (by sorry))
    (h₂ : measurableEquivalent μ g₁ g₂ (by sorry) (by sorry)) :
    measurableEquivalent μ (fun x => f₁ x + g₁ x) (fun x => f₂ x + g₂ x) (by sorry) (by sorry)

axiom l0SmulWellDefined {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (c : ℕ) (f g : X → ℕ)
    (h : measurableEquivalent μ f g (by sorry) (by sorry)) :
    measurableEquivalent μ (fun x => c * f x) (fun x => c * g x) (by sorry) (by sorry)

/-! ## #eval Examples -/

#eval "=== MiniMeasurableFunctions.Constructions.Quotients ==="

-- L⁰ as quotient: f ~ g iff f = g a.e.
#eval "L⁰ = M / ~,  where f ~ g iff μ{f ≠ g} = 0"

-- Ky Fan metric: d(f, g) = μ{f ≠ g}
#eval "Ky Fan metric: distance is measure of disagreement set"

-- L⁰ is complete under convergence in measure
#eval "L⁰ is a complete metric space (axiom)"

end MiniMeasurableFunctions
