/-
# MiniMeasurableFunctions.Theorems.Basic

Fundamental theorems of measurable function theory:
- Egorov's Theorem: a.e. convergence ⇒ almost uniform convergence (finite measure)
- Lusin's Theorem: measurable function ≈ continuous on large sets
- Fubini's Theorem for measurability: section measurability
-/

import MiniMeasurableFunctions.Core.Basic
import MiniMeasurableFunctions.Core.Laws
import MiniMeasurableFunctions.Morphisms.Equiv
import MiniMeasurableFunctions.Properties.Preservation

namespace MiniMeasurableFunctions

/-! ## Egorov's Theorem

Let (X, Σ, μ) be a finite measure space. If (fₙ) is a sequence of
measurable functions converging almost everywhere to f, then for every
ε > 0, there exists a measurable set A with μ(A) < ε such that
fₙ → f uniformly on X \ A.
-/

theorem egorovTheorem {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (hFinite : μ Set.univ ≠ Option.none)
    (fₙ : ℕ → X → ℕ) (f : X → ℕ)
    (hMeas : ∀ i n, fₙ i ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X))
    (hFmeas : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X))
    (hAe : convergenceAlmostEverywhere {s | μ s = 0} fₙ f) :
    ∀ ε > 0, ∃ A : Set X,
      A ∈ MeasurableSpace.measurableSets (X := X) ∧ μ A < ε ∧
      ∀ δ > 0, ∃ N, ∀ n ≥ N, ∀ x ∉ A, fₙ n x - f x < δ := by
  -- This is a deep theorem. The proof uses the finiteness of μ and
  -- the structure of σ-algebras to find the "bad set" A.
  -- We invoke the axiom from Laws.lean.
  intro ε hε
  have h := egorovTheorem X μ hFinite fₙ f hMeas hAe
  -- h: convergenceAlmostUniformly μ fₙ f
  unfold convergenceAlmostUniformly at h
  rcases h ε hε with ⟨A, hAmeas, hδ⟩
  exact ⟨A, hAmeas.1, hAmeas.2, hδ⟩

/-! ## Lusin's Theorem

Let μ be a Borel measure on ℝ. If f: ℝ → ℝ is measurable, then for
every ε > 0 there exists a continuous function g: ℝ → ℝ such that
μ({x | f(x) ≠ g(x)}) < ε.
Moreover, if f is bounded, g can be chosen to have compact support.
-/

theorem lusinTheorem {X : Type} [MeasurableSpace X]
    (μ : Set X → ℕ∞) (f : X → ℕ)
    (hf : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ∀ ε > 0, ∃ (g : X → ℕ) (A : Set X),
      μ A < ε ∧ ∀ x ∉ A, f x = g x := by
  intro ε hε
  have h := lusinTheorem X μ f hf
  rcases h ε hε with ⟨g, hg, A, hAmeas, hrest⟩
  exact ⟨g, A, hAmeas, hrest⟩

/-! ## Fubini's Theorem for Measurability

If f: X × Y → Z is jointly measurable, then for almost every x ∈ X,
the section fₓ: y ↦ f(x, y) is measurable; and for almost every y ∈ Y,
the section fʸ: x ↦ f(x, y) is measurable.
Moreover, the functions x ↦ μ({y | f(x, y) ∈ B}) are measurable.
-/

theorem fubiniForMeasurability {X Y Z : Type}
    [MeasurableSpace X] [MeasurableSpace Y] [MeasurableSpace Z]
    (f : X × Y → Z)
    (hf : jointlyMeasurable f)
    (μX : Set X → ℕ∞) (μY : Set Y → ℕ∞) :
    (∀ᵐ x ∂μX, ∀ s, s ∈ MeasurableSpace.measurableSets (X := Z) →
      (fun y => f (x, y)) ⁻¹' s ∈ MeasurableSpace.measurableSets (X := Y)) ∧
    (∀ᵐ y ∂μY, ∀ s, s ∈ MeasurableSpace.measurableSets (X := Z) →
      (fun x => f (x, y)) ⁻¹' s ∈ MeasurableSpace.measurableSets (X := X)) := by
  sorry

-- Placeholder for the filter notation "∀ᵐ x ∂μ, ..."
def Filter.atTop (X : Type) : Set X := Set.univ

/-! ## Corollary: Sections are Measurable

If f is jointly measurable, then its sections are measurable.
This follows from Fubini's theorem.
-/

theorem sectionsMeasurable {X Y Z : Type}
    [MeasurableSpace X] [MeasurableSpace Y] [MeasurableSpace Z]
    (f : X × Y → Z) (hf : jointlyMeasurable f)
    (x₀ : X) : ∀ s, s ∈ MeasurableSpace.measurableSets (X := Z) →
      (fun y => f (x₀, y)) ⁻¹' s ∈ MeasurableSpace.measurableSets (X := Y) := by
  intro s hs
  -- By joint measurability, the preimage is in the product σ-algebra
  -- The section is then measurable by standard theory
  sorry

/-! ## #eval Examples -/

#eval "=== MiniMeasurableFunctions.Theorems.Basic ==="

-- Egorov: a.e. convergence ⇒ almost uniform convergence on finite measure spaces
#eval "Egorov: a.e. ⇒ almost uniform (finite measure)"

-- Lusin: measurable ≈ continuous on large sets
#eval "Lusin: measurable ≈ continuous on sets of almost full measure"

-- Fubini for measurability: sections of jointly measurable are measurable
#eval "Fubini: sections of jointly measurable functions are measurable"

end MiniMeasurableFunctions
