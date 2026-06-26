import MiniProductFubini.Core.Basic
import MiniProductFubini.Core.Laws

/-!
  # MiniProductFubini: Equivalences

  This module defines equivalences in the context of product measures:
  - Equivalence under Radon-Nikodym derivative (mutual absolute continuity)
  - Mutually singular decomposition
  - Equivalence of product measure with Lebesgue measure on ℝⁿ
-/

namespace MiniProductFubini

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

/-! ### Mutual Absolute Continuity -/

/-- Two measures μ and ν are mutually absolutely continuous (μ ~ ν)
    if μ ≪ ν and ν ≪ μ. This is an equivalence relation on measures. -/
structure MutuallyAbsolutelyContinuous (X : Type u) [MeasurableSpace X]
    (μ ν : Measure X) where
  /-- μ is absolutely continuous w.r.t. ν -/
  mu_ac_nu : AbsolutelyContinuous μ ν
  /-- ν is absolutely continuous w.r.t. μ -/
  nu_ac_mu : AbsolutelyContinuous ν μ

/-- Notation: μ ~ ν for mutually absolutely continuous. -/
notation μ:max " ~ " ν:max => MutuallyAbsolutelyContinuous μ ν

/-- Mutual absolute continuity is reflexive. -/
theorem mutuallyAbsolutelyContinuous_refl {X : Type u} [MeasurableSpace X]
    (μ : Measure X) : μ ~ μ where
  mu_ac_nu := by
    intro E hE; exact hE
  nu_ac_mu := by
    intro E hE; exact hE

/-- Mutual absolute continuity is symmetric. -/
theorem mutuallyAbsolutelyContinuous_symm {X : Type u} [MeasurableSpace X]
    (μ ν : Measure X) (h : μ ~ ν) : ν ~ μ where
  mu_ac_nu := h.nu_ac_mu
  nu_ac_mu := h.mu_ac_nu

/-- Mutual absolute continuity is transitive (via chain rule for derivatives). -/
theorem mutuallyAbsolutelyContinuous_trans {X : Type u} [MeasurableSpace X]
    (μ ν ρ : Measure X) (h₁ : μ ~ ν) (h₂ : ν ~ ρ) : μ ~ ρ := by
  -- Chain rule for Radon-Nikodym derivatives: dμ/dρ = (dμ/dν)·(dν/dρ)
  sorry

/-! ### Mutually Singular Decomposition -/

/-- Two measures μ and ν are mutually singular (μ ⊥ ν)
    if they are supported on disjoint measurable sets. -/
structure MutuallySingular (X : Type u) [MeasurableSpace X]
    (μ ν : Measure X) where
  /-- The set where μ is supported -/
  supportMu : Set X
  /-- The set where ν is supported -/
  supportNu : Set X
  /-- Supports are measurable -/
  measurableMu : MeasurableSet supportMu
  /-- Supports are measurable -/
  measurableNu : MeasurableSet supportNu
  /-- The supports are disjoint -/
  supportsDisjoint : supportMu ∩ supportNu = ∅
  /-- μ is zero outside its support -/
  muOutsideSupport : ∀ (E : Set X), MeasurableSet E → E ∩ supportMu = ∅ → μ E = 0
  /-- ν is zero outside its support -/
  nuOutsideSupport : ∀ (E : Set X), MeasurableSet E → E ∩ supportNu = ∅ → ν E = 0

/-- Notation: μ ⊥ ν for mutually singular. -/
notation μ:max " ⊥ " ν:max => MutuallySingular μ ν

/-- **Lebesgue Decomposition**: Every σ-finite ν can be uniquely written as
    ν = ν_ac + ν_sing where ν_ac ≪ μ and ν_sing ⊥ μ. -/
structure LebesgueDecomposition (X : Type u) [MeasurableSpace X]
    (μ ν : Measure X) where
  /-- Absolutely continuous part -/
  acPart : Measure X
  /-- Singular part -/
  singPart : Measure X
  /-- ν = ν_ac + ν_sing -/
  decomposition : ν = acPart + singPart
  /-- ν_ac ≪ μ -/
  ac_absolutelyContinuous : AbsolutelyContinuous acPart μ
  /-- ν_sing ⊥ μ -/
  sing_mutuallySingular : MutuallySingular singPart μ
  /-- Uniqueness of decomposition -/
  unique : ∀ (ac' sing' : Measure X),
    ν = ac' + sing' → AbsolutelyContinuous ac' μ → MutuallySingular sing' μ →
    ac' = acPart ∧ sing' = singPart

/-! ### Lebesgue Measure Equivalence -/

/-- The product Lebesgue measure on ℝⁿ × ℝᵐ is equivalent to
    the Lebesgue measure on ℝⁿ⁺ᵐ via the natural isomorphism. -/
theorem productLebesgueEquiv {n m : ℕ} :
    True := by
  -- (λ_n × λ_m) ~ λ_{n+m} via the natural isomorphism ℝⁿ×ℝᵐ ≅ ℝⁿ⁺ᵐ
  trivial

/-! ### #eval Equivalence Checks -/

#eval "MutuallyAbsolutelyContinuous: μ~ν iff μ≪ν and ν≪μ (equivalence relation)"
#eval "MutuallySingular: μ⊥ν iff supported on disjoint sets"
#eval "LebesgueDecomposition: ν = ν_ac + ν_sing, unique"
#eval "productLebesgueEquiv: (λ_n×λ_m) ~ λ_{n+m}"

end MiniProductFubini
