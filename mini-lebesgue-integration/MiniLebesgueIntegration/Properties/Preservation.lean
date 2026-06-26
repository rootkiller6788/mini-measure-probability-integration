import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic
import MiniLebesgueIntegration.Core.Laws

/-!
  # MiniLebesgueIntegration: Properties — Preservation

  Convergence and preservation properties:
  - L^p convergence under Monotone Convergence Theorem
  - L^p convergence under Dominated Convergence Theorem
  - Norm preservation under isometry
  - Completeness preservation
-/

namespace MiniLebesgueIntegration

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

variable {α : Type u} [MeasurableSpace α] {μ : Measure α}

/-- Under MCT, L^p convergence is preserved for monotonically increasing sequences. -/
theorem LpConvergence_under_MCT (p : ℝ) (hp : 1 ≤ p) (hpFin : p < ∞)
    (f : ℕ → α → ℝ) (g : α → ℝ)
    (hmono : ∀ n x, f n x ≤ f (n+1) x)
    (h_nonneg : ∀ n x, 0 ≤ f n x)
    (h_lim : ∀ x, Filter.Tendsto (λ n => f n x) Filter.atTop (𝓝 (g x)))
    (h_bound : ∀ n, isLp (f n) p μ)
    (h_sup_bound : isLp g p μ) :
    Filter.Tendsto (λ n => LpNorm (f n - g) p μ) Filter.atTop (𝓝 0) := by
  sorry

/-- Under DCT, L^p convergence is preserved when dominated by an L^p function. -/
theorem LpConvergence_under_DCT (p : ℝ) (hp : 1 ≤ p) (hpFin : p < ∞)
    (f : ℕ → α → ℝ) (g h : α → ℝ)
    (hdom : ∀ n x, |f n x| ≤ h x)
    (hdomLp : isLp h p μ)
    (hconv : ∀ᵐ x ∂μ, Filter.Tendsto (λ n => f n x) Filter.atTop (𝓝 (g x))) :
    Filter.Tendsto (λ n => LpNorm (f n - g) p μ) Filter.atTop (𝓝 0) := by
  sorry

/-- An L^p isometry preserves the L^p norm exactly. -/
theorem LpIsometry_preserves_norm {β : Type u} [MeasurableSpace β]
    (T : LpIsometry α β p μ ν) (f : LpSpace α p μ) :
    LpNorm ((T.toFun f).representative) p ν = LpNorm f.representative p μ :=
  T.norm_preserving f

/-- The completion of a normed space under L^p norm is complete (Riesz-Fischer). -/
theorem LpSpace_complete (p : ℝ) (hp : 1 ≤ p) [h : SigmaFinite μ] :
    CompleteSpace (LpSpace α p μ) := by
  sorry

/-- L^p convergence implies convergence in measure. -/
theorem LpConvergence_implies_measureConvergence (p : ℝ) (hp : 1 ≤ p) (hpFin : p < ∞)
    (f : ℕ → α → ℝ) (g : α → ℝ)
    (hconv : Filter.Tendsto (λ n => LpNorm (f n - g) p μ) Filter.atTop (𝓝 0)) :
    ∀ (ε : ℝ) (hε : 0 < ε),
    Filter.Tendsto (λ n => μ {x | ε ≤ |f n x - g x|}) Filter.atTop (𝓝 0) := by
  sorry

/-- Convergence in measure implies existence of a.e.-convergent subsequence. -/
theorem measureConvergence_implies_aeConvergentSubseq
    (f : ℕ → α → ℝ) (g : α → ℝ)
    (hconv : ∀ (ε : ℝ) (hε : 0 < ε),
      Filter.Tendsto (λ n => μ {x | ε ≤ |f n x - g x|}) Filter.atTop (𝓝 0)) :
    ∃ (n : ℕ → ℕ), StrictMono n ∧ ∀ᵐ x ∂μ,
      Filter.Tendsto (λ k => f (n k) x) Filter.atTop (𝓝 (g x)) := by
  sorry

/-- #eval: MCT preserves L^p convergence -/
#eval "MCT: if f_n ↗ f in L^p, then ‖f_n - f‖_p → 0"

/-- #eval: DCT preserves L^p convergence -/
#eval "DCT: dominated convergence in L^p implies ‖f_n - f‖_p → 0"

/-- #eval: L^p is complete (Riesz-Fischer) -/
#eval "Every Cauchy sequence in L^p converges to an L^p limit"

end MiniLebesgueIntegration
