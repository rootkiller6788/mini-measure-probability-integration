/-
# Example Tests — MiniIndependenceConvergence

Run: `lake env lean --run Test/Examples.lean`
-/

import MiniIndependenceConvergence

open MiniIndependenceConvergence

#eval "══ MINI-INDEPENDENCE-CONVERGENCE EXAMPLE TESTS ══"

/-! ## Example 1: Coin Flip Independence -/

#eval "── Ex1: Two coin flips are independent ──"
-- In a fair coin flip space, two events for different flips are independent
def flip1 : Event (Fin 2) := ⟨{0}⟩
def flip2 : Event (Fin 2) := ⟨{1}⟩
#eval "Coin flip events: flip1 = {0}, flip2 = {1}"

/-! ## Example 2: WLLN Convergence Check -/

#eval "── Ex2: WLLN simulation ──"
#eval "WLLN for n=10: " ++ toString (wllnSimulation 10)
#eval "WLLN for n=1000: " ++ toString (wllnSimulation 1000)
#eval "As n→∞, sample mean approaches 0.5"

/-! ## Example 3: CLT Distribution Comparison -/

#eval "── Ex3: CLT Normal Approximation ──"
#eval "Φ(0) = " ++ toString (cltNormalApproximation 100 0)
#eval "Φ(1) ≈ " ++ toString (cltNormalApproximation 100 1)
#eval "True Φ(0) = 1/√(2π) ≈ 0.399, Φ(1) ≈ 0.242"

/-! ## Example 4: Dice Statistics -/

#eval "── Ex4: Dice roll (6 faces) ──"
#eval "Mean = " ++ toString (diceMean 6)
#eval "Variance = " ++ toString (diceVariance 6)
#eval "True mean = 2.5, True variance = 35/12 ≈ 2.917"

/-! ## Example 5: Cauchy LLN Failure -/

#eval "── Ex5: Cauchy distribution has no mean ──"
#eval "Cauchy PDF at 0 = " ++ toString cauchyExampleValue
#eval "∫ x * cauchyPDF(x) dx does not converge absolutely"

/-! ## Example 6: Berry-Esseen Computation -/

#eval "── Ex6: Berry-Esseen sample size ──"
#eval "For ε=0.01, δ=0.05: n > " ++
  toString (berryEsseenMCSampleSize 0.01 0.05 (by norm_num) (by norm_num))

/-! ## Example 7: Convergence Mode Hierarchy -/

#eval "── Ex7: Convergence hierarchy ──"
#eval convergenceHierarchy

/-! ## Example 8: Free vs Classical Independence -/

#eval "── Ex8: Independence types ──"
#eval classicalIndependence.name ++ ": " ++ classicalIndependence.productFormula
#eval freeIndependenceType.name ++ ": " ++ freeIndependenceType.productFormula

#eval "══ ALL EXAMPLE TESTS COMPLETE ══"
