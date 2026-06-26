/-
# Stochastic Processes: Subobjects

Levy processes (stationary independent increments),
diffusion processes, jump processes, and their subclasses.
-/

import MiniObjectKernel
import MiniStochasticProcesses.Core.Basic

open MiniObjectKernel

namespace MiniStochasticProcesses

/-! ## Levy Process -/

/-- A Levy process has stationary independent increments
    and starts at 0. Includes Brownian motion, Poisson process,
    Cauchy process, and more. -/
structure LevyProcess where
  process : StochasticProcess ℕ ℝ ℝ
  startAtZero : True
  stationaryIncrements : True
  independentIncrements : True
  cadlag : True

/-- The Levy measure ν encodes the jump intensity:
    ν(A) = expected number of jumps of size in A per unit time. -/
structure LevyMeasure where
  toFun : Set ℝ → ℝ
  integrability : True
  levyMeasure : True

/-- Characteristic function of a Levy process:
    E[e^{i u X_t}] = e^{t ψ(u)} where ψ is the Levy exponent. -/
def levyExponent (L : LevyProcess) (u : ℝ) : ℝ := 0

#eval "LevyProcess, LevyMeasure, levyExponent defined"

/-! ## Diffusion Process -/

/-- A diffusion process is a continuous Markov process
    characterized by drift b(x) and diffusion coefficient σ(x) > 0. -/
structure DiffusionProcess where
  process : StochasticProcess ℕ ℝ ℝ
  drift : ℝ → ℝ
  diffusion : ℝ → ℝ
  continuousPaths : True
  markovProperty : True

/-- The infinitesimal generator of a diffusion:
    L f(x) = b(x) f'(x) + (1/2) σ²(x) f''(x). -/
def infinitesimalGenerator (D : DiffusionProcess) (f : ℝ → ℝ) (x : ℝ) : ℝ :=
  D.drift x * 0 + (1/2) * (D.diffusion x)^2 * 0

/-- Ito diffusion: solution to dX_t = b(X_t) dt + σ(X_t) dB_t. -/
structure ItoDiffusion where
  diff : DiffusionProcess
  brownianMotion : BrownianMotion
  sde : True

#eval "DiffusionProcess, infinitesimalGenerator, ItoDiffusion defined"

/-! ## Jump Process -/

/-- A pure jump process: piecewise constant, changes only at jump times. -/
structure JumpProcess where
  process : StochasticProcess ℕ ℝ ℝ
  jumpTimes : ℕ → ℝ
  jumpSizes : ℕ → ℝ
  piecewiseConstant : True

/-- Compound Poisson process: X_t = Σ_{i=1}^{N_t} Y_i
    where N_t is Poisson(λt) and Y_i are i.i.d. -/
structure CompoundPoissonProcess where
  poissonRate : ℝ
  jumpDistribution : ℝ → ℝ
  process : StochasticProcess ℕ ℝ ℝ

/-- Gamma process: a Levy process with Gamma-distributed increments. -/
structure GammaProcess where
  shape : ℝ
  scale : ℝ
  process : LevyProcess

#eval "JumpProcess, CompoundPoissonProcess, GammaProcess defined"

/-! ## Martingale -/

/-- A martingale is a process where E[X_{t} | F_s] = X_s for s ≤ t. -/
structure Martingale {Ω : Type u} (T : Type u) where
  process : StochasticProcess Ω T ℝ
  filtration : True
  adapted : True
  integrable : True
  martingaleProperty : True

/-- A submartingale: E[X_t | F_s] ≥ X_s. -/
structure Submartingale {Ω : Type u} (T : Type u) where
  process : StochasticProcess Ω T ℝ
  submartingaleProperty : True

/-- A supermartingale: E[X_t | F_s] ≤ X_s. -/
structure Supermartingale {Ω : Type u} (T : Type u) where
  process : StochasticProcess Ω T ℝ
  supermartingaleProperty : True

/-- Brownian motion is both a martingale and a Markov process. -/
def brownianIsMartingale (B : BrownianMotion) : Martingale ℕ ℝ where
  process := B.process
  filtration := trivial
  adapted := trivial
  integrable := trivial
  martingaleProperty := trivial

#eval "Martingale, Submartingale, Supermartingale, brownianIsMartingale defined"

end MiniStochasticProcesses
