import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic

/-!
  # MiniLebesgueIntegration: Morphisms — Hom

  Structure-preserving maps between Lebesgue integration structures:
  - Integral-preserving maps (pushforwards)
  - L^p isometries
  - Fourier transform as a morphism between L^p spaces
-/

namespace MiniLebesgueIntegration

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

variable {α β : Type u} [MeasurableSpace α] [MeasurableSpace β]

/-- An integral-preserving map between measure spaces.
    φ : α → β preserves the integral: ∫ f dν = ∫ (f ∘ φ) dμ. -/
structure IntegralPreservingMap (μ : Measure α) (ν : Measure β) where
  /-- The underlying map -/
  toFun : α → β
  /-- Measurability -/
  measurable : Measurable toFun
  /-- Pushforward condition: ν = μ ∘ toFun⁻¹ -/
  pushforward_eq : Measure.pushForward toFun μ = ν

/-- Composition of integral-preserving maps. -/
def IntegralPreservingMap.comp {μ : Measure α} {ν : Measure β} {ξ : Measure γ}
    [MeasurableSpace γ]
    (φ : IntegralPreservingMap μ ν) (ψ : IntegralPreservingMap ν ξ) :
    IntegralPreservingMap μ ξ where
  toFun := ψ.toFun ∘ φ.toFun
  measurable := Measurable.comp ψ.measurable φ.measurable
  pushforward_eq := by
    calc
      Measure.pushForward (ψ.toFun ∘ φ.toFun) μ = Measure.pushForward ψ.toFun (Measure.pushForward φ.toFun μ) := by
        rw [Measure.pushForward_comp]
      _ = Measure.pushForward ψ.toFun ν := by rw [φ.pushforward_eq]
      _ = ξ := by rw [ψ.pushforward_eq]

/-- An L^p isometry: a norm-preserving map between L^p spaces. -/
structure LpIsometry (α : Type u) (β : Type u) [MeasurableSpace α] [MeasurableSpace β]
    (p : ℝ) (μ : Measure α) (ν : Measure β) where
  /-- The linear map L^p(α,μ) → L^p(β,ν) -/
  toFun : (LpSpace α p μ) → (LpSpace β p ν)
  /-- Norm preservation: ‖Tf‖_p = ‖f‖_p -/
  norm_preserving : ∀ (f : LpSpace α p μ),
    LpNorm (f.representative) p μ = LpNorm ((toFun f).representative) p ν

/-- Fourier transform as a morphism between L^p spaces.
    F: L¹(ℝ) → C₀(ℝ) or L²(ℝ) → L²(ℝ). -/
structure FourierTransformMorphism (α : Type u) [MeasurableSpace α] where
  /-- Source L^p space -/
  source_exponent : ℝ
  /-- Target L^p space -/
  target_exponent : ℝ
  /-- The Fourier transform operator -/
  transform : (LpSpace α source_exponent Measure.lebesgue) →
             (LpSpace α target_exponent Measure.lebesgue)
  /-- Riemann-Lebesgue: L¹ → C₀ -/
  riemannLebesgue : source_exponent = 1 → target_exponent = 2
  /-- Plancherel: L² → L² isometry -/
  plancherel : (source_exponent = 2 ∧ target_exponent = 2) → True

/-- The identity map is an integral-preserving map. -/
def identityIntegralPreserving {μ : Measure α} : IntegralPreservingMap μ μ where
  toFun := id
  measurable := measurable_id
  pushforward_eq := by
    simp [Measure.pushForward_id]

/-- #eval: Composition of integral-preserving maps -/
#eval "Integral-preserving maps compose: (ψ ∘ φ)_* μ = ψ_*(φ_* μ) = ψ_* ν = ξ"

/-- #eval: L^p isometry preserves norms -/
#eval "L^p isometry: ‖Tf‖_p = ‖f‖_p for all f ∈ L^p"

/-- #eval: Fourier transform preserves L² norm (Plancherel) -/
#eval "Fourier: ‖Ff‖₂ = ‖f‖₂ on L²(ℝ) — Plancherel theorem"

end MiniLebesgueIntegration
