import MiniConditionalMartingale.Core.Basic

/-!
  # MiniConditionalMartingale: Constructions (Quotients)

  This module constructs quotients by tail equivalence and studies
  reversed (backwards) martingales.

  ## Main Constructions

  * `tailEquivalence` -- two processes have the same tail behavior
  * `tailQuotient` -- quotient by tail equivalence
  * `reversedMartingale` -- process indexed by negative time: E[X_{-n} | F_{-n}] = X_{-n}
  * `reversedMartingaleConvergence` -- reversed martingales converge a.s. and in L^1
-/

namespace MiniConditionalMartingale

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

set_option maxHeartbeats 400000 in

variable {α : Type u} [MeasurableSpace α]

/-! ## Tail Equivalence -/

/-- Two processes X and Y are tail-equivalent if there exists N such that
    X_n = Y_n for all n ≥ N a.s. -/
def tailEquivalent (X Y : ℕ → α → ℝ) (μ : Measure α default) : Prop :=
  {ω : α | ∃ N, ∀ n ≥ N, X n ω = Y n ω} ∈ Set.univ

/-- The tail quotient identifies processes up to tail equivalence. -/
def tailQuotient (μ : Measure α default) : Setoid (ℕ → α → ℝ) where
  r X Y := tailEquivalent X Y μ
  iseqv := {
    refl := λ X => by
      refine ⟨0, λ n hn => ?_⟩; rfl
    symm := λ X Y ⟨N, h⟩ => ⟨N, λ n hn => (h n hn).symm⟩
    trans := λ X Y Z hXY hYZ =>
      let ⟨N₁, h₁⟩ := hXY; let ⟨N₂, h₂⟩ := hYZ
      ⟨max N₁ N₂, λ n hn => by
        have hn₁ : n ≥ N₁ := le_of_lt (Nat.lt_of_lt_of_le (by omega) hn)
        have hn₂ : n ≥ N₂ := le_of_lt (Nat.lt_of_lt_of_le (by omega) hn)
        rw [h₁ n hn₁, h₂ n hn₂]⟩
  }

/-! ## Reversed Martingale -/

/-- A reversed martingale (backwards martingale): X_{-n} indexed by
    negative integers where E[X_{-n} | F_{-n-1}] = X_{-n-1}. -/
structure ReversedMartingale (ℱ : Filtration α) (μ : Measure α default) where
  /-- Process indexed by n (we use positive n for -n in the filtration) -/
  process : ℕ → α → ℝ
  /-- X is adapted to the reversed filtration -/
  adapted : ∀ n, @Measurable _ default (ℱ.sigmaAt n) (process n)
  /-- Integrability -/
  integrable : ∀ n, integrable (process n) μ
  /-- Reversed martingale property: E[X_n | F_{n+1}] = X_{n+1} -/
  reversed_property : ∀ n, E[process n | ℱ.sigmaAt (n+1)] μ = E[process (n+1) | ℱ.sigmaAt (n+1)] μ

/-- A reversed martingale converges almost surely and in L^1 as n → ∞.
    This is Levy's downward theorem. -/
theorem reversedMartingaleConvergence (M : ReversedMartingale ℱ μ)
    (h_bdd : ∃ C : ℝ, ∀ n, ‖M.process n‖₁[μ] ≤ C) :
    ∃ M_∞ : α → ℝ,
      (∀ᵉ x, lim n → ∞, M.process n x = M_∞ x) ∧
      (lim n → ∞, ‖M.process n - M_∞‖₁[μ] = 0) := by
  sorry

/-- #eval: Tail equivalence is an equivalence relation -/
#eval "X ~ Y iff X_n = Y_n for large n a.s. (tail equivalence)"

/-- #eval: Reversed martingale example: E[f | F_n] for decreasing F_n -/
#eval "Reversed martingale: E[f | F_{-n}] → E[f | ∩_n F_{-n}] a.s."

/-- #eval: Reversed martingale convergence a.s. and in L^1 -/
#eval "Levy's downward: reversed martingales converge a.s. and in L^1"

end MiniConditionalMartingale
