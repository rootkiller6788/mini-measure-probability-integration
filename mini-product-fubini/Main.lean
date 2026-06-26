import MiniProductFubini

open MiniProductFubini

def main : IO Unit := do
  IO.println "═══════════════════════════════════════════"
  IO.println "  MiniProductFubini v0.1.0"
  IO.println "  Product Measures and Fubini's Theorem"
  IO.println "═══════════════════════════════════════════"
  IO.println s!"  ProductSigmaAlgebra: Σ_X ⊗ Σ_Y construction"
  IO.println s!"  ProductMeasure: μ×ν on product space"
  IO.println s!"  Fubini Theorem: iterated = product integral"
  IO.println s!"  Tonelli Theorem: nonnegative measurable case"
  IO.println s!"  Convolution: f*g(x) = ∫ f(x-y)g(y)dy"
  IO.println s!"  Young's Inequality: ‖f*g‖_r ≤ ‖f‖_p‖g‖_q"
  IO.println s!"  Radon-Nikodym Theorem: ν≪μ ⇒ ν = ∫(dν/dμ)dμ"
  IO.println s!"  Lebesgue Decomposition: ν = ν_ac + ν_sing"
  IO.println s!"  Hahn Decomposition: signed measure space split"
  IO.println s!"  Jordan Decomposition: ν = ν⁺ - ν⁻"
  IO.println ""
  IO.println "  Run `lake env lean --run Test/Smoke.lean` for tests."
  IO.println "  Run `lake build` to compile the library."

#eval "MiniProductFubini main entry point loaded successfully"
