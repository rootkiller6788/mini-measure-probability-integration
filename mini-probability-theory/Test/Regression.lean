/-
# MiniProbabilityTheory: Regression Tests

Regression tests for invariants, constructions, and theorems.
-/

import MiniProbabilityTheory

namespace MiniProbabilityTheory.RegressionTests

/-! ## Invariants -/

#eval "meanOfDist defined"
#eval "varianceOfDist defined"
#eval "skewness defined"
#eval "kurtosis defined"
#eval "entropy defined"
#eval "mutualInformation defined"

/-! ## Constructions -/

#eval "productProbSpace (⊗) defined"
#eval "jointDistribution defined"
#eval "conditionalProbability P(A|B) defined"
#eval "RegularConditionalProbability defined"
#eval "AbsolutelyContinuousDist defined"
#eval "DiscreteDist with Poisson PMF"
#eval "MixtureDist defined"
#eval "LebesgueDecomposition defined"

/-! ## Theorems -/

#eval "levyContinuityTheorem stated"
#eval "portmanteauTheorem stated"
#eval "kolmogorovExtensionTheorem stated"
#eval "strongLawOfLargeNumbers stated"
#eval "centralLimitTheorem stated"
#eval "deFinettiTheorem stated"
#eval "cramerRaoLowerBound stated"

/-! ## Bridges -/

#eval "pgf defined (Probability Generating Function)"
#eval "cumulant defined (additive for independent sums)"
#eval "prokhorovMetric defined"
#eval "fisherMetric defined"
#eval "monteCarloEstimate defined"
#eval "inverseCDFMethod defined"
#eval "boxMuller defined"

/-! ## Equivalence Relations -/

#eval "eqInDistribution (≗) defined"
#eval "almostSurelyEqual (≗ₐₛ) defined"
#eval "ProbEquiv defined"

end MiniProbabilityTheory.RegressionTests
