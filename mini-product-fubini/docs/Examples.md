# MiniProductFubini - Examples

## Standard Examples

### Fubini on a Rectangle
For f(x,y) = xy on [0,1]²:
```
∫₀¹∫₀¹ xy dydx = ∫₀¹∫₀¹ xy dxdy = 1/4
```
Both iterated integrals equal by Fubini/Tonelli.

### Gaussian Integral
Using Fubini and polar coordinates:
```
I² = (∫_{-∞}^∞ e^{-x²} dx)² = ∫∫ e^{-(x²+y²)} dxdy
   = ∫₀^{2π}∫₀^∞ e^{-r²} r dr dθ = π
```
Hence I = √π.

### Convolution of Indicators
```
(1_{[-1,1]} ∗ 1_{[-1,1]})(x) = max(0, 2-|x|)
```
A triangular function. ‖1_{[-1,1]}‖₁ = 2, ‖1_{[-1,1]}∗1_{[-1,1]}‖₁ = 4.

### Gaussian Convolution Semigroup
```
N(0,σ₁²) ∗ N(0,σ₂²) = N(0, σ₁²+σ₂²)
```
Gaussians form a convolution semigroup with variance addition.

## Counterexamples

### Fubini Fails Without Sigma-Finiteness
Consider μ = Lebesgue, ν = counting measure on [0,1].
For f(x,y) = 1_{x=y}:
- ∫∫ f dμ dν = 0 (each x has f(x,y)=0 for μ-a.e. y)
- ∫∫ f dν dμ = 1 (each y has f(x,y)=1 at x=y, counting gives 1)
These disagree because counting measure is not σ-finite on [0,1].

### Tonelli Needs Nonnegativity or Integrability
For f(x,y) = (x²-y²)/(x²+y²)² on (0,1)²:
- ∫₀¹∫₀¹ f dxdy = π/4
- ∫₀¹∫₀¹ f dydx = -π/4
Different! f is not integrable on (0,1)².

### Convolution L¹∗L∞
f = 1_{[0,1]} ∈ L¹(ℝ), g = 1 ∈ L∞(ℝ) but not L¹.
f∗g(x) = ∫ 1_{[0,1]}(x-y)·1 dy = 1 (constant function).
Result: f∗g = 1 ∉ L¹(ℝ). Convolution of L¹ and L∞ can leave L¹.

## Computational Examples

### Numerical Fubini Validation
```lean
validateFubiniNumerical (λ x y => x*y) 0 1 0 1 100 100
-- Returns true: both iterated integrals ≈ 0.25
```

### FFT Convolution
```lean
-- Convolution of two 1D signals of length N
-- Direct: O(N²) operations
-- FFT: O(N log N) operations
-- Speedup for N=1024: ~100x
```

### Sparse Grid Integration
```lean
-- Integrate f: ℝ¹⁰ → ℝ
-- Tensor product with 100 points/dim: 100^10 = 10^20 points (impossible)
-- Sparse grid level 5: ~10^5 points (feasible)
```
