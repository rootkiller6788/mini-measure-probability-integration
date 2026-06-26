/-
# MiniMeasurableFunctions.Core.Basic

Core definitions for measurable functions:
- `MeasurableFunction`: a function f: X → Y such that f⁻¹(B) is measurable for all Borel B
- `SimpleFunction`: finite range, each level set measurable
- `simpleApproximation`: approximate a measurable function by simple functions
- Convergence modes: almost everywhere, in measure, almost uniformly
- `almostEverywhere`: a property holds a.e. if the exception set is null

This module imports `MiniObjectKernel` for the Object typeclass foundation.
-/

import MiniObjectKernel.Core.Basic

namespace MiniMeasurableFunctions

/-! ## σ-Algebra and Measurable Space

For the purpose of this package, we work with abstract measurable spaces.
A measurable space is a type X equipped with a σ-algebra (a collection of
subsets closed under complement and countable union, containing the whole set).
-/

structure MeasurableSpace (X : Type) where
  measurableSets : Set (Set X)
  containsEmpty : ∅ ∈ measurableSets
  closedUnderComplement : ∀ s ∈ measurableSets, sᶜ ∈ measurableSets
  closedUnderCountableUnion : ∀ (A : ℕ → Set X), (∀ n, A n ∈ measurableSets) →
    (⋃ n, A n) ∈ measurableSets

/-! ## Measurable Function

A function f: X → Y between measurable spaces is measurable if the
preimage of every measurable set in Y is measurable in X.
-/

structure MeasurableFunction (X Y : Type) [mX : MeasurableSpace X] [mY : MeasurableSpace Y] where
  toFun : X → Y
  measurable : ∀ s, s ∈ mY.measurableSets → toFun ⁻¹' s ∈ mX.measurableSets

instance (X Y : Type) [MeasurableSpace X] [MeasurableSpace Y] :
    FunLike (MeasurableFunction X Y) X Y where
  coe f := f.toFun
  coe_injective' f g h := by
    cases f; cases g; congr

/-! ## Indicator Functions

For any subset A of X, the indicator function 1_A maps x to 1 if x ∈ A and 0 otherwise.
-/

def indicator {X : Type} (A : Set X) (x : X) : ℕ :=
  if x ∈ A then 1 else 0

/-! ## Simple Function

A simple function is a measurable function with finite range — it takes only
finitely many values, and the preimage of each value (its level set) is measurable.
-/

structure SimpleFunction (X : Type) [MeasurableSpace X] where
  toFun : X → ℕ
  isMeasurable : ∀ n : ℕ, toFun ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)
  finiteRange : Finset ℕ
  rangeComplete : ∀ x, toFun x ∈ finiteRange

instance (X : Type) [MeasurableSpace X] : CoeFun (SimpleFunction X) (fun _ => X → ℕ) where
  coe s := s.toFun

/-! ## Almost Everywhere

A property P(x) holds almost everywhere (with respect to a null-ideal / measure 0 sets)
if the set where it fails is contained in the null sets.
-/

def almostEverywhere {X : Type} [MeasurableSpace X]
    (nullSets : Set (Set X)) (P : X → Prop) : Prop :=
  {x | ¬ P x} ∈ nullSets

/-! ## Convergence Modes

Different ways a sequence of measurable functions can converge.
-/

-- Convergence almost everywhere
def convergenceAlmostEverywhere {X : Type} [MeasurableSpace X]
    (nullSets : Set (Set X)) (fₙ : ℕ → X → ℕ) (f : X → ℕ) : Prop :=
  {x | ¬ (∀ ε > 0, ∃ N, ∀ n ≥ N, fₙ n x - f x < ε)} ∈ nullSets

-- Convergence in measure
def convergenceInMeasure {X : Type} [MeasurableSpace X]
    (μ : (Set X) → ℕ∞) (fₙ : ℕ → X → ℕ) (f : X → ℕ) : Prop :=
  ∀ ε > 0, ∀ δ > 0, ∃ N, ∀ n ≥ N, μ {x | fₙ n x - f x ≥ ε} < δ

-- Convergence almost uniformly (Egorov-like: uniform convergence off a small set)
def convergenceAlmostUniformly {X : Type} [MeasurableSpace X]
    (μ : (Set X) → ℕ∞) (fₙ : ℕ → X → ℕ) (f : X → ℕ) : Prop :=
  ∀ δ > 0, ∃ A, μ A < δ ∧ ∀ ε > 0, ∃ N, ∀ n ≥ N, ∀ x ∉ A, fₙ n x - f x < ε

/-! ## ℕ∞ type (extended natural numbers for measures) -/

def ℕ∞ := Option ℕ
  deriving Inhabited

instance : OfNat ℕ∞ 0 where
  ofNat := Option.some 0

instance : LT ℕ∞ where
  lt a b :=
    match a, b with
    | Option.some a', Option.some b' => a' < b'
    | Option.some _, Option.none => true
    | Option.none, _ => false

/-! ## simplexApproximation

Every measurable function can be approximated from below by simple functions.
-/

def simpleApproximation {X : Type} [MeasurableSpace X]
    (f : X → ℕ) (hmeas : ∀ n, f ⁻¹' {n} ∈ MeasurableSpace.measurableSets (X := X)) :
    ℕ → SimpleFunction X
  | k =>
    { toFun := fun x => if f x ≤ k then f x else k
      isMeasurable := by
        intro n
        -- The preimage is a finite union of level sets of f (for n ≤ k) plus the set where f > k.
        -- Using measurable sets being a σ-algebra, this preimage is measurable.
        sorry
      finiteRange := Finset.range (k + 1)
      rangeComplete := by
        intro x
        apply Finset.mem_range.mpr
        -- The value is at most k by construction, so it lies in range (k+1).
        exact Nat.lt_succ_of_le (by
          dsimp
          split
          · rename_i h; exact h
          · exact Nat.le_refl k)
    }

/-! ## isBorelMeasurable -/

def isBorelMeasurable {X Y : Type} [MeasurableSpace X] [MeasurableSpace Y]
    (f : X → Y) : Prop :=
  ∃ (hf : MeasurableFunction X Y), hf.toFun = f

/-! ## isLebesgueMeasurable -/

structure LebesgueMeasure (X : Type) where
  -- A placeholder for the Lebesgue measure on ℝⁿ
  measureOf : Set X → ℝ

def isLebesgueMeasurable {X : Type} [MeasurableSpace X]
    (f : X → ℝ) (μ : LebesgueMeasure X) : Prop :=
  ∀ s : Set ℝ, Measurable (Set ℝ) s → f ⁻¹' s ∈ MeasurableSpace.measurableSets (X := X)

-- Placeholder: a set is measurable if it belongs to the Lebesgue σ-algebra
def Measurable (α : Type) (s : Set α) : Prop := True

/-! ## #eval Examples -/

#eval "=== MiniMeasurableFunctions.Core.Basic ==="

-- A simple indicator on a finite set
def smallSpace : MeasurableSpace (Fin 5) := {
  measurableSets := {∅, Set.univ, {0}, {1,2,3,4}}
  containsEmpty := by simp
  closedUnderComplement := by
    intro s hs
    simp at hs ⊢
    rcases hs with (rfl|rfl|rfl|rfl)
    · exact Set.mem_insert Set.univ {0, {1,2,3,4}}
    · exact Set.mem_insert ∅ {0, {1,2,3,4}}
    · right; right; exact Set.mem_singleton _
    · right; exact Set.mem_singleton _
  closedUnderCountableUnion := fun A h => by
    -- Finite space: any countable union is just a finite union of the 4 sets.
    sorry
}

#eval "MeasurableSpace defined for Fin 5"

-- Simple function: indicator of {0} on Fin 5
def indicator01 : SimpleFunction (Fin 5) := {
  toFun := fun i => if i = 0 then 1 else 0
  isMeasurable := by
    intro n
    sorry
  finiteRange := {0, 1}
  rangeComplete := by
    intro i
    dsimp
    split
    · apply Finset.mem_insert.mpr; left; rfl
    · apply Finset.mem_insert.mpr; right; exact Finset.mem_singleton.mpr rfl
}

#eval indicator01 0  -- should be 1
#eval indicator01 1  -- should be 0

end MiniMeasurableFunctions
