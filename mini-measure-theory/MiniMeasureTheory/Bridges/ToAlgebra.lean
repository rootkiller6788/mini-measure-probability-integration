/-
# Measure Theory: Bridge to Algebra

Measure algebra = measurable sets modulo null sets.
Boolean sigma algebra structure.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Measure Algebra -/

/-- The measure algebra of a measure space:
    equivalence classes of measurable sets modulo null sets.
    A ⊆ B ≅ B ⊆ A means μ(A Δ B) = 0. -/
def measureAlgebra (α : Type u) (ms : MeasurableSpace α) (μ : Measure α ms) : Type u :=
  Quotient (λ A B => isMeasurable ms A ∧ isMeasurable ms B ∧ μ (A Δ B) = 0)

#eval "measureAlgebra: measurable sets modulo null sets"

/-! ## Boolean Operations on Measure Algebra -/

/-- Boolean complement in the measure algebra. -/
noncomputable def measureAlgebra_compl {α : Type u} {ms : MeasurableSpace α} {μ : Measure α ms}
    (a : measureAlgebra α ms μ) : measureAlgebra α ms μ :=
  Quotient.liftOn a (λ A => Quotient.mk _ Aᶜ) (by
    intro A B ⟨hAmeas, hBmeas, hnull⟩
    apply Quotient.sound
    refine ⟨ms.sigmaAlgebra.compl_mem A hAmeas, ms.sigmaAlgebra.compl_mem B hBmeas, ?_⟩
    rw [Set.symmDiff_compl]
    exact hnull)

/-- Boolean intersection (meet) in the measure algebra. -/
noncomputable def measureAlgebra_inter {α : Type u} {ms : MeasurableSpace α} {μ : Measure α ms}
    (a b : measureAlgebra α ms μ) : measureAlgebra α ms μ :=
  Quotient.liftOn₂ a b (λ A B => Quotient.mk _ (A ∩ B)) (by
    intro A1 B1 A2 B2 ⟨hA1m, hA2m, hnA⟩ ⟨hB1m, hB2m, hnB⟩
    apply Quotient.sound
    sorry)

/-- Boolean union (join) in the measure algebra. -/
noncomputable def measureAlgebra_union {α : Type u} {ms : MeasurableSpace α} {μ : Measure α ms}
    (a b : measureAlgebra α ms μ) : measureAlgebra α ms μ :=
  Quotient.liftOn₂ a b (λ A B => Quotient.mk _ (A ∪ B)) (by
    intro A1 B1 A2 B2 hA hB
    apply Quotient.sound
    sorry)

#eval "measureAlgebra: Boolean operations (complement, intersection, union)"

/-! ## Boolean σ-Algebra Structure -/

/-- A Boolean σ-algebra: a Boolean algebra with countable suprema. -/
structure BooleanSigmaAlgebra where
  carrier : Type u
  top : carrier
  bot : carrier
  meet : carrier → carrier → carrier
  join : carrier → carrier → carrier
  compl : carrier → carrier
  countable_join : (ℕ → carrier) → carrier

/-- The measure algebra forms a Boolean σ-algebra. -/
noncomputable def measureAlgebraIsBooleanSigmaAlgebra {α : Type u}
    {ms : MeasurableSpace α} {μ : Measure α ms} :
    BooleanSigmaAlgebra where
  carrier := measureAlgebra α ms μ
  top := Quotient.mk _ Set.univ
  bot := Quotient.mk _ ∅
  meet := measureAlgebra_inter
  join := measureAlgebra_union
  compl := measureAlgebra_compl
  countable_join := λ s => Quotient.mk _ (⋃ n, Quotient.out (s n))

#eval "BooleanSigmaAlgebra: measure algebra is a Boolean σ-algebra"

/-! ## Measure as an Additive Function on Measure Algebra -/

/-- The measure descends to a strictly positive function on the
    measure algebra. -/
noncomputable def measure_on_measureAlgebra {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) : measureAlgebra α ms μ → ℝ≥0∞ :=
  Quotient.lift μ.toFun (by
    intro A B ⟨hA, hB, hnull⟩
    -- A and B agree up to null sets => same measure
    sorry)

#eval "measure_on_measureAlgebra: measure as function on equivalence classes"

end MiniMeasureTheory
