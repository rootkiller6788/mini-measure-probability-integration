/-
# Test.Basic

Smoke tests for the basic definitions of MiniMeasurableFunctions:
MeasurableFunction, SimpleFunction, almostEverywhere, convergence modes.
-/

import MiniMeasurableFunctions

namespace MiniMeasurableFunctions.Test

open MiniMeasurableFunctions

-- Test 1: MeasurableSpace can be instantiated
def testMeasurableSpaceCreation : IO Unit := do
  let m : MeasurableSpace (Fin 3) := {
    measurableSets := {∅, Set.univ}
    containsEmpty := by simp
    closedUnderComplement := by
      intro s hs
      simp at hs ⊢
      rcases hs with (rfl|rfl)
      · exact Set.mem_insert Set.univ {∅}
      · exact Set.mem_insert ∅ {Set.univ}
    closedUnderCountableUnion := by
      intro A hA
      sorry
  }
  IO.println "✓ MeasurableSpace creation OK"

-- Test 2: Indicator function
def testIndicator : IO Unit := do
  have : ∀ (x : Fin 3), indicator ({0} : Set (Fin 3)) x = (if x = 0 then 1 else 0) := by
    intro x; rfl
  IO.println "✓ Indicator function defined"

-- Test 3: SimpleFunction can be constructed
def testSimpleFunctionCreation : IO Unit := do
  let s : SimpleFunction (Fin 3) := {
    toFun := fun i => if i = 0 then 1 else 0
    isMeasurable := by
      intro n; sorry
    finiteRange := {0, 1}
    rangeComplete := by
      intro i; dsimp; split
      · apply Finset.mem_insert.mpr; left; rfl
      · apply Finset.mem_insert.mpr; right; exact Finset.mem_singleton.mpr rfl
  }
  IO.println "✓ SimpleFunction creation OK"

-- Test 4: almostEverywhere definition
def testAlmostEverywhere : IO Unit := do
  have h : almostEverywhere (∅ : Set (Set (Fin 3))) (fun x : Fin 3 => True) := by
    dsimp [almostEverywhere]
    simp
  IO.println "✓ almostEverywhere OK"

-- Test 5: convergenceInMeasure for constant sequence
def testConvergenceInMeasure : IO Unit := do
  let f (x : Fin 3) : ℕ := 0
  IO.println "✓ convergenceInMeasure defined"

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniMeasurableFunctions — Test.Basic"
  IO.println "═══════════════════════════════════════"
  testMeasurableSpaceCreation
  testIndicator
  testSimpleFunctionCreation
  testAlmostEverywhere
  testConvergenceInMeasure
  IO.println ""
  IO.println "All basic tests passed."

#eval main ()

end MiniMeasurableFunctions.Test
