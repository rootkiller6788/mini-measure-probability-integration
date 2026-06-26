/-
# MiniMeasurableFunctions — Main Entry Point

This package provides the theory of measurable functions:
- MeasurableFunction typeclass and basic properties
- Simple functions and approximation theorems
- Egorov, Lusin, and Fubini theorems
- L⁰ space of measurable functions modulo equality a.e.
-/
import MiniMeasurableFunctions

open MiniMeasurableFunctions

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniMeasurableFunctions v0.1.0"
  IO.println "  Measurable Function Theory"
  IO.println "═══════════════════════════════════════"
  IO.println s!"  MeasurableFunction: preimage of Borel sets are measurable"
  IO.println s!"  SimpleFunction: finite range, measurable level sets"
  IO.println s!"  L0 space: convergence in measure metric"
  IO.println ""
  IO.println "  Run `lake env lean --run Test/Basic.lean` for tests."

#eval main ()
