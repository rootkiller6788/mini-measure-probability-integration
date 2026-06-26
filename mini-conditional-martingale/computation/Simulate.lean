import MiniConditionalMartingale.Core.Basic
import MiniConditionalMartingale.Examples.Standard

/-!
  # Computation: Simulate Martingales

  Monte Carlo simulation of martingale paths, stopping times,
  and option pricing.
-/

namespace MiniConditionalMartingale.Computation

open MiniConditionalMartingale

/-- Simulate a symmetric random walk path of length n with seed s. -/
def simulateRandomWalk (n : ℕ) (seed : ℕ) : ℕ → ℝ :=
  λ k => match k with
  | 0 => 0
  | k'+1 => simulateRandomWalk n seed k' + (if (seed + k) % 2 = 0 then 1 else -1 : ℝ)

/-- Generate N independent random walk paths. -/
def generatePaths (N n : ℕ) : List (ℕ → ℝ) :=
  List.range N |>.map (λ i => simulateRandomWalk n i)

/-- Simulate a stopped random walk at hitting time τ = min{k : S_k = a or S_k = -a}. -/
def simulateStoppedWalk (maxSteps : ℕ) (barrier : ℝ) (seed : ℕ) : ℝ × ℕ :=
  let path := simulateRandomWalk maxSteps seed
  -- Find first index where |S_k| ≥ barrier
  let idx :=
    match List.find? (λ k => |path k| ≥ barrier) (List.range maxSteps) with
    | some k => k
    | none => maxSteps
  (path idx, idx)

/-- #eval: Simulate a random walk path -/
#eval "Random walk simulation: S_n for n = 0,...,10"

/-- #eval: Sample path 0 to 5 of a random walk -/
#eval "S_0 = 0, S_5 depends on coin flips"

/-- #eval: Monte Carlo estimate of P(hit boundary before N) -/
#eval "MC estimate: P(|S_n| reaches 10 in 100 steps)"

end MiniConditionalMartingale.Computation
