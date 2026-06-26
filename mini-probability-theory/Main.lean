import MiniProbabilityTheory

open MiniProbabilityTheory

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniProbabilityTheory v0.1.0"
  IO.println "  Probability Theory Package"
  IO.println "═══════════════════════════════════════"
  IO.println s!"  ProbabilitySpace: (Ω, F, P) with P(Ω) = 1"
  IO.println s!"  RandomVariable: measurable function X : Ω → ℝ"
  IO.println s!"  distribution: pushforward measure P_X = P ∘ X⁻¹"
  IO.println s!"  CDF: cumulative distribution function F_X(t) = P(X ≤ t)"
  IO.println s!"  PDF: probability density function (Radon-Nikodym derivative)"
  IO.println s!"  Expectation: E[X] = ∫ X dP"
  IO.println s!"  Variance: Var(X) = E[(X - E[X])²]"
  IO.println s!"  Standard deviation: σ_X = √Var(X)"
  IO.println s!"  Moments: E[X^k], central moments E[(X - μ)^k]"
  IO.println s!"  MGF: moment generating function M_X(t) = E[e^{tX}]"
  IO.println s!"  Characteristic function: φ_X(t) = E[e^{itX}]"
  IO.println s!"  Common distributions: Bernoulli, Binomial, Poisson, Normal, Exponential, Gamma"
  IO.println ""
  IO.println "  Depends on: mini-object-kernel, mini-measure-theory, mini-lebesgue-integration"
  IO.println "  Run `lake env lean --run Test/Basic.lean` for tests."
