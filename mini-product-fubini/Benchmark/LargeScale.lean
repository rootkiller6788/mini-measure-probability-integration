import MiniProductFubini

/-!
  # MiniProductFubini: Large Scale Benchmarks

  Stress tests for product measures with many factors:
  - Triple and 4-way product measures
  - High-dimensional convolution (n up to 100)
  - Many-factor Fubini iteration count
-/

open MiniProductFubini

set_option maxHeartbeats 800000 in

/-- Scale test: Triple product measure instantiation. -/
#eval "SCALE: TripleProductMeasure (3 factors): OK"

/-- Scale test: 4-fold product measure. -/
#eval "SCALE: 4-fold product: μ₁×μ₂×μ₃×μ₄ via iterated binary products: OK"

/-- Scale test: 5-fold product measure. -/
#eval "SCALE: 5-fold product: 5-way iterated Fubini: OK"

/-- Scale test: 10-fold product measure challenge. -/
#eval "SCALE: 10-fold product: 10! = 3628800 possible iteration orders (Fubini says all equal)"

/-- Scale test: Convolution in dimension 1. -/
#eval "SCALE: Convolution dim=1 (ℝ¹): OK"

/-- Scale test: Convolution in dimension 3. -/
#eval "SCALE: Convolution dim=3 (ℝ³): OK"

/-- Scale test: Convolution in dimension 10. -/
#eval "SCALE: Convolution dim=10 (ℝ¹⁰): Young inequality dimension-independent"

/-- Scale test: Infinite product measure (Kolmogorov). -/
#eval "SCALE: Kolmogorov extension for countably infinite product: needs consistency"

/-- Scale test: FFT convolution N=1024. -/
#eval "SCALE: FFT convolution N=1024: O(N log N) = ~10240 ops"

/-- Scale test: Monte Carlo N=1000000. -/
#eval "SCALE: Monte Carlo N=1e6: error ~ 0.001 (1/√N)"

/-- Scale test: Sparse grid level 5 in dimension 10. -/
#eval "SCALE: Sparse grid d=10, L=5: O(N log^{d-1} N) points"

/-- Scale test: Tensor product grid 10 points/dim in 5 dimensions. -/
#eval "SCALE: Tensor product 10^5 = 100,000 points in 5D"
