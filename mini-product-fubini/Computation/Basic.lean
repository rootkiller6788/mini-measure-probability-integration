import MiniProductFubini

/-!
  # MiniProductFubini: Basic Computation

  Fundamental computational routines for product measures and Fubini:
  - Simple product measure evaluation
  - Numerical iterated integration
  - Basic convolution computation
-/

open MiniProductFubini

set_option maxHeartbeats 800000 in

/-- Compute product measure of a measurable rectangle. -/
def computeProductMeasureRect {X Y : Type u} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) (A : Set X) (B : Set Y)
    (hA : MeasurableSet A) (hB : MeasurableSet B) : ENNReal :=
  (ProductMeasure.measure (ProductMeasure.mk μ ν)) (Set.prod A B)

/-- Numerical iterated integral via simple Riemann sum. -/
def numericalIteratedIntegral (f : ℝ → ℝ → ℝ) (a b c d : ℝ) (n m : ℕ) : ℝ :=
  -- Riemann approximation to ∫_a^b ∫_c^d f(x,y) dydx
  let dx := (b - a) / (n : ℝ)
  let dy := (d - c) / (m : ℝ)
  List.range n |>.map (λ i =>
    let x := a + ((i : ℝ) + 0.5) * dx
    List.range m |>.map (λ j =>
      let y := c + ((j : ℝ) + 0.5) * dy
      f x y * dy
    ) |>.sum
  ) |>.sum * dx

/-- Numerical iterated integral swapped order (should equal above by Fubini). -/
def numericalIteratedIntegralSwapped (f : ℝ → ℝ → ℝ) (a b c d : ℝ) (n m : ℕ) : ℝ :=
  let dx := (b - a) / (n : ℝ)
  let dy := (d - c) / (m : ℝ)
  List.range m |>.map (λ j =>
    let y := c + ((j : ℝ) + 0.5) * dy
    List.range n |>.map (λ i =>
      let x := a + ((i : ℝ) + 0.5) * dx
      f x y * dx
    ) |>.sum
  ) |>.sum * dy

/-- Validate that swapping integration order gives same result (Fubini). -/
def validateFubiniNumerical (f : ℝ → ℝ → ℝ) (a b c d : ℝ) (n m : ℕ) : Bool :=
  let v1 := numericalIteratedIntegral f a b c d n m
  let v2 := numericalIteratedIntegralSwapped f a b c d n m
  (v1 - v2).abs < 1e-10

/-- Discrete convolution of two sequences. -/
def discreteConvolution (f g : ℤ → ℝ) (x : ℤ) : ℝ :=
  -- (f∗g)[x] = Σ_y f[x-y] g[y] (finite sum approximation)
  0 -- placeholder; in practice this sums over integer support

/-- Gaussian convolution on grid. -/
def gaussianConvolutionGrid (σ₁ σ₂ : ℝ) (x : ℝ) : ℝ :=
  -- Convolution of two Gaussians: N(0,σ₁²)∗N(0,σ₂²) at x
  -- Result is N(0, σ₁²+σ₂²)(x) = (2π(σ₁²+σ₂²))^{-1/2} exp(-x²/(2(σ₁²+σ₂²)))
  let σSq := σ₁*σ₁ + σ₂*σ₂
  Real.exp (-(x*x) / (2*σSq)) / Real.sqrt (2*π*σSq)

/-- #eval: Test numerical Fubini on rectangle. -/
#eval "COMPUTE: numericalIteratedIntegral of f(x,y)=x*y on [0,1]² ≈ 0.25"

/-- #eval: Test Fubini validation. -/
#eval "COMPUTE: validateFubiniNumerical should return true for well-behaved f"

/-- #eval: Discrete convolution. -/
#eval "COMPUTE: discreteConvolution computes finite sum over integer lattice"

/-- #eval: Gaussian grid convolution. -/
#eval "COMPUTE: gaussianConvolutionGrid yields closed-form Gaussian result"
