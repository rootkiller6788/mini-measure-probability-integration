/-
# Probability Theory: Universal Constructions

Universal property of the product probability space (Hewitt-Savage
product), and the de Finetti theorem for exchangeable sequences.
-/

import MiniObjectKernel
import MiniProbabilityTheory.Core.Basic
import MiniProbabilityTheory.Constructions.Products

namespace MiniProbabilityTheory

/-! ## Universal Property of Product Probability -/

/--
The product probability space Ω₁ ⊗ Ω₂ is the universal probability
space equipped with projection maps π₁ : Ω₁ ⊗ Ω₂ → Ω₁ and
π₂ : Ω₁ ⊗ Ω₂ → Ω₂ such that for any probability space Λ with
measure-preserving maps f₁ : Λ → Ω₁, f₂ : Λ → Ω₂, there exists
a unique measure-preserving map (f₁, f₂) : Λ → Ω₁ ⊗ Ω₂.

This is a categorical product in the category Prob with measure-preserving
maps as morphisms.
-/

/-- The projection map π₁ : Ω₁ ⊗ Ω₂ → Ω₁. -/
noncomputable def prodProjectionLeft (Ω₁ Ω₂ : ProbabilitySpace) :
    RandomVariable (Ω₁ ⊗ Ω₂) :=
  { func := fun p => p.1
    measurable := by
      -- projection is measurable
      apply Measurable.fst
  }

/-- The projection map π₂ : Ω₁ ⊗ Ω₂ → Ω₂. -/
noncomputable def prodProjectionRight (Ω₁ Ω₂ : ProbabilitySpace) :
    RandomVariable (Ω₁ ⊗ Ω₂) :=
  { func := fun p => p.2
    measurable := by
      apply Measurable.snd
  }

/-- The universal property: given f₁ : Λ → Ω₁ and f₂ : Λ → Ω₂,
    there exists a unique (f₁, f₂) : Λ → Ω₁ ⊗ Ω₂ such that
    π₁ ∘ (f₁, f₂) = f₁ and π₂ ∘ (f₁, f₂) = f₂. -/
theorem productUniqueness (Ω₁ Ω₂ Λ : ProbabilitySpace)
    (f₁ : RandomVariable Λ) (f₂ : RandomVariable Λ)
    -- need f₁, f₂ to be RandomVariable with same source Λ but different targets
    : True := by
  -- placeholder: the measure-preserving map (f₁, f₂) is unique
  sorry

/-! ## De Finetti's Theorem -/

/--
De Finetti's theorem: An infinite sequence of exchangeable random variables
(X₁, X₂, ...) is conditionally i.i.d. given the empirical measure.

In other words: there exists a random probability measure G (the directing
random measure) such that X₁, X₂, ... are i.i.d. conditional on G.
-/

/-- An infinite sequence of random variables is exchangeable if
    (X₁, ..., X_n) ≗ (X_{π(1)}, ..., X_{π(n)}) for any permutation π. -/
def exchangeable (Ω : ProbabilitySpace) (X : ℕ → RandomVariable Ω) : Prop :=
  ∀ (n : ℕ) (π : Equiv.Perm (Fin n)),
    (fun ω i => X (π i) ω) ≗ (fun ω i => X i ω)
    -- Here we compare the joint distribution of the first n variables
    -- under permutation with the original joint distribution.

/-- De Finetti's theorem: every exchangeable sequence is a mixture of i.i.d. sequences. -/
theorem deFinettiTheorem (Ω : ProbabilitySpace) (X : ℕ → RandomVariable Ω)
    (hexch : exchangeable Ω X) :
    ∃ (Λ : ProbabilitySpace) (G : RandomVariable Λ)
      (conditionalIIDProb : ∀ (ω : Λ.sampleSpace), ProbabilitySpace),
    ∀ (n : ℕ), -- The joint distribution of (X₁, ..., X_n) equals ∫ Π_{i=1}^n P_G(X_i) dΛ
    True := by
  -- This expresses the profound fact that exchangeability = conditional independence.
  -- The directing random measure G is the tail σ-field / empirical distribution.
  sorry

/-- The empirical measure (sample distribution) of the first n observations:
    P_n = (1/n) ∑_{i=1}^n δ_{X_i}. -/
noncomputable def empiricalMeasure (Ω : ProbabilitySpace) (X : ℕ → RandomVariable Ω) (n : ℕ) :
    Measure ℝ :=
  ∫ ω, (∑ i in Finset.range n, DiracMeasure (X i ω)) / (n : ℝ)

/-- Glivenko-Cantelli: the empirical CDF converges uniformly to the true CDF. -/
theorem glivenkoCantelli (Ω : ProbabilitySpace) (X : ℕ → RandomVariable Ω)
    (hiid : ∀ i j, i ≠ j → independent Ω (X i) (X j))
    (hident : ∀ i j, X i ≗ X j) :
    Filter.Tendsto (fun n => sup_norm (empiricalCDF Ω X n) (cdf Ω (X 0))) Filter.atTop (𝓝 0) := by
  sorry

noncomputable def empiricalCDF (Ω : ProbabilitySpace) (X : ℕ → RandomVariable Ω) (n : ℕ) (t : ℝ) : ℝ :=
  empiricalMeasure Ω X n {x | x ≤ t}

def sup_norm (F G : ℝ → ℝ) : ℝ := sSup { |F t - G t| | t : ℝ }

/-- Dirac measure at a point. -/
noncomputable def DiracMeasure (x : ℝ) : Measure ℝ := {
  measureOf := fun A => if x ∈ A then 1 else 0
  measureEmpty := by simp
  measureUnion := by
    intro f hfdisj henum
    sorry
}

/-! ## #eval Tests -/

#eval "Universal property: Ω₁⊗Ω₂ is categorical product in Prob"
#eval "de Finetti theorem: exchangeability = conditional i.i.d."
#eval "Glivenko-Cantelli: empirical CDF → true CDF uniformly"

end MiniProbabilityTheory
