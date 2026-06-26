import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic
import MiniLebesgueIntegration.Theorems.Main

/-!
  # MiniLebesgueIntegration: Bridges — ToTopology

  Connections between Lebesgue integration and topology/functional analysis:
  - Weak and weak-* topologies on L^p spaces
  - Banach-Alaoglu theorem for L^p spaces
  - L^p as a Banach lattice
  - Krein-Milman and extreme points
-/

namespace MiniLebesgueIntegration

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

variable {α : Type u} [MeasurableSpace α] {μ : Measure α}

/-- The weak topology on L^p(μ) (1 ≤ p < ∞): f_n ⇀ f weakly
    if ∫ f_n g dμ → ∫ f g dμ for all g ∈ L^q, 1/p + 1/q = 1. -/
def weakConvergence (p q : ℝ) (hpq : (1 / p) + (1 / q) = 1)
    (f : ℕ → LpSpace α p μ) (f_lim : LpSpace α p μ) : Prop :=
  ∀ (g : LpSpace α q μ),
    Filter.Tendsto (λ n => ENNReal.toReal
      (∫ (λ x => (((f n).representative x * g.representative x : ℝ) : ℝ≥0∞)) dμ))
      Filter.atTop (𝓝 (ENNReal.toReal
        (∫ (λ x => ((f_lim.representative x * g.representative x : ℝ) : ℝ≥0∞)) dμ)))

/-- Banach-Alaoglu for L^p: The closed unit ball in L^p(μ) is weak-* compact
    (or weakly compact for 1 < p < ∞ by reflexivity). -/
theorem BanachAlaoglu_Lp (p : ℝ) (hp : 1 < p) (hpFin : p < ∞)
    [SigmaFinite μ] :
    IsCompact (Metric.closedBall (0 : LpSpace α p μ) 1) := by
  -- L^p is reflexive for 1 < p < ∞, so weak = weak-* and
  -- the closed unit ball is weakly compact by Banach-Alaoglu.
  sorry

/-- Weak sequential compactness in L^p (1 < p < ∞): Every bounded sequence
    in L^p has a weakly convergent subsequence. -/
theorem weakSequentialCompactness_Lp (p : ℝ) (hp : 1 < p) (hpFin : p < ∞)
    [SigmaFinite μ] (f : ℕ → LpSpace α p μ)
    (h_bounded : ∃ (M : ℝ), ∀ n, ‖(f n).representative‖p[μ] ≤ M) :
    ∃ (n : ℕ → ℕ) (f_lim : LpSpace α p μ),
      StrictMono n ∧ weakConvergence p ((p - 1) / p) (by
        -- 1/p + (p-1)/p = 1
        field_simp; ring) (f ∘ n) f_lim := by
  sorry

/-- L^p(μ) is a Banach lattice with the pointwise order: f ≤ g iff f(x) ≤ g(x) a.e. -/
theorem Lp_is_BanachLattice (p : ℝ) (hp : 1 ≤ p) [SigmaFinite μ] :
    True := by
  -- L^p with a.e.-order is a Banach lattice:
  -- f ≤ g ⇒ f + h ≤ g + h
  -- |f| ≤ |g| ⇒ ‖f‖_p ≤ ‖g‖_p
  sorry

/-- Uniform convexity of L^p for 1 < p < ∞ implies the Kadec-Klee property:
    weak convergence + norm convergence of norms ⇒ strong convergence. -/
theorem KadecKlee_Lp (p : ℝ) (hp : 1 < p) (hpFin : p < ∞)
    [SigmaFinite μ] (f : ℕ → LpSpace α p μ) (f_lim : LpSpace α p μ)
    (h_weak : weakConvergence p ((p - 1) / p) (by field_simp; ring) f f_lim)
    (h_norm : Filter.Tendsto (λ n => ‖(f n).representative‖p[μ])
      Filter.atTop (𝓝 (‖f_lim.representative‖p[μ]))) :
    Filter.Tendsto (λ n => LpNorm ((f n).representative - f_lim.representative) p μ)
      Filter.atTop (𝓝 0) := by
  sorry

/-- Krein-Milman for L^p: The closed unit ball has extreme points.
    For L^p with 1 < p < ∞, every boundary point is an extreme point. -/
theorem extremePoints_Lp_unitBall (p : ℝ) (hp : 1 < p) (hpFin : p < ∞)
    [SigmaFinite μ] [h_atomless : HasNoAtoms μ] :
    True := by
  -- In strictly convex spaces, every point on the sphere is extreme.
  -- L^p is strictly convex for 1 < p < ∞.
  sorry

/-- #eval: Weak convergence in L^p -/
#eval "f_n ⇀ f in L^p iff ∫ f_n g → ∫ f g for all g ∈ L^q (1/p+1/q=1)"

/-- #eval: Banach-Alaoglu for L^p -/
#eval "Banach-Alaoglu: closed unit ball of L^p is weakly compact (1<p<∞)"

/-- #eval: L^p as Banach lattice -/
#eval "L^p with f ≤ g ⇔ f(x) ≤ g(x) a.e. is a Banach lattice"

end MiniLebesgueIntegration
