/-
# MiniMeasurableFunctions.Core.Laws

Algebraic and analytical laws for measurable functions:
- Closure under addition, multiplication, scalar multiplication
- Closure under limsup/liminf and pointwise limits
- Composition with continuous functions preserves measurability
- Simple functions are dense in measurable functions (with respect to pointwise convergence)
- Egorov's theorem: a.e. convergence implies almost uniform convergence on finite measure spaces
- Lusin's theorem: measurable functions are continuous on large sets

These are axiomatized here; deep proofs use `sorry`.
-/

import MiniMeasurableFunctions.Core.Basic

namespace MiniMeasurableFunctions

open MiniMeasurableFunctions

/-! ## Algebraic Closure

Measurable functions are closed under algebraic operations.
-/

-- Sum of measurable functions is measurable
axiom measurable_add {X : Type} [MeasurableSpace X]
    (f g : X → ℕ) (hf : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X))
    (hg : ∀ n, g ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ∀ n, (fun x => f x + g x) ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)

-- Product of measurable functions is measurable
axiom measurable_mul {X : Type} [MeasurableSpace X]
    (f g : X → ℕ) (hf : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X))
    (hg : ∀ n, g ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ∀ n, (fun x => f x * g x) ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)

-- Scalar multiplication preserves measurability
axiom measurable_smul {X : Type} [MeasurableSpace X]
    (c : ℕ) (f : X → ℕ) (hf : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ∀ n, (fun x => c * f x) ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)

-- Supremum of countably many measurable functions is measurable
axiom measurable_sup {X : Type} [MeasurableSpace X]
    (f : ℕ → X → ℕ) (hf : ∀ i n, f i ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ∀ n, (fun x => ⨆ i, f i x) ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)

-- Infimum of countably many measurable functions is measurable
axiom measurable_inf {X : Type} [MeasurableSpace X]
    (f : ℕ → X → ℕ) (hf : ∀ i n, f i ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ∀ n, (fun x => ⨅ i, f i x) ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)

-- limsup of measurable functions is measurable
axiom measurable_limsup {X : Type} [MeasurableSpace X]
    (f : ℕ → X → ℕ) (hf : ∀ i n, f i ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ∀ n, (fun x => limsup (fun i => f i x)) ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)

-- liminf of measurable functions is measurable
axiom measurable_liminf {X : Type} [MeasurableSpace X]
    (f : ℕ → X → ℕ) (hf : ∀ i n, f i ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ∀ n, (fun x => liminf (fun i => f i x)) ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)

-- Composition with continuous function preserves measurability
axiom measurable_comp_continuous {X Y Z : Type}
    [MeasurableSpace X] [MeasurableSpace Y] [MeasurableSpace Z]
    (g : Y → Z) (hg : Continuous g) (f : X → Y)
    (hf : ∀ s, s ∈ MeasurableSpace.measurableSets (X := Y) →
      f ⁻¹' s ∈ MeasurableSpace.measurableSets (X := X)) :
    ∀ s, s ∈ MeasurableSpace.measurableSets (X := Z) →
      (g ∘ f) ⁻¹' s ∈ MeasurableSpace.measurableSets (X := X)

/-
Placeholder: `Continuous` and `limsup`/`liminf` are not defined here
but would be imported from appropriate topology packages.
-/

-- Continuous functions between ℕ spaces (for the composition law)
def Continuous (f : ℕ → ℕ) : Prop := ∀ n, ∃ m, ∀ k, k ≥ m → f k = f m

/-! ## Density of Simple Functions

Every measurable function is the pointwise limit of simple functions.
-/

axiom simpleFunctionsDense {X : Type} [MeasurableSpace X]
    (f : X → ℕ) (hf : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ∃ (s : ℕ → SimpleFunction X), ∀ x, (fun n => s n x) → f x

-- The limit of simple functions is measurable
axiom limitOfSimpleIsMeasurable {X : Type} [MeasurableSpace X]
    (s : ℕ → SimpleFunction X) (f : X → ℕ)
    (hlim : ∀ x, (fun n => s n x) → f x) :
    ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)

/-! ## Egorov's Theorem

On a finite measure space, almost everywhere convergence implies
almost uniform convergence (convergence uniformly except on a set of arbitrarily small measure).
-/

axiom egorovTheorem {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (hFinite : μ Set.univ ≠ Option.none)
    (fₙ : ℕ → X → ℕ) (f : X → ℕ)
    (hMeas : ∀ i, ∀ n, fₙ i ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X))
    (hAe : convergenceAlmostEverywhere {s | μ s = 0} fₙ f) :
    convergenceAlmostUniformly μ fₙ f

/-! ## Lusin's Theorem

A measurable function on ℝ is continuous on a set of arbitrarily large measure
(more precisely, for every ε > 0, there exists a continuous function that
agrees with f except on a set of measure < ε).
-/

axiom lusinTheorem {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (f : X → ℕ)
    (hf : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ∀ ε > 0, ∃ (g : X → ℕ) (hg : Continuous g) (A : Set X), μ A < ε ∧ ∀ x ∉ A, f x = g x

/-! ## #eval Examples -/

-- Define ℕ∞ equality for eval
def ℕ∞.eq (a b : ℕ∞) : Bool :=
  match a, b with
  | Option.some m, Option.some n => m = n
  | Option.none, Option.none => true
  | _, _ => false

instance : BEq ℕ∞ where
  beq := ℕ∞.eq

#eval "=== MiniMeasurableFunctions.Core.Laws ==="
#eval "Algebraic closure axioms established"
#eval "Egorov, Lusin theorems as axioms"
#eval "Simple functions dense in measurable functions"

end MiniMeasurableFunctions
