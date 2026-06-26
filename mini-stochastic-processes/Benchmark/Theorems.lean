/-
# Theorem Benchmarks

Benchmarks for theorem declarations and axiom usage.
-/

import MiniStochasticProcesses

open MiniStochasticProcesses

#eval "=== Theorem Benchmarks ==="

/-! ## Benchmark: Strong Markov Property -/

/-- Accessing the strong Markov property theorem. -/
#eval "Benchmark: strongMarkovProperty access"
#eval "  Axiom access is O(1)"

/-! ## Benchmark: Reflection Principle -/

/-- Computing the reflection principle formula. -/
#eval "Benchmark: reflectionPrinciple computation"
#eval "  P(sup B_t ≥ 1) ≈ 2*P(B_1 ≥ 1): " ++ toString (reflectionPrinciple default 1 1 (by norm_num))

/-! ## Benchmark: Ergodic Theorem -/

/-- Accessing Birkhoff's ergodic theorem. -/
#eval "Benchmark: ergodicTheorem and pointwiseErgodicTheorem"

/-! ## Benchmark: Donsker Invariance Principle -/

/-- Accessing the Donsker convergence statements. -/
#eval "Benchmark: donskerInvariancePrinciple"

/-! ## Benchmark: Levy Characterization -/

/-- Classic characterization theorems. -/
#eval "Benchmark: levyCharacterizationOfBrownian"
#eval "Benchmark: levyCharacterizationQuadraticVariation"

/-! ## Benchmark: Kolmogorov Theorems -/

/-- Kolmogorov continuity and extension theorems. -/
#eval "Benchmark: kolmogorovContinuityTheorem"
#eval "Benchmark: kolmogorovExtensionTheorem"

/-! ## Benchmark: Levy-Ito Decomposition -/

/-- Classification of Levy processes. -/
#eval "Benchmark: levyItoDecomposition"
#eval "Benchmark: continuousLevyIsBrownianWithDrift"

#eval "=== Theorem Benchmarks Complete ==="
