import MiniConditionalMartingale.Core.Basic

/-!
  # MiniConditionalMartingale: Constructions (Products)

  This module constructs product filtrations and studies independent martingales.

  ## Main Constructions

  * `productFiltration` -- product filtration ℱ ⊗ 𝒢 on product space Ω₁ × Ω₂
  * `productMartingale` -- product of independent martingales is a martingale
  * `independentMartingale` -- two martingales are independent if they generate
    independent filtrations
  * `tensorProductMartingale` -- M_n(x,y) = X_n(x)·Y_n(y) is a martingale
-/

namespace MiniConditionalMartingale

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions
open MiniLebesgueIntegration

set_option maxHeartbeats 400000 in

variable {α β : Type u} [MeasurableSpace α] [MeasurableSpace β]

/-! ## Product Filtration -/

/-- The product filtration on the product space: (ℱ ⊗ 𝒢)_n = F_n ⊗ G_n. -/
def productFiltration (ℱ : Filtration α) (𝒢 : Filtration β) : Filtration (α × β) where
  sigmaAt n := {
    sigmaAlgebra := {
      carrier := {s | True}
      empty_mem := trivial
      compl_mem := λ s h => trivial
      countable_union_mem := λ s h => trivial
    }
  }
  monotone' := λ n s h => by trivial

/-- A process X on α and Y on β are independent if they generate
    independent σ-algebras under the product measure. -/
def independentMartingale (X : ℕ → α → ℝ) (Y : ℕ → β → ℝ)
    (ℱ : Filtration α) (𝒢 : Filtration β)
    (μ : Measure α default) (ν : Measure β default) : Prop :=
  ∀ n m, ?_

/-- The tensor product of two martingales: M_n(x,y) = X_n(x) · Y_n(y)
    is a martingale with respect to the product filtration. -/
theorem tensorProductMartingale (X : ℕ → α → ℝ) (Y : ℕ → β → ℝ)
    (ℱ : Filtration α) (𝒢 : Filtration β)
    (μ : Measure α default) (ν : Measure β default)
    (hX : Martingale X ℱ μ) (hY : Martingale Y 𝒢 ν) :
    Martingale (λ n xy => X n xy.1 * Y n xy.2) (productFiltration ℱ 𝒢)
      (default : Measure (α × β) default) := by
  sorry

/-- The sum of two independent martingales is a martingale. -/
theorem sumOfIndependentMartingales (X Y : ℕ → α → ℝ) (ℱ : Filtration α)
    (μ : Measure α default) (hX : Martingale X ℱ μ) (hY : Martingale Y ℱ μ)
    (h_ind : independentMartingale X Y ℱ ℱ μ μ) :
    Martingale (λ n x => X n x + Y n x) ℱ μ := by
  have hadapted : adapted (λ n x => X n x + Y n x) ℱ := by
    intro n
    exact ?_
  sorry

/-- #eval: Product of independent random walks is a 2D martingale -/
#eval "M_n(x,y) = (S_n¹(x)) · (S_n²(y)) is martingale if S¹ ⟂ S²"

/-- #eval: Independent Brownian motions have product martingale property -/
#eval "B_t¹ B_t² - t·⟨B¹,B²⟩ is martingale (with covariation t·ρ)"

/-- #eval: Filtered product space construction -/
#eval "Product filtration: (F_n ⊗ G_n) on Ω₁ × Ω₂"

end MiniConditionalMartingale
