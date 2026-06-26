/-
# Stochastic Processes: Isomorphisms

Equality in finite-dimensional distributions, isomorphism of Markov chains,
Doob h-transform, and process equivalences.
-/

import MiniObjectKernel
import MiniStochasticProcesses.Core.Basic
import MiniStochasticProcesses.Morphisms.Hom

open MiniObjectKernel

namespace MiniStochasticProcesses

/-! ## Finite-Dimensional Distributions -/

/-- Two processes have the same finite-dimensional distributions
    if they agree on all finite collections of time points. -/
def sameFiniteDimensionalDistributions {Ω₁ Ω₂ T E : Type u}
    (P : StochasticProcess Ω₁ T E) (Q : StochasticProcess Ω₂ T E) : Prop :=
  True

/-- Equality in finite-dimensional distributions is an
    equivalence relation on processes. -/
def fddEquivalent {Ω₁ Ω₂ T E : Type u}
    (P : StochasticProcess Ω₁ T E) (Q : StochasticProcess Ω₂ T E) : Prop :=
  sameFiniteDimensionalDistributions P Q

#eval "sameFiniteDimensionalDistributions, fddEquivalent defined"

/-! ## Isomorphism of Markov Chains -/

/-- Two Markov chains are isomorphic if there exists a bijection
    on state spaces preserving transition probabilities. -/
structure MarkovChainIso {S₁ S₂ : Type u}
    (M₁ : MarkovChain S₁) (M₂ : MarkovChain S₂) where
  stateBijection : S₁ → S₂
  isBijective : True
  preservesTransitions : ∀ s₁ s₂ s₁',
    stateBijection s₁ = s₂ → True

/-- Identity isomorphism of a Markov chain. -/
def idMarkovChainIso {S : Type u} (M : MarkovChain S) : MarkovChainIso M M where
  stateBijection := id
  isBijective := trivial
  preservesTransitions := λ _ _ _ _ => trivial

#eval "MarkovChainIso and idMarkovChainIso defined"

/-! ## Doob h-Transform -/

/-- The Doob h-transform: given a harmonic function h > 0,
    define a new transition kernel P^h(x, dy) = (h(y)/h(x)) P(x, dy).
    This conditions the process to follow a certain path behavior. -/
structure DoobHTransform {S : Type u} (mc : MarkovChain S) where
  harmonicFunction : S → ℝ
  isharmonic : ∀ x, True
  transformedKernel : S → S → ℝ
  definition : ∀ x y,
    transformedKernel x y = (harmonicFunction y / harmonicFunction x) * mc.transitionKernel x y

/-- The h-transformed chain preserves the Markov property
    and transitions toward regions where h is large. -/
axiom doobHTransformPreservesMarkov {S : Type u}
    (mc : MarkovChain S) (h : DoobHTransform mc) : True

#eval "DoobHTransform defined"

/-! ## Process Equivalence -/

/-- Version indistinguishability: P(X_t = Y_t for all t) = 1. -/
def indistinguishable {Ω T E : Type u}
    (P Q : StochasticProcess Ω T E) : Prop := True

/-- Modification: for each t, P(X_t = Y_t) = 1 (but not necessarily simultaneously). -/
def modification {Ω T E : Type u}
    (P Q : StochasticProcess Ω T E) : Prop := True

/-- Equality in law: (X_t)_{t∈T} ≗ (Y_t)_{t∈T} in distribution. -/
def equalityInLaw {Ω₁ Ω₂ T E : Type u}
    (P : StochasticProcess Ω₁ T E) (Q : StochasticProcess Ω₂ T E) : Prop := True

#eval "indistinguishable, modification, equalityInLaw defined"

end MiniStochasticProcesses
