/-
# Computation.Simulate

Monte Carlo simulation and sampling for measurable functions:
- Generate random samples from a finite measure space
- Compute empirical distribution of a measurable function
- Estimate integrals via sampling
-/

import MiniMeasurableFunctions

namespace MiniMeasurableFunctions.Computation

open MiniMeasurableFunctions

-- Generate N random samples from a finite type (pseudo-random using linear congruential)
def pseudoRandomSequence (seed nSamples : ℕ) : List ℕ :=
  let modulus := 2 ^ 31 - 1
  let a := 1103515245
  let c := 12345
  List.range nSamples |>.scanl (fun s _ => (a * s + c) % modulus) seed |>.drop 1

-- Map samples to elements of a Fintype X
def samplesToFintype {X : Type} [Fintype X] [DecidableEq X] (samples : List ℕ) : List X :=
  let elements := (Finset.univ : Finset X).val
  let n := elements.length
  samples.map fun s => elements.get! (s % n)

-- Compute empirical distribution (frequency of each value)
def empiricalDistribution {X Y : Type} [Fintype Y] [DecidableEq Y]
    (f : X → Y) (samples : List X) : Finset (Y × ℕ) :=
  let values := samples.map f
  (Finset.univ : Finset Y).map fun y =>
    (y, values.count y)

-- Monte Carlo estimate of ∫ f dμ for uniform measure on finite X
def monteCarloIntegral {X : Type} [Fintype X] [DecidableEq X]
    (f : X → ℕ) (nSamples : ℕ) : ℕ :=
  let seed := 42
  let samples := pseudoRandomSequence seed nSamples
  let xs := samplesToFintype samples
  let sum := xs.foldl (fun acc x => acc + f x) 0
  sum / nSamples

#eval "=== MiniMeasurableFunctions.Computation.Simulate ==="

-- Generate some pseudo-random samples
#eval pseudoRandomSequence 42 5

-- Monte Carlo integral for f(x) = x on Fin 5
#eval monteCarloIntegral (fun x : Fin 5 => x.val) 1000

-- Theoretical mean for uniform{0,1,2,3,4} = 2
#eval "Expected value ≈ 2 for large N"

end MiniMeasurableFunctions.Computation
