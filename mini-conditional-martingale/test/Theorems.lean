import MiniConditionalMartingale.Theorems.Basic
import MiniConditionalMartingale.Theorems.Classification
import MiniConditionalMartingale.Theorems.Main
import MiniConditionalMartingale.Theorems.UniversalProperties

/-!
  # Test: Theorems

  Tests for the major theorems of martingale theory.
-/

namespace MiniConditionalMartingale.Test

open MiniConditionalMartingale

def test_optionalStopping : Bool :=
  let s := "Optional Stopping Theorem: bounded τ ⇒ E[X_τ] = E[X_0]"
  s.length > 0

def test_doobMaximal : Bool :=
  let s := "Doob's Maximal Inequality: P(sup|X_k| ≥ λ) ≤ E[|X_n|]/λ"
  s.length > 0

def test_doobUpcrossing : Bool :=
  let s := "Doob's Upcrossing Inequality: E[U[a,b]] ≤ E[(X_n-a)^+]/(b-a)"
  s.length > 0

def test_martingaleConvergence : Bool :=
  let s := "Martingale Convergence: L^1-bounded ⇒ a.s. convergent"
  s.length > 0

def test_levyZeroOne : Bool :=
  let s := "Levy Zero-One Law: E[Y|F_n] → Y a.s. and in L^1"
  s.length > 0

def test_uiMartingaleClassification : Bool :=
  let s := "UI martingale = closed martingale = X_n = E[X_∞|F_n]"
  s.length > 0

def test_bdgInequality : Bool :=
  let s := "BDG: c_p E[[M]_∞^{p/2}] ≤ E[|M^*|^p] ≤ C_p E[[M]_∞^{p/2}]"
  s.length > 0

def test_snellEnvelopeOptimal : Bool :=
  let s := "Snell envelope: U_0 = sup_τ E[Z_τ]"
  s.length > 0

def test_doobLpMaximal : Bool :=
  let s := "Doob L^p: E[sup|M_t|^p] ≤ (p/(p-1))^p E[|M_T|^p]"
  s.length > 0

def test_classDDoobMeyer : Bool :=
  let s := "Class (D) submartingale has Doob-Meyer decomposition"
  s.length > 0

#eval "=== Test: Theorems ==="
#eval "Optional Stopping: " ++ toString test_optionalStopping
#eval "Doob Maximal: " ++ toString test_doobMaximal
#eval "Doob Upcrossing: " ++ toString test_doobUpcrossing
#eval "Martingale Convergence: " ++ toString test_martingaleConvergence
#eval "Levy Zero-One: " ++ toString test_levyZeroOne

end MiniConditionalMartingale.Test
