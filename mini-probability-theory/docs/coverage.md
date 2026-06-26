# mini-probability-theory: Coverage Analysis

## Core Concepts Covered

| Concept | Status | File |
|---------|--------|------|
| Probability Space | Defined | Core/Basic.lean |
| Random Variable | Defined | Core/Basic.lean |
| Distribution (pushforward) | Defined | Core/Basic.lean |
| CDF | Defined | Core/Basic.lean |
| PDF (Radon-Nikodym) | Defined | Core/Basic.lean |
| Expectation | Defined | Core/Basic.lean |
| Variance | Defined | Core/Basic.lean |
| Moments | Defined | Core/Basic.lean |
| MGF | Defined | Core/Basic.lean |
| Characteristic Function | Defined | Core/Basic.lean |
| Coupling | Defined | Morphisms/Hom.lean |
| Copula | Defined | Morphisms/Hom.lean |
| Markov Kernel | Defined | Morphisms/Hom.lean |
| Equality in Distribution | Defined | Morphisms/Iso.lean |
| Product Probability | Defined | Constructions/Products.lean |
| Independence | Defined | Constructions/Products.lean |
| Conditional Probability | Defined | Constructions/Quotients.lean |
| Bayes Theorem | Stated | Constructions/Quotients.lean |
| AC/Discrete/Singular | Defined | Constructions/Subobjects.lean |
| De Finetti Theorem | Stated | Constructions/Universal.lean |

## Theorems Covered

| Theorem | Status |
|---------|--------|
| Linearity of Expectation | Stated |
| Chebyshev Inequality | Stated |
| Markov Inequality | Stated |
| Cauchy-Schwarz (Expectation) | Stated |
| Levy Continuity Theorem | Stated (sorry) |
| Cramer Continuity Theorem | Stated (sorry) |
| Uniqueness of Ch.F. | Stated (sorry) |
| Portmanteau Theorem | Stated (sorry) |
| SLLN | Stated (sorry) |
| CLT | Stated (sorry) |
| Kolmogorov Extension | Stated (sorry) |
| Berry-Esseen | Stated (sorry) |
| De Finetti | Stated (sorry) |
| Cramer-Rao | Stated (sorry) |

## Distribution Families

| Family | Status |
|--------|--------|
| Bernoulli(p) | Defined |
| Binomial(n,p) | Defined |
| Normal(μ,σ²) | Defined |
| Poisson(λ) | Defined |
| Exponential(λ) | Defined |
| Uniform[a,b] | Defined |
| Gamma(α,β) | Defined |
| Beta(α,β) | Defined |
| Chi-squared(k) | Defined |
| Student's t(ν) | Defined |
| Cauchy(x₀,γ) | Defined |
| Pareto(xm,α) | Defined |

## Bridges

| Connection | File |
|------------|------|
| Algebra (PGF, cumulants, L^p) | Bridges/ToAlgebra.lean |
| Topology (weak conv., Prokhorov) | Bridges/ToTopology.lean |
| Geometry (Fisher, exp. families) | Bridges/ToGeometry.lean |
| Computation (MC, MCMC) | Bridges/ToComputation.lean |
