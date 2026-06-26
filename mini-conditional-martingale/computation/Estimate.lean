import MiniConditionalMartingale.Computation.MonteCarlo

/-!
  # Computation: Estimation Methods

  Parameter estimation and inference for martingale models.
-/

namespace MiniConditionalMartingale.Computation

open MiniConditionalMartingale

/-- Estimate volatility from a sequence of log-returns using quadratic variation.
    σ² ≈ (1/T) Σ (ΔX_k)² = [X]_T / T. -/
def estimateVolatility (returns : ℕ → ℝ) (T : ℕ) : ℝ :=
  Real.sqrt ((Finset.sum (Finset.Icc 1 T) (λ k => (returns k)^2)) / (T : ℝ))

/-- Estimate drift of a process: μ ≈ (1/T)(X_T - X_0). -/
def estimateDrift (X : ℕ → ℝ) (T : ℕ) : ℝ :=
  (X T - X 0) / (T : ℝ)

/-- Maximum likelihood estimator for the parameter of an exponential martingale.
    Given observations of M_n = exp(θS_n) / (cosh θ)^n, estimate θ. -/
def estimateExponentialMartingaleParam (S : ℕ → ℝ) (T : ℕ) : ℝ :=
  -- Using the fact that E[S_T] = 0, solve for θ from observed S_T
  Real.arcsinh (S T / (2 * (T : ℝ)))

/-- Confidence interval for Monte Carlo estimate using CLT:
    [μ̂ - z·σ/√N, μ̂ + z·σ/√N]. -/
def monteCarloConfidenceInterval (estimate stddev : ℝ) (N : ℕ) (z : ℝ) : ℝ × ℝ :=
  let se := stddev / Real.sqrt (N : ℝ)
  (estimate - z * se, estimate + z * se)

/-- #eval: Volatility estimate from quadratic variation -/
#eval "σ²_T ≈ [X]_T / T (realized variance estimator)"

/-- #eval: Drift estimate from terminal value -/
#eval "μ̂ = (X_T - X_0)/T (simple drift estimator)"

/-- #eval: 95% confidence interval for Monte Carlo -/
#eval "CI: μ̂ ± 1.96·σ/√N (Central Limit Theorem)"

end MiniConditionalMartingale.Computation
