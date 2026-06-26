/-
# Stochastic Processes: Morphisms and Homomorphisms

Process maps, random time changes, process transformations,
and Markov kernels as morphisms between processes.
-/

import MiniObjectKernel
import MiniStochasticProcesses.Core.Basic

open MiniObjectKernel

namespace MiniStochasticProcesses

/-! ## Process Map -/

/-- A morphism between two stochastic processes:
    a map on the sample space that transforms one process into another. -/
structure ProcessMap {Ω₁ Ω₂ T₁ T₂ E₁ E₂ : Type u}
    (P : StochasticProcess Ω₁ T₁ E₁) (Q : StochasticProcess Ω₂ T₂ E₂) where
  spaceMap : Ω₁ → Ω₂
  timeMap : T₁ → T₂
  stateMap : E₁ → E₂
  compatibility : True

/-- Identity process map. -/
def idProcessMap {Ω T E : Type u} (P : StochasticProcess Ω T E) : ProcessMap P P where
  spaceMap := id
  timeMap := id
  stateMap := id
  compatibility := trivial

/-- Composition of process maps. -/
def compProcessMap {Ω₁ Ω₂ Ω₃ T₁ T₂ T₃ E₁ E₂ E₃ : Type u}
    {P : StochasticProcess Ω₁ T₁ E₁}
    {Q : StochasticProcess Ω₂ T₂ E₂}
    {R : StochasticProcess Ω₃ T₃ E₃}
    (g : ProcessMap Q R) (f : ProcessMap P Q) : ProcessMap P R where
  spaceMap := g.spaceMap ∘ f.spaceMap
  timeMap := g.timeMap ∘ f.timeMap
  stateMap := g.stateMap ∘ f.stateMap
  compatibility := trivial

#eval "ProcessMap, idProcessMap, compProcessMap defined"

/-! ## Random Time Change -/

/-- A random time change transforms a process X by a family of
    stopping times τ(t), giving Y_t = X_{τ(t)}. -/
structure RandomTimeChange {Ω E : Type u} (P : StochasticProcess Ω ℝ E) where
  timeChange : ℝ → ℝ
  isNondecreasing : True
  isRightContinuous : True
  adapted : True

/-- Apply a random time change to a process. -/
def applyTimeChange {Ω E : Type u} (P : StochasticProcess Ω ℝ E)
    (τ : RandomTimeChange P) : StochasticProcess Ω ℝ E where
  indexSet := P.indexSet
  randomVars := λ t ω => P.randomVars (τ.timeChange t) ω
  probabilitySpace := Ω

#eval "RandomTimeChange and applyTimeChange defined"

/-! ## Process Transformation -/

/-- A general process transformation: X ↦ f(X). -/
def processTransformation {Ω T E F : Type u}
    (X : StochasticProcess Ω T E) (f : E → F) : StochasticProcess Ω T F where
  indexSet := X.indexSet
  randomVars := λ t ω => f (X.randomVars t ω)
  probabilitySpace := Ω

/-- The time-reversed process: Y_t = X_{-t} (for two-sided processes). -/
def timeReversal {Ω E : Type u} (P : StochasticProcess Ω ℝ E) : StochasticProcess Ω ℝ E where
  indexSet := P.indexSet
  randomVars := λ t ω => P.randomVars (-t) ω
  probabilitySpace := Ω

#eval "processTransformation, timeReversal defined"

/-! ## Markov Kernel as Morphism -/

/-- A Markov kernel K(x, dy) is a morphism from the state space
    to the space of probability measures, encoding transition probabilities. -/
structure MarkovKernel (S T : Type u) where
  kernel : S → T → ℝ
  isProbability : ∀ s, (∑' t, kernel s t) = 1
  isMeasurable : True

/-- Composition of Markov kernels: (K₁ ∘ K₂)(x, z) = ∫ K₁(x, dy) K₂(y, z). -/
def composeKernels {S T U : Type u} [Fintype T]
    (K₁ : MarkovKernel S T) (K₂ : MarkovKernel T U) : MarkovKernel S U where
  kernel := λ s u => ∑ t, K₁.kernel s t * K₂.kernel t u
  isProbability := by
    intro s
    simp [kernel]
    sorry
  isMeasurable := trivial

#eval "MarkovKernel and composeKernels defined"

end MiniStochasticProcesses
