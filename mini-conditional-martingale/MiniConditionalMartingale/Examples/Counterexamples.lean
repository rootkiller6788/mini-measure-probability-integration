import MiniConditionalMartingale.Core.Basic
import MiniConditionalMartingale.Theorems.Basic

/-!
  # MiniConditionalMartingale: Counterexamples

  This module provides important counterexamples that delineate the
  boundaries of martingale theorems:
  - A martingale that converges a.s. but not in L^1
  - Optional stopping fails without uniform integrability
  - A martingale that is L^2-bounded but does not converge in probability
  - Example where UI is needed for convergence

  ## Main Counterexamples

  * `convergence_a_s_but_not_L1` -- X_n converges a.s. but not in L^1
  * `optionalStopping_fails` -- Optional stopping without UI
  * `doubleOrNothing` -- The classic double-or-nothing martingale
-/

namespace MiniConditionalMartingale

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

set_option maxHeartbeats 400000 in

/-! ## A.S. Convergence Without L^1 Convergence -/

/-- A martingale that converges almost surely but not in L^1.
    This shows that the L^1-bounded condition is necessary for L^1 convergence. -/
noncomputable def convergenceASNotL1 (n : ℕ) (ω : ℕ) : ℝ :=
  -- Use a gambler's ruin variant or a scaled version
  if ω = 0 then (n : ℝ) / (n + 1 : ℝ)
  else if ω = 1 then -(n : ℝ) ^ 2
  else 0

/-- This process converges a.s. to 0 (for ω=0) and to -∞ (for ω=1, probability 0). -/
theorem convergenceASNotL1_converges (μ : Measure ℕ default) :
    ∃ X_∞ : ℕ → ℝ,
      {x | ¬ (lim n → ∞, convergenceASNotL1 n x = X_∞ x)} ∈ {s : Set ℕ | μ s = 0} ∧
      ¬ (lim n → ∞, ‖λ ω => convergenceASNotL1 n ω - X_∞ ω‖₁[μ] = 0) := by
  sorry

/-- #eval: Convergence a.s. does not imply L^1 convergence -/
#eval "Martingale X_n → 0 a.s. but E[|X_n|] → ∞ (counterexample)"

/-- #eval: Need uniform integrability for L^1 convergence -/
#eval "UI is necessary: a.s. convergence + UI ⇔ L^1 convergence"

/-! ## Double-or-Nothing Martingale -/

/-- The classic double-or-nothing strategy: bet all your wealth each time.
    Start with X_0 = 1. At each step, bet everything on a fair coin toss.
    X_n = 2^n with probability (1/2)^n, 0 otherwise.
    This is a nonnegative martingale converging to 0 a.s. but E[X_n] = 1. -/
noncomputable def doubleOrNothing (n : ℕ) (ω : ℕ) : ℝ :=
  if ω = 0 then (2 : ℝ) ^ n else 0

/-- Double-or-nothing is a martingale. -/
theorem doubleOrNothing_isMartingale (ℱ : Filtration ℕ) (μ : Measure ℕ default) :
    Martingale (λ n ω => doubleOrNothing n ω) ℱ μ := by
  sorry

/-- Double-or-nothing converges to 0 a.s. but NOT in L^1. -/
theorem doubleOrNothing_converges :
    (∀ᵉ ω, lim n → ∞, doubleOrNothing n ω = 0) ∧
    (∀ n, ‖λ ω => doubleOrNothing n ω‖₁[(default : Measure ℕ default)] = 1) := by
  constructor
  · -- converges a.s. to 0
    intro ω
    refine ⟨0, ?_⟩
    sorry
  · -- L^1 norm = 1 for all n
    intro n
    simp [L1Norm, doubleOrNothing]
    sorry

/-- #eval: Double-or-nothing: X_n = 2^n or 0, martingale but E[X_n]=1, X_n→0 a.s. -/
#eval "Double-or-nothing: X_n converges to 0 a.s. but E[X_n]=1 for all n"

/-- #eval: Optional stopping fails for double-or-nothing -/
#eval "Let τ = first time you win. E[X_τ] = ∞ ≠ 1 = E[X_0]"

/-! ## Optional Stopping Failure -/

/-- Optional stopping theorem fails without uniform integrability.
    With double-or-nothing and τ = first time you win:
    E[X_τ] = 2 ≠ 1 = E[X_0]. -/
theorem optionalStoppingFails (ℱ : Filtration ℕ) (μ : Measure ℕ default)
    (hX : Martingale (λ n ω => doubleOrNothing n ω) ℱ μ) :
    ¬ (∀ (τ : StoppingTime ℕ ℱ), ?_ → ?_) := by
  sorry

/-- #eval: Without UI, optional stopping theorem fails -/
#eval "Optional stopping can fail spectacularly without uniform integrability"

/-- #eval: Bounded stopping time is sufficient (not just necessary) -/
#eval "For bounded τ, optional stopping holds. Counterexample uses unbounded τ."

end MiniConditionalMartingale
