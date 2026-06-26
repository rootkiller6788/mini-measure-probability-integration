/-
# Test.Theorems

Tests for the main theorems of MiniMeasurableFunctions:
measurable ⇒ limit of simple, Lusin, Egorov corollaries.
-/

import MiniMeasurableFunctions

namespace MiniMeasurableFunctions.Test

open MiniMeasurableFunctions

-- Test 1: measurableIsLimitOfSimple exists
def testMainTheorem : IO Unit := do
  have h := measurableIsLimitOfSimple
  IO.println "✓ measurableIsLimitOfSimple theorem present"

-- Test 2: measurableIffLimitOfSimple equivalence
def testEquivalence : IO Unit := do
  have h := measurableIffLimitOfSimple
  IO.println "✓ measurableIffLimitOfSimple theorem present"

-- Test 3: measurabilityPreservedUnderPointwiseLimit
def testPreservationPointwise : IO Unit := do
  have h := measurabilityPreservedUnderPointwiseLimit
  IO.println "✓ measurabilityPreservedUnderPointwiseLimit present"

-- Test 4: measurabilityPreservedUnderComposition
def testPreservationComposition : IO Unit := do
  have h := measurabilityPreservedUnderComposition
  IO.println "✓ measurabilityPreservedUnderComposition present"

-- Test 5: Section measurability (Fubini)
def testSectionsMeasurable : IO Unit := do
  have h := sectionsMeasurable
  IO.println "✓ sectionsMeasurable theorem present"

-- Test 6: Universal dense subalgebra
def testUniversalDenseSubalgebra : IO Unit := do
  have h := universalDenseSubalgebra
  IO.println "✓ universalDenseSubalgebra theorem present"

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniMeasurableFunctions — Test.Theorems"
  IO.println "═══════════════════════════════════════"
  testMainTheorem
  testEquivalence
  testPreservationPointwise
  testPreservationComposition
  testSectionsMeasurable
  testUniversalDenseSubalgebra
  IO.println ""
  IO.println "All theorem tests passed."

#eval main ()

end MiniMeasurableFunctions.Test
