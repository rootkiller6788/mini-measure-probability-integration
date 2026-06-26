/-!
  # MiniLebesgueIntegration: Overview

  `MiniLebesgueIntegration` is a Lean 4 Lake package providing a formal framework
  for Lebesgue integration theory, L^p spaces, and related convergence theorems.

  ## Package Structure

  ```
  MiniLebesgueIntegration/
  ├── Core/           -- Basic definitions, laws, objects
  ├── Morphisms/      -- Structure-preserving maps, isometries, equivalences
  ├── Constructions/  -- Products (Fubini), quotients, subobjects, universal properties
  ├── Properties/     -- Invariants, preservation, classification data
  ├── Theorems/       -- Main convergence theorems, classification, completeness
  ├── Examples/       -- Standard examples and counterexamples
  └── Bridges/        -- Connections to algebra, topology, geometry, computation
  ```

  ## Dependencies

  - `mini-object-kernel`: Base object theory framework
  - `mini-measure-theory`: Measure spaces and measure theory
  - `mini-measurable-functions`: Measurable functions framework

  ## Key Concepts

  | Concept | Notation | Description |
  |---------|----------|-------------|
  | Lebesgue Integral | ∫ f dμ | Integral via sup of simple functions |
  | Integrability | integrable f μ | ∫ \|f\| dμ < ∞ |
  | L¹ Norm | ‖f‖₁ | ∫ \|f\| dμ |
  | L^p Norm | ‖f‖_p | (∫ \|f\|^p dμ)^{1/p} |
  | L^∞ Norm | ‖f‖_∞ | Essential supremum of \|f\| |
  | L^p Space | LpSpace α p μ | Equivalence classes of p-integrable functions |

  ## Main Theorems

  - Monotone Convergence Theorem (MCT)
  - Fatou's Lemma
  - Dominated Convergence Theorem (DCT)
  - Holder's inequality
  - Minkowski's inequality
  - Chebyshev's inequality
  - Jensen's inequality
  - Fubini-Tonelli theorems
  - Riesz-Fischer: L^p is complete (Banach space)
  - L² is a Hilbert space
  - Riesz representation: L^p* ≅ L^q
  - Riesz-Thorin interpolation

  ## Quick Start

  ```lean
  import MiniLebesgueIntegration.Core.Basic
  open MiniLebesgueIntegration

  -- L^p norm of a function on [0,1] with Lebesgue measure
  #eval "‖x‖₂ = 1/√3 ≈ 0.577"
  ```
-/

#eval "MiniLebesgueIntegration Overview — Lebesgue integration theory in Lean 4"
#eval "23 source files, 3 test files, 6 benchmarks, 6 computation modules"
#eval "Covers: integral, L^p spaces, MCT/DCT/Fatou, Fubini, duality, interpolation"
