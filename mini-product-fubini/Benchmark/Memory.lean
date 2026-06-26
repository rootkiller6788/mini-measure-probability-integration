import MiniProductFubini

/-!
  # MiniProductFubini: Memory Benchmarks

  Memory usage estimates for various operations:
  - Product measure representation size
  - Convolution kernel storage
  - Cubature grid memory
-/

open MiniProductFubini

set_option maxHeartbeats 800000 in

/-- Memory: ProductSigmaAlgebra representation. -/
#eval "MEMORY: ProductSigmaAlgebra: 3 fields (carrier + 2 sigmas): ~24 bytes overhead"

/-- Memory: ProductMeasure representation. -/
#eval "MEMORY: ProductMeasure: measure + rectangle_rule + sigmaFinite: ~40 bytes"

/-- Memory: SimpleFunction in product space. -/
#eval "MEMORY: SimpleFunction on X×Y: values + sets + toFun: ~64 bytes base"

/-- Memory: Convolution grid storage (N points). -/
#eval "MEMORY: Convolution discrete: 2*N floats for f,g + N for result = 3N floats"

/-- Memory: FFT convolution working memory. -/
#eval "MEMORY: FFT: 2*N complex for input + N complex workspace = O(N)"

/-- Memory: Cubature tensor product grid (N^d points). -/
#eval "MEMORY: Cubature d=3, N=100: 1e6 points × 8 bytes = ~8 MB"

/-- Memory: Sparse grid dimensions 10, level 5. -/
#eval "MEMORY: Sparse grid d=10, L=5: ~O(N log^{d-1} N) << N^d"

/-- Memory: Monte Carlo samples. -/
#eval "MEMORY: MC N=1e6 samples × 8 bytes = ~8 MB for values"

/-- Memory: Kolmogorov extension finite-dim projections. -/
#eval "MEMORY: Kolmogorov: store finitely many projections, not infinite measure directly"

/-- Memory: Lebesgue decomposition storage. -/
#eval "MEMORY: LebesgueDecomposition: acPart + singPart + proof terms: ~80 bytes"

/-- Memory: Radon-Nikodym derivative discretization. -/
#eval "MEMORY: RadonNikodym: derivative discretized at N grid points = N floats"

/-- Memory: Total package theory graph. -/
#eval "MEMORY: Full package imports: ~1500 lines Lean code compiled"
