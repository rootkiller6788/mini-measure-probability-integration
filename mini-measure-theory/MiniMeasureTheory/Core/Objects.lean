/-
# Measure Theory: Object Instances and Registration

Register measure-theoretic structures as Objects in MiniObjectKernel.
-/

import MiniObjectKernel
import MiniMeasureTheory.Core.Basic

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Object Instances for Sigma Algebras -/

variable (α : Type u) [Object α]

instance : Object (SigmaAlgebra α) where
  theory := Object.theory α |>.extend "MeasureTheory"
  objName := "SigmaAlgebra"
  repr σ := s!"SigmaAlgebra({σ.carrier})"

instance : Object (MeasurableSpace α) where
  theory := Object.theory α |>.extend "MeasureTheory"
  objName := "MeasurableSpace"
  repr ms := s!"MeasurableSpace({ms.sigmaAlgebra.carrier})"

instance : Object (Measure α ms) where
  theory := Object.theory α |>.extend "MeasureTheory"
  objName := "Measure"
  repr μ := s!"Measure(μ.toFun)"

#eval "Object instances registered: SigmaAlgebra, MeasurableSpace, Measure"

/-! ## Theory Registration -/

/-- The measure theory theory name. -/
def measureTheory : TheoryName :=
  TheoryName.ofString "MiniMeasureTheory"

/-- Register the measure theory as an Object theory. -/
def registerMeasureTheory : TheoryName :=
  measureTheory

/-- Core objects in measure theory. -/
def coreObjects : List (Σ α : Type, Object α) :=
  [
    ⟨SigmaAlgebra ℕ, inferInstance⟩,
    ⟨MeasurableSpace ℕ, inferInstance⟩,
    ⟨Measure ℕ (default : MeasurableSpace ℕ), inferInstance⟩,
    ⟨OuterMeasure ℕ, inferInstance⟩
  ]

#eval "coreObjects list defined (4 entries)"
#eval (coreObjects 0).1

/-! ## Sigma Algebra Objects -/

/-- Generate the trivial sigma algebra for a type. -/
def mkTrivialSigmaAlgebra (α : Type u) [Object α] : SigmaAlgebra α :=
  trivialSigmaAlgebra α

/-- Generate the discrete sigma algebra for a type. -/
def mkDiscreteSigmaAlgebra (α : Type u) [Object α] : SigmaAlgebra α :=
  discreteSigmaAlgebra α

/-- Generate the Borel sigma algebra for a topological type. -/
def mkBorelSigmaAlgebra (α : Type u) [Object α] [TopologicalSpace α] : SigmaAlgebra α :=
  borelSigmaAlgebra α

#eval "Factory functions: mkTrivialSigmaAlgebra, mkDiscreteSigmaAlgebra, mkBorelSigmaAlgebra"
#eval (trivialSigmaAlgebra ℕ).empty_mem

end MiniMeasureTheory
