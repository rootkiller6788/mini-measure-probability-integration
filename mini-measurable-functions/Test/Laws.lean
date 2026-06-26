/-
# Test.Laws

Tests for the axiomatic laws of MiniMeasurableFunctions:
algebraic closure, density of simple functions, Egorov, Lusin.
-/

import MiniMeasurableFunctions

namespace MiniMeasurableFunctions.Test

open MiniMeasurableFunctions

-- Test 1: Algebraic closure axioms exist
def testAlgebraicClosure : IO Unit := do
  IO.println "Testing algebraic closure axioms..."
  -- Verify that measurable_add, measurable_mul, measurable_smul exist
  have h_add := measurable_add
  have h_mul := measurable_mul
  have h_smul := measurable_smul
  IO.println "✓ measurable_add axiom present"
  IO.println "✓ measurable_mul axiom present"
  IO.println "✓ measurable_smul axiom present"

-- Test 2: Limit operations axioms
def testLimitOperations : IO Unit := do
  have h_sup := measurable_sup
  have h_inf := measurable_inf
  have h_limsup := measurable_limsup
  have h_liminf := measurable_liminf
  IO.println "✓ measurable_sup axiom present"
  IO.println "✓ measurable_inf axiom present"
  IO.println "✓ measurable_limsup axiom present"
  IO.println "✓ measurable_liminf axiom present"

-- Test 3: Density of simple functions
def testSimpleFunctionsDense : IO Unit := do
  have h := simpleFunctionsDense
  IO.println "✓ simpleFunctionsDense axiom present"

-- Test 4: Egorov theorem axiom
def testEgorovTheorem : IO Unit := do
  have h := egorovTheorem
  IO.println "✓ egorovTheorem axiom present"

-- Test 5: Lusin theorem axiom
def testLusinTheorem : IO Unit := do
  have h := lusinTheorem
  IO.println "✓ lusinTheorem axiom present"

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniMeasurableFunctions — Test.Laws"
  IO.println "═══════════════════════════════════════"
  testAlgebraicClosure
  testLimitOperations
  testSimpleFunctionsDense
  testEgorovTheorem
  testLusinTheorem
  IO.println ""
  IO.println "All law tests passed."

#eval main ()

end MiniMeasurableFunctions.Test
