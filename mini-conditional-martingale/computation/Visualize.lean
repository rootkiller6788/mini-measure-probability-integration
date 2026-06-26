import MiniConditionalMartingale.Computation.Simulate

/-!
  # Computation: Visualization Helpers

  Data structures and utilities for visualizing martingale paths
  and stopping times.
-/

namespace MiniConditionalMartingale.Computation

open MiniConditionalMartingale

/-- A point in a time series (time, value). -/
structure TimePoint where
  time : ℕ
  value : ℝ
  deriving Inhabited, Repr

/-- A path is a sequence of time points. -/
def PathData := List TimePoint

/-- Convert a process function to path data. -/
def processToPath (X : ℕ → ℝ) (n : ℕ) : PathData :=
  List.range (n+1) |>.map (λ k => { time := k, value := X k })

/-- Compute the maximum drawdown of a path:
    MDD = max_{0≤i≤j≤n} (X_i - X_j). -/
def maxDrawdown (X : ℕ → ℝ) (n : ℕ) : ℝ :=
  let values := List.range (n+1) |>.map (λ k => X k)
  let peaks := values.scanl (λ a b => max a b) 0
  let drawdowns := List.zipWith (λ p v => p - v) peaks values
  match drawdowns.maximum? with
  | some m => m
  | none => 0

/-- Compute the number of times a path crosses a level. -/
def levelCrossings (X : ℕ → ℝ) (n : ℕ) (level : ℝ) : ℕ :=
  let values := List.range (n+1) |>.map (λ k => X k)
  let pairs := values.zip (values.tailD [])
  pairs.count (λ (a, b) => (a < level ∧ b ≥ level) ∨ (a ≥ level ∧ b < level))

/-- The high-low range of a path up to time n. -/
def highLowRange (X : ℕ → ℝ) (n : ℕ) : ℝ :=
  let values := List.range (n+1) |>.map (λ k => X k)
  match values.maximum?, values.minimum? with
  | some mx, some mn => mx - mn
  | _, _ => 0

/-- #eval: Generate path data from process -/
#eval "processToPath generates (t, X_t) pairs for visualization"

/-- #eval: Maximum drawdown for random walk -/
#eval "MDD = max_{i≤j}(X_i - X_j) measures worst peak-to-trough loss"

/-- #eval: Count upcrossings of level a -/
#eval "Level crossings: number of times path crosses a given threshold"

end MiniConditionalMartingale.Computation
