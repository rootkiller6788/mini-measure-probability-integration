/-
# Computation Runner for MiniStochasticProcesses

Provides executable computational capabilities for stochastic
processes: simulation, MCMC, visualization data generation.
-/

import MiniStochasticProcesses

open MiniStochasticProcesses

def main : IO Unit := do
  IO.println "========================================="
  IO.println "  MiniStochasticProcesses Computation"
  IO.println "========================================="
  IO.println ""
  IO.println "  Available computations:"
  IO.println "    1. Simulation.lean      - Process simulation"
  IO.println "    2. MCMC.lean            - MCMC sampling"
  IO.println "    3. Visualization.lean   - Data for plots"
  IO.println "    4. IO.lean              - File I/O for paths"
  IO.println "    5. Overrides.lean       - Override default params"
  IO.println ""

#eval "Computation runner loaded"

-- Seed the pseudo-RNG
def seed : ℕ := 42

def simpleLcg (state : ℕ) : ℕ × ℝ :=
  let a := 1664525
  let c := 1013904223
  let m := 2^32
  let newState := (a * state + c) % m
  (newState, (newState : ℝ) / (m : ℝ))
