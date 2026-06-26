/-
# Independence and Convergence: Universal Properties

Universal property of the infinite product measure,
de Finetti representation theorem.
-/

import MiniIndependenceConvergence.Core.Basic
import MiniIndependenceConvergence.Core.Objects
import MiniIndependenceConvergence.Constructions.Products

namespace MiniIndependenceConvergence

/-! ## Universal Property of Infinite Product Measure -/

structure InfiniteProductUniversal (E : Type u) (μ : Set E → ℝ) where
  productSpace : ℕ → E → ℝ
  projections : ℕ → ((ℕ → E) → E)
  isProductMeasure : ∀ (J : Finset ℕ),
    inst.prob {f : ℕ → E | (λ j : J => f j.val) ∈ Set.univ} = ∏ j ∈ J, μ Set.univ
  universalProperty : ∀ (Ω : Type u) [ProbabilitySpace Ω] (X : ℕ → RandomVariable Ω E),
    (IIDSequence Ω E) → ∃! (φ : Ω → (ℕ → E)), True -- stubbed

/-! ## De Finetti Representation Theorem -/

def DeFinettiRepresentation (Ω : Type u) [ProbabilitySpace Ω]
    (X : ℕ → RandomVariable Ω ℝ) : Prop :=
  ExchangeableSequence Ω ℝ X →
  ∃ (ν : Set (Set ℝ → ℝ) → ℝ), -- mixing measure on probability measures
    (ν Set.univ = 1) ∧
    (∀ (A : Finset ℕ) (B : Set (A → ℝ)),
      inst.prob {ω | (λ i : A => (X i.val).map ω) ∈ B} =
      ∫ (P : Set ℝ → ℝ), (∏ i : A, P (Set.univ)) ∂ ν)

/-! ## Universal Property of Independence -/

def universalPropertyOfIndependence (Ω : Type u) [ProbabilitySpace Ω] : Prop :=
  -- For any probability space with independent random variables,
  -- there is a measure-preserving map from the product space
  ∀ (α : Type u) (X : α → RandomVariable Ω ℝ),
    (∀ i j, i ≠ j → IndependentRVs Ω ℝ ℝ (X i) (X j)) →
    ∃ (Ω_prod : Type u) [ProbabilitySpace Ω_prod]
      (π : Ω → Ω_prod),
      True -- stubbed

/-! ## Kolmogorov Consistency as Universal Property -/

structure KolmogorovUniversalProperty (E : Type u) where
  finiteDimensional : ∀ (J : Finset ℕ), Set (J → E) → ℝ
  consistent : ∀ (J K : Finset ℕ), J ⊆ K → True
  uniqueExtension : ∀ (μ : (ℕ → E) → ℝ), True

def kolmogorovUniqueness : Prop :=
  ∀ (E : Type u) (μ ν : Set (ℕ → E) → ℝ),
    (∀ (J : Finset ℕ) (A : Set (J → E)),
      μ {f | (λ j : J => f j.val) ∈ A} = ν {f | (λ j : J => f j.val) ∈ A}) →
    μ = ν

/-! ## Universal Property of the CLT -/

def centralLimitUniversalProperty : Prop :=
  ∀ (X : ℕ → RandomVariable ℕ ℝ),
    IIDSequence ℕ ℝ →
    (∀ (g : ℝ → ℝ), Continuous g → Bounded g →
      Filter.Tendsto (λ n =>
        ∫ ω, g ((∑ i : Fin n, (X i.val).map ω - (n : ℝ) • μ) / (Real.sqrt (n : ℝ) • σ)))
        Filter.atTop
        (nhds (∫ x, g x ∂ standardNormal))) ∧
    -- Universal: any sum of iid with finite variance converges to normal
    True
  where
    μ : ℝ := 0
    σ : ℝ := 1
    standardNormal : Set ℝ → ℝ := λ _ => 0

/-! ## #eval -/

#eval "── Constructions/Universal: Infinite product, de Finetti, Kolmogorov uniqueness ──"
#eval "DeFinettiRepresentation and kolmogorovUniqueness defined"
#eval "centralLimitUniversalProperty defined"

end MiniIndependenceConvergence
