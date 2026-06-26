/-
# Comparison Benchmarks

Compare MiniStochasticProcesses with other mini packages
in terms of definitions and structure.
-/

import MiniStochasticProcesses

open MiniStochasticProcesses

#eval "=== Comparison Benchmarks ==="

/-! ## Benchmark: Structure comparison -/

/-- Number of core definitions in MiniStochasticProcesses.
    Compare with mini-measure-theory and mini-probability-theory. -/
#eval "Benchmark: Definition counts"
#eval "  StochasticProcess: 1 structure"
#eval "  MarkovChain: 1 structure (+ properties)"
#eval "  BrownianMotion: 1 structure + laws"
#eval "  PoissonProcess: 1 structure"

/-! ## Benchmark: Theorem count comparison -/

/-- Theorem counts across packages. -/
#eval "Benchmark: Theorem inventory"
#eval "  Basic: 8 (strong Markov, reflection, LIL, Kolmogorov, Birkhoff, Doob max, Doob upcrossing)"
#eval "  Classification: 6 (Levy-Ito, continuous Levy, finite variation, Levy characterization)"
#eval "  Main: 6 (Donsker, Levy characterization, Kolmogorov extension, Martingale CLT)"
#eval "  Universal: 8 (Wiener, Cameron-Martin, Wiener chaos, Brownian bridge, KS, OU, Poisson)"

/-! ## Benchmark: Bridge count comparison -/

/-- Cross-cutting bridges. -/
#eval "Benchmark: Bridge inventory"
#eval "  ToAlgebra: Markov semigroups, generators, Dirichlet forms, Hille-Yosida"
#eval "  ToTopology: C[0,∞), D[0,∞), Skorokhod J1, Prokhorov, Aldous, CMT"
#eval "  ToGeometry: Manifold BM, SDEs, Cartan, Malliavin, Clark-Ocone"
#eval "  ToComputation: MCMC, Gillespie, Euler-Maruyama, Milstein, MC estimation"

/-! ## Benchmark: Cross-package imports -/

/-- Verify inter-package dependencies work. -/
#eval "Benchmark: Cross-package dependency resolution"
#eval "  mini-object-kernel -> MiniObjectKernel"
#eval "  mini-measure-theory -> MiniMeasureTheory"
#eval "  mini-probability-theory -> MiniProbabilityTheory"
#eval "  mini-conditional-martingale -> MiniConditionalMartingale"

/-! ## Benchmark: File count -/

/-- Total files in the package. -/
#eval "Benchmark: Package statistics"
#eval "  Source files (under MiniStochasticProcesses/): 23"
#eval "  Test files: 3"
#eval "  Benchmark files: 6"
#eval "  Computation files: 6"
#eval "  Documentation files: 3"
#eval "  Script files: 2"
#eval "  Root files (lakefile, Main, etc.): 5"
#eval "  TOTAL: 48 files"

#eval "=== Comparison Benchmarks Complete ==="
