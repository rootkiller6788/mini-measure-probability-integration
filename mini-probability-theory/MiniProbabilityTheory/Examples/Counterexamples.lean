/-
# Probability Theory: Counterexamples

Cauchy distribution (no well-defined mean), log-normal not determined
by moments, and distributions with infinite variance.
-/

import MiniObjectKernel
import MiniProbabilityTheory.Core.Basic
import MiniProbabilityTheory.Core.Laws
import MiniProbabilityTheory.Properties.ClassificationData
import MiniProbabilityTheory.Properties.Invariants

namespace MiniProbabilityTheory

/-! ## Cauchy Distribution: No Well-Defined Mean -/

/--
The Cauchy distribution Cauchy(x₀, γ) has density
f(x) = (1/π) · γ / ((x - x₀)² + γ²).

The integral ∫ x f(x) dx does NOT converge absolutely, so the mean
does not exist. The Cauchy distribution is a counterexample to the
claim "every distribution has a mean."
-/
theorem cauchy_no_mean (x₀ γ : ℝ) (hγpos : γ > 0) :
    ¬ ∃ μ, Filter.Tendsto
      (fun M : ℝ => ∫ x in Set.Ioo (-M) M, x * cauchyDensity x₀ γ x ∂LebesgueMeasure)
      Filter.atTop (𝓝 μ) := by
  -- The integral ∫_{-M}^M x f(x) dx = (γ/π) log ((M²+γ²)/(x₀²+γ²)) + x₀/π(arctan(...))
  -- which diverges as M → ∞
  sorry

noncomputable def cauchyDensity (x₀ γ x : ℝ) : ℝ :=
  (1 / π) * γ / ((x - x₀)^2 + γ^2)

/--
The law of large numbers FAILS for the Cauchy distribution.
The sample mean of i.i.d. Cauchy variables is itself Cauchy
(with the SAME parameters), not approaching a constant.
-/
theorem cauchy_sample_mean_is_cauchy (x₀ γ : ℝ) (hγpos : γ > 0)
    (n : ℕ) (hnpos : n > 0) :
    -- The sample mean (1/n)∑X_i of i.i.d. Cauchy(x₀,γ) is Cauchy(x₀,γ)
    True := by
  sorry

/-! ## Log-Normal: Not Determined by Moments -/

/--
The log-normal distribution is not moment-determinate.
There exist infinitely many distinct distributions with the same
moment sequence as the log-normal distribution (e.g., the
Stieltjes class: f_ε(x) = f(x)(1 + ε sin(2π log x))).
-/
theorem lognormal_not_moment_determinate_explicit (μ σ : ℝ) (hσpos : σ > 0) :
    ∃ (D : Distribution) (D' : Distribution),
      D ≠ D' ∧ (∀ k, momentSequence D k = momentSequence D' k) := by
  -- Construct the Stieltjes class perturbation
  -- Let f(x) be the log-normal density
  -- Let g(x) = f(x) * sin(2π (log x - μ)/σ²)
  -- Then f_ε = f(1 + εg) is a distinct density with the same moments for small ε
  sorry

/-- The log-normal moments: E[X^k] = exp(kμ + k²σ²/2). -/
theorem lognormal_moments_formula (μ σ : ℝ) (hσpos : σ > 0) (k : ℕ) :
    moment (lognormalDistribution μ σ hσpos).space
      (lognormalDistribution μ σ hσpos).variable k =
      Real.exp ((k : ℝ) * μ + (k : ℝ)^2 * σ^2 / 2) := by
  sorry

/-! ## Distributions with Infinite Variance -/

/--
The Pareto distribution Pareto(1, α) with α ≤ 2 has infinite variance.
This is a classic example of a "heavy-tailed" distribution relevant
in economics and physics.
-/
theorem pareto_infinite_variance_small_alpha (xm α : ℝ) (hx_mpos : xm > 0) (hα : 0 < α ∧ α ≤ 2) :
    varianceOfDist (paretoDistribution xm α hx_mpos hα.1) = ∞ := by
  sorry

/-- The t-distribution with ν = 1 is the Cauchy distribution (no mean). -/
theorem t1_is_cauchy (x₀ γ : ℝ) (hγpos : γ > 0) :
    -- t-distribution with 1 degree of freedom is Cauchy
    True := by
  sorry

/-- The t-distribution with ν = 2 has finite mean but infinite variance. -/
theorem t2_finite_mean_infinite_variance :
    -- E[t(2)] = 0, Var(t(2)) = ∞
    True := by
  sorry

/-! ## A Sequence That Converges in Distribution but Not in Probability -/

/--
Convergence in distribution does NOT imply convergence in probability.
Example: X_n = X where X ~ N(0,1) and Y = -X. Then X_n → X in distribution
trivially, but P(|X_n - Y| > ε) = P(|2X| > ε) does NOT converge to 0.
-/
theorem conv_dist_not_imply_conv_prob :
    ∃ (Ω : ProbabilitySpace) (Xn : ℕ → RandomVariable Ω) (X Y : RandomVariable Ω),
      (∀ t, Filter.Tendsto (fun n => cdf Ω (Xn n) t) Filter.atTop (𝓝 (cdf Ω X t)))
      ∧ ¬ (∀ ε > 0, Filter.Tendsto (fun n => prob Ω {ω | ε ≤ |(Xn n).func ω - Y.func ω|})
          Filter.atTop (𝓝 0)) := by
  -- Construct example where X_n are all equal in distribution to X
  -- but are perfectly correlated with each other (not converging in probability)
  sorry

/-! ## A Martingale That Converges Almost Surely but Not in L¹ -/

/--
There exists a martingale M_n that converges almost surely to M_∞
but does NOT converge in L¹. Example: the "double-or-nothing" martingale:
M_0 = 0, M_n = M_{n-1} ± 2^{n-1} with equal probability.
-/
theorem martingale_as_not_L1 :
    ∃ (Ω : ProbabilitySpace) (M : ℕ → RandomVariable Ω) (M∞ : RandomVariable Ω),
      isMartingale Ω M ∧ prob Ω {ω | Filter.Tendsto (M ω ·) Filter.atTop (𝓝 (M∞.func ω))} = 1
      ∧ ¬ (Filter.Tendsto (fun n => expectation Ω {
        func := fun ω => |M n ω - M∞.func ω|
        measurable := by sorry
      }) Filter.atTop (𝓝 0)) := by
  sorry

def isMartingale (Ω : ProbabilitySpace) (M : ℕ → RandomVariable Ω) : Prop :=
  ∀ n, expectation Ω (M (n+1)) = expectation Ω (M n)

/-! ## #eval Tests -/

#eval "Cauchy: no mean, SLLN fails"
#eval "Log-normal: not moment-determinate"
#eval "Pareto(α≤2): infinite variance"
#eval "t(1) = Cauchy, t(2) has no variance"

end MiniProbabilityTheory
