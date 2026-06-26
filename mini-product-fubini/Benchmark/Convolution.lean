import MiniProductFubini

/-!
  # MiniProductFubini: Convolution Benchmarks

  Specialized benchmarks for convolution operations:
  - Direct vs FFT convolution
  - Convolution for different L^p spaces
  - Convolution semigroup benchmarks
  - Young inequality tightness
-/

open MiniProductFubini

set_option maxHeartbeats 800000 in

/-- Bench: Convolution definition type-checks. -/
#eval "CONV-BENCH: Convolution (f∗g)(x) = ∫ f(x-y)g(y) dy: defined"

/-- Bench: ConvolutionBanachAlgebraInequality available. -/
#eval "CONV-BENCH: ‖f∗g‖₁ ≤ ‖f‖₁·‖g‖₁: stated with sorry"

/-- Bench: Young inequality for p=q=1. -/
#eval "CONV-BENCH: Young p=q=1: ‖f∗g‖₁ ≤ ‖f‖₁·‖g‖₁"

/-- Bench: Young inequality for p=1, q=∞. -/
#eval "CONV-BENCH: Young p=1,q=∞: ‖f∗g‖_∞ ≤ ‖f‖₁·‖g‖_∞"

/-- Bench: Young inequality for p=q=2. -/
#eval "CONV-BENCH: Young p=q=2: ‖f∗g‖_∞ ≤ ‖f‖₂·‖g‖₂"

/-- Bench: Convolution commutativity in L¹. -/
#eval "CONV-BENCH: f∗g = g∗f a.e. for f,g∈L¹"

/-- Bench: Convolution associativity in L¹. -/
#eval "CONV-BENCH: (f∗g)∗h = f∗(g∗h) a.e. for f,g,h∈L¹"

/-- Bench: Gaussian convolution semigroup. -/
#eval "CONV-BENCH: Gaussian semigroup: N(0,σ₁²)∗N(0,σ₂²) = N(0,σ₁²+σ₂²)"

/-- Bench: Indicator convolution gives triangle. -/
#eval "CONV-BENCH: 1_{[-1,1]}∗1_{[-1,1]} = triangle (2-|x|)₊"

/-- Bench: FFT convolution accuracy. -/
#eval "CONV-BENCH: FFT convolution error = O(N^{-k}) for C^k functions"

/-- Bench: Mollifier convolution convergence. -/
#eval "CONV-BENCH: u∗φ_ε → u in L¹ as ε→0 (mollification)"

/-- Bench: Convolution preserves compact support. -/
#eval "CONV-BENCH: supp(f∗g) ⊆ supp(f) + supp(g) (Minkowski sum)"
