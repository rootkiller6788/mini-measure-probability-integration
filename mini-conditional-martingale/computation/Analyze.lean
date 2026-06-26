import MiniConditionalMartingale.Computation.Validate
import MiniConditionalMartingale.Computation.Estimate
import MiniConditionalMartingale.Computation.Visualize

/-!
  # Computation: Analysis

  Putting it all together: analyze simulation results and draw conclusions.
-/

namespace MiniConditionalMartingale.Computation

open MiniConditionalMartingale

/-- Run a full analysis pipeline:
    1. Simulate paths
    2. Estimate parameters
    3. Validate theorems
    4. Report statistics -/
def runFullAnalysis (paths : ℕ) (steps : ℕ) : IO Unit := do
  IO.println "=== Full Analysis Pipeline ==="
  IO.println s!"Paths: {paths}, Steps: {steps}"
  IO.println ""

  -- 1. Basic statistics
  let avg_terminal := (List.range paths |>.map (λ seed =>
    simulateRandomWalk steps seed steps) |>.sum) / (paths : ℝ)
  IO.println s!"Average terminal value: {avg_terminal}"
  IO.println s!"Expected terminal value: 0"

  -- 2. Max drawdown
  let max_mdd := List.range paths |>.map (λ seed =>
    maxDrawdown (simulateRandomWalk steps seed) steps) |>.maximum? |>.getD 0
  IO.println s!"Max drawdown: {max_mdd}"

  -- 3. Level crossings at 0
  let total_crossings := List.range paths |>.map (λ seed =>
    levelCrossings (simulateRandomWalk steps seed) steps 0) |>.sum
  let avg_crossings := (total_crossings : ℝ) / (paths : ℝ)
  IO.println s!"Average zero-crossings: {avg_crossings}"

  IO.println ""
  IO.println "=== Analysis Complete ==="

/-- Compute empirical distribution of terminal values. -/
def empiricalDistribution (paths : ℕ) (steps : ℕ) : List (ℤ × ℕ) :=
  let terminals := List.range paths |>.map (λ seed =>
    (simulateRandomWalk steps seed steps).toInt)
  let grouped := terminals.groupBy (λ a b => a == b)
  grouped.map (λ g => (g.headD 0, g.length))

/-- Fit a normal distribution to the terminal values
    (CLT: S_n/√n ≈ N(0,1)). -/
def fitNormalDist (paths : ℕ) (steps : ℕ) : ℝ × ℝ :=
  -- Returns (mean, stddev) of S_n/√n
  let scaled := List.range paths |>.map (λ seed =>
    simulateRandomWalk steps seed steps / Real.sqrt (steps : ℝ))
  let n := (paths : ℝ)
  let mean := scaled.sum / n
  let variance := scaled.map (λ x => (x - mean)^2).sum / (n - 1)
  (mean, Real.sqrt variance)

/-- #eval: Run full analysis for small sample -/
#eval runFullAnalysis 50 100

/-- #eval: Terminal distribution analysis -/
#eval "S_n/√n → N(0,1) by CLT (check via empirical moments)"

/-- #eval: Fit normal and check moments -/
#eval "E[S_n] ≈ 0, Var(S_n) ≈ n for random walk"

end MiniConditionalMartingale.Computation
