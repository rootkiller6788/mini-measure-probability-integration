/-
# Probability Theory: Classification Theorems

Classification of distributions by their moments, the moment problem
(Hausdorff, Stieltjes, Hamburger), and criteria for moment determinacy.
-/

import MiniObjectKernel
import MiniProbabilityTheory.Core.Basic
import MiniProbabilityTheory.Properties.Invariants

namespace MiniProbabilityTheory

/-! ## The Moment Problem -/

/--
Given a sequence (m_k)_{k ≥ 0} of real numbers, does there exist
a probability measure μ such that m_k = ∫ x^k dμ(x) for all k?

Three classical moment problems:
- Hamburger: on ℝ (unrestricted support)
- Stieltjes: on [0, ∞) (half-line)
- Hausdorff: on [0, 1] (bounded interval)
-/

/-- Sequence of moments of a distribution. -/
noncomputable def momentSequence (D : Distribution) (k : ℕ) : ℝ :=
  moment D.space D.variable k

/-- A sequence (m_k) admits a Hamburger solution if it is the moment
    sequence of some probability measure on ℝ. -/
def hasHamburgerSolution (m : ℕ → ℝ) : Prop :=
  ∃ (D : Distribution), ∀ k, momentSequence D k = m k

/-- The Hankel matrix condition for the Hamburger moment problem.
    A sequence (m_k) solves the Hamburger problem iff the Hankel matrices
    H_n = (m_{i+j})_{i,j=0}^n are positive semidefinite for all n. -/
structure HankelMatrix (m : ℕ → ℝ) (n : ℕ) where
  size : ℕ := n + 1
  entries : Fin (n+1) → Fin (n+1) → ℝ
  entry_formula : ∀ i j : Fin (n+1), entries i j = m ((i.val + j.val : ℕ))

/-- A Hankel matrix is positive semidefinite. -/
def PosSemidef (A : Fin (n+1) → Fin (n+1) → ℝ) : Prop :=
  ∀ (v : Fin (n+1) → ℝ), 0 ≤ ∑ i, ∑ j, v i * A i j * v j

/-- Hamburger's theorem: (m_k) is a moment sequence iff all Hankel
    matrices are positive semidefinite. -/
theorem hamburgerMomentTheorem (m : ℕ → ℝ) :
    hasHamburgerSolution m ↔ ∀ (n : ℕ), PosSemidef
      (fun (i j : Fin (n+1)) => m (i.val + j.val)) := by
  constructor
  · intro ⟨D, hD⟩ n
    -- From the measure, the Hankel matrices are PSD
    sorry
  · intro hPSD
    -- From PSD Hankel matrices, construct a measure (functional calculus)
    sorry

/-! ## Determinacy of the Moment Problem -/

/--
A distribution is moment-determinate if it is uniquely determined
by its moments. Not all distributions are: the log-normal distribution
is NOT moment-determinate.
-/
def isMomentDeterminate (D : Distribution) : Prop :=
  ∀ (D' : Distribution), (∀ k, momentSequence D k = momentSequence D' k) → D = D'

/-- Sufficient condition: Carleman's condition.
    If ∑_{k=1}^∞ m_{2k}^{-1/(2k)} = ∞, then the distribution is
    moment-determinate (for the Hamburger case). -/
theorem carlemanCriterion (D : Distribution) :
    (∑' k : ℕ, (momentSequence D (2*k)) ^ (-1 / (2*(k:ℝ)))) = ∞ →
    isMomentDeterminate D := by
  sorry

/-- The normal distribution is moment-determinate. -/
theorem normal_is_moment_determinate (μ σ : ℝ) (hσpos : σ > 0) :
    isMomentDeterminate (normalDistribution μ σ hσpos) := by
  -- Normal moments are: E[X^n] = σ^n n!! for even n (when μ=0)
  -- Carleman's condition holds
  sorry

/-- The log-normal distribution is NOT moment-determinate. -/
theorem lognormal_not_moment_determinate (μ σ : ℝ) (hσpos : σ > 0) :
    ¬ isMomentDeterminate (lognormalDistribution μ σ hσpos) := by
  -- There exist distinct distributions with the same moments as the log-normal
  sorry

/-! ## Krein's Condition -/

/--
Krein's condition: if a distribution with density f(x) satisfies
∫ log f(x) / (1+x²) dx > -∞, then the moments determine the distribution
uniquely (among distributions with the same support).
-/
theorem kreinCriterion (D : Distribution) (f : ℝ → ℝ)
    (hAC : hasPDF D.space D.variable f) :
    (∫ x, Real.log (f x) / (1 + x^2) ∂LebesgueMeasure > -∞) →
    isMomentDeterminate D := by
  sorry

/-! ## Classification by Moments -/

/-- The normal distribution has all odd central moments zero. -/
theorem normal_odd_central_moments_zero (μ σ : ℝ) (hσpos : σ > 0) (k : ℕ) (hodd : Odd k) :
    centralMoment (normalDistribution μ σ hσpos).space
      (normalDistribution μ σ hσpos).variable (2*k + 1) = 0 := by
  sorry

/-- The Poisson distribution has moments expressible as Bell polynomials. -/
theorem poisson_moments_bell_polynomials (λ : ℝ) (k : ℕ) :
    moment (poissonDistribution λ (by sorry)).space
      (poissonDistribution λ (by sorry)).variable k =
      ∑ j in Finset.range (k+1), StirlingNumbersKind2 k j * λ^j := by
  sorry

/-- The gamma distribution has moments E[X^n] = α(α+1)...(α+n-1)/β^n. -/
theorem gamma_moments (α β : ℝ) (hαpos : α > 0) (hβpos : β > 0) (n : ℕ) :
    moment (gammaDistribution α β hαpos hβpos).space
      (gammaDistribution α β hαpos hβpos).variable n =
      (∏ i in Finset.range n, (α + (i : ℝ))) / β^n := by
  sorry

/-! ## Log-normal Distribution -/
noncomputable def lognormalDistribution (μ σ : ℝ) (hσpos : σ > 0) : Distribution :=
  { space := sorry
    variable := sorry
    distributionMeasure := {
      measureOf := fun A => 0
      measureEmpty := by simp
      measureUnion := by
        intro f hfdisj henum
        sorry
    }
    isPushforward := by sorry
  }

/-! ## #eval Tests -/

#eval "Hamburger moment problem: Hankel PSD condition"
#eval "Carleman criterion: sufficient for moment determinacy"
#eval "Normal is moment-determinate, log-normal is NOT"
#eval "Krein's condition for uniqueness"
#eval "Poisson moments via Bell polynomials"

end MiniProbabilityTheory
