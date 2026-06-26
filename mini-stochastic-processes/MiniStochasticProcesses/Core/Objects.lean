/-
# Stochastic Processes: Object Registration

Register stochastic process types in the MiniObjectKernel theory graph
and set up the category-theoretic infrastructure.
-/

import MiniObjectKernel
import MiniStochasticProcesses.Core.Basic
import MiniStochasticProcesses.Core.Laws

open MiniObjectKernel

namespace MiniStochasticProcesses

/-! ## Theory Registration -/

/-- The theory name for stochastic processes. -/
def stochasticProcessesTheory : TheoryName :=
  TheoryName.ofString "MiniStochasticProcesses"

/-- Register StochasticProcess as an Object. -/
instance stochasticProcessObject (Ω T E : Type u) : Object (StochasticProcess Ω T E) where
  theory := stochasticProcessesTheory
  objName := s!"StochasticProcess({toString (repr Ω)})"
  repr sp := s!"StochasticProcess(indexSet={sp.indexSet})"

/-- Register MarkovChain as an Object. -/
instance markovChainObject (S : Type u) : Object (MarkovChain S) where
  theory := stochasticProcessesTheory.extend "Markov"
  objName := s!"MarkovChain({toString (repr S)})"
  repr mc := s!"MarkovChain(stateSpace={toString (repr S)})"

/-- Register BrownianMotion as an Object. -/
instance brownianMotionObject : Object BrownianMotion where
  theory := stochasticProcessesTheory.extend "Brownian"
  objName := "BrownianMotion"
  repr _ := "BrownianMotion(ℝ)"

/-- Register PoissonProcess as an Object. -/
instance poissonProcessObject (λ : ℝ) : Object (PoissonProcess λ) where
  theory := stochasticProcessesTheory.extend "Poisson"
  objName := s!"PoissonProcess(λ={λ})"
  repr _ := s!"PoissonProcess(rate={λ})"

/-- Register StationaryProcess as an Object. -/
instance stationaryProcessObject (Ω T E : Type u) : Object (StationaryProcess Ω T E) where
  theory := stochasticProcessesTheory.extend "Stationary"
  objName := "StationaryProcess"
  repr _ := "StationaryProcess"

/-- Register ErgodicProcess as an Object. -/
instance ergodicProcessObject (Ω T E : Type u) : Object (ErgodicProcess Ω T E) where
  theory := stochasticProcessesTheory.extend "Ergodic"
  objName := "ErgodicProcess"
  repr _ := "ErgodicProcess"

/-- Register GaussianProcess as an Object. -/
instance gaussianProcessObject (Ω T : Type u) : Object (GaussianProcess Ω T) where
  theory := stochasticProcessesTheory.extend "Gaussian"
  objName := "GaussianProcess"
  repr gp := s!"GaussianProcess(mean={gp.meanFn 0}, cov={gp.covFn 0 0})"

#eval "Theory: " ++ toString stochasticProcessesTheory
#eval describe (StochasticProcess ℕ ℕ ℕ)
#eval describe BrownianMotion
#eval describe (PoissonProcess 1.0)

end MiniStochasticProcesses
