/-
# Probability Theory: Morphism Equivalences

Wasserstein distance, total variation distance, and other metrics
on probability measures and random variables.
-/

import MiniObjectKernel
import MiniProbabilityTheory.Core.Basic

namespace MiniProbabilityTheory

/-! ## Total Variation Distance -/

/--
The total variation distance between two probability measures
μ and ν on the same measurable space:
d_TV(μ, ν) = sup_{A measurable} |μ(A) - ν(A)|.
-/
noncomputable def totalVariationDistance (Ω : ProbabilitySpace)
    (μ ν : Measure Ω.sampleSpace) : ℝ :=
  sSup { |μ A - ν A| | (A : Set Ω.sampleSpace) (_ : Measurable A) }

/-- Total variation distance satisfies the triangle inequality. -/
theorem totalVariation_triangle (Ω : ProbabilitySpace) (μ ν ξ : Measure Ω.sampleSpace) :
    totalVariationDistance Ω μ ξ ≤
      totalVariationDistance Ω μ ν + totalVariationDistance Ω ν ξ := by
  sorry

/-- Total variation between the distributions of two random variables. -/
noncomputable def totalVariationRV (Ω₁ Ω₂ : ProbabilitySpace)
    (X : RandomVariable Ω₁) (Y : RandomVariable Ω₂) : ℝ :=
  -- Use any probability space that couples both, or compare on ℝ
  totalVariationDistance (ℝ_as_prob_space) (distribution Ω₁ X) (distribution Ω₂ Y)
  where ℝ_as_prob_space : ProbabilitySpace := sorry

/-! ## Wasserstein Distance (1st Order) -/

/--
The 1-Wasserstein distance (Earth Mover's distance) between two
probability measures μ and ν on ℝ:
W_1(μ, ν) = inf_{couplings γ} ∫ |x - y| dγ(x, y).
-/
noncomputable def wassersteinDistance (Ω₁ Ω₂ : ProbabilitySpace)
    (X : RandomVariable Ω₁) (Y : RandomVariable Ω₂) : ℝ :=
  sInf { d : ℝ | ∃ (Ω : ProbabilitySpace) (X' Y' : RandomVariable Ω),
    X' ≗ X ∧ Y' ≗ Y ∧ expectation Ω { func := fun ω => |X'.func ω - Y'.func ω|
      measurable := by sorry
    } = d }

/-- The Wasserstein distance metrizes weak convergence plus
    convergence of first moments. -/
theorem wasserstein_metrizes_weak_convergence (μn : ℕ → Distribution) (μ : Distribution) :
    (Filter.Tendsto (fun n => wassersteinDistribution (μn n) μ) Filter.atTop (𝓝 0))
    ↔ WeakConvergence (μn ·) μ := by
  sorry

noncomputable def wassersteinDistribution (μ ν : Distribution) : ℝ :=
  sorry

def WeakConvergence (μn : ℕ → Distribution) (μ : Distribution) : Prop :=
  sorry

/-! ## Kullback-Leibler Divergence -/

/--
The KL divergence (relative entropy) of ν with respect to μ:
D_KL(μ ‖ ν) = ∫ log(dμ/dν) dμ if μ ≪ ν, +∞ otherwise.
-/
noncomputable def klDivergence (Ω : ProbabilitySpace)
    (μ ν : Measure Ω.sampleSpace) : ℝ :=
  if h : AbsolutelyContinuous μ ν then
    ∫ ω, Real.log (RadonNikodymDerivative μ ν ω) ∂μ
  else
    -1  -- sentinel for +∞ (KL divergence is nonnegative, so -1 means infinite)

/-- KL divergence is nonnegative (Gibbs' inequality). -/
theorem klDivergence_nonneg (Ω : ProbabilitySpace) (μ ν : Measure Ω.sampleSpace) :
    0 ≤ klDivergence Ω μ ν := by
  sorry

/-! ## Hellinger Distance -/

/--
The Hellinger distance between two probability measures with densities
f, g (w.r.t. a common dominating measure):
H²(μ, ν) = (1/2) ∫ (√f - √g)² dλ.
-/
noncomputable def hellingerDistance (Ω : ProbabilitySpace)
    (μ ν : Measure Ω.sampleSpace) : ℝ :=
  -- Assume both are absolutely continuous w.r.t. Lebesgue
  sorry

/-- Hellinger distance satisfies 0 ≤ H² ≤ 1 for probability measures. -/
theorem hellinger_bounds (Ω : ProbabilitySpace) (μ ν : Measure Ω.sampleSpace) :
    0 ≤ hellingerDistance Ω μ ν ∧ hellingerDistance Ω μ ν ≤ 1 := by
  sorry

/-! ## #eval Tests -/

#eval "totalVariationDistance defined"
#eval "wassersteinDistance (Earth Mover) defined"
#eval "klDivergence defined"
#eval "hellingerDistance defined"

/-- Define two simple distributions for comparison. -/
def simpleMeasureA : Measure ℝ := {
  measureOf := fun S => if (0 : ℝ) ∈ S then 1 else 0
  measureEmpty := by simp
  measureUnion := by
    intro f hfdisj henum
    sorry
}

#eval "totalVariation, Wasserstein, KL, Hellinger distances declared"

end MiniProbabilityTheory
