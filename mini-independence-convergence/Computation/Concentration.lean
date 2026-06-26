/-
# Computation: Concentration Inequalities

Hoeffding, Bernstein, and Chernoff bounds for independent sums.
-/

import MiniIndependenceConvergence

namespace MiniIndependenceConvergence

/-! ## Hoeffding Bound Computation -/

def hoeffdingBound (ε : ℝ) (n : ℕ) (a b : ℝ) : ℝ :=
  -- P(|̄X - μ| ≥ ε) ≤ 2 exp(-2nε²/(b-a)²)
  let range := (b - a) ^ 2
  if range = 0 then 0
  else 2 * Real.exp (-2 * (n : ℝ) * ε ^ 2 / range)

def hoeffdingSampleSize (ε δ : ℝ) (a b : ℝ) (hε : ε > 0) (hδ : δ > 0) : ℕ :=
  -- n > (b-a)² log(2/δ) / (2ε²)
  let range := (b - a) ^ 2
  ⌈range * Real.log (2 / δ) / (2 * ε ^ 2)⌉.toNat

/-! ## Bernstein Bound -/

def bernsteinBound (ε : ℝ) (n : ℕ) (σ² v : ℝ) : ℝ :=
  -- P(|̄X - μ| ≥ ε) ≤ 2 exp(-nε²/(2σ² + 2vε/3))
  let denominator := 2 * σ² + 2 * v * ε / 3
  if denominator = 0 then 0
  else 2 * Real.exp (-(n : ℝ) * ε ^ 2 / denominator)

/-! ## Chernoff Bound for Bernoulli -/

def chernoffBernoulli (n : ℕ) (p ε : ℝ) : ℝ :=
  -- P(̄X ≥ p + ε) ≤ exp(-n D_KL(p+ε || p))
  -- where D_KL(q||p) = q log(q/p) + (1-q) log((1-q)/(1-p))
  let klDiv (q : ℝ) : ℝ :=
    q * Real.log (q / p) + (1 - q) * Real.log ((1 - q) / (1 - p))
  Real.exp (-(n : ℝ) * klDiv (p + ε))

/-! ## Union Bound with Bonferroni -/

def unionBoundBonferroni (probs : List ℝ) : ℝ :=
  -- P(∪ A_i) ≤ Σ P(A_i) (simple union bound)
  probs.sum

def bonferroniCorrection (α : ℝ) (m : ℕ) : ℝ :=
  -- For m tests, use α/m to control family-wise error rate
  α / (m : ℝ)

/-! ## #eval -/

#eval "── Computation/Concentration: Hoeffding, Bernstein, Chernoff ──"
#eval hoeffdingBound 0.1 100 0 1
#eval "Hoeffding bound for n=100, ε=0.1, [0,1] bounded"
#eval hoeffdingSampleSize 0.01 0.05 0 1 (by norm_num) (by norm_num)
#eval "Sample size for ε=0.01, δ=0.05"
#eval bernsteinBound 0.1 100 1 0.1
#eval "Bernstein bound"

end MiniIndependenceConvergence
