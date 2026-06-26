/-
# Measure Theory: Preservation Properties

How measure-theoretic properties are preserved under
pushforward, products, restrictions, etc.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic
import MiniMeasureTheory.Properties.Invariants

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Absolute Continuity Preserved by Pushforward -/

/-- If ν ≪ μ, then f_*ν ≪ f_*μ. -/
theorem absoluteContinuity_pushforward {α β : Type u}
    {ms_α : MeasurableSpace α} {ms_β : MeasurableSpace β}
    (μ ν : Measure α ms_α) (f : α → β)
    (h : absolutelyContinuous ν μ) :
    absolutelyContinuous (pushforward ν f) (pushforward μ f) := by
  intro A hA h
  dsimp [pushforward] at h
  have : μ (f ⁻¹' A) = 0 := h
  sorry

#eval "absoluteContinuity_pushforward: ν ≪ μ ⇒ f_*ν ≪ f_*μ"

/-! ## Sigma-Finiteness Under Products -/

/-- If μ and ν are sigma-finite, then μ × ν is sigma-finite. -/
theorem sigmaFinite_product {α β : Type u}
    {ms_α : MeasurableSpace α} {ms_β : MeasurableSpace β}
    (μ : Measure α ms_α) (ν : Measure β ms_β)
    (hμ : isSigmaFinite μ) (hν : isSigmaFinite ν) :
    isSigmaFinite (productMeasure μ ν) := by
  rcases hμ with ⟨A, hAmeas, hAfin, hAunion⟩
  rcases hν with ⟨B, hBmeas, hBfin, hBunion⟩
  refine ⟨λ n => Set.prod (A n) (B n), ?_, ?_, ?_⟩
  · intro n
    -- measurable rectangle is measurable in product sigma algebra
    sorry
  · intro n
    -- μ(A_n) * ν(B_n) < ∞
    sorry
  · -- ⋃_n A_n × B_n = α × β
    ext ⟨x, y⟩; simp; constructor
    · intro hx; rcases Set.mem_iUnion.mp ?_ with ⟨n, hn⟩
      sorry
    · intro ⟨hx, hy⟩
      rcases Set.mem_iUnion.mp (by rw [hAunion]; exact Set.mem_univ x) with ⟨n, hn⟩
      rcases Set.mem_iUnion.mp (by rw [hBunion]; exact Set.mem_univ y) with ⟨m, hm⟩
      sorry

#eval "sigmaFinite_product: product of sigma-finite is sigma-finite"

/-! ## Finiteness Preserved Under Restriction -/

/-- If μ is finite, then μ|_A is finite. -/
theorem finite_restriction {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) (A : Set α) (hA : isMeasurable ms A)
    (hfinite : isFinite μ) : isFinite (traceMeasure μ A hA) := by
  rcases hfinite with ⟨M, hM, hMfin⟩
  refine ⟨M, ?_, hMfin⟩
  dsimp [traceMeasure]
  simp [hM]

#eval "finite_restriction: finite measure remains finite after restriction"

/-! ## Probability Preserved Under Pushforward -/

/-- If μ is a probability measure and f is measurable,
    then f_*μ is a probability measure. -/
theorem probability_pushforward {α β : Type u}
    {ms_α : MeasurableSpace α} {ms_β : MeasurableSpace β}
    (μ : Measure α ms_α) (f : α → β)
    (hprob : isProbabilityMeasure μ) : isProbabilityMeasure (pushforward μ f) := by
  dsimp [isProbabilityMeasure, pushforward]
  simp [hprob]

#eval "probability_pushforward: probability preserved under pushforward"

/-! ## Atom-Free Preserved Under Absolute Continuity -/

/-- If μ is atom-free and ν ≪ μ, then ν is atom-free. -/
theorem atomFree_under_absoluteContinuity {α : Type u} {ms : MeasurableSpace α}
    (μ ν : Measure α ms) (hμ : isAtomFree μ) (hνμ : absolutelyContinuous ν μ) :
    isAtomFree ν := by
  intro A hA hpos
  have hpos' : μ A > 0 := by
    by_contra hzero
    have hnzero := hνμ A hA (by
      apply le_antisymm ?_ (by simp)
      exact hzero)
    rw [hnzero] at hpos
    exact lt_irrefl 0 hpos
  rcases hμ A hA hpos' with ⟨B, hB, hBsub, hBpos, hBless⟩
  refine ⟨B, hB, hBsub, ?_, ?_⟩
  · -- ν(B) > 0
    by_contra hzero
    have := hνμ B hB hzero
    rw [this] at hBpos
    exact lt_irrefl 0 hBpos
  · -- ν(B) < ν(A)
    sorry

#eval "atomFree_under_absoluteContinuity: atom-free preserved under ≪"

end MiniMeasureTheory
