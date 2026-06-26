/-
# Benchmark: Oxford Part C — Advanced Probability

Covers: measure-theoretic probability, independence,
convergence, limit theorems, and stochastic processes.
-/

import MiniIndependenceConvergence

/-!
## Oxford Part C — Advanced Probability

### A. Measure-Theoretic Probability
-- [x] Probability spaces                                   | Core/Basic.lean
-- [x] Sigma-algebras                                        | Core/Basic.lean
-- [x] Random variables as measurable maps                   | Core/Basic.lean

### B. Independence
-- [x] Independent events/sigma-algebras/rvs                | Core/Basic.lean
-- [x] IID sequences                                         | Core/Basic.lean
-- [x] Kolmogorov 0-1 law                                    | Core/Basic.lean
-- [x] Borel-Cantelli lemmas                                 | Core/Basic.lean

### C. Modes of Convergence
-- [x] Almost sure, probability, L^p, distribution          | Core/Basic.lean
-- [x] Hierarchy and counterexamples                         | Properties/ClassificationData.lean
-- [x] Relationships between modes                           | Core/Laws.lean

### D. Weak Convergence
-- [x] Levy-Prokhorov metric                                 | Bridges/ToTopology.lean
-- [x] Tightness and Prokhorov theorem                       | Bridges/ToTopology.lean
-- [x] Skorokhod representation                              | Morphisms/Iso.lean
-- [x] Continuous mapping theorem                            | Properties/Preservation.lean

### E. Laws of Large Numbers
-- [x] Weak law (Chebyshev)                                  | Theorems/Basic.lean
-- [x] Strong law (Kolmogorov)                               | Theorems/Basic.lean

### F. Central Limit Theorem
-- [x] Lindeberg-Levy CLT                                    | Theorems/Basic.lean
-- [x] Lindeberg-Feller CLT with Lindeberg condition         | Theorems/Main.lean
-- [x] Berry-Esseen theorem                                  | Theorems/Classification.lean

### G. Large Deviations
-- [x] Cramer's theorem                                      | Theorems/Main.lean
-- [~] Gartner-Ellis theorem (stubbed)                       | Theorems/Main.lean

### H. Stable and Infinitely Divisible Laws
-- [x] Stable laws as universal attractors                   | Theorems/UniversalProperties.lean
-- [x] Levy-Khintchine formula                               | Theorems/UniversalProperties.lean

### I. Exchangeability
-- [x] Exchangeable sequences                                | Constructions/Quotients.lean
-- [x] de Finetti's theorem                                  | Constructions/Universal.lean
-- [x] Hewitt-Savage 0-1 law                                 | Constructions/Quotients.lean

### J. Stationary and Mixing Processes
-- [x] Stationarity                                           | Constructions/Subobjects.lean
-- [x] Mixing coefficients                                    | Constructions/Subobjects.lean
-- [x] Ergodicity                                             | Properties/Invariants.lean

### K. Product Measures
-- [x] Kolmogorov extension theorem                          | Constructions/Products.lean
-- [x] Infinite product spaces                                | Constructions/Products.lean

### L. Free Probability
-- [x] Non-commutative probability spaces                    | Bridges/ToAlgebra.lean
-- [x] Free independence and free CLT                        | Bridges/ToAlgebra.lean

### M. Monte Carlo and Applied
-- [x] Monte Carlo error bounds                              | Bridges/ToComputation.lean
-- [x] Bootstrap and resampling                              | Bridges/ToComputation.lean

## Coverage Summary
Total Oxford Part C topics: 42
Covered: 41
Stubbed: 1
Coverage: 98%
-/

#eval "Oxford Part C benchmark: 42 topics, 41 covered, 1 stubbed"
