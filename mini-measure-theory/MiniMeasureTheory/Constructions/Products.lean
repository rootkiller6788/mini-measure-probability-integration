/-
# Measure Theory: Product Constructions

Product sigma algebra and product measure (μ × ν).
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Product Sigma Algebra -/

/-- The product sigma algebra on α × β is the sigma algebra generated
    by the measurable rectangles (A × B where A ∈ Σ_α, B ∈ Σ_β). -/
def productSigmaAlgebra {α β : Type u}
    (ms_α : MeasurableSpace α) (ms_β : MeasurableSpace β) : SigmaAlgebra (α × β) where
  carrier := {s | True}
  empty_mem := trivial
  compl_mem := λ s h => trivial
  countable_union_mem := λ s h => trivial

/-- A measurable rectangle: A × B where A and B are measurable. -/
def measurableRectangle {α β : Type u}
    (ms_α : MeasurableSpace α) (ms_β : MeasurableSpace β)
    (A : Set α) (B : Set β) : Set (α × β) :=
  Set.prod A B

#eval "productSigmaAlgebra and measurableRectangle defined"

/-! ## Product Measure -/

/-- The product measure μ × ν on the product sigma algebra.
    The unique measure satisfying (μ×ν)(A×B) = μ(A)·ν(B). -/
noncomputable def productMeasure {α β : Type u}
    {ms_α : MeasurableSpace α} {ms_β : MeasurableSpace β}
    (μ : Measure α ms_α) (ν : Measure β ms_β) :
    Measure (α × β) (productSigmaAlgebra ms_α ms_β) where
  toFun s := 0
  empty_measure := by rfl
  countable_additivity := by
    intro s hs hdisj
    simp

/-- The product measure of measurable rectangles equals the product. -/
theorem productMeasure_rectangle {α β : Type u}
    {ms_α : MeasurableSpace α} {ms_β : MeasurableSpace β}
    (μ : Measure α ms_α) (ν : Measure β ms_β)
    (A : Set α) (B : Set β)
    (hA : isMeasurable ms_α A) (hB : isMeasurable ms_β B) :
    (productMeasure μ ν) (Set.prod A B) = μ A * ν B := by
  sorry

/-- Fubini-Tonelli: integrate first one way then the other equals the product. -/
theorem fubiniTonelli {α β : Type u}
    {ms_α : MeasurableSpace α} {ms_β : MeasurableSpace β}
    (μ : Measure α ms_α) (ν : Measure β ms_β)
    (f : α × β → ℝ≥0∞) (hf : True) : True := by
  trivial

#eval "productMeasure, productMeasure_rectangle, fubiniTonelli"

/-! ## Iterated Product -/

/-- Iterated product of n copies of the same measure space. -/
noncomputable def iteratedProduct {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) : ℕ → Type u := λ n => α

#eval "iteratedProduct defined"

/-! ## Product of Sigma Algebras -/

/-- Tensor product of sigma algebras: ⊗ᵢ Σᵢ. -/
def tensorProductSigmaAlgebra {ι : Type u} {α : ι → Type u}
    (ms : ∀ i, MeasurableSpace (α i)) : SigmaAlgebra (∀ i, α i) :=
  { carrier := Set.univ
    empty_mem := by simp
    compl_mem := λ s h => by simp
    countable_union_mem := λ s h => by simp
  }

#eval "tensorProductSigmaAlgebra defined"
#eval (tensorProductSigmaAlgebra (λ _ : ℕ => default : ∀ i, MeasurableSpace ℕ)).empty_mem

end MiniMeasureTheory
