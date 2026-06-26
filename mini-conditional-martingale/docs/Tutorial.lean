/-
# MiniConditionalMartingale: Tutorial

A step-by-step guide to using the conditional martingale library.

## 1. Setting Up

```lean
import MiniConditionalMartingale
open MiniConditionalMartingale
```

## 2. Conditional Expectation

The conditional expectation `E[X | 𝒢]` is defined as the unique
𝒢-measurable random variable such that for all G ∈ 𝒢:
`∫_G E[X|𝒢] dP = ∫_G X dP`.

Key properties:
- Linearity: `E[aX + bY | 𝒢] = aE[X|𝒢] + bE[Y|𝒢]`
- Tower: `E[E[X|𝒢] | ℋ] = E[X|ℋ]` when ℋ ⊆ 𝒢
- Pull-out: `E[Y·X | 𝒢] = Y·E[X|𝒢]` when Y is 𝒢-measurable
- Independence: `E[X|𝒢] = E[X]` when X ⟂ 𝒢

## 3. Defining a Filtration

```lean
-- A filtration is an increasing family of σ-algebras
def myFiltration : Filtration Ω := {
  sigmaAt := λ n => ...
  monotone' := λ n s h => ...
}
```

## 4. Creating a Martingale

```lean
-- A symmetric random walk is a martingale
theorem randomWalk_martingale : Martingale S ℱ μ := ...
```

## 5. Working with Stopping Times

```lean
-- A hitting time is a stopping time
def hittingTime (a : ℝ) (X : ℕ → Ω → ℝ) : StoppingTime Ω ℱ := ...

-- Optional stopping: E[X_τ] = E[X_0] for bounded τ
theorem optionalStopping (hτ_bound : τ ≤ N) : E[X_τ] = E[X_0] := ...
```

## 6. Doob Decomposition

```lean
-- Any submartingale decomposes as martingale + increasing predictable
theorem doobDecomposition (h_sub : Submartingale X ℱ μ) :
  ∃ M A, Martingale M ℱ μ ∧ predictable A ℱ ∧ X = M + A := ...
```

## 7. Martingale Convergence

```lean
-- L^1-bounded martingales converge almost surely
theorem martingaleConvergence (h_bdd : sup_n ‖X_n‖₁ < ∞) :
  ∃ X_∞, X_n → X_∞ a.s. := ...
```

## 8. Snell Envelope and Optimal Stopping

```lean
-- The Snell envelope: U_n = max(Z_n, E[U_{n+1}|F_n])
-- U_0 = optimal stopping value = sup_τ E[Z_τ]
def U := snellEnvelope Z ℱ μ N
```

## 9. Monte Carlo Simulation

```lean
-- Simulate paths and estimate expectations
def estimate := monteCarloEstimate process N
```

## 10. Further Reading

- Core/Basic.lean: all definitions
- Core/Laws.lean: key laws
- Examples/Standard.lean: worked examples
- Examples/Counterexamples.lean: edge cases
- Theorems/Basic.lean: main theorems
-/

#eval "Tutorial: Step-by-step guide to MiniConditionalMartingale"
