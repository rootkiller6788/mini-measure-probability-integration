/-!
  # MiniLebesgueIntegration: Contributing Guide

  ## How to Contribute

  MiniLebesgueIntegration is a formalization of Lebesgue integration theory
  in Lean 4. Contributions are welcome for filling in `sorry` proofs,
  adding new theorems, and improving documentation.

  ## Project Structure

  Each source file follows the pattern:
  - Module docstring describing the file's purpose
  - Imports from dependencies and sibling modules
  - Namespace `MiniLebesgueIntegration`
  - Definitions and theorems
  - `#eval` examples at the bottom

  ## Proof Guidelines

  1. **Deep proofs use `sorry`**: Fundamental theorems (MCT, DCT, Riesz-Fischer)
     are stated with `sorry` for their deep proofs.

  2. **Complete simple proofs**: Lemmas, structural properties, and examples
     should have complete or near-complete proofs.

  3. **Follow Mathlib4 conventions**: Use `Measurable`, `Measure`, `ENNReal`
     from MiniObjectKernel and sibling packages.

  4. **Document with `/-! ... -/`**: Every module has a docstring.

  ## Adding New Theorems

  1. Add to the appropriate subdirectory (Core, Theorems, Properties, etc.)
  2. State the theorem with hypotheses and conclusion
  3. Use `sorry` for deep analytic proofs
  4. Add an `#eval` example demonstrating usage
  5. Update `docs/reference.lean` with the new definition

  ## Areas Needing Work

  - Fill in MCT, DCT, Fatou proofs
  - Complete Riesz-Fischer (L^p completeness)
  - Riesz representation theorem for L^p duals
  - Fubini-Tonelli proofs
  - Interpolation theorems (Riesz-Thorin, Marcinkiewicz)
  - Convolution algebra structure on L¹(G)

  ## Style Guide

  - Use `set_option pp.unicode.fun true`
  - Use `set_option maxHeartbeats 400000`
  - Namespace: `MiniLebesgueIntegration`
  - Open `MiniObjectKernel`, `MiniMeasureTheory`, `MiniMeasurableFunctions`
  - Use `variable` for common bindings
  - Notation: `∫ f dμ`, `‖f‖p[μ]`, etc.

  ## Testing

  Run the test suite:
  ```bash
  lake build
  lake exe test
  ```

  See `test/` directory for test files.
-/

#eval "Contributing Guide — structure, proof conventions, style"
#eval "Areas: MCT/DCT/Fatou, Riesz-Fischer, Riesz representation, Fubini, interpolation"
#eval "Style: namespace MiniLebesgueIntegration, maxHeartbeats 400000, unicode fun"
