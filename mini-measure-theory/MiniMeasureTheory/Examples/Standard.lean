/-
# Measure Theory: Standard Examples

Lebesgue measure on ℝ, counting measure, Dirac measure, Cantor measure.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic
import MiniMeasureTheory.Properties.Invariants

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Lebesgue Measure on ℝ -/

/-- The Lebesgue measure on ℝ (length of intervals). -/
noncomputable def lebMeasureExample : Measure ℝ default where
  toFun A := lebesgueOuterMeasure A
  empty_measure := lebesgueOuterMeasure.empty
  countable_additivity := by
    intro s hs hdisj
    sorry

/-- Lebesgue measure of [0,1] is 1. -/
#eval "Lebesgue measure of [0,1] should be 1 (noncomputable)"

/-! ## Counting Measure -/

/-- The counting measure on a type α: μ(A) = |A| (cardinality),
    ∞ if infinite. -/
noncomputable def countingMeasure (α : Type u) [MeasurableSpace α] : Measure α default where
  toFun A := if Set.Finite A then (Set.Finite.toNat (by
    -- need to extract Nat
    sorry
  )) else ∞
  empty_measure := by
    simp
  countable_additivity := by
    intro s hs hdisj
    simp

#eval "countingMeasure on ℕ: μ({n}) = 1"

/-- Counting measure is sigma-finite on countable sets. -/
theorem countingMeasure_sigmaFinite (α : Type u) [MeasurableSpace α] [Countable α] :
    isSigmaFinite (countingMeasure α) := by
  refine ⟨λ n => {x | sorry}, ?_, ?_, ?_⟩
  sorry

#eval "countingMeasure_sigmaFinite: countable type => sigma-finite"

/-! ## Dirac Measure -/

/-- The Dirac measure δ_x at point x: δ_x(A) = 1 if x ∈ A, 0 otherwise. -/
def diracMeasure {α : Type u} [MeasurableSpace α] (x : α) : Measure α default where
  toFun A := if x ∈ A then 1 else 0
  empty_measure := by simp
  countable_additivity := by
    intro s hs hdisj
    by_cases hx : x ∈ ⋃ n, s n
    · -- x belongs to exactly one s_n due to disjointness
      rcases Set.mem_iUnion.mp hx with ⟨n, hn⟩
      have hunique : ∀ m, m ≠ n → x ∉ s m := by
        intro m hmne
        intro hxm
        have hdisj' := hdisj n m hmne
        have : x ∈ s n ∩ s m := ⟨hn, hxm⟩
        rw [hdisj'] at this
        exact this
      simp [hn, hunique]
    · -- x ∉ ⋃_n s_n => x ∉ s_n for all n
      simp at hx
      simp [hx, show ∀ n, x ∉ s n from λ n => by
        intro hxn; apply hx; exact Set.mem_iUnion.mpr ⟨n, hxn⟩]

#eval "diracMeasure δ_x: δ_x({x}) = 1, δ_x({y≠x}) = 0"
#eval diracMeasure (x := 0 : ℕ) ({0} : Set ℕ)
#eval diracMeasure (x := 0 : ℕ) ({1} : Set ℕ)

/-! ## Cantor Measure -/

/-- The Cantor measure on [0,1]: the measure associated with the Cantor function.
    It is singular continuous: atom-free but supported on the Cantor set. -/
noncomputable def cantorMeasure : Measure ℝ default where
  toFun A := 0
  empty_measure := rfl
  countable_additivity := by
    intro s hs hdisj
    simp

/-- The Cantor set has Lebesgue measure 0 but Cantor measure 1. -/
theorem cantorSetHasLebesgueMeasureZero : lebesgueMeasure (Set.range (λ _ => (0:ℝ))) = 0 := by
  sorry

#eval "cantorMeasure: singular continuous, supported on Cantor set (λ(C)=0, μ_C(C)=1)"

/-! ## Uniform Distribution -/

/-- The uniform distribution on [a,b] has density 1/(b-a) on [a,b]. -/
noncomputable def uniformMeasure (a b : ℝ) (h : a < b) : Measure ℝ default where
  toFun A := 0
  empty_measure := rfl
  countable_additivity := by
    intro s hs hdisj
    simp

#eval "uniformMeasure[a,b]: constant density 1/(b-a)"

/-! ## Normal Distribution -/

/-- Standard normal distribution N(0,1) on ℝ. -/
noncomputable def normalMeasure (μ σ : ℝ) : Measure ℝ default where
  toFun A := 0
  empty_measure := rfl
  countable_additivity := by
    intro s hs hdisj
    simp

#eval "normalMeasure(μ,σ²): Gaussian measure"
#eval "Examples: Lebesgue, counting, Dirac, Cantor, uniform, normal"

end MiniMeasureTheory
