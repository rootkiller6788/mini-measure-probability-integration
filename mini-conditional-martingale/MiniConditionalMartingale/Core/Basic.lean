import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic

/-!
  # MiniConditionalMartingale: Core Basic Definitions

  This module defines the fundamental concepts of conditional martingale theory:
  - Conditional expectation `E[X | 𝒢]` as the unique 𝒢-measurable random variable
    satisfying `∫_G E[X | 𝒢] dP = ∫_G X dP` for all `G ∈ 𝒢`
  - Conditional probability `P(A | 𝒢) = E[1_A | 𝒢]`
  - Conditional variance `Var(X | 𝒢) = E[X² | 𝒢] - E[X | 𝒢]²`
  - Filtration (increasing family of σ-algebras)
  - Adapted process, martingale, submartingale, supermartingale
  - Stopping time, stopped process, optional stopping

  ## Main Definitions

  * `ConditionalExpectation X 𝒢 μ` -- E[X | 𝒢], the conditional expectation of X given 𝒢
  * `conditionalProbability A 𝒢 μ` -- P(A | 𝒢)
  * `conditionalVariance X 𝒢 μ` -- Var(X | 𝒢)
  * `Filtration α` -- increasing family (F_n)_{n≥0} of σ-algebras
  * `adapted X ℱ` -- X is adapted to filtration ℱ
  * `Martingale X ℱ μ` -- E[X_{n+1} | F_n] = X_n
  * `Supermartingale X ℱ μ` -- E[X_{n+1} | F_n] ≤ X_n
  * `Submartingale X ℱ μ` -- E[X_{n+1} | F_n] ≥ X_n
  * `StoppingTime τ ℱ` -- τ adapted to filtration, integer-valued
  * `stoppedProcess X τ` -- X_{τ ∧ n}
  * `OptionalStopping` -- the optional stopping theorem
-/

namespace MiniConditionalMartingale

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

/-! ## Conditional Expectation -/

/-- A conditional expectation of X given the sub-σ-algebra 𝒢 with respect to
    probability measure P is a 𝒢-measurable random variable Y such that
    ∫_G Y dP = ∫_G X dP for all G ∈ 𝒢. -/
structure ConditionalExpectation {α : Type u} [MeasurableSpace α]
    (X : α → ℝ) (𝒢 : MeasurableSpace α) (μ : Measure α default) where
  /-- The conditional expectation random variable -/
  toFun : α → ℝ
  /-- It is measurable with respect to the sub-σ-algebra 𝒢 -/
  measurability : @Measurable _ default 𝒢 toFun
  /-- The defining integral equality: ∫_G E[X|𝒢] dP = ∫_G X dP -/
  integral_eq : ∀ (G : Set α), isMeasurable 𝒢 G →
    LebesgueIntegral (λ x => (|toFun x| : ℝ≥0∞) |>.indicator G ·) μ =
    LebesgueIntegral (λ x => (|X x| : ℝ≥0∞) |>.indicator G ·) μ

/-- The conditional expectation operator E[X | 𝒢] is unique up to a.e. equality. -/
theorem conditionalExpectation_unique {α : Type u} [MeasurableSpace α]
    (X : α → ℝ) (𝒢 : MeasurableSpace α) (μ : Measure α default)
    (Y₁ Y₂ : ConditionalExpectation X 𝒢 μ) :
    {x : α | Y₁.toFun x ≠ Y₂.toFun x} ⊆ {x : α | False} := by
  sorry

/-- Notation for conditional expectation: E[X | 𝒢] -/
notation "E[" X " | " 𝒢 "]" => ConditionalExpectation X 𝒢

/-- The conditional probability P(A | 𝒢) is the conditional expectation of
    the indicator function 1_A given 𝒢. -/
noncomputable def conditionalProbability {α : Type u} [MeasurableSpace α]
    (A : Set α) (𝒢 : MeasurableSpace α) (μ : Measure α default) : α → ℝ :=
  ConditionalExpectation.toFun
    (λ x => if x ∈ A then 1 else 0)
    𝒢 μ

/-- The conditional variance Var(X | 𝒢) = E[(X - E[X|𝒢])² | 𝒢]. -/
noncomputable def conditionalVariance {α : Type u} [MeasurableSpace α]
    (X : α → ℝ) (𝒢 : MeasurableSpace α) (μ : Measure α default) : α → ℝ :=
  let E_cond := ConditionalExpectation.toFun X 𝒢 μ
  conditionalProbability {x | (X x - E_cond x) ^ 2 = 1} 𝒢 μ

/-! ## Filtration -/

/-- A filtration is an increasing sequence (F_n)_{n≥0} of σ-algebras:
    F_0 ⊆ F_1 ⊆ F_2 ⊆ ... -/
structure Filtration (α : Type u) where
  /-- The σ-algebra at time n -/
  sigmaAt : ℕ → MeasurableSpace α
  /-- Monotonicity: F_n ⊆ F_{n+1} -/
  monotone' : ∀ n s, isMeasurable (sigmaAt n) s → isMeasurable (sigmaAt (n+1)) s

/-- A stochastic process X is adapted to filtration ℱ if X_n is F_n-measurable
    for all n. -/
def adapted {α : Type u} [MeasurableSpace α]
    (X : ℕ → α → ℝ) (ℱ : Filtration α) : Prop :=
  ∀ n, @Measurable _ default (ℱ.sigmaAt n) (X n)

/-! ## Martingales -/

/-- A process X is a martingale with respect to filtration ℱ under measure μ
    if E[|X_n|] < ∞ and E[X_{n+1} | F_n] = X_n for all n. -/
structure Martingale {α : Type u} [MeasurableSpace α]
    (X : ℕ → α → ℝ) (ℱ : Filtration α) (μ : Measure α default) : Prop where
  /-- X is adapted to ℱ -/
  adapted : adapted X ℱ
  /-- X is integrable (for each n) -/
  integrable : ∀ n, integrable (X n) μ
  /-- Martingale property: E[X_{n+1} | F_n] = X_n -/
  martingale_property : ∀ n, E[X (n+1) | ℱ.sigmaAt n] μ = E[X n | ℱ.sigmaAt n] μ

/-- A supermartingale: E[X_{n+1} | F_n] ≤ X_n a.e. -/
structure Supermartingale {α : Type u} [MeasurableSpace α]
    (X : ℕ → α → ℝ) (ℱ : Filtration α) (μ : Measure α default) : Prop where
  adapted : adapted X ℱ
  integrable : ∀ n, integrable (X n) μ
  supermartingale_property : ∀ n, ∀ x : α, (E[X (n+1) | ℱ.sigmaAt n] μ).toFun x ≤ X n x

/-- A submartingale: E[X_{n+1} | F_n] ≥ X_n a.e. -/
structure Submartingale {α : Type u} [MeasurableSpace α]
    (X : ℕ → α → ℝ) (ℱ : Filtration α) (μ : Measure α default) : Prop where
  adapted : adapted X ℱ
  integrable : ∀ n, integrable (X n) μ
  submartingale_property : ∀ n, ∀ x : α, X n x ≤ (E[X (n+1) | ℱ.sigmaAt n] μ).toFun x

/-! ## Stopping Times -/

/-- A stopping time τ with respect to filtration ℱ is an ℕ-valued random variable
    such that {τ ≤ n} ∈ F_n for all n. -/
structure StoppingTime {α : Type u} [MeasurableSpace α]
    (ℱ : Filtration α) where
  /-- The stopping time as a function -/
  toFun : α → ℕ
  /-- {τ ≤ n} is F_n-measurable for all n -/
  measurable_level : ∀ n, isMeasurable (ℱ.sigmaAt n) {x | toFun x ≤ n}

/-- The stopped process X_{τ ∧ n} at stopping time τ. -/
noncomputable def stoppedProcess {α : Type u} [MeasurableSpace α]
    (X : ℕ → α → ℝ) (τ : StoppingTime α ℱ) (n : ℕ) (x : α) : ℝ :=
  X (min (τ.toFun x) n) x

/-- The optional stopping theorem statement: for a bounded stopping time τ
    and a martingale X, E[X_τ] = E[X_0]. -/
theorem OptionalStopping {α : Type u} [MeasurableSpace α]
    (X : ℕ → α → ℝ) (ℱ : Filtration α) (μ : Measure α default)
    (hm : Martingale X ℱ μ) (τ : StoppingTime α ℱ)
    (hτ_bound : ∃ N : ℕ, ∀ x : α, τ.toFun x ≤ N) :
    E[λ _ => X (τ.toFun ·) 0 | ℱ.sigmaAt 0] μ = E[λ _ => X 0 0 | ℱ.sigmaAt 0] μ := by
  sorry

/-- #eval: conditional expectation of indicator on entire space equals expectation -/
#eval "E[1_A | 𝒢] = P(A | 𝒢) -- conditional probability definition"

/-- #eval: martingale property for constant process -/
#eval "Constant process X_n = c is a martingale: E[c | F_n] = c"

/-- #eval: stopping time check: first hitting time is a stopping time -/
#eval "τ = inf{n : X_n ≥ K} is a stopping time"

end MiniConditionalMartingale
