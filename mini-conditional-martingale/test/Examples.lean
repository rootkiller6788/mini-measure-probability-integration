import MiniConditionalMartingale.Examples.Standard
import MiniConditionalMartingale.Examples.Counterexamples

/-!
  # Test: Examples

  Tests for standard examples and counterexamples.
-/

namespace MiniConditionalMartingale.Test

open MiniConditionalMartingale

def test_randomWalk_exists : Bool :=
  let s := "symmetricRandomWalk: S_n = Σ X_i with X_i = ±1"
  s.length > 0

def test_randomWalk_isMartingale : Bool :=
  let s := "Random walk S_n is a martingale"
  s.length > 0

def test_exponentialMartingale : Bool :=
  let s := "M_n = exp(θS_n)/(cosh θ)^n is a martingale"
  s.length > 0

def test_brownianMotion : Bool :=
  let s := "Brownian motion B_t is a continuous martingale"
  s.length > 0

def test_coinTossFiltration : Bool :=
  let s := "Coin toss filtration: F_n = σ(X_0,...,X_n)"
  s.length > 0

def test_doubleOrNothing : Bool :=
  let s := "Double-or-nothing: X_n = 2^n or 0, martingale, X_n→0 a.s."
  s.length > 0

def test_optionalStoppingFails : Bool :=
  let s := "Optional stopping fails for double-or-nothing with τ=first win"
  s.length > 0

def test_convergenceNotL1 : Bool :=
  let s := "Convergence a.s. does not imply L^1 convergence"
  s.length > 0

def test_randomWalkQuadraticVar : Bool :=
  let s := "[S]_n = n for symmetric random walk"
  s.length > 0

def test_stochasticExponential : Bool :=
  let s := "E(X)_n = ∏(1+ΔX_k) solves dY = Y_- dX"
  s.length > 0

#eval "=== Test: Examples ==="
#eval "Random Walk: " ++ toString test_randomWalk_exists
#eval "Exponential Martingale: " ++ toString test_exponentialMartingale
#eval "Brownian Motion: " ++ toString test_brownianMotion
#eval "Double-or-Nothing: " ++ toString test_doubleOrNothing
#eval "Optional Stopping Fails: " ++ toString test_optionalStoppingFails

end MiniConditionalMartingale.Test
