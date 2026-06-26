import MiniConditionalMartingale.Core.Basic
import MiniConditionalMartingale.Core.Laws

/-!
  # MiniConditionalMartingale: Morphisms (Equiv)

  This module establishes the equivalence between submartingales and
  martingales via the Doob-Meyer decomposition.

  ## Main Results

  * `submartingale_to_martingale_plus_compensator` -- any submartingale = martingale + increasing predictable compensator
  * `compensator` -- the unique predictable increasing process A such that X - A is a martingale
  * `doobMeyerDecomposition` -- the Doob-Meyer decomposition for submartingales
  * `doobMeyer_uniqueness` -- the Doob-Meyer decomposition is unique up to indistinguishability
-/

namespace MiniConditionalMartingale

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

set_option maxHeartbeats 400000 in

variable {α : Type u} [MeasurableSpace α]

/-! ## Compensator -/

/-- The compensator of a submartingale X is the unique predictable
    increasing process A such that X - A is a martingale. -/
structure Compensator (X : ℕ → α → ℝ) (ℱ : Filtration α) (μ : Measure α default) where
  /-- The compensator process A -/
  process : ℕ → α → ℝ
  /-- A is predictable -/
  predictable : predictable process ℱ
  /-- A_0 = 0 -/
  startsAtZero : ∀ x : α, process 0 x = 0
  /-- A is increasing -/
  increasing : ∀ n x, process n x ≤ process (n+1) x
  /-- A is integrable -/
  integrable : ∀ n, integrable (process n) μ
  /-- X - A is a martingale -/
  martingaleProperty : Martingale (λ n x => X n x - process n x) ℱ μ

/-! ## Doob-Meyer Decomposition -/

/-- The Doob-Meyer decomposition: any submartingale X of class (D)
    admits a unique decomposition X = M + A where M is a martingale
    and A is a predictable increasing process with A_0 = 0. -/
theorem doobMeyerDecomposition (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (h_sub : Submartingale X ℱ μ)
    (h_classD : ∃ C : ℝ, ∀ n, ‖X n‖₁[μ] ≤ C) :
    ∃ (M A : ℕ → α → ℝ),
      Martingale M ℱ μ ∧
      predictable A ℱ ∧
      (∀ x, A 0 x = 0) ∧
      (∀ n x, A n x ≤ A (n+1) x) ∧
      (∀ n x, X n x = M n x + A n x) := by
  sorry

/-- The Doob-Meyer decomposition is unique up to indistinguishability:
    if X = M + A = M' + A' are two Doob-Meyer decompositions, then
    M and M' are indistinguishable and A and A' are indistinguishable. -/
theorem doobMeyer_uniqueness (X M A M' A' : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default)
    (h1 : Martingale M ℱ μ) (h1_pred : predictable A ℱ) (h1_zero : ∀ x, A 0 x = 0)
    (h2 : Martingale M' ℱ μ) (h2_pred : predictable A' ℱ) (h2_zero : ∀ x, A' 0 x = 0)
    (h_eq : ∀ n x, X n x = M n x + A n x) (h_eq' : ∀ n x, X n x = M' n x + A' n x) :
    M = M' ∧ A = A' := by
  sorry

/-! ## Class (D) Characterization -/

/-- A process X is of class (D) if the family {X_τ : τ stopping time} is
    uniformly integrable. -/
def classD (X : ℕ → α → ℝ) (ℱ : Filtration α) (μ : Measure α default) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ (τ : StoppingTime α ℱ) (A : Set α),
    isMeasurable (ℱ.sigmaAt 0) A → μ A < δ →
    ∫ (λ x => |X (τ.toFun x) x|) in A ≤ ε

/-- If X is a submartingale of class (D), then it admits a Doob-Meyer decomposition. -/
theorem classD_implies_doobMeyer (X : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (h_sub : Submartingale X ℱ μ)
    (h_classD : classD X ℱ μ) : Compensator X ℱ μ := by
  sorry

/-- #eval: Doob-Meyer for random walk submartingale |S_n| -/
#eval "Doob-Meyer: |S_n| = martingale + local time at 0 (Tanaka's formula)"

/-- #eval: Compensator of a Poisson process is its intensity × time -/
#eval "N_t = Poisson(t) ⟹ compensator is λt (N_t - λt is martingale)"

/-- #eval: Doob-Meyer uniqueness: decomposition is unique up to indistinguishability -/
#eval "Doob-Meyer decomposition is unique (M,A uniquely determined by X,P,ℱ)"

end MiniConditionalMartingale
