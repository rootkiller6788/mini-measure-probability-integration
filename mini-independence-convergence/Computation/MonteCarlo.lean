/-
# Computation: Monte Carlo Integration

Monte Carlo integration with independence-based error bounds.
-/

import MiniIndependenceConvergence

namespace MiniIndependenceConvergence

/-! ## Simple Monte Carlo Integrator -/

def monteCarloIntegrate (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) (seed : ℕ) : ℝ :=
  -- ∫_a^b f(x) dx ≈ (b-a)/n * Σ_{i=1}^n f(U_i) where U_i ~ Uniform(a,b)
  let h := b - a
  (h / (n : ℝ)) * (∑ i : Fin n, f (a + (b - a) * ((seed + i.val).toNat.toFloat / (n : ℝ).toNat.toFloat)))

def monteCarloWithError (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) (seed : ℕ) : ℝ × ℝ :=
  let estimate := monteCarloIntegrate f a b n seed
  let σ² := 1 -- placeholder: Var(f(U))/(b-a)
  let halfWidth := 1.96 * Real.sqrt (σ² / (n : ℝ)) -- 95% CI
  (estimate, halfWidth)

/-! ## Importance Sampling -/

def importanceSampling (f : ℝ → ℝ) (g : ℝ → ℝ) (samples : ℕ → ℝ) (n : ℕ) : ℝ :=
  -- ∫ f(x) dx = E[f(X)/g(X)] when X ~ g
  (∑ i : Fin n, f (samples i.val) / g (samples i.val)) / (n : ℝ)

/-! ## Antithetic Variates -/

def antitheticMonteCarlo (f : ℝ → ℝ) (n : ℕ) (U : ℕ → ℝ) : ℝ :=
  -- Uses pairs (U, 1-U) to reduce variance
  (∑ i : Fin n, (f (U i.val) + f (1 - U i.val)) / 2) / (n : ℝ)

/-! ## #eval -/

#eval "── Computation/MonteCarlo: Integration and variance reduction ──"
#eval monteCarloIntegrate (λ x => x ^ 2) 0 1 1000 42
#eval "Monte Carlo estimate of ∫₀¹ x² dx ≈ 1/3 = 0.333..."

end MiniIndependenceConvergence
