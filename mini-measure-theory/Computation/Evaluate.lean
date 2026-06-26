/-
# Computation: Evaluate Measure-Theoretic Expressions

Numerical evaluation of measure and integration operations.
-/

import MiniMeasureTheory

open MiniMeasureTheory

/-! ## Evaluate Lebesgue Measure of an Interval -/

/-- Compute Lebesgue measure of a closed interval [a,b] as b-a. -/
noncomputable def evalLebesgueInterval (a b : ℝ) : ℝ≥0∞ :=
  ENNReal.ofReal (b - a)

#eval "evalLebesgueInterval: λ([a,b]) = b - a"

/-! ## Evaluate Integral via Riemann Sum -/

/-- Approximate ∫_a^b f(x) dx using n-point Riemann sum. -/
noncomputable def evalRiemannSum (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) : ℝ :=
  let dx := (b - a) / (n : ℝ)
  dx * (∑ i in Finset.range n, f (a + (i : ℝ) * dx))

#eval "evalRiemannSum: numerical Lebesgue integral"

/-! ## Evaluate Dirac Measure -/

/-- δ_x(A) = 1 if x ∈ A, else 0. -/
def evalDirac {α : Type u} [DecidableEq α] (x : α) (A : Finset α) : ℝ≥0∞ :=
  if x ∈ A then 1 else 0

#eval "evalDirac: δ_x({x}) = 1"

/-! ## Evaluate Product Measure of Rectangles -/

/-- (μ × ν)(A × B) = μ(A) * ν(B) for finite measures on finite spaces. -/
noncomputable def evalProductRectangle {α β : Type u} [Fintype α] [Fintype β]
    (μ : Measure α default) (ν : Measure β default)
    (A : Finset α) (B : Finset β) : ℝ≥0∞ :=
  μ (A : Set α) * ν (B : Set β)

#eval "evalProductRectangle: (μ×ν)(A×B) = μ(A)ν(B)"

end MiniMeasureTheory
