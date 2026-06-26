/-
# Parameter Overrides

Override default stochastic process parameters for
computational experiments and sensitivity analysis.
-/

import MiniStochasticProcesses

open MiniStochasticProcesses

#eval "=== Parameter Overrides ==="

/-! ## Default Parameters -/

/-- Default Brownian motion parameters. -/
def defaultDrift : ℝ := 0.0
def defaultVolatility : ℝ := 1.0

/-- Default Poisson process rate. -/
def defaultPoissonRate : ℝ := 1.0

/-- Default random walk probability. -/
def defaultRWP : ℝ := 0.5

/-- Default simulation time horizon. -/
def defaultTimeHorizon : ℝ := 1.0

/-- Default number of time steps. -/
def defaultTimeSteps : ℕ := 1000

#eval "Default parameters loaded"

/-! ## Parameter Override Functions -/

/-- Create Brownian motion with custom drift and volatility.
    X_t = μt + σB_t (Brownian motion with drift). -/
def brownianWithDrift (μ σ : ℝ) : ℝ × ℝ := (μ, σ)

/-- Create an inhomogeneous Poisson process with rate function λ(t). -/
def inhomogeneousPoissonRate (λ₀ : ℝ) (trend : ℝ) (t : ℝ) : ℝ :=
  λ₀ * Real.exp (trend * t)

/-- Create a geometric Brownian motion with custom parameters. -/
def gbmParams (S₀ μ σ : ℝ) : ℝ × ℝ × ℝ := (S₀, μ, σ)

/-- Override the default Markov chain transition matrix. -/
def customTransitionMatrix (S : Type u) [Fintype S] (values : S → S → ℝ) : Matrix S S ℝ :=
  values

#eval "Parameter override functions defined"

/-! ## Sensitivity Analysis -/

/-- Compute option price delta: ∂C/∂S₀ via finite difference. -/
def deltaFiniteDifference (S₀ K r σ T h : ℝ) : ℝ :=
  (blackScholesCall (S₀ + h) K r σ T - blackScholesCall (S₀ - h) K r σ T) / (2 * h)

/-- Compute option price vega: ∂C/∂σ. -/
def vegaFiniteDifference (S₀ K r σ T h : ℝ) : ℝ :=
  (blackScholesCall S₀ K r (σ + h) T - blackScholesCall S₀ K r (σ - h) T) / (2 * h)

#eval "Sensitivity: Black-Scholes Greeks"
#eval "  Delta (S₀=100): " ++ toString (deltaFiniteDifference 100 100 0.05 0.2 1 0.01)
#eval "  Vega (σ=0.2): " ++ toString (vegaFiniteDifference 100 100 0.05 0.2 1 0.01)

#eval "=== Overrides Module Loaded ==="
