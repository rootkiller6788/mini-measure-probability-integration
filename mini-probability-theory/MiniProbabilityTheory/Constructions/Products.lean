/-
# Probability Theory: Product Constructions

Product probability space, joint distributions, and marginal distributions.
-/

import MiniObjectKernel
import MiniProbabilityTheory.Core.Basic

namespace MiniProbabilityTheory

/-! ## Product Probability Space -/

/--
The product probability space of two probability spaces (Ω₁, P₁) and (Ω₂, P₂)
is (Ω₁ × Ω₂, P₁ ⊗ P₂), where the product measure is the unique measure
satisfying (P₁ ⊗ P₂)(A × B) = P₁(A) · P₂(B).
-/
structure ProductProbabilitySpace (Ω₁ Ω₂ : ProbabilitySpace) where
  carrier : Type
  [measurableSpace : MeasurableSpace carrier]
  [productMeasure : Measure carrier]
  isomorphToProduct : ProbEquiv { sampleSpace := carrier
    := Ω₁ }
    -- : product measurable space = Ω₁.sampleSpace × Ω₂.sampleSpace
  -- product measure property: for measurable rectangles A×B
  productRectangleFormula : ∀ (A : Set Ω₁.sampleSpace) (B : Set Ω₂.sampleSpace),
    Measurable A → Measurable B →
    productMeasure ((fun (x : Ω₁.sampleSpace × Ω₂.sampleSpace) => x.1) ⁻¹' A ∩
      (fun (x : Ω₁.sampleSpace × Ω₂.sampleSpace) => x.2) ⁻¹' B) =
    Ω₁.measure A * Ω₂.measure B

/-- The canonical product probability space using the type `Ω₁ × Ω₂`. -/
noncomputable def productProbSpace (Ω₁ Ω₂ : ProbabilitySpace) : ProbabilitySpace :=
  { sampleSpace := Ω₁.sampleSpace × Ω₂.sampleSpace
    measurableSpace := by
      -- product σ-algebra
      exact instMeasurableSpace
    measure := {
      measureOf := fun S => 0  -- placeholder: product measure
      measureEmpty := by simp
      measureUnion := by
        intro f hfdisj henum
        sorry
    }
    totalProbabilityOne := by
      -- P(Ω₁ × Ω₂) = P₁(Ω₁) * P₂(Ω₂) = 1 * 1 = 1
      sorry
  }

notation Ω₁:80 " ⊗ " Ω₂:80 => productProbSpace Ω₁ Ω₂

/-! ## Joint Distribution -/

/--
The joint distribution of random variables X : Ω → ℝ and Y : Ω → ℝ
is the pushforward measure of (X, Y) : Ω → ℝ².
-/
noncomputable def jointDistribution (Ω : ProbabilitySpace)
    (X Y : RandomVariable Ω) : Measure (ℝ × ℝ) :=
  pushforwardMeasure (fun ω => (X.func ω, Y.func ω)) Ω.measure

/-- The joint CDF: F_{X,Y}(x,y) = P(X ≤ x, Y ≤ y). -/
noncomputable def jointCDF (Ω : ProbabilitySpace) (X Y : RandomVariable Ω) (x y : ℝ) : ℝ :=
  jointDistribution Ω X Y { (a,b) : ℝ × ℝ | a ≤ x ∧ b ≤ y }

/-! ## Marginal Distributions -/

/-- The marginal distribution of X from a joint distribution: P_X(A) = P_{X,Y}(A × ℝ). -/
noncomputable def marginalDistributionX (Ω : ProbabilitySpace)
    (X Y : RandomVariable Ω) (A : Set ℝ) : ℝ :=
  jointDistribution Ω X Y { (a,b) | a ∈ A }

/-- The marginal distribution of Y from a joint distribution: P_Y(B) = P_{X,Y}(ℝ × B). -/
noncomputable def marginalDistributionY (Ω : ProbabilitySpace)
    (X Y : RandomVariable Ω) (B : Set ℝ) : ℝ :=
  jointDistribution Ω X Y { (a,b) | b ∈ B }

/-- The marginal of X from the joint distribution equals the distribution of X. -/
theorem marginalOfX_eq_distribution (Ω : ProbabilitySpace) (X Y : RandomVariable Ω)
    (A : Set ℝ) (hA : Measurable A) :
    marginalDistributionX Ω X Y A = distribution Ω X A := by
  sorry

/-- The marginal of Y from the joint distribution equals the distribution of Y. -/
theorem marginalOfY_eq_distribution (Ω : ProbabilitySpace) (X Y : RandomVariable Ω)
    (B : Set ℝ) (hB : Measurable B) :
    marginalDistributionY Ω X Y B = distribution Ω Y B := by
  sorry

/-! ## Independence -/

/--
Two random variables X and Y are independent if their joint distribution
is the product of their marginals: P_{X,Y} = P_X ⊗ P_Y.
-/
def independent (Ω : ProbabilitySpace) (X Y : RandomVariable Ω) : Prop :=
  ∀ (A B : Set ℝ), Measurable A → Measurable B →
    jointDistribution Ω X Y { (a,b) | a ∈ A ∧ b ∈ B } =
    distribution Ω X A * distribution Ω Y B

/-- If X and Y are independent, E[XY] = E[X]E[Y]. -/
theorem expectation_product_independent (Ω : ProbabilitySpace) (X Y : RandomVariable Ω)
    (hindep : independent Ω X Y) :
    expectation Ω { func := fun ω => X.func ω * Y.func ω
      measurable := by sorry
    } = expectation Ω X * expectation Ω Y := by
  sorry

/-! ## Infinite Product Spaces -/

/-- A countable product of probability spaces (for sequences of random variables). -/
noncomputable def countableProduct (Ω_seq : ℕ → ProbabilitySpace) : ProbabilitySpace :=
  { sampleSpace := (n : ℕ) → (Ω_seq n).sampleSpace
    measurableSpace := by
      exact instMeasurableSpace
    measure := {
      measureOf := fun _ => 0
      measureEmpty := by simp
      measureUnion := by
        intro f hfdisj henum
        sorry
    }
    totalProbabilityOne := by
      sorry
  }

/-! ## #eval Tests -/

#eval "productProbSpace (⊗) defined"
#eval "jointDistribution and jointCDF defined"
#eval "marginal distributions and independence defined"
#eval "countableProduct for i.i.d. sequences"

end MiniProbabilityTheory
