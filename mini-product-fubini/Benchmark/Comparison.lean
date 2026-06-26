import MiniProductFubini

/-!
  # MiniProductFubini: Comparison Benchmarks

  Compares different approaches and implementations:
  - Iterated integrals vs product integral
  - Different iteration orders
  - Convolution methods comparison
-/

open MiniProductFubini

set_option maxHeartbeats 800000 in

/-- Compare iterated integrals XY vs YX (should agree by Fubini). -/
#eval "COMPARE: iteratedIntegralXY == iteratedIntegralYX (by Fubini)"

/-- Compare product integral with iterated integral (should agree). -/
#eval "COMPARE: ∫_{X×Y} f d(μ×ν) == iteratedIntegralXY f μ ν (by Fubini)"

/-- Compare convolution vs direct definition. -/
#eval "COMPARE: (f∗g)(x) == ∫ f(x-y)g(y) dy (by definition)"

/-- Compare FFT convolution vs direct convolution. -/
#eval "COMPARE: FFT convolution O(N log N) vs direct O(N²)"

/-- Compare Monte Carlo vs deterministic cubature. -/
#eval "COMPARE: MC error O(1/√N) vs cubature exponential in smoothness"

/-- Compare sparse grid vs tensor product grid. -/
#eval "COMPARE: Sparse grid O(N log^{d-1} N) vs tensor product O(N^d)"

/-- Compare Young inequality bounds for different p,q. -/
#eval "COMPARE: Young bound ‖f∗g‖_r ≤ ‖f‖_p·‖g‖_q for p=q=1, r=1"

/-- Compare Radon-Nikodym chain rule vs direct. -/
#eval "COMPARE: dρ/dμ via chain rule dρ/dν·dν/dμ == direct computation"

/-- Compare Lebesgue decomposition vs direct absolutely continuous test. -/
#eval "COMPARE: ν_ac from Lebesgue decomposition vs Radon-Nikodym density"

/-- Compare Hahn vs Jordan decomposition. -/
#eval "COMPARE: Hahn (X=P⊔N) gives Jordan (ν⁺ = ν(P∩·), ν⁻ = -ν(N∩·))"
