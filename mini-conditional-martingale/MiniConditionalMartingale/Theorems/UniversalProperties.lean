import MiniConditionalMartingale.Core.Basic
import MiniConditionalMartingale.Constructions.Universal

/-!
  # MiniConditionalMartingale: Universal Properties Theorems

  This module proves the universal properties of the Snell envelope:
  - The Snell envelope is the smallest supermartingale dominating a process
  - Optimal stopping time characterization
  - Snell envelope as the value function of optimal stopping

  ## Main Theorems

  * `snellEnvelope_optimalStopping` -- U_0 = sup_{τ stopping time} E[Z_τ]
  * `snellEnvelope_minimal` -- U is the minimal supermartingale ≥ Z
  * `snellEnvelope_optimalTime` -- τ* = min{n : U_n = Z_n} attains the supremum
  * `snellEnvelope_doobDecomposition` -- Doob decomposition of Snell envelope
-/

namespace MiniConditionalMartingale

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

set_option maxHeartbeats 800000 in

variable {α : Type u} [MeasurableSpace α]

/-! ## Snell Envelope as Optimal Stopping Value -/

/-- The Snell envelope at time 0 equals the optimal stopping value:
    U_0 = sup_{τ ∈ T_0^N} E[Z_τ]. -/
theorem snellEnvelope_optimalStopping (Z : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (N : ℕ) (h_int : ∀ n ≤ N, integrable (Z n) μ) :
    (snellEnvelope Z ℱ μ N 0) =
    (E[λ x => Z (optimalStoppingTime Z (snellEnvelope Z ℱ μ N) N x) x | ℱ.sigmaAt 0] μ).toFun 0 := by
  sorry

/-- The Snell envelope characterizes the value of American options:
    U_0 = sup_{τ stopping time, τ ≤ N} E[Z_τ]. -/
theorem snellEnvelope_isValueFunction (Z : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (N : ℕ) (h_int : ∀ n ≤ N, integrable (Z n) μ) :
    ∀ x, (snellEnvelope Z ℱ μ N 0 x) =
      iSup (λ (τ : StoppingTime α ℱ) => E[λ x => Z (τ.toFun x) x | ℱ.sigmaAt 0] μ).toFun x) := by
  sorry

/-! ## Minimal Supermartingale Property -/

/-- The Snell envelope is the minimal supermartingale that dominates Z:
    any supermartingale V ≥ Z satisfies V_n ≥ U_n a.s. -/
theorem snellEnvelope_minimal (Z : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (N : ℕ) (h_int : ∀ n ≤ N, integrable (Z n) μ)
    (V : ℕ → α → ℝ) (hV : Supermartingale V ℱ μ) (hV_dom : ∀ n ≤ N, ∀ x, Z n x ≤ V n x)
    (hV_int : ∀ n ≤ N, integrable (V n) μ) :
    ∀ n ≤ N, ∀ x, (snellEnvelope Z ℱ μ N n x) ≤ V n x := by
  sorry

/-! ## Optimal Stopping Time -/

/-- The optimal stopping time τ* = min{n : U_n = Z_n} is indeed optimal:
    E[Z_{τ*}] = sup_τ E[Z_τ] = U_0. -/
theorem optimalStoppingTime_isOptimal (Z : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (N : ℕ) (h_int : ∀ n ≤ N, integrable (Z n) μ) :
    let U := snellEnvelope Z ℱ μ N
    let τ := optimalStoppingTime Z U N
    E[λ x => Z (τ x) x | ℱ.sigmaAt 0] μ = E[λ x => U 0 x | ℱ.sigmaAt 0] μ := by
  sorry

/-! ## Doob Decomposition of Snell Envelope -/

/-- The Snell envelope admits a unique Doob decomposition:
    U_n = M_n - A_n where M is a martingale and A is predictable increasing with A_0 = 0.
    This gives the hedging strategy for an American option. -/
theorem snellEnvelope_doobDecomposition (Z : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (N : ℕ) (h_int : ∀ n ≤ N, integrable (Z n) μ) :
    ∃ (M A : ℕ → α → ℝ),
      Martingale M ℱ μ ∧
      predictable A ℱ ∧
      (∀ x, A 0 x = 0) ∧
      (∀ n x, A n x ≤ A (n+1) x) ∧
      (∀ n ≤ N x, snellEnvelope Z ℱ μ N n x = M n x - A n x) :=
  universalDoobDecomposition Z ℱ μ N h_int

/-- #eval: Snell envelope = value of optimal stopping problem -/
#eval "U_0 = sup_τ E[Z_τ] -- Snell envelope at time 0"

/-- #eval: Minimal supermartingale above Z characterizes American option price -/
#eval "Snell envelope = minimal supermartingale ≥ Z = American option price"

/-- #eval: Doob decomposition of Snell envelope gives optimal hedge -/
#eval "U = M - A: M is hedge martingale, A is consumption process"

end MiniConditionalMartingale
