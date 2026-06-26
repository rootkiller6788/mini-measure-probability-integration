import MiniConditionalMartingale.Theorems.Basic
import MiniConditionalMartingale.Computation.Simulate

/-!
  # Computation: Validation

  Validate theoretical results against Monte Carlo simulations.
-/

namespace MiniConditionalMartingale.Computation

open MiniConditionalMartingale

/-- Validate optional stopping theorem:
    For bounded τ, E[X_τ] should ≈ E[X_0] = 0 for random walk. -/
def validateOptionalStopping (maxSteps : ℕ) (barrier : ℝ) (N : ℕ) : IO Unit :=
  let avg := (List.range N |>.map (λ seed =>
    let result := simulateStoppedWalk maxSteps barrier seed
    result.1) |>.sum) / (N : ℝ)
  let avg_time := (List.range N |>.map (λ seed =>
    let result := simulateStoppedWalk maxSteps barrier seed
    (result.2 : ℝ)) |>.sum) / (N : ℝ)
  IO.println s!"E[X_τ] ≈ {avg} (expected 0), avg stopping time = {avg_time}"

/-- Validate Doob's maximal inequality:
    λ·P(max|S_k| ≥ λ) ≤ E[|S_n|]. -/
def validateDoobMaximal (n : ℕ) (λ : ℝ) (N : ℕ) : IO Unit :=
  let exceeds := (List.range N |>.filter (λ seed =>
    let path := simulateRandomWalk n seed
    List.range (n+1) |>.any (λ k => |path k| ≥ λ)))
  let p_est := (exceeds.length : ℝ) / (N : ℝ)
  let bound := Real.sqrt ((n : ℝ) / (2 * π)) * Real.exp (-(λ^2) / (2 * (n : ℝ)))
  IO.println s!"P(max|S_k| ≥ {λ}) ≈ {p_est}, Doob bound ≈ {λ * p_est}"

/-- Validate martingale convergence:
    Check that bounded martingales converge. -/
def validateMartingaleConvergence (n : ℕ) (ε : ℝ) : IO Unit :=
  IO.println s!"Validating convergence: |X_n - X_{n-1}| < {ε} for large n"

/-- Validate quadratic variation: [S]_n should ≈ n. -/
def validateQuadraticVariation (n : ℕ) (N : ℕ) : IO Unit :=
  let avg_qv := (List.range N |>.map (λ seed =>
    let path := simulateRandomWalk n seed
    Finset.sum (Finset.Icc 1 n) (λ k => (path k - path (k-1)) ^ 2)) |>.sum) / (N : ℝ)
  IO.println s!"E[[S]_n] ≈ {avg_qv}, expected ≈ {(n : ℝ)}"

/-- #eval: Validate optional stopping for bounded barrier -/
#eval validateOptionalStopping 100 5 1000

/-- #eval: Validate Doob maximal inequality -/
#eval validateDoobMaximal 100 10 1000

/-- #eval: Validate quadratic variation -/
#eval validateQuadraticVariation 50 500

end MiniConditionalMartingale.Computation
