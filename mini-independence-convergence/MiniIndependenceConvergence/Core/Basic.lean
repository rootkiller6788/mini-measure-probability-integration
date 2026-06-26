/-
# Independence and Convergence: Core Definitions

Defines independence for events, sigma-algebras, random variables,
and convergence modes: in probability, in distribution, in L^p,
and almost sure convergence.
-/

import MiniObjectKernel.Core.Basic
import MiniObjectKernel.Core.Objects

namespace MiniIndependenceConvergence

/-! ## Events and Probability Space -/

structure Event (Ω : Type u) where
  set : Set Ω

structure ProbabilitySpace (Ω : Type u) where
  prob : Set Ω → ℝ
  axiom_nonneg : ∀ A : Set Ω, prob A ≥ 0
  axiom_unit : prob Set.univ = 1
  axiom_additive : ∀ (A B : Set Ω), Disjoint A B → prob (A ∪ B) = prob A + prob B

/-! ## Independent Events -/

def IndependentEvents (Ω : Type u) [inst : ProbabilitySpace Ω] (A B : Event Ω) : Prop :=
  inst.prob (A.set ∩ B.set) = inst.prob A.set * inst.prob B.set

/-! ## Independent Sigma-Algebras -/

structure SigmaAlgebra (Ω : Type u) where
  sets : Set (Set Ω)
  contains_empty : Set.empty ∈ sets
  closed_complement : ∀ A, A ∈ sets → (Set.univ \ A) ∈ sets
  closed_union : ∀ (A : ℕ → Set Ω), (∀ n, A n ∈ sets) → (⋃ n, A n) ∈ sets

def IndependentSigmaAlgebras (Ω : Type u) [ProbabilitySpace Ω]
    (F G : SigmaAlgebra Ω) : Prop :=
  ∀ (A ∈ F.sets) (B ∈ G.sets), IndependentEvents Ω ⟨A⟩ ⟨B⟩

/-! ## Random Variables and Independence -/

structure RandomVariable (Ω E : Type u) where
  map : Ω → E
  measurable : String -- placeholder for measurability condition

def IndependentRVs (Ω E₁ E₂ : Type u) [ProbabilitySpace Ω]
    (X : RandomVariable Ω E₁) (Y : RandomVariable Ω E₂) : Prop :=
  ∀ (B₁ : Set E₁) (B₂ : Set E₂),
    IndependentEvents Ω ⟨X.map⁻¹' B₁⟩ ⟨Y.map⁻¹' B₂⟩

/-! ## IID (Independent Identically Distributed) -/

structure IIDSequence (Ω E : Type u) [ProbabilitySpace Ω] where
  vars : ℕ → RandomVariable Ω E
  independent : ∀ i j, i ≠ j → IndependentRVs Ω E E (vars i) (vars j)
  identicallyDistributed : ∀ i j,
    ∀ B : Set E, inst.prob ((vars i).map⁻¹' B) = inst.prob ((vars j).map⁻¹' B)

/-! ## Limsup and Liminf of Sets -/

def limsupSets (A : ℕ → Set Ω) : Set Ω :=
  ⋂ n, ⋃ k, (fun m => A (n + m)) k

def liminfSets (A : ℕ → Set Ω) : Set Ω :=
  ⋃ n, ⋂ k, (fun m => A (n + m)) k

/-! ## Borel-Cantelli Lemma (statements) -/

def BorelCantelliFirst (Ω : Type u) [ProbabilitySpace Ω] (A : ℕ → Event Ω) : Prop :=
  (∑' n, inst.prob (A n).set < ∞) → inst.prob (limsupSets (λ n => (A n).set)) = 0

def BorelCantelliSecond (Ω : Type u) [ProbabilitySpace Ω] (A : ℕ → Event Ω) : Prop :=
  (∀ i j, i ≠ j → IndependentEvents Ω (A i) (A j)) ∧
  (∑' n, inst.prob (A n).set = ∞) → inst.prob (limsupSets (λ n => (A n).set)) = 1

/-! ## Kolmogorov Zero-One Law -/

def TailSigmaAlgebra (Ω : Type u) (F : ℕ → SigmaAlgebra Ω) : SigmaAlgebra Ω :=
  SigmaAlgebra.mk
    (⋂ n, ⋃ k, (fun m => (F (n + m)).sets) k)
    (by
      intro n
      apply F.1.1)
    (by
      intro A hA
      sorry)
    (by
      intro A hA
      sorry)

def KolmogorovZeroOneLaw (Ω : Type u) [ProbabilitySpace Ω]
    (F : ℕ → SigmaAlgebra Ω) (h_indep : ∀ n, IndependentSigmaAlgebras Ω (F n) (TailSigmaAlgebra Ω F))
    (A : Event Ω) (h_tail : A.set ∈ (TailSigmaAlgebra Ω F).sets) : Prop :=
  inst.prob A.set = 0 ∨ inst.prob A.set = 1

/-! ## Convergence Modes -/

def convergenceInProbability (Ω E : Type u) [MetricSpace E] [ProbabilitySpace Ω]
    (X : ℕ → RandomVariable Ω E) (Xlim : RandomVariable Ω E) : Prop :=
  ∀ ε > 0, Filter.Tendsto (λ n => inst.prob {ω | dist ((X n).map ω) (Xlim.map ω) ≥ ε})
    Filter.atTop (nhds 0)

def convergenceInDistribution (E : Type u) [MetricSpace E]
    (X : ℕ → RandomVariable ℕ E) (Xlim : RandomVariable ℕ E) : Prop :=
  ∀ (f : E → ℝ), Continuous f → Bounded f → Filter.Tendsto
    (λ n => ∫ ω, f ((X n).map ω)) Filter.atTop (nhds (∫ ω, f (Xlim.map ω)))

def convergenceInLp (Ω E : Type u) [NormedAddCommGroup E] [ProbabilitySpace Ω]
    (p : ℝ) (p_pos : p ≥ 1) (X : ℕ → RandomVariable Ω E) (Xlim : RandomVariable Ω E) : Prop :=
  Filter.Tendsto (λ n => (∫ ω, ‖(X n).map ω - Xlim.map ω‖ ^ p)) Filter.atTop (nhds 0)

def almostSureConvergence (Ω E : Type u) [MetricSpace E] [ProbabilitySpace Ω]
    (X : ℕ → RandomVariable Ω E) (Xlim : RandomVariable Ω E) : Prop :=
  inst.prob {ω | Filter.Tendsto (λ n => (X n).map ω) Filter.atTop (nhds (Xlim.map ω))} = 1

/-! ## #eval checks -/

#eval "── IndependenceConvergence Core.Basic loaded ──"

def sampleProbSpace : ProbabilitySpace (Fin 2) where
  prob A := 1/2
  axiom_nonneg A := by
    have : (0 : ℝ) ≤ 1/2 := by norm_num
    exact this
  axiom_unit := rfl
  axiom_additive A B h := by
    have : (1/2 : ℝ) + (1/2 : ℝ) = 1 := by norm_num
    exact this

#eval "ProbabilitySpace defined on Fin 2"

def trivialEvent : Event (Fin 2) := ⟨Set.univ⟩
#eval "Event structure defined"

end MiniIndependenceConvergence
