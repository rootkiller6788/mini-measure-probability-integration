import MiniIndependenceConvergence

open MiniIndependenceConvergence

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniIndependenceConvergence v0.1.0"
  IO.println "  Independence and Convergence Theory"
  IO.println "═══════════════════════════════════════"
  IO.println s!"  Independent events, algebras, variables"
  IO.println s!"  Borel-Cantelli lemmas, Kolmogorov 0-1 law"
  IO.println s!"  Convergence modes: a.s., prob, L^p, distribution"
  IO.println s!"  Weak/Strong LLN, CLT"
  IO.println ""
  IO.println "  Run `lake env lean --run Test/Smoke.lean` for tests."
  IO.println "  Run `lake build` to compile the library."

#eval "MiniIndependenceConvergence main entry point loaded successfully"
