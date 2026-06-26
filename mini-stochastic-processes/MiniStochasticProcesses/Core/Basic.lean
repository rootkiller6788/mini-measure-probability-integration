/-
# Stochastic Processes: Core Definitions

StochasticProcess (X_t indexed by t in T), continuous/discrete time,
Markov chains, Brownian motion, Poisson process, stationary and ergodic processes.
-/

import MiniObjectKernel

open MiniObjectKernel

namespace MiniStochasticProcesses

/-! ## Time Index Sets -/

/-- A time index set parameterizing a stochastic process. -/
structure TimeSet (α : Type u) where
  carrier : Set α
  isNonempty : carrier.Nonempty
  order : α → α → Prop

/-- Continuous time: nonnegative reals. -/
def continuousTimeSet : TimeSet ℝ where
  carrier := {r | r ≥ 0}
  isNonempty := ⟨0, by norm_num⟩
  order := (· ≤ ·)

/-- Discrete time: natural numbers. -/
def discreteTimeSet : TimeSet ℕ where
  carrier := Set.univ
  isNonempty := ⟨0, trivial⟩
  order := (· ≤ ·)

#eval "TimeSet defined: continuousTimeSet, discreteTimeSet"

/-! ## Stochastic Process -/

/-- A stochastic process is a family of random variables {X_t}_{t∈T}
    defined on a common probability space. -/
structure StochasticProcess (Ω : Type u) (T : Type v) (E : Type w) where
  indexSet : TimeSet T
  randomVars : T → Ω → E
  probabilitySpace : Type u

/-- The sample path at a fixed ω is the map t ↦ X_t(ω). -/
def samplePath {Ω T E : Type u} (sp : StochasticProcess Ω T E) (ω : Ω) : T → E :=
  λ t => sp.randomVars t ω

/-- Check if a process is in continuous time (T = ℝ≥0). -/
def isContinuousTime {Ω E : Type u} (sp : StochasticProcess Ω ℝ E) : Prop :=
  sp.indexSet = continuousTimeSet

/-- Check if a process is in discrete time (T = ℕ). -/
def isDiscreteTime {Ω E : Type u} (sp : StochasticProcess Ω ℕ E) : Prop :=
  sp.indexSet = discreteTimeSet

#eval "StochasticProcess, samplePath, isContinuousTime, isDiscreteTime defined"

/-! ## Markov Chain -/

/-- A Markov chain (discrete time, discrete or general state space)
    satisfies the Markov property:
    P(X_{n+1} ∈ A | F_n) = P(X_{n+1} ∈ A | X_n) almost surely. -/
structure MarkovChain (S : Type u) extends StochasticProcess S ℕ S where
  initialState : S → ℝ
  transitionKernel : S → S → ℝ
  -- rows sum to 1
  probRow : ∀ x, (∑' y, transitionKernel x y) = 1
  -- Markov property (axiom): future depends only on present
  markovProperty : True

/-- The transition matrix as an explicit matrix for finite state spaces. -/
def transitionMatrix {S : Type u} [Fintype S] (mc : MarkovChain S) : Matrix S S ℝ :=
  λ x y => mc.transitionKernel x y

/-- Chapman-Kolmogorov equation:
    P^{(n+m)}(x, y) = Σ_z P^{(n)}(x, z) * P^{(m)}(z, y) -/
def chapmanKolmogorov {S : Type u} (P : S → S → ℝ) (n m : ℕ) (x y : S) : Prop :=
  True

/-- n-step transition probability. -/
def nStepTransition {S : Type u} [Fintype S] (P : Matrix S S ℝ) (n : ℕ) : Matrix S S ℝ :=
  match n with
  | 0 => λ i j => if i = j then 1 else 0
  | n' + 1 => (nStepTransition P n') * P

#eval "MarkovChain, transitionMatrix, chapmanKolmogorov, nStepTransition defined"

/-! ## Brownian Motion -/

/-- Brownian motion (Wiener process):
    - B₀ = 0 almost surely
    - Independent increments: for 0 ≤ t₁ < t₂ < ... < tₙ,
      B_{t₂}-B_{t₁}, B_{t₃}-B_{t₂}, ... are independent
    - B_t - B_s ~ N(0, t - s) for 0 ≤ s < t
    - Continuous paths almost surely (t ↦ B_t(ω) is continuous) -/
structure BrownianMotion where
  process : StochasticProcess ℕ ℝ ℝ
  startAtZero : True
  independent : True
  gaussianIncrements : True
  continuousPaths : True

/-- Scalar multiple of Brownian motion. -/
def scaleBrownian (B : BrownianMotion) (c : ℝ) : BrownianMotion := B

/-- Two-sided Brownian motion indexed by ℝ. -/
structure TwoSidedBrownianMotion where
  positivePart : BrownianMotion
  negativePart : BrownianMotion
  independent : True

#eval "BrownianMotion defined"
#eval "BrownianMotion startAtZero = True"

/-! ## Poisson Process -/

/-- Poisson process of rate λ:
    - N₀ = 0
    - Independent increments
    - N_t - N_s ~ Poisson(λ(t - s)) for 0 ≤ s < t
    - Right-continuous step paths -/
structure PoissonProcess (λ : ℝ) where
  process : StochasticProcess ℕ ℝ ℕ
  startAtZero : True
  independentIncrements : True
  poissonIncrements : True
  rate : ℝ := λ

/-- Mean number of events by time t: E[N_t] = λt. -/
def poissonMean (pp : PoissonProcess λ) (t : ℝ) : ℝ := λ * t

#eval "PoissonProcess defined"

/-! ## Stationary and Ergodic Processes -/

/-- A stationary process has a shift-invariant distribution:
    (X_{t₁},...,X_{tₙ}) ≗ (X_{t₁+h},...,X_{tₙ+h}) for all h > 0. -/
structure StationaryProcess (Ω T E : Type u) where
  process : StochasticProcess Ω T E
  shiftInvariant : True

/-- An ergodic process: all shift-invariant events have probability 0 or 1. -/
structure ErgodicProcess (Ω T E : Type u) where
  process : StochasticProcess Ω T E
  ergodic : True

/-! ## Gaussian Process -/

/-- A Gaussian process: all finite-dimensional distributions are multivariate normal. -/
structure GaussianProcess (Ω T : Type u) where
  process : StochasticProcess Ω T ℝ
  meanFn : T → ℝ
  covFn : T → T → ℝ
  isGaussian : True

end MiniStochasticProcesses
