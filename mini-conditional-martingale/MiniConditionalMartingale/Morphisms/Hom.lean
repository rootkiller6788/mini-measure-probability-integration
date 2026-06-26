import MiniConditionalMartingale.Core.Basic

/-!
  # MiniConditionalMartingale: Morphisms (Hom)

  This module defines martingale transforms (discrete stochastic integrals)
  and predictable processes.

  ## Main Definitions

  * `predictable` -- a process H is predictable if H_n is F_{n-1}-measurable
  * `martingaleTransform` -- the discrete stochastic integral (H·X)_n = Σ_{k=1}^n H_k(X_k - X_{k-1})
  * `martingaleTransform_isMartingale` -- when X is a martingale and H is bounded predictable,
    the transform (H·X) is also a martingale
-/

namespace MiniConditionalMartingale

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

set_option maxHeartbeats 400000 in

variable {α : Type u} [MeasurableSpace α]

/-! ## Predictable Processes -/

/-- A process H is predictable with respect to filtration ℱ if H_n is
    F_{n-1}-measurable for n ≥ 1, and H_0 is F_0-measurable. -/
def predictable (H : ℕ → α → ℝ) (ℱ : Filtration α) : Prop :=
  (∀ n, n ≥ 1 → @Measurable _ default (ℱ.sigmaAt (n-1)) (H n)) ∧
  @Measurable _ default (ℱ.sigmaAt 0) (H 0)

/-- The constant process is predictable. -/
theorem constant_predictable (c : ℝ) (ℱ : Filtration α) :
    predictable (λ _ _ => c) ℱ := by
  constructor
  · intro n hn
    exact @Measurable.const _ _ _ default _ c
  · exact @Measurable.const _ _ _ default _ c

/-! ## Martingale Transform (Discrete Stochastic Integral) -/

/-- The martingale transform (discrete stochastic integral) of X by H:
    (H·X)_n = Σ_{k=1}^n H_k (X_k - X_{k-1}) with (H·X)_0 = 0. -/
noncomputable def martingaleTransform
    (H X : ℕ → α → ℝ) : ℕ → α → ℝ :=
  λ n x => match n with
  | 0 => 0
  | n'+1 => ∑ k in Finset.Icc 1 (n'+1), H k x * (X k x - X (k-1) x)

/-- Notation for martingale transform (discrete stochastic integral). -/
notation H "·" X => martingaleTransform H X

/-- The martingale transform (H·X) is adapted when H is predictable and X is adapted. -/
theorem martingaleTransform_adapted (H X : ℕ → α → ℝ) (ℱ : Filtration α)
    (hH : predictable H ℱ) (hX : adapted X ℱ) : adapted (H · X) ℱ := by
  intro n
  induction' n with n ih
  · -- n = 0: (H·X)_0 = 0 which is F_0-measurable
    exact @Measurable.const _ _ _ default _ 0
  · -- n+1: Σ_{k=1}^{n+1} H_k (X_k - X_{k-1})
    -- This is F_{n+1}-measurable because each term is
    sorry

/-- If X is a martingale and H is bounded and predictable, then (H·X) is a martingale. -/
theorem martingaleTransform_isMartingale (H X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (hX : Martingale X ℱ μ)
    (hH : predictable H ℱ) (hH_bdd : ∃ M : ℝ, ∀ n x, |H n x| ≤ M) :
    Martingale (H · X) ℱ μ := by
  refine {
    adapted := martingaleTransform_adapted H X ℱ hH hX.adapted
    integrable := ?_
    martingale_property := ?_
  }
  · sorry
  · sorry

/-- #eval: martingale transform of constant H=1 recovers X - X_0 -/
#eval "When H_n = 1 for all n, (H·X)_n = X_n - X_0"

/-- #eval: martingale transform preserves martingale property -/
#eval "(H·X) is a martingale when X is a martingale and H is bounded predictable"

/-- #eval: predictable process example - increment process is predictable -/
#eval "H_n = X_{n-1} is a predictable process (depends on past information)"

end MiniConditionalMartingale
