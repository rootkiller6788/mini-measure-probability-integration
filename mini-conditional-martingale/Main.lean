import MiniConditionalMartingale

open MiniConditionalMartingale

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniConditionalMartingale v0.1.0"
  IO.println "  Conditional Expectation and Martingale Theory"
  IO.println "═══════════════════════════════════════"
  IO.println s!"  Conditional expectation E[X | G] w.r.t. sigma-algebra G"
  IO.println s!"  Properties: linearity, tower property, Jensen inequality, independence"
  IO.println s!"  Filtration: increasing family of σ-algebras (F_n)"
  IO.println s!"  Adapted process: X_n is F_n-measurable for each n"
  IO.println s!"  Martingale: E[X_{n+1} | F_n] = X_n"
  IO.println s!"  Submartingale: E[X_{n+1} | F_n] ≥ X_n"
  IO.println s!"  Supermartingale: E[X_{n+1} | F_n] ≤ X_n"
  IO.println s!"  Stopping time: {τ = n} ∈ F_n for all n"
  IO.println s!"  Optional stopping theorem (bounded stopping times)"
  IO.println s!"  Doob decomposition: X_n = M_n + A_n (martingale + predictable)"
  IO.println s!"  Doob's maximal inequality and upcrossing inequality"
  IO.println s!"  Martingale convergence theorem: L¹-bounded ⇒ a.s. convergence"
  IO.println ""
  IO.println "  Depends on: mini-probability-theory, mini-measure-theory"
  IO.println "  Run `lake env lean --run test/basic.lean` for tests."
