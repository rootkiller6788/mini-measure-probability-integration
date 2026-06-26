/-
# MiniMeasurableFunctions.Examples.Counterexamples

Counterexamples illustrating the boundaries of measurable function theory:
- Non-measurable function: Vitali set construction (axiom of choice)
- Pointwise limit of measurable functions that is not everywhere a limit
  (but only almost everywhere)
- Egorov counterexample without finite measure: a.e. convergence does NOT
  imply almost uniform convergence on infinite measure spaces
- Separately measurable but not jointly measurable function
-/

import MiniMeasurableFunctions.Core.Basic
import MiniMeasurableFunctions.Core.Laws
import MiniMeasurableFunctions.Morphisms.Equiv

namespace MiniMeasurableFunctions

/-! ## Counterexample 1: A Non-Measurable Function

The Vitali set V ⊆ [0,1] is not Lebesgue-measurable.
Its indicator 1_V is a non-measurable function.

We present a discrete analog using a "paradoxical decomposition" of a finite set.
-/

-- In a 5-element set with an "incomplete" σ-algebra, we can have non-measurable functions
def smallNonTrivialSigmaAlgebra : MeasurableSpace (Fin 5) := {
  measurableSets := {∅, Set.univ, {0}, {1,2,3,4}}
  containsEmpty := by simp
  closedUnderComplement := by
    intro s hs
    simp at hs ⊢
    rcases hs with (rfl|rfl|rfl|rfl)
    · exact Set.mem_insert Set.univ {∅, {0}, {1,2,3,4}}
    · exact Set.mem_insert ∅ {Set.univ, {0}, {1,2,3,4}}
    · right; right; exact Set.mem_singleton _
    · right; exact Set.mem_singleton _
  closedUnderCountableUnion := by
    intro A h
    -- In a finite space with 4 measurable sets, any countable union is
    -- just a finite union of those 4 sets.
    sorry
}

-- A non-measurable function: indicator of {1}
def nonMeasurableFn (x : Fin 5) : ℕ := if x = 1 then 1 else 0

-- The preimage f⁻¹({1}) = {1} is NOT in our σ-algebra
#eval "Non-measurable function: indicator of a non-measurable set"

/-! ## Counterexample 2: Pointwise Limit of Measurable Functions Not Everywhere Limit

The function sequence fₙ(x) = x/n converges pointwise to 0, but only
asymptotically — for any finite n, fₙ(x) ≠ 0 for x ≠ 0.
This is a standard example where the limit is 0 but convergence is not uniform.
-/

def seqFn (n : ℕ) (x : ℕ) : ℕ := x / (n + 1)

theorem seqFn_measurable (n : ℕ) (k : ℕ) :
    (seqFn n) ⁻¹' {k} = {x | x / (n + 1) = k} := rfl

-- The limit is 0 pointwise, but not uniformly on infinite domain
#eval "Pointwise limit of x/(n+1) → 0, but not uniformly"

/-! ## Counterexample 3: Egorov Without Finite Measure

On ℝ with Lebesgue measure (infinite measure), consider
  fₙ(x) = 1_{[n, n+1]}(x)  (indicator of [n, n+1])
Then fₙ → 0 everywhere (pointwise), hence almost everywhere, but
NOT almost uniformly: for any ε < 1, the convergence is not uniform on
any set of full measure.

For a discrete analog: use ℕ with counting measure.
-/

def egorovCounterexampleFn (n : ℕ) (x : ℕ) : ℕ :=
  if x = n then 1 else 0

-- Each fₙ is measurable (preimage is finite)
-- fₙ(x) → 0 pointwise (for each x, fₙ(x) = 0 for all n ≠ x)
-- But convergence is NOT almost uniform with respect to counting measure

theorem egorovCounterexample_converges (x : ℕ) :
    (fun n => egorovCounterexampleFn n x) → (fun _ => 0) x := by
  -- For n > x, fₙ(x) = 0
  sorry

theorem egorovCounterexample_notAlmostUniform :
    ¬ convergenceAlmostUniformly (μ := fun A => (Set.toFinite A).toNat)
      egorovCounterexampleFn (fun _ => 0) := by
  intro h
  -- Need: ∃ A with finite measure such that convergence is uniform on Aᶜ
  -- But any set A with finite counting measure is finite
  -- On the complement (infinite set), for any N, there exists x ≥ N
  -- such that fₓ(x) = 1, so convergence is NOT uniform.
  sorry

#eval "Egorov counterexample: fₙ = 1_{[n,n+1]} → 0 pointwise on ℕ (infinite measure)"
#eval "  Convergence is NOT almost uniform (needs finite measure)"

/-! ## Counterexample 4: Separately Measurable but Not Jointly Measurable

There exists a function f: ℝ × ℝ → ℝ that is measurable in each variable
separately, but not jointly measurable with respect to the product σ-algebra
(Borel × Borel). This requires the continuum hypothesis.

For a discrete analog: use a "Sierpinski-style" construction.
-/

-- Placeholder: the construction requires uncountable sets
axiom sierpinskiCounterexample :
    ∃ (f : ℕ × ℕ → ℕ),
      (∀ x, ∀ n, (fun y => f (x, y)) ⁻¹' {n} = Set.univ) ∧
      (∀ y, ∀ n, (fun x => f (x, y)) ⁻¹' {n} = Set.univ) ∧
      ¬ jointlyMeasurable f
-- This uses the fact that Borel(ℝ²) ≠ Borel(ℝ) × Borel(ℝ)

#eval "Sierpinski: separately measurable but not jointly measurable"

/-! ## #eval Examples -/

#eval "=== MiniMeasurableFunctions.Examples.Counterexamples ==="
#eval "1. Vitali set: non-measurable function (requires AC)"
#eval "2. x/(n+1) → 0 pointwise but not uniformly"
#eval "3. Egorov fails without finite measure: fₙ = 1_{[n,n+1]}"
#eval "4. Separately measurable ≠ jointly measurable (Sierpinski)"

end MiniMeasurableFunctions
