/-
# Computation.Check

Computation utilities for checking measurability:
- Check that a function on a finite measurable space is measurable
- Compute the preimage of each measurable set
- Verify simple function properties
-/

import MiniMeasurableFunctions

namespace MiniMeasurableFunctions.Computation

open MiniMeasurableFunctions

-- Check if a function preimage is in the sigma-algebra
def checkPreimageInSigmaAlgebra {X Y : Type} [DecidableEq X] [DecidableEq Y] [Fintype X]
    (mX : MeasurableSpace X) (f : X → Y) (s : Set Y) : Bool :=
  f ⁻¹' s ∈ mX.measurableSets

-- Enumerate all measurable sets in a finite measurable space
def allMeasurableSets {X : Type} [DecidableEq X] [Fintype X]
    (mX : MeasurableSpace X) : Finset (Set X) :=
  Finset.filter (fun s => s ∈ mX.measurableSets) (Finset.powerset (Finset.univ : Finset X))

-- Check all preimages at once
def isCompletelyMeasurable {X Y : Type} [DecidableEq X] [DecidableEq Y] [Fintype X] [Fintype Y]
    (mX : MeasurableSpace X) (mY : MeasurableSpace Y) (f : X → Y) : Bool :=
  allMeasurableSets mY |>.all (fun s => checkPreimageInSigmaAlgebra mX f s)

#eval "=== MiniMeasurableFunctions.Computation.Check ==="
#eval "checkPreimageInSigmaAlgebra: verify preimage is in σ-algebra"
#eval "allMeasurableSets: list all measurable sets in finite space"
#eval "isCompletelyMeasurable: check measurability of a finite function"

end MiniMeasurableFunctions.Computation
