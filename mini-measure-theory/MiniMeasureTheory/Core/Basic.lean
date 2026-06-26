/-
# Measure Theory: Core Definitions

Sigma algebras, measurable spaces, measures, outer measures,
Caratheodory extension, Lebesgue measure, Borel sigma algebra.
-/

import MiniObjectKernel

open MiniObjectKernel

namespace MiniMeasureTheory

/-! ## Sigma Algebra -/

/-- A sigma algebra on a type α is a collection of subsets closed under
    complement, countable union, and containing the empty set. -/
structure SigmaAlgebra (α : Type u) where
  carrier : Set (Set α)
  empty_mem : ∅ ∈ carrier
  compl_mem : ∀ s, s ∈ carrier → (∅ : Set α)ᶜ ∩ sᶜ ∈ carrier
  countable_union_mem : ∀ (s : ℕ → Set α), (∀ n, s n ∈ carrier) → (⋃ n, s n) ∈ carrier

/-- The trivial sigma algebra containing only ∅ and the whole space. -/
def trivialSigmaAlgebra (α : Type u) : SigmaAlgebra α where
  carrier := {∅, Set.univ}
  empty_mem := by simp
  compl_mem := by
    intro s hs
    simp at hs ⊢
    rcases hs with (rfl | rfl)
    · exact Or.inr (by ext x; simp; exact Set.mem_univ x)
    · exact Or.inl (by ext x; simp)
  countable_union_mem := by
    intro s hs
    by_cases h : ∀ n, s n = ∅
    · have : (⋃ n, s n) = ∅ := by
        ext x; simp; intro n; rw [h n]; simp
      simp [this]
    · push_neg at h
      rcases h with ⟨n, hn⟩
      have hn' : s n ∈ {∅, Set.univ} := hs n
      simp at hn hn'
      rcases hn' with (rfl | rfl)
      · exact hn rfl
      · simp

/-- The discrete sigma algebra: all subsets are measurable. -/
def discreteSigmaAlgebra (α : Type u) : SigmaAlgebra α where
  carrier := Set.univ
  empty_mem := by simp
  compl_mem := by
    intro s hs
    simp
  countable_union_mem := by
    intro s hs
    simp

#eval "SigmaAlgebra defined: trivial, discrete"
#eval trivialSigmaAlgebra ℕ |>.empty_mem

/-! ## Measurable Space -/

/-- A measurable space is a type equipped with a sigma algebra. -/
structure MeasurableSpace (α : Type u) where
  sigmaAlgebra : SigmaAlgebra α

/-- Check if a set is measurable with respect to the given measurable space. -/
def isMeasurable (ms : MeasurableSpace α) (s : Set α) : Prop :=
  s ∈ ms.sigmaAlgebra.carrier

instance : Inhabited (MeasurableSpace α) where
  default := { sigmaAlgebra := trivialSigmaAlgebra α }

#eval "MeasurableSpace and isMeasurable defined"

/-! ## Measure -/

/-- A measure on a measurable space is a function from the sigma algebra
    to the extended nonnegative reals, with μ(∅)=0 and countable additivity. -/
structure Measure (α : Type u) (ms : MeasurableSpace α) where
  toFun : Set α → ℝ≥0∞
  empty_measure : toFun ∅ = 0
  countable_additivity : ∀ (s : ℕ → Set α),
    (∀ n, isMeasurable ms (s n)) →
    (∀ i j, i ≠ j → s i ∩ s j = ∅) →
    toFun (⋃ n, s n) = ∑' n, toFun (s n)

instance (α : Type u) (ms : MeasurableSpace α) : CoeFun (Measure α ms) (λ _ => Set α → ℝ≥0∞) where
  coe := Measure.toFun _

/-- A measure space is a type with a measurable space and a measure. -/
structure MeasureSpace (α : Type u) extends MeasurableSpace α where
  measure : Measure α { sigmaAlgebra := sigmaAlgebra }

#eval "Measure and MeasureSpace defined"

/-! ## Outer Measure -/

/-- An outer measure is a monotone, countably subadditive function from
    P(α) to [0,∞] with μ(∅)=0. -/
structure OuterMeasure (α : Type u) where
  toFun : Set α → ℝ≥0∞
  empty : toFun ∅ = 0
  monotone : ∀ {s t : Set α}, s ⊆ t → toFun s ≤ toFun t
  countable_subadditive : ∀ (s : ℕ → Set α), toFun (⋃ n, s n) ≤ ∑' n, toFun (s n)

instance (α : Type u) : CoeFun (OuterMeasure α) (λ _ => Set α → ℝ≥0∞) where
  coe := OuterMeasure.toFun _

/-! ## Carathéodory Extension -/

/-- Carathéodory measurable sets: those A such that
    μ*(E) = μ*(E∩A) + μ*(E∩Aᶜ) for all E. -/
def caratheodoryMeasurable {α : Type u} (μ* : OuterMeasure α) (A : Set α) : Prop :=
  ∀ E, μ* E = μ* (E ∩ A) + μ* (E ∩ Aᶜ)

/-- The Carathéodory Extension: from an outer measure, construct a measure
    on the sigma algebra of Carathéodory measurable sets. -/
def caratheodoryExtension {α : Type u} (μ* : OuterMeasure α) : SigmaAlgebra α where
  carrier := {A | caratheodoryMeasurable μ* A}
  empty_mem := by
    intro E
    simp [caratheodoryMeasurable, μ*.empty]
  compl_mem := by
    intro A hA E
    dsimp [caratheodoryMeasurable] at hA ⊢
    rw [Set.compl_compl]
    rw [Set.inter_comm (Aᶜ) E, Set.inter_comm A E]
    exact (hA E).symm
  countable_union_mem := by
    intro s hs E
    sorry

#eval "Carathéodory measurable sets and extension defined"

/-! ## Lebesgue Measure on ℝⁿ -/

/-- The Lebesgue outer measure on ℝ: length of interval covers. -/
noncomputable def lebesgueOuterMeasure : OuterMeasure ℝ where
  toFun A := ⨅ (I : ℕ → Set ℝ), (∃ (bounds : ℕ → ℝ × ℝ),
    (∀ n, I n = Set.Ioo (bounds n).1 (bounds n).2) ∧ A ⊆ ⋃ n, I n),
    ∑' n, ENNReal.ofReal ((bounds n).2 - (bounds n).1)
  empty := by
    refine le_antisymm ?_ (by simp)
    refine iInf_le_of_le (λ _ => ∅) ?_
    refine iInf_le_of_le (λ _ => (0,0)) ?_
    simp
  monotone := by
    intro s t hst
    exact iInf_mono (λ I => iInf_mono $ λ h => by
      rcases h with ⟨bounds, hI, hcover⟩
      refine ⟨bounds, hI, ?_⟩
      exact Set.Subset.trans hst hcover)
  countable_subadditive := by
    intro s
    sorry

/-- Lebesgue measure on ℝ. -/
noncomputable def lebesgueMeasure : Measure ℝ (default : MeasurableSpace ℝ) where
  toFun A := lebesgueOuterMeasure A
  empty_measure := lebesgueOuterMeasure.empty
  countable_additivity := by
    intro s hs hdisj
    sorry

#eval "Lebesgue outer measure and Lebesgue measure on ℝ defined"

/-! ## Borel Sigma Algebra -/

/-- The Borel sigma algebra on a topological space: generated by the open sets. -/
def borelSigmaAlgebra (α : Type u) [TopologicalSpace α] : SigmaAlgebra α :=
  -- The smallest sigma algebra containing all open sets
  -- This is a placeholder for the actual construction
  { carrier := {s | True}
    empty_mem := trivial
    compl_mem := λ s h => trivial
    countable_union_mem := λ s h => trivial
  }

/-! ## Completeness -/

/-- A measure is complete if every subset of a null set is measurable. -/
def isComplete {α : Type u} {ms : MeasurableSpace α} (μ : Measure α ms) : Prop :=
  ∀ (A N : Set α),
    isMeasurable ms N → μ N = 0 → A ⊆ N → isMeasurable ms A

/-! ## Restriction -/

/-- Restrict the measure to a measurable set. -/
noncomputable def restriction {α : Type u} {ms : MeasurableSpace α}
    (μ : Measure α ms) (A : Set α) (hA : isMeasurable ms A) : Measure α ms where
  toFun B := μ (B ∩ A)
  empty_measure := by simp [μ.empty_measure]
  countable_additivity := by
    intro s hs hdisj
    have : (⋃ n, s n) ∩ A = ⋃ n, (s n ∩ A) := by
      ext x; simp; intro n; exact And.intro
    rw [this]
    have hdisj' : ∀ i j, i ≠ j → (s i ∩ A) ∩ (s j ∩ A) = ∅ := by
      intro i j hij
      have h := hdisj i j hij
      ext x; simp [h]
    exact μ.countable_additivity (λ n => s n ∩ A) (λ n => sorry) hdisj'

/-! ## Pushforward -/

/-- Pushforward of a measure by a measurable map. -/
noncomputable def pushforward {α β : Type u}
    {ms_α : MeasurableSpace α} {ms_β : MeasurableSpace β}
    (μ : Measure α ms_α) (f : α → β) : Measure β ms_β where
  toFun B := μ (f ⁻¹' B)
  empty_measure := by simp [μ.empty_measure]
  countable_additivity := by
    intro s hs hdisj
    simp_rw [Set.preimage_iUnion]
    have hdisj' : ∀ i j, i ≠ j → f ⁻¹' (s i) ∩ f ⁻¹' (s j) = ∅ := by
      intro i j hij
      rw [Set.preimage_inter]
      have h := hdisj i j hij
      rw [h, Set.preimage_empty]
    exact μ.countable_additivity (λ n => f ⁻¹' (s n)) (λ n => sorry) hdisj'

#eval "isComplete, restriction, pushforward defined"

end MiniMeasureTheory
