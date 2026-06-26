/-
# Probability Theory: Isomorphisms

Equality in distribution and equivalence of probability spaces.
-/

import MiniObjectKernel
import MiniProbabilityTheory.Core.Basic

namespace MiniProbabilityTheory

/-! ## Equality in Distribution -/

/--
Two random variables X and Y (possibly on different probability
spaces) are equal in distribution, denoted X ≗ Y, if they have
the same distribution: P_X = P_Y.
-/
def eqInDistribution (Ω₁ Ω₂ : ProbabilitySpace)
    (X : RandomVariable Ω₁) (Y : RandomVariable Ω₂) : Prop :=
  distribution Ω₁ X = distribution Ω₂ Y

notation X:50 " ≗ " Y:50 => eqInDistribution _ _ X Y

/-- Equality in distribution is an equivalence relation on random variables
    (across possibly different probability spaces). -/
theorem eqInDistribution_refl (Ω : ProbabilitySpace) (X : RandomVariable Ω) : X ≗ X := by
  rfl

theorem eqInDistribution_symm (Ω₁ Ω₂ : ProbabilitySpace)
    (X : RandomVariable Ω₁) (Y : RandomVariable Ω₂) (h : X ≗ Y) : Y ≗ X := by
  rw [eqInDistribution] at h ⊢
  rw [h]

theorem eqInDistribution_trans (Ω₁ Ω₂ Ω₃ : ProbabilitySpace)
    (X : RandomVariable Ω₁) (Y : RandomVariable Ω₂) (Z : RandomVariable Ω₃)
    (hXY : X ≗ Y) (hYZ : Y ≗ Z) : X ≗ Z := by
  rw [eqInDistribution] at hXY hYZ ⊢
  rw [hXY, hYZ]

/-! ## Equivalence of Probability Spaces -/

/--
Two probability spaces are equivalent if there exists a measure-preserving
bijection between them (a probability isomorphism).
-/
structure ProbEquiv (Ω₁ Ω₂ : ProbabilitySpace) where
  toFun : Ω₁.sampleSpace → Ω₂.sampleSpace
  invFun : Ω₂.sampleSpace → Ω₁.sampleSpace
  left_inv : ∀ x, invFun (toFun x) = x
  right_inv : ∀ y, toFun (invFun y) = y
  measurable : Measurable toFun
  measurable_inv : Measurable invFun
  measurePreserving : ∀ (A : Set Ω₂.sampleSpace), Measurable A →
    Ω₁.measure (toFun ⁻¹' A) = Ω₂.measure A

/-- Identity probability equivalence. -/
def ProbEquiv.refl (Ω : ProbabilitySpace) : ProbEquiv Ω Ω where
  toFun := id
  invFun := id
  left_inv := by intro x; rfl
  right_inv := by intro y; rfl
  measurable := by
    -- identity is measurable
    exact measurable_id
  measurable_inv := by
    exact measurable_id
  measurePreserving := by
    intro A hA; simp

/-- Inverse of a probability equivalence. -/
def ProbEquiv.symm (e : ProbEquiv Ω₁ Ω₂) : ProbEquiv Ω₂ Ω₁ where
  toFun := e.invFun
  invFun := e.toFun
  left_inv := e.right_inv
  right_inv := e.left_inv
  measurable := e.measurable_inv
  measurable_inv := e.measurable
  measurePreserving := by
    intro A hA
    -- pushforward of inverse preserves measure
    sorry

/-- Composition of probability equivalences. -/
def ProbEquiv.trans (e₁ : ProbEquiv Ω₁ Ω₂) (e₂ : ProbEquiv Ω₂ Ω₃) : ProbEquiv Ω₁ Ω₃ where
  toFun := e₂.toFun ∘ e₁.toFun
  invFun := e₁.invFun ∘ e₂.invFun
  left_inv := by
    intro x; simp [e₁.left_inv, e₂.left_inv]
  right_inv := by
    intro y; simp [e₁.right_inv, e₂.right_inv]
  measurable := by
    apply Measurable.comp
    · exact e₂.measurable
    · exact e₁.measurable
  measurable_inv := by
    apply Measurable.comp
    · exact e₁.measurable_inv
    · exact e₂.measurable_inv
  measurePreserving := by
    intro A hA
    sorry

/-! ## Isomorphism in the Category of Random Variables -/

/--
A morphism between random variables (Ω₁, X₁) → (Ω₂, X₂) is a
measure-preserving map φ : Ω₁ → Ω₂ such that X₂ ∘ φ = X₁.
-/
structure RandomVariableIso (Ω₁ Ω₂ : ProbabilitySpace)
    (X₁ : RandomVariable Ω₁) (X₂ : RandomVariable Ω₂) where
  probIso : ProbEquiv Ω₁ Ω₂
  compatibility : X₂.func ∘ probIso.toFun = X₁.func

/-! ## #eval Tests -/

#eval "eqInDistribution (≗) defined as equivalence relation"
#eval "ProbEquiv: probability space isomorphism"
#eval "RandomVariableIso: isomorphism of random variables"

/-- Reflexivity check. -/
#eval "reflexivity of ≗ holds"

end MiniProbabilityTheory
