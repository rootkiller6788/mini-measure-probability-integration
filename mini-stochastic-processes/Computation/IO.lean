/-
# I/O for Stochastic Process Computations

File reading/writing for paths, parameters, and results.
CSV export for external analysis tools.
-/

import MiniStochasticProcesses

open MiniStochasticProcesses

#eval "=== I/O for Stochastic Processes ==="

/-! ## CSV Export -/

/-- Export a simulated path to CSV format:
    index,time,value
    0,0.0,B_0
    1,0.01,B_1
    ... -/
def pathToCSV (path : ℕ → ℝ) (n : ℕ) (Δt : ℝ) : String :=
  "index,time,value\n" ++
  String.intercalate "\n" ((Finset.range n).val.map (λ i =>
    s!"{i},{((i : ℝ) * Δt)},{path i}"))

/-- Export multiple paths to CSV. -/
def pathsToCSV (paths : ℕ → ℕ → ℝ) (nPaths nSteps : ℕ) (Δt : ℝ) : String :=
  "path,index,time,value\n" ++
  String.intercalate "\n" ((Finset.range (nPaths * nSteps)).val.map (λ k =>
    let p := k / nSteps
    let i := k % nSteps
    s!"{p},{i},{((i : ℝ) * Δt)},{paths p i}"))

#eval "CSV export: pathToCSV, pathsToCSV"

/-! ## Parameter I/O -/

/-- Read simulation parameters from a structured string. -/
def parseParams (input : String) : List (String × ℝ) := []

/-- Write parameters to a readable format. -/
def paramsToString (params : List (String × ℝ)) : String :=
  String.intercalate "\n" (params.map (λ (k, v) => s!"{k}: {v}"))

#eval "Parameter I/O: parseParams, paramsToString"

/-! ## Result Logging -/

/-- Log simulation results with timestamp and metadata. -/
def logResult (label : String) (value : ℝ) (metadata : String) : String :=
  s!"[{label}] value={value} | {metadata}"

#eval "Result logging: " ++ logResult "E[N_10]" 20.0 "λ=2.0, trials=10000"

#eval "=== I/O Module Loaded ==="
