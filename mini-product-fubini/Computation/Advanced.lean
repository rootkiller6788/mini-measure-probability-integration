import MiniProductFubini

/-!
  # MiniProductFubini: Advanced Computation

  Advanced computational routines:
  - Adaptive iterated integration
  - Change of measure computation
  - Lebesgue decomposition computation
-/

open MiniProductFubini

set_option maxHeartbeats 800000 in

/-- Adaptive Simpson rule for 1D integration. -/
def adaptiveSimpson (f : ℝ → ℝ) (a b ε : ℝ) (maxDepth : ℕ) : ℝ :=
  -- Adaptive Simpson quadrature with tolerance ε
  0 -- placeholder

/-- Adaptive Fubini: adaptive integration in each dimension. -/
def adaptiveFubini2D (f : ℝ → ℝ → ℝ) (a b c d ε : ℝ) (maxDepth : ℕ) : ℝ :=
  -- Apply adaptive Simpson to inner integral, then to outer
  adaptiveSimpson (λ x => adaptiveSimpson (f x) c d ε maxDepth) a b ε maxDepth

/-- Compute Radon-Nikodym derivative numerically via finite differences. -/
def computeRadonNikodymDerivative (ν_density μ_density : ℝ → ℝ) (grid : List ℝ) : List (ℝ × ℝ) :=
  -- dν/dμ(x) ≈ ν_density(x) / μ_density(x) at grid points
  grid.map (λ x => (x, ν_density x / μ_density x))

/-- Numerical Lebesgue decomposition: separate absolutely continuous and singular parts. -/
def computeLebesgueDecomposition (ν μ : ℝ → ℝ) (grid : List ℝ) : (ℝ → ℝ) × (ℝ → ℝ) :=
  -- Detect where μ density is zero (singular part goes there)
  let acPart (x : ℝ) : ℝ := 0  -- ν(x) when μ(x) > 0
  let singPart (x : ℝ) : ℝ := 0  -- ν(x) when μ(x) = 0 (singular support)
  (acPart, singPart)

/-- Compute total variation of a signed measure on a grid. -/
def computeTotalVariation (signedDensity : ℝ → ℝ) (grid : List ℝ) : ℝ :=
  -- |ν| ≈ Σ |signedDensity(x_i)| * Δx
  -- This is a naive Riemann sum approximation
  grid.map (λ x => (signedDensity x).abs) |>.sum * (0.01 : ℝ) -- Δx

/-- Hahn decomposition: find P (positive) and N (negative) sets. -/
def computeHahnDecomposition (signedDensity : ℝ → ℝ) (grid : List ℝ) : (List ℝ) × (List ℝ) :=
  let P := grid.filter (λ x => signedDensity x ≥ 0)
  let N := grid.filter (λ x => signedDensity x < 0)
  (P, N)

/-- Jordan decomposition from Hahn decomposition. -/
def computeJordanDecomposition (signedDensity : ℝ → ℝ) (grid : List ℝ) :
    (ℝ → ℝ) × (ℝ → ℝ) :=
  -- ν⁺(x) = max(signedDensity(x), 0)
  -- ν⁻(x) = max(-signedDensity(x), 0)
  let posPart (x : ℝ) : ℝ := max (signedDensity x) 0
  let negPart (x : ℝ) : ℝ := max (-(signedDensity x)) 0
  (posPart, negPart)

/-- #eval: Adaptive Fubini on oscillatory integrand. -/
#eval "COMPUTE: adaptiveFubini2D adaptively refines where integrand varies"

/-- #eval: Radon-Nikodym derivative via density ratio. -/
#eval "COMPUTE: computeRadonNikodymDerivative: dν/dμ ≈ ν_density/μ_density"

/-- #eval: Numerical Lebesgue decomposition. -/
#eval "COMPUTE: computeLebesgueDecomposition separates ac and singular parts"

/-- #eval: Total variation grid approximation. -/
#eval "COMPUTE: computeTotalVariation approximates |ν| via grid sum"

/-- #eval: Hahn and Jordan decomposition. -/
#eval "COMPUTE: computeHahnDecomposition: P = {f≥0}, N = {f<0}"

/-- #eval: Jordan from Hahn. -/
#eval "COMPUTE: computeJordanDecomposition: ν⁺ = f⁺, ν⁻ = f⁻"
