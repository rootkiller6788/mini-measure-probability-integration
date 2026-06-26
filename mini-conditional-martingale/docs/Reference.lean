/-
# MiniConditionalMartingale: API Reference

Complete API reference for all public definitions and theorems.

## Conditional Expectation `MiniConditionalMartingale.Core.Basic`

| Symbol | Type | Description |
|--------|------|-------------|
| `ConditionalExpectation X 𝒢 μ` | `Type` | E[X\|𝒢] — conditional expectation |
| `E[X \| 𝒢]` | notation | Notation for conditional expectation |
| `conditionalProbability A 𝒢 μ` | `α → ℝ` | P(A\|𝒢) = E[1_A\|𝒢] |
| `conditionalVariance X 𝒢 μ` | `α → ℝ` | Var(X\|𝒢) |

## Filtration `MiniConditionalMartingale.Core.Basic`

| Symbol | Type | Description |
|--------|------|-------------|
| `Filtration α` | `Type` | Increasing family of σ-algebras F_n |
| `adapted X ℱ` | `Prop` | X_n is F_n-measurable ∀n |

## Martingales `MiniConditionalMartingale.Core.Basic`

| Symbol | Type | Description |
|--------|------|-------------|
| `Martingale X ℱ μ` | `Prop` | E[X_{n+1}\|F_n] = X_n |
| `Submartingale X ℱ μ` | `Prop` | E[X_{n+1}\|F_n] ≥ X_n |
| `Supermartingale X ℱ μ` | `Prop` | E[X_{n+1}\|F_n] ≤ X_n |

## Stopping Times `MiniConditionalMartingale.Core.Basic`

| Symbol | Type | Description |
|--------|------|-------------|
| `StoppingTime α ℱ` | `Type` | {τ ≤ n} ∈ F_n ∀n |
| `stoppedProcess X τ` | `ℕ → α → ℝ` | X_{τ∧n} |
| `OptionalStopping` | `theorem` | E[X_τ] = E[X_0] for bounded τ |

## Laws `MiniConditionalMartingale.Core.Laws`

| Symbol | Type | Description |
|--------|------|-------------|
| `condExpectation_linear` | `theorem` | Linearity of E[·\|𝒢] |
| `condExpectation_tower` | `theorem` | Tower property |
| `condExpectation_pullOut` | `theorem` | Pull-out property |
| `condExpectation_independence` | `theorem` | Independence ⇒ E[X\|𝒢] = E[X] |
| `doobDecomposition` | `theorem` | X = M + A decomposition |
| `optionalStoppingTheorem` | `theorem` | OST for UI martingales |

## Morphisms `MiniConditionalMartingale.Morphisms`

| Symbol | Type | Description |
|--------|------|-------------|
| `martingaleTransform H X` | `ℕ → α → ℝ` | (H·X)_n discrete Ito integral |
| `predictable H ℱ` | `Prop` | H_n is F_{n-1}-measurable |
| `equivalentMeasure μ ν` | `Prop` | P ~ Q |
| `riskNeutralMeasure` | `Type` | Equivalent martingale measure |
| `compensator X ℱ μ` | `Type` | Doob-Meyer compensator |

## Properties `MiniConditionalMartingale.Properties`

| Symbol | Type | Description |
|--------|------|-------------|
| `quadraticVariation X` | `ℕ → α → ℝ` | [X]_n = Σ(ΔX_k)² |
| `predictableVariation X ℱ μ` | `ℕ → α → ℝ` | ⟨X⟩_n angle bracket |
| `convex_submartingale` | `theorem` | φ convex, X subM ⇒ φ(X) subM |
| `boundedMartingale X ℱ μ` | `Prop` | |X_n| ≤ M |
| `LpMartingale X ℱ μ p` | `Prop` | sup ‖X_n‖_p < ∞ |
| `uniformlyIntegrable X μ` | `Prop` | UI family |

## Theorems `MiniConditionalMartingale.Theorems`

| Symbol | Type | Description |
|--------|------|-------------|
| `doobMaximalInequality` | `theorem` | λ·P(sup X_k ≥ λ) ≤ E[X_n^+] |
| `doobUpcrossingInequality` | `theorem` | E[U[a,b]] ≤ E[(X_n-a)^+]/(b-a) |
| `martingaleConvergenceTheorem` | `theorem` | L^1-bdd ⇒ a.s. conv |
| `levyZeroOneLaw` | `theorem` | E[Y\|F_n] → Y a.s. |
| `bdgInequality` | `theorem` | BDG bounds |
| `ui_martingale_closed` | `theorem` | UI ⟺ closed |
| `snellEnvelope_optimalStopping` | `theorem` | U_0 = sup_τ E[Z_τ] |

## Examples `MiniConditionalMartingale.Examples`

| Symbol | Type | Description |
|--------|------|-------------|
| `symmetricRandomWalk` | `ℕ → ℕ → ℝ` | S_n = Σ X_i, X_i = ±1 |
| `exponentialMartingale θ` | `ℕ → (ℕ→ℕ) → ℝ` | M_n = exp(θS_n)/(cosh θ)^n |
| `coinTossFiltration` | `Filtration` | Natural filtration on {0,1}^ℕ |
| `doubleOrNothing` | `ℕ → ℕ → ℝ` | X_n = 2^n or 0 |

## Bridges `MiniConditionalMartingale.Bridges`

| Symbol | Type | Description |
|--------|------|-------------|
| `discreteItoIntegral` | `ℕ → α → ℝ` | (H·X) discrete Ito |
| `stochasticExponential X` | `ℕ → α → ℝ` | E(X) Doleans-Dade |
| `ucpConvergence` | `Prop` | Uniform in probability |
| `ManifoldMartingale` | `Type` | Martingale on manifold |
-/

#eval "API Reference: complete listing of all definitions and theorems"
