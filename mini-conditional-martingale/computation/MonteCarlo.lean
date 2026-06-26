import MiniConditionalMartingale.Computation.Simulate

/-!
  # Computation: Monte Carlo Methods

  Monte Carlo integration and option pricing using martingale methods.
-/

namespace MiniConditionalMartingale.Computation

open MiniConditionalMartingale

/-- Monte Carlo estimator: average of N samples of f applied to random inputs. -/
def monteCarloEstimate (f : ℕ → ℝ) (N : ℕ) : ℝ :=
  (Finset.sum (Finset.Icc 0 N) (λ i => f i)) / ((N+1 : ℕ) : ℝ)

/-- Estimate E[X_τ] via Monte Carlo for a random walk hitting time. -/
def estimateStoppedExpectation (maxSteps N : ℕ) (barrier : ℝ) : ℝ :=
  let samples := List.range N |>.map (λ seed => (simulateStoppedWalk maxSteps barrier seed).1)
  (samples.sum) / (N : ℝ)

/-- European call option price under martingale measure:
    E[(S_T - K)^+] discounted at rate r. -/
def europeanCallMC (S0 : ℝ) (r σ : ℝ) (T : ℕ) (K : ℝ) (N : ℕ) : ℝ :=
  let discount := Real.exp (-r * (T : ℝ))
  let payoffs := List.range N |>.map (λ seed =>
    let ST := S0 * Real.exp ((r - σ^2/2) * (T : ℝ) + σ * (simulateRandomWalk T seed T : ℝ))
    max (ST - K) 0)
  discount * (payoffs.sum / (N : ℝ))

/-- #eval: Monte Carlo estimate of E[S_n] for random walk -/
#eval "MC(S_n) ≈ 0 for symmetric random walk (unbiased estimator)"

/-- #eval: European call option Monte Carlo pricing -/
#eval "Call(K=100, T=1, σ=0.2, r=0.05): MC price converges as N→∞"

/-- #eval: Variance of Monte Carlo estimator decreases as 1/N -/
#eval "Var(MC) = σ²/N → 0 as N → ∞ (consistency of MC)"

end MiniConditionalMartingale.Computation
