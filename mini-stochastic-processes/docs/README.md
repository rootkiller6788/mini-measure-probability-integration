# MiniStochasticProcesses Documentation

## Overview

`mini-stochastic-processes` is a Lean 4 Lake package formalizing the theory of stochastic processes, built on the MiniMathKernel ecosystem.

## Package Structure

```
mini-stochastic-processes/
  lakefile.lean        -- Package configuration
  Main.lean            -- Entry point
  MiniStochasticProcesses.lean  -- Umbrella import
  MiniStochasticProcesses/
    Core/              -- Fundamental definitions
    Morphisms/         -- Process maps and equivalences
    Constructions/     -- Products, quotients, subobjects
    Properties/        -- Invariants and preservation
    Theorems/          -- Major theorems
    Examples/          -- Standard examples and counterexamples
    Bridges/           -- Connections to other theories
  Test/                -- Test suite
  Benchmark/           -- Performance benchmarks
  Computation/         -- Computational tools
  docs/                -- Documentation
  scripts/             -- Build scripts
```

## Dependencies

- `mini-object-kernel` -- Mathematical object kernel
- `mini-measure-theory` -- Measure theory
- `mini-probability-theory` -- Probability theory
- `mini-conditional-martingale` -- Conditional expectation and martingales

## Core Concepts

- **StochasticProcess**: Family of random variables {X_t}_{t in T}
- **MarkovChain**: Discrete-time Markov process with transition kernel
- **BrownianMotion**: Gaussian process with independent increments and continuous paths
- **PoissonProcess**: Counting process with independent Poisson-distributed increments
- **LevyProcess**: Process with stationary independent increments
- **StationaryProcess**: Shift-invariant process distribution
- **ErgodicProcess**: All shift-invariant events have probability 0 or 1

## Getting Started

```bash
cd mini-stochastic-processes
lake build
lake env lean --run Main.lean
lake env lean --run Test/Smoke.lean
```
