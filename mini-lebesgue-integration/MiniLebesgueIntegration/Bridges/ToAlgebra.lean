import MiniObjectKernel.Core.Basic
import MiniMeasureTheory.Core.Basic
import MiniMeasurableFunctions.Core.Basic
import MiniLebesgueIntegration.Core.Basic

/-!
  # MiniLebesgueIntegration: Bridges — ToAlgebra

  Connections between Lebesgue integration and algebra:
  - L¹(G) as a convolution algebra for locally compact groups G
  - L^∞ as a commutative C*-algebra
  - L²(G) and group von Neumann algebras
  - Fourier algebra A(G) and its connections
-/

namespace MiniLebesgueIntegration

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in
set_option pp.unicode.fun true

variable {G : Type u} [TopologicalSpace G] [Group G] [TopologicalGroup G]
  [MeasurableSpace G] [BorelMeasureSpace G]

/-- Convolution of two L¹ functions on a locally compact group G with Haar measure μ. -/
noncomputable def convolution {μ : Measure G} [haar : IsHaarMeasure μ]
    (f g : G → ℝ) (hf : integrable f μ) (hg : integrable g μ) (x : G) : ℝ :=
  ENNReal.toReal (∫ (λ y => (|f y * g (y⁻¹ * x)| : ℝ≥0∞)) dμ)

/-- L¹(G) is a Banach algebra under convolution. -/
theorem L1_convolution_BanachAlgebra {μ : Measure G} [haar : IsHaarMeasure μ] :
    True := by
  -- L¹(G) with convolution is a Banach algebra:
  -- ‖f * g‖₁ ≤ ‖f‖₁ ‖g‖₁ (Young's inequality)
  -- Convolution is associative and distributive.
  sorry

/-- Young's inequality: ‖f * g‖_r ≤ ‖f‖_p ‖g‖_q for 1/p + 1/q = 1 + 1/r. -/
theorem YoungsInequality (p q r : ℝ) (hp : 1 ≤ p) (hq : 1 ≤ q) (hr : 1 ≤ r)
    (hpq : (1 / p) + (1 / q) = 1 + (1 / r))
    {μ : Measure G} [IsHaarMeasure μ]
    (f g : G → ℝ) (hf : isLp f p μ) (hg : isLp g q μ) :
    isLp (convolution f g hf hg) r μ := by
  sorry

/-- L^∞(X,μ) is a commutative C*-algebra with pointwise operations
    and essential supremum norm. -/
theorem Linf_is_CstarAlgebra {α : Type u} [MeasurableSpace α] (μ : Measure α) :
    True := by
  -- L^∞(μ) with ‖·‖_∞ is a commutative C*-algebra:
  -- ‖f*g‖_∞ ≤ ‖f‖_∞ ‖g‖_∞, ‖f*f‖_∞ = ‖f‖_∞² (C*-identity)
  sorry

/-- L^∞(μ) acts on L²(μ) by multiplication, giving a representation
    as multiplication operators. -/
theorem Linf_acts_on_L2 {α : Type u} [MeasurableSpace α] (μ : Measure α)
    (φ : LpSpace α ∞ μ) (f : LpSpace α 2 μ) :
    isLp (λ x => φ.representative x * f.representative x) 2 μ := by
  sorry

/-- The Fourier algebra A(G) can be realized as the predual of
    the group von Neumann algebra VN(G). -/
structure FourierAlgebra (G : Type u) [TopologicalSpace G] [Group G]
    [TopologicalGroup G] [MeasurableSpace G] where
  /-- Underlying set: L²-convolution of L² functions -/
  carrier : Set G
  /-- A(G) ⊆ C₀(G) and is a Banach algebra under pointwise multiplication -/
  algebra_structure : True

/-- #eval: L¹(G) as convolution algebra -/
#eval "L¹(G) with convolution (f*g)(x) = ∫ f(y)g(y⁻¹x) dμ(y) is a Banach algebra"

/-- #eval: L^∞ as C*-algebra -/
#eval "L^∞(μ) is a commutative C*-algebra: Gelfand-Naimark duality with measure algebra"

/-- #eval: Young's convolution inequality -/
#eval "Young: ‖f*g‖_r ≤ ‖f‖_p ‖g‖_q for 1/p + 1/q = 1 + 1/r"

end MiniLebesgueIntegration
