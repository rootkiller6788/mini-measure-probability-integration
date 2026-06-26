import MiniMeasureTheory

open MiniMeasureTheory

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniMeasureTheory v0.1.0"
  IO.println "  Measure and Probability Theory"
  IO.println "═══════════════════════════════════════"
  IO.println s!"  SigmaAlgebra: 20 measurable spaces"
  IO.println s!"  Measure: Lebesgue, counting, Dirac"
  IO.println s!"  Caratheodory extension theorem"
  IO.println s!"  Hahn and Jordan decompositions"
  IO.println s!"  Lebesgue decomposition"
  IO.println ""
  IO.println "  Run `lake env lean --run Test/Smoke.lean` for tests."
  IO.println "  Run `lake build` to compile the library."

#eval "MiniMeasureTheory main entry point loaded successfully"
