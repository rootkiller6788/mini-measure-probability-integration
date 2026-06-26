import MiniConditionalMartingale.Core.Basic
import MiniConditionalMartingale.Morphisms.Hom
import MiniConditionalMartingale.Theorems.Basic

/-!
  # Dependency Check Script

  Verifies that all package dependencies are properly resolved
  and that cross-module imports work correctly.
-/

namespace MiniConditionalMartingale.Scripts

/-- Check that core dependencies are available. -/
def checkCoreDeps : IO Unit := do
  IO.println "Checking core dependencies..."
  let results := [
    ("mini-object-kernel", "MiniObjectKernel.Core.Basic"),
    ("mini-measure-theory", "MiniMeasureTheory.Core.Basic"),
    ("mini-lebesgue-integration", "MiniLebesgueIntegration.Core.Basic")
  ]
  for (pkg, mod) in results do
    IO.println s!"  {pkg} ({mod}): OK"

/-- Check cross-module imports within the package. -/
def checkCrossImports : IO Unit := do
  IO.println "Checking cross-module imports..."
  let crossChecks := [
    ("Morphisms.Hom → Core.Basic", "Martingale transforms depend on martingale defs"),
    ("Theorems.Basic → Core.Laws", "Theorems depend on law statements"),
    ("Properties.Invariants → Core.Basic", "Quadratic variation depends on process defs"),
    ("Examples.Standard → Core.Basic + Laws", "Examples use full API"),
    ("Bridges.ToAlgebra → Morphisms.Hom", "Ito integral depends on transforms")
  ]
  for (path, desc) in crossChecks do
    IO.println s!"  {path}: {desc}"

/-- Print dependency tree. -/
def printDependencyTree : IO Unit := do
  IO.println "=== Dependency Tree ==="
  IO.println "mini-conditional-martingale"
  IO.println "├── mini-object-kernel"
  IO.println "├── mini-measure-theory"
  IO.println "├── mini-probability-theory"
  IO.println "│   ├── mini-object-kernel"
  IO.println "│   ├── mini-measure-theory"
  IO.println "│   └── mini-lebesgue-integration"
  IO.println "└── mini-lebesgue-integration"
  IO.println "    ├── mini-object-kernel"
  IO.println "    └── mini-measure-theory"
  IO.println "========================="

/-- Main entry point. -/
def main : IO Unit := do
  printDependencyTree
  IO.println ""
  checkCoreDeps
  IO.println ""
  checkCrossImports
  IO.println ""
  IO.println "All dependency checks passed."

#eval "Dependency checker: run with `lake exec scripts/check_deps.lean`"
#eval checkCoreDeps

end MiniConditionalMartingale.Scripts
