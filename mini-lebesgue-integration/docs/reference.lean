/-!
  # MiniLebesgueIntegration: API Reference

  Complete API reference for the MiniLebesgueIntegration package.

  ## Core Definitions

  ### `MiniLebesgueIntegration.Core.Basic`

  | Definition | Type | Description |
  |-----------|------|-------------|
  | `LebesgueIntegral f μ` | `ℝ≥0∞` | Integral of nonnegative f wrt μ |
  | `integrable f μ` | `Prop` | ∫\|f\| dμ < ∞ |
  | `L1Norm f μ` | `ℝ` | ‖f‖₁ = ∫\|f\| dμ |
  | `LpNorm f p μ` | `ℝ` | ‖f‖_p = (∫\|f\|^p)^{1/p} |
  | `LinfNorm f μ` | `ℝ` | ‖f‖_∞ = ess sup \|f\| |
  | `isLp f p μ` | `Prop` | f ∈ L^p(μ) |
  | `LpSpace α p μ` | `Type` | L^p space |
  | `HolderInequality` | theorem | Holder's inequality |
  | `MinkowskiInequality` | theorem | Minkowski's inequality |
  | `SimpleFunction α` | `Type` | Simple function structure |

  ### `MiniLebesgueIntegration.Core.Laws`

  | Definition | Description |
  |-----------|-------------|
  | `monotoneConvergenceTheorem` | MCT for nonnegative sequences |
  | `fatouLemma` | Fatou's lemma |
  | `dominatedConvergenceTheorem` | DCT for dominated sequences |
  | `linearityOfIntegral` | Linearity of Lebesgue integral |
  | `holderInequality` | Holder for conjugate exponents |
  | `minkowskiInequality` | Minkowski for L^p |
  | `jensenInequality` | Jensen for convex functions |

  ## Morphisms

  | Structure | Description |
  |-----------|-------------|
  | `IntegralPreservingMap μ ν` | Map preserving integrals |
  | `LpIsometry α β p μ ν` | Norm-preserving L^p map |
  | `FourierTransformMorphism α` | Fourier transform morphism |
  | `LpIsometricIsomorphism p q μ ν` | Isometric L^p isomorphism |
  | `LpMeasureEquivalence p μ ν` | L^p equivalence under measure change |

  ## Constructions

  | Theorem | Description |
  |---------|-------------|
  | `tonelliTheorem` | Tonelli for nonnegative functions |
  | `fubiniTheorem` | Fubini for integrable functions |
  | `aeEquivalent_equivalence` | a.e. equivalence is equiv. relation |
  | `stepFunctions_dense_in_Lp` | Step functions dense in L^p |
  | `L1_completion_of_Cc` | L¹ as completion of C_c |

  ## Main Theorems

  | Theorem | File |
  |---------|------|
  | `MCT` | `Theorems/Basic.lean` |
  | `Fatou` | `Theorems/Basic.lean` |
  | `DCT` | `Theorems/Basic.lean` |
  | `Holder` | `Theorems/Basic.lean` |
  | `Minkowski` | `Theorems/Basic.lean` |
  | `Chebyshev` | `Theorems/Basic.lean` |
  | `Jensen` | `Theorems/Basic.lean` |
  | `RieszFischer` | `Theorems/Main.lean` |
  | `L2_is_Hilbert` | `Theorems/Main.lean` |
  | `RieszRepresentation_LpDual` | `Theorems/UniversalProperties.lean` |
  | `RieszThorinInterpolation` | `Properties/ClassificationData.lean` |

  ## Examples

  See `Examples/Standard.lean` and `Examples/Counterexamples.lean`.

  ## Notation

  | Notation | Meaning |
  |----------|---------|
  | `∫ f dμ` | Lebesgue integral |
  | `‖f‖₁[μ]` | L¹ norm |
  | `‖f‖p[μ]` | L^p norm |
  | `‖f‖∞[μ]` | L^∞ norm |
-/

#eval "API Reference — complete documentation of all definitions and theorems"
#eval "30+ definitions, 15+ major theorems, 6 convergence/integral theorems"
#eval "Namespace: MiniLebesgueIntegration"
