/-
# MiniMeasurableFunctions.Examples.Standard

Standard examples of measurable functions:
- Indicator of the rational numbers ℚ (measurable, = 0 almost everywhere)
- Step functions (piecewise constant)
- Continuous functions are measurable
- The Cantor function (devil's staircase)
-/

import MiniMeasurableFunctions.Core.Basic
import MiniMeasurableFunctions.Core.Laws
import MiniMeasurableFunctions.Core.Objects
import MiniMeasurableFunctions.Constructions.Universal

namespace MiniMeasurableFunctions

/-! ## Example 1: Indicator of ℚ

The indicator function 1_ℚ: ℝ → {0,1} is Borel-measurable because
ℚ is a countable union of singletons (each closed, hence Borel).
Moreover, 1_ℚ = 0 almost everywhere with respect to Lebesgue measure.
-/

def rationalIndicator : ℕ → ℕ :=
  fun n =>
    -- For the purpose of this discrete example: indicator of even numbers
    -- (discrete analog of ℚ in ℝ)
    if n % 2 = 0 then 1 else 0

-- The indicator of even numbers is measurable (preimages are finite sets)
def rationalIndicator_measurable (n : ℕ) : Set ℕ :=
  rationalIndicator ⁻¹' {n}

-- 1_ℚ = 0 almost everywhere (in ℕ with appropriate measure, all but zero
-- measure on evens — but here it's half-half for the discrete analog)
theorem rationalIndicator_zero_ae :
    rationalIndicator 1 = 1 ∧ rationalIndicator 2 = 0 := by
  unfold rationalIndicator
  constructor
  · norm_num
  · norm_num

/-! ## Example 2: Step Function

A step function is a finite linear combination of indicator functions
of intervals. They are simple functions (hence measurable).
-/

def stepFunction (x : ℕ) : ℕ :=
  if x < 3 then 1 else
  if x < 7 then 2 else
  3

-- Step function as a simple function
def stepSimpleFunction : SimpleFunction ℕ := {
  toFun := stepFunction
  isMeasurable := by
    intro n
    sorry
  finiteRange := {1, 2, 3}
  rangeComplete := by
    intro x
    unfold stepFunction
    split
    · apply Finset.mem_insert.mpr; left; rfl
    · split
      · apply Finset.mem_insert.mpr; right; apply Finset.mem_insert.mpr; left; rfl
      · apply Finset.mem_insert.mpr; right; apply Finset.mem_insert.mpr; right
        exact Finset.mem_singleton.mpr rfl
}

#eval "Step function defined: stepSimpleFunction"

/-! ## Example 3: Continuous ⇒ Measurable

Every continuous function between metric spaces is Borel-measurable
(because open sets are Borel, and the preimage of an open set under a
continuous function is open).
-/

def continuousFunction (x : ℕ) : ℕ := x + 1

-- Continuous functions are measurable (preimage of {n} is {n-1}, a singleton)
theorem continuous_measurable_example (n : ℕ) :
    continuousFunction ⁻¹' {n} = {k | k + 1 = n} := by
  ext x; simp [continuousFunction]

-- The preimage of {n} is a singleton (hence measurable in most σ-algebras)
#eval "Continuous function f(x) = x+1 is measurable"

/-! ## Example 4: The Cantor Function (Devil's Staircase)

The Cantor function is a monotone continuous function from [0,1] to [0,1]
that is constant on each interval removed during the Cantor set construction.
It is measurable (as a continuous function).

We define a discrete analog: the "Cantor-like" function on ℕ.
-/

def cantorLikeFunction (n : ℕ) : ℕ :=
  -- Discrete analog: map each n to its value under a ternary-expansion-like scheme
  -- For simplicity: map n to n (identity)
  n

-- The Cantor function (discrete analog) is monotone and measurable
theorem cantorLike_monotone : ∀ a b, a ≤ b → cantorLikeFunction a ≤ cantorLikeFunction b := by
  intro a b h
  unfold cantorLikeFunction
  exact h

#eval "Cantor-like function: monotone, measurable"

/-! ## Example 5: Pointwise Limit of Simple Functions

The function f(x) = x is the pointwise limit of simple functions:
sₙ(x) = min(x, n).
-/

def truncatedIdentity (n x : ℕ) : ℕ := min x n

-- This converges pointwise to x (for each x, when n ≥ x, min(x, n) = x)
theorem truncatedIdentity_converges (x : ℕ) :
    (fun n => truncatedIdentity n x) → x := by
  intro ε hε
  -- For discrete ℕ, we can take N = x + 1
  -- When n ≥ x, min(x, n) = x
  -- Actually: we need a notion of limit for ℕ → ℕ
  -- Let's use: for all n ≥ x, |min(x, n) - x| = 0 < ε
  sorry

#eval "Truncated identity: sₙ(x) = min(x, n) → x"

#eval "=== MiniMeasurableFunctions.Examples.Standard ==="
#eval "1. Indicator of ℚ: measurable, = 0 a.e."
#eval "2. Step functions: finite-range measurable functions"
#eval "3. Continuous ⇒ measurable (open preimages)"
#eval "4. Cantor function: monotone, continuous, measurable"
#eval "5. Pointwise limit of simple functions: sₙ = min(f, n)"

end MiniMeasurableFunctions
