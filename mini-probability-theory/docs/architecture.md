# mini-probability-theory: Architecture

## Package Structure

```
mini-probability-theory/
  lakefile.lean
  Main.lean
  MiniProbabilityTheory.lean           -- Top-level module
  MiniProbabilityTheory/
    Core/
      Basic.lean        -- ProbabilitySpace, RandomVariable, Distribution, CDF, PDF, Expectation, Variance, Moment, MGF, CharacteristicFunction
      Laws.lean         -- Linearity, Chebyshev, Markov, Cauchy-Schwarz, Jensen
      Objects.lean      -- Object registration, subobjects, quotients
    Morphisms/
      Hom.lean          -- Coupling, Copula, ProbabilityKernel (Markov kernel)
      Iso.lean          -- Equality in distribution, ProbEquiv
      Equiv.lean        -- Wasserstein, total variation, KL, Hellinger distances
    Constructions/
      Products.lean     -- Product probability space, joint/marginal distributions
      Quotients.lean    -- Conditional probability, regular conditional probability
      Subobjects.lean   -- AC/discrete/singular distributions, mixtures
      Universal.lean    -- Universal property, de Finetti theorem
    Properties/
      Invariants.lean         -- Mean, variance, skewness, kurtosis, entropy, mutual information
      Preservation.lean       -- Expectation/variance under affine transforms
      ClassificationData.lean -- Distribution families (Normal, Poisson, Gamma, etc.)
    Theorems/
      Basic.lean              -- Levy, Cramer, Portmanteau, Berry-Esseen
      Classification.lean     -- Moment problem, determinacy
      Main.lean               -- SLLN, CLT, Kolmogorov extension
      UniversalProperties.lean -- Expectation minimizes MSE, max entropy
    Examples/
      Standard.lean          -- Bernoulli, Binomial, Normal, Poisson, Exponential, Uniform
      Counterexamples.lean   -- Cauchy (no mean), log-normal (not moment-det)
    Bridges/
      ToAlgebra.lean         -- PGF, cumulants, L^p spaces
      ToTopology.lean        -- Weak convergence, Prokhorov metric, tightness
      ToGeometry.lean        -- Fisher metric, exponential families, Cramer-Rao
      ToComputation.lean     -- Monte Carlo, inverse CDF, MCMC
  Test/
    Smoke.lean
    Examples.lean
    Regression.lean
  Benchmark/
    CambridgePartIII.lean
    CoreCoverage.lean
    Harvard.lean
    MIT.lean
    OxfordPartC.lean
    Princeton.lean
  Computation/
    Evaluate.lean
    Algorithms.lean
    DecisionProcedures.lean
    notebooks/   (Python/Jupyter)
    python/       (Python bindings)
    sage/         (SageMath)
  docs/
    architecture.md
    coverage.md
    dependency.md
  scripts/
    check.ps1
    check.sh
```

## Design Principles

1. **Measure-theoretic foundation**: Probability is built on measure theory.
   Every probability space is a measure space with total mass 1.

2. **Object system**: All structures inherit from MiniMathKernel.Object,
   enabling unified representation, serialization, and theory metadata.

3. **Axiomatic approach**: Deep theorems (SLLN, CLT) are stated with `sorry`
   proofs, serving as a formal specification rather than a fully verified proof
   assistant library.

4. **Bridges to other theories**: Connections to algebra (PGF, cumulants),
   topology (weak convergence, Prokhorov), geometry (Fisher metric), and
   computation (sampling, MCMC).

5. **Comprehensive examples and counterexamples**: Standard distribution families
   with their properties, and counterexamples demonstrating boundaries of theorems.
