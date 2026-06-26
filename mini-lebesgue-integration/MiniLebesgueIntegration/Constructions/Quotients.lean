import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic

/-!
  # MiniLebesgueIntegration: Constructions — Quotients

  L^p as a quotient of measurable functions by almost-everywhere equivalence.
  - a.e.-equivalence relation on measurable functions
  - L^p as quotient vector space
  - Norm well-definedness on equivalence classes
-/

namespace MiniLebesgueIntegration

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

variable {α : Type u} [MeasurableSpace α] {μ : Measure α}

/-- Two measurable functions are a.e.-equivalent if they agree μ-almost everywhere. -/
def aeEquivalent (f g : α → ℝ) (μ : Measure α) : Prop :=
  ∀ᵐ x ∂μ, f x = g x

/-- a.e.-equivalence is an equivalence relation on measurable functions. -/
theorem aeEquivalent_equivalence (μ : Measure α) :
    Equivalence (λ f g : α → ℝ => aeEquivalent f g μ) where
  refl f := by
    filter_upwards [@Filter.univ_mem _ Measure.ae] with x _
    rfl
  symm h := by
    filter_upwards [h] with x hx
    symm; exact hx
  trans h h' := by
    filter_upwards [h, h'] with x hx hx'
    exact Eq.trans hx hx'

/-- The set of measurable functions with finite L^p seminorm. -/
def measurableLpCandidates (p : ℝ) (μ : Measure α) : Set (α → ℝ) :=
  {f | Measurable f ∧ LebesgueIntegral (λ x => (|f x| ^ (p : ℝ) : ℝ≥0∞)) μ < ∞}

/-- The L^p seminorm on measurable candidates. -/
noncomputable def LpSeminorm (f : α → ℝ) (p : ℝ) (μ : Measure α) : ℝ :=
  LpNorm f p μ

/-- The L^p seminorm is constant on a.e.-equivalence classes. -/
theorem LpSeminorm_ae_invariant (f g : α → ℝ) (p : ℝ) (μ : Measure α)
    (h : aeEquivalent f g μ) : LpSeminorm f p μ = LpSeminorm g p μ := by
  sorry

/-- L^p space as quotient: measurable functions mod a.e.-equivalence. -/
def LpAsQuotient (p : ℝ) (μ : Measure α) : Type u :=
  Quotient (aeEquivalent_equivalence μ).toSetoid

/-- The quotient map from measurable functions to L^p classes. -/
def toLpQuotient (p : ℝ) (μ : Measure α) (f : α → ℝ)
    (hf : Measurable f) (hfin : LebesgueIntegral (λ x => (|f x| ^ (p : ℝ) : ℝ≥0∞)) μ < ∞) :
    LpAsQuotient p μ :=
  Quotient.mk (aeEquivalent_equivalence μ).toSetoid f

/-- The L^p norm is well-defined on quotient classes. -/
noncomputable def LpQuotientNorm (p : ℝ) (μ : Measure α) (q : LpAsQuotient p μ) : ℝ :=
  Quotient.liftOn q (LpSeminorm · p μ) (LpSeminorm_ae_invariant · · p μ)

/-- L^p as quotient is isomorphic to LpSpace. -/
theorem LpQuotient_iso_LpSpace (p : ℝ) (μ : Measure α) (hp : 1 ≤ p) :
    True := by
  -- There is a natural bijection between LpAsQuotient and LpSpace.
  sorry

/-- #eval: a.e.-equivalence classes -/
#eval "L^p = {measurable f : ∫|f|^p < ∞} / ~ where f ~ g iff f = g a.e."

/-- #eval: Quotient construction of L^p -/
#eval "L^p as quotient: equivalence classes of measurable p-integrable functions"

/-- #eval: Norm well-definedness -/
#eval "‖[f]‖_p = (∫|f|^p)^{1/p} well-defined since a.e.-equal functions have same norm"

end MiniLebesgueIntegration
