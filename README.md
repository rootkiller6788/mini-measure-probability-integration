# Mini Measure, Probability & Integration

A collection of **from-scratch Lean 4 implementations** of university-level measure theory, probability theory, and integration. Each sub-package maps to MIT and other top-tier university courses, building the foundations of measure and probability from first principles using the Lean 4 proof assistant and kernel libraries.

## Sub-Packages

| Sub-Package | Topics | Key Courses |
|-------------|--------|-------------|
| [mini-measure-theory](mini-measure-theory/) | Measures, σ-algebras, Caratheodory extension, Borel measures | MIT 18.102, Stanford Math 172 |
| [mini-measurable-functions](mini-measurable-functions/) | Measurable functions, simple functions, approximation theorems | MIT 18.102, Harvard Math 212 |
| [mini-lebesgue-integration](mini-lebesgue-integration/) | Lebesgue integral, dominated convergence, Fubini, L^p spaces | MIT 18.102, Princeton MAT 570 |
| [mini-product-fubini](mini-product-fubini/) | Product measures, Fubini-Tonelli, convolution, iterated integrals | MIT 18.102, Berkeley Math 202B |
| [mini-probability-theory](mini-probability-theory/) | Probability spaces, random variables, expectation, distributions, moments | MIT 18.05, Stanford Math 151 |
| [mini-independence-convergence](mini-independence-convergence/) | Independence, law of large numbers, central limit theorem, modes of convergence | MIT 18.05, Harvard Stat 110 |
| [mini-conditional-martingale](mini-conditional-martingale/) | Conditional expectation, martingales, stopping times, optional stopping | MIT 18.177, Cambridge Part III |
| [mini-stochastic-processes](mini-stochastic-processes/) | Brownian motion, Markov chains, Poisson processes, Ito calculus | MIT 18.177, Stanford Math 228 |

## Design Philosophy

- **Zero external dependencies** -- pure Lean 4, only kernel + sibling imports
- **Self-contained sub-packages** -- each with `lakefile.lean`, Core/, Morphisms/, Constructions/, Theorems/
- **Theory-to-code mapping** -- inline `#eval` examples and theorem statements throughout

## Building

```bash
cd mini-measure-theory
lake build
lake env lean --run Test/Smoke.lean
```

Requires **Lean 4** and **Lake**.

## Project Structure

```
8. mini-measure-probability-integration/
├── mini-measure-theory/            # Measures, σ-algebras, Caratheodory extension
├── mini-measurable-functions/      # Measurable functions, approximation theorems
├── mini-lebesgue-integration/      # Lebesgue integral, DCT, Fubini, L^p
├── mini-product-fubini/            # Product measures, Fubini-Tonelli, convolution
├── mini-probability-theory/        # Probability spaces, random variables, moments
├── mini-independence-convergence/  # LLN, CLT, modes of convergence
├── mini-conditional-martingale/    # Conditional expectation, martingales, stopping
└── mini-stochastic-processes/      # Brownian motion, Markov chains, Ito calculus
```

## License

MIT
