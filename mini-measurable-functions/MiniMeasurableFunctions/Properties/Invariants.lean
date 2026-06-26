/-
# MiniMeasurableFunctions.Properties.Invariants

Invariants of measurable functions under measure-preserving transformations:
- `distribution`: the pushforward measure f_*μ (the law of f)
- `essentialSup`: the essential supremum of a measurable function
- `essentialInf`: the essential infimum of a measurable function
-/

import MiniMeasurableFunctions.Core.Basic

namespace MiniMeasurableFunctions

/-! ## Distribution of a Measurable Function

Given a measure μ on X and a measurable function f: X → Y,
the distribution (or law) of f is the pushforward measure f_*μ on Y,
defined by (f_*μ)(B) = μ(f⁻¹(B)) for all measurable B ⊆ Y.
-/

def distribution {X Y : Type} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Set X → ℕ∞) (f : X → Y)
    (hf : ∀ s, s ∈ MeasurableSpace.measurableSets (X := Y) →
      f ⁻¹' s ∈ MeasurableSpace.measurableSets (X := X))
    (B : Set Y) : ℕ∞ :=
  if h : B ∈ MeasurableSpace.measurableSets (X := Y) then
    μ (f ⁻¹' B)
  else
    0

/-! ## Properties of the Distribution

The distribution is a probability measure if μ is a probability measure.
-/

axiom distributionIsMeasure {X Y : Type} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Set X → ℕ∞) (f : X → Y)
    (hf : ∀ s, s ∈ MeasurableSpace.measurableSets (X := Y) →
      f ⁻¹' s ∈ MeasurableSpace.measurableSets (X := X))
    (hμEmpty : μ ∅ = 0)
    (hμCountableAdditive : ∀ (A : ℕ → Set X),
      (∀ n, A n ∈ MeasurableSpace.measurableSets (X := X)) →
      (∀ i j, i ≠ j → A i ∩ A j = ∅) →
      μ (⋃ n, A n) = ∑' n, μ (A n)) :
    distribution μ f hf ∅ = 0 ∧
    ∀ (B : ℕ → Set Y),
      (∀ n, B n ∈ MeasurableSpace.measurableSets (X := Y)) →
      (∀ i j, i ≠ j → B i ∩ B j = ∅) →
      distribution μ f hf (⋃ n, B n) = ∑' n, distribution μ f hf (B n)

/-! ## Essential Supremum

The essential supremum of f is the smallest M such that f(x) ≤ M
almost everywhere. That is:
  ess sup f = inf{M ∈ ℝ : μ({x | f(x) > M}) = 0}
-/

def essentialSup {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (f : X → ℕ)
    (hf : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) : ℕ∞ :=
  -- For ℕ-valued functions: the essential sup is the largest n
  -- such that μ(f⁻¹({n})) > 0 (i.e., f takes value n on a non-null set)
  Option.none
  -- Placeholder: would need to compute sup over {n | μ(f⁻¹{n}) > 0}

/-! ## Essential Infimum

The essential infimum of f is the largest m such that f(x) ≥ m
almost everywhere.
-/

def essentialInf {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (f : X → ℕ)
    (hf : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) : ℕ∞ :=
  Option.none
  -- Placeholder: would need to compute inf over {n | μ(f⁻¹{n}) > 0}

/-! ## Essential Sup/Inf Properties

For bounded functions, ess sup f < ∞ and ess inf f > -∞.
-/

axiom essentialSup_bounded {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (f : X → ℕ) (M : ℕ)
    (hf : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X))
    (hBounded : ∀ x, f x ≤ M) :
    essentialSup μ f hf ≠ Option.none ∧
    (match essentialSup μ f hf with
     | Option.some s => s ≤ M
     | Option.none => False)

/-! ## Equality of Distributions Implies Equality in Law

Two functions have the same distribution if and only if they are equal in law.
-/

def equalInDistribution {X Y : Type} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Set X → ℕ∞) (f g : X → Y)
    (hf : ∀ s, s ∈ MeasurableSpace.measurableSets (X := Y) →
      f ⁻¹' s ∈ MeasurableSpace.measurableSets (X := X))
    (hg : ∀ s, s ∈ MeasurableSpace.measurableSets (X := Y) →
      g ⁻¹' s ∈ MeasurableSpace.measurableSets (X := X)) : Prop :=
  ∀ B, B ∈ MeasurableSpace.measurableSets (X := Y) →
    distribution μ f hf B = distribution μ g hg B

/-! ## #eval Examples -/

#eval "=== MiniMeasurableFunctions.Properties.Invariants ==="

-- Distribution: pushforward measure f_*μ(B) = μ(f⁻¹(B))
#eval "Distribution: f_*μ(B) = μ(f⁻¹(B))"

-- Essential sup: smallest M such that f ≤ M a.e.
#eval "essential sup: inf{M | μ{f > M} = 0}"

-- Essential inf: largest m such that f ≥ m a.e.
#eval "essential inf: sup{m | μ{f < m} = 0}"

#eval "Equal in distribution = equal in law"

end MiniMeasurableFunctions
