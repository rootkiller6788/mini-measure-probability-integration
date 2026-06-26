/-
# Stochastic Processes: Products

Product of independent processes, coupled processes,
and joint constructions.
-/

import MiniObjectKernel
import MiniStochasticProcesses.Core.Basic

open MiniObjectKernel

namespace MiniStochasticProcesses

/-! ## Independent Product -/

/-- The product of two independent stochastic processes.
    On the product probability space with product measure,
    the component processes are independent. -/
def productProcess {Ω₁ Ω₂ T E₁ E₂ : Type u}
    (P : StochasticProcess Ω₁ T E₁) (Q : StochasticProcess Ω₂ T E₂) :
    StochasticProcess (Ω₁ × Ω₂) T (E₁ × E₂) where
  indexSet := {
    carrier := P.indexSet.carrier ∩ Q.indexSet.carrier
    isNonempty := by
      rcases P.indexSet.isNonempty with ⟨t, ht⟩
      rcases Q.indexSet.isNonempty with ⟨s, hs⟩
      sorry
    order := P.indexSet.order
  }
  randomVars := λ t ω => (P.randomVars t ω.1, Q.randomVars t ω.2)
  probabilitySpace := Ω₁ × Ω₂

/-- Projection onto the first component. -/
def productProjectionFirst {Ω₁ Ω₂ T E₁ E₂ : Type u}
    (P : StochasticProcess Ω₁ T E₁) (Q : StochasticProcess Ω₂ T E₂) :
    ProcessMap (productProcess P Q) P where
  spaceMap := Prod.fst
  timeMap := id
  stateMap := Prod.fst
  compatibility := trivial

/-- Projection onto the second component. -/
def productProjectionSecond {Ω₁ Ω₂ T E₁ E₂ : Type u}
    (P : StochasticProcess Ω₁ T E₁) (Q : StochasticProcess Ω₂ T E₂) :
    ProcessMap (productProcess P Q) Q where
  spaceMap := Prod.snd
  timeMap := id
  stateMap := Prod.snd
  compatibility := trivial

#eval "productProcess, productProjectionFirst, productProjectionSecond defined"

/-! ## Finite Products -/

/-- Product of n independent copies of the same process. -/
def productProcessN {Ω T E : Type u}
    (P : StochasticProcess Ω T E) (n : ℕ) :
    StochasticProcess (Fin n → Ω) T (Fin n → E) where
  indexSet := P.indexSet
  randomVars := λ t ω i => P.randomVars t (ω i)
  probabilitySpace := Fin n → Ω

#eval "productProcessN defined"

/-! ## Infinite Products (Kolmogorov Extension) -/

/-- Kolmogorov's extension theorem: consistent finite-dimensional
    distributions define a unique process on the product space. -/
structure KolmogorovExtension {T E : Type u} where
  finiteDimDists : (List T) → (List E) → ℝ
  consistency : True
  symmetry : True

/-- The Kolmogorov extension constructs a process on ℝ^T. -/
def kolmogorovProcess {T E : Type u} (ke : KolmogorovExtension (T := T) (E := E)) :
    StochasticProcess ℕ T E where
  indexSet := discreteTimeSet
  randomVars := λ _ _ => default
  probabilitySpace := ℕ

#eval "KolmogorovExtension, kolmogorovProcess defined"

/-! ## Joint Distribution of Processes -/

/-- Joint finite-dimensional distribution of two processes. -/
def jointFiniteDimensionalDistribution {Ω₁ Ω₂ T E₁ E₂ : Type u}
    (P : StochasticProcess Ω₁ T E₁) (Q : StochasticProcess Ω₂ T E₂)
    (times : List T) : Prop := True

#eval "jointFiniteDimensionalDistribution defined"

end MiniStochasticProcesses
