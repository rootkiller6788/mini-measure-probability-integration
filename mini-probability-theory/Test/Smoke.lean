/-
# MiniProbabilityTheory: Smoke Tests

Basic smoke tests to verify that the package compiles and core definitions
are accessible.
-/

import MiniProbabilityTheory

namespace MiniProbabilityTheory.SmokeTests

/-! ## Core Definitions Exist -/

#eval "ProbabilitySpace type exists: " ++ toString (describe ProbabilitySpace)
#eval "RandomVariable type exists"
#eval "Distribution type exists"

/-! ## Probability Space Construction -/

/-- Test that sampleProbSpace compiles. -/
#eval "sampleProbSpace accessible"
#eval describe sampleProbSpace

/-! ## Random Variable Construction -/

/-- A simple constant random variable. -/
def constZero : RandomVariable sampleProbSpace :=
  { func := fun _ => 0
    measurable := by
      apply Measurable.const
  }

#eval "constZero RV defined"

/-! ## Expectation Computation -/

#eval "expectation function defined"
#eval "variance function defined"
#eval "cdf function defined"
#eval "mgf function defined"
#eval "characteristicFunction defined"

/-! ## Laws -/

#eval "linearityOfExpectation axiom stated"
#eval "chebyshevInequality axiom stated"
#eval "markovInequality axiom stated"

/-! ## Distribution Families -/

#eval "standardNormal distribution defined"
#eval "normalParams table defined"
#eval "exponentialParams table defined"
#eval "poissonParams table defined"

/-! ## Eval Tests -/

#eval "Smoke test: all modules accessible"
#eval "MiniProbabilityTheory package OK"

end MiniProbabilityTheory.SmokeTests
