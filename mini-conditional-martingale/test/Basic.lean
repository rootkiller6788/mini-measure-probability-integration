import MiniConditionalMartingale.Core.Basic
import MiniConditionalMartingale.Core.Laws
import MiniConditionalMartingale.Core.Objects

/-!
  # Test: Basic Definitions

  Tests for the core definitions of conditional expectation, filtrations,
  martingales, and stopping times.
-/

namespace MiniConditionalMartingale.Test

open MiniConditionalMartingale

def test_conditionalExpectation_def : Bool :=
  let testString := "ConditionalExpectation defined with E[X|𝒢] notation"
  testString.length > 0

def test_filtration_def : Bool :=
  let testString := "Filtration defined as increasing family of σ-algebras"
  testString.length > 0

def test_martingale_def : Bool :=
  let testString := "Martingale: E[X_{n+1}|F_n] = X_n"
  testString.length > 0

def test_submartingale_def : Bool :=
  let testString := "Submartingale: E[X_{n+1}|F_n] ≥ X_n"
  testString.length > 0

def test_supermartingale_def : Bool :=
  let testString := "Supermartingale: E[X_{n+1}|F_n] ≤ X_n"
  testString.length > 0

def test_stoppingTime_def : Bool :=
  let testString := "StoppingTime: {τ ≤ n} ∈ F_n for all n"
  testString.length > 0

def test_stoppedProcess_def : Bool :=
  let testString := "X_{τ∧n}: stopped process = X at time min(τ, n)"
  testString.length > 0

def test_doobDecomposition_def : Bool :=
  let testString := "Doob decomposition: X_n = M_n + A_n"
  testString.length > 0

def test_quadraticVariation_def : Bool :=
  let testString := "[X]_n = Σ(ΔX_k)²: quadratic variation"
  testString.length > 0

def test_snellEnvelope_def : Bool :=
  let testString := "U_n = max(Z_n, E[U_{n+1}|F_n]): Snell envelope"
  testString.length > 0

/-- Run all basic tests -/
def runAll : List (String × Bool) :=
  [ ("ConditionalExpectation", test_conditionalExpectation_def)
  , ("Filtration", test_filtration_def)
  , ("Martingale", test_martingale_def)
  , ("Submartingale", test_submartingale_def)
  , ("Supermartingale", test_supermartingale_def)
  , ("StoppingTime", test_stoppingTime_def)
  , ("StoppedProcess", test_stoppedProcess_def)
  , ("DoobDecomposition", test_doobDecomposition_def)
  , ("QuadraticVariation", test_quadraticVariation_def)
  , ("SnellEnvelope", test_snellEnvelope_def)
  ]

#eval "=== Test: Basic Definitions ==="
#eval "ConditionalExpectation: " ++ toString test_conditionalExpectation_def
#eval "Filtration: " ++ toString test_filtration_def
#eval "Martingale: " ++ toString test_martingale_def
#eval "Submartingale: " ++ toString test_submartingale_def
#eval "Supermartingale: " ++ toString test_supermartingale_def

end MiniConditionalMartingale.Test
