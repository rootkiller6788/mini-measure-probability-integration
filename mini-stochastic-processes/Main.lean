import MiniStochasticProcesses

open MiniStochasticProcesses

def main : IO Unit := do
  IO.println "========================================="
  IO.println "  MiniStochasticProcesses v0.1.0"
  IO.println "  Stochastic Processes Theory"
  IO.println "========================================="
  IO.println s!"  StochasticProcess: Brownian, Poisson, Markov"
  IO.println s!"  Markov chains: transition kernels, Chapman-Kolmogorov"
  IO.println s!"  Levy processes: classification, Ito decomposition"
  IO.println s!"  Ergodic theory: Birkhoff theorem"
  IO.println s!"  Donsker invariance principle"
  IO.println ""
  IO.println "  Run `lake env lean --run Test/Smoke.lean` for tests."
  IO.println "  Run `lake build` to compile the library."

#eval "MiniStochasticProcesses main entry point loaded successfully"
