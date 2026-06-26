import MiniConditionalMartingale.Core.Basic
import MiniConditionalMartingale.Core.Laws

/-!
  # MiniConditionalMartingale: Core Objects

  This module registers the categorical and typeclass structure for
  the core objects of conditional martingale theory:
  - `FiltrationObject` -- Filtration as an object in the category of filtered spaces
  - `MartingaleObject` -- Martingale as an object in the category of processes
  - `StoppingTimeObject` -- Stopping time as a truncation object

  ## Theory Registrations

  * `instFiltrationObject` -- theory registration for Filtration
  * `instMartingaleObject` -- theory registration for Martingale
  * `instStoppingTimeObject` -- theory registration for StoppingTime
-/

namespace MiniConditionalMartingale

open MiniObjectKernel
open MiniMeasureTheory
open MiniMeasurableFunctions

set_option maxHeartbeats 400000 in

/-! ## Filtration Object -/

/-- A filtration object packages a type with a filtration, providing
    the filtered probability space structure. -/
structure FiltrationObject (α : Type u) [MeasurableSpace α] where
  filtration : Filtration α
  measure : Measure α default

/-- The filtered probability space: (Ω, ℱ, (F_n), P). -/
structure FilteredProbabilitySpace (α : Type u) extends
    MeasurableSpace α, FiltrationObject α where
  /-- The probability measure is indeed a probability measure -/
  total_mass : measure Set.univ = 1

/-- Registration of the filtration object theory. -/
def FiltrationObject.registered : String :=
  "FiltrationObject: filtered probability space (Ω, ℱ, (F_n), P)"

/-! ## Martingale Object -/

/-- A martingale object packages a stochastic process together with
    the filtration and measure under which it is a martingale. -/
structure MartingaleObject (α : Type u) [MeasurableSpace α] where
  process : ℕ → α → ℝ
  filtration : Filtration α
  measure : Measure α default
  isMartingale : Martingale process filtration measure

/-- Registration of the martingale object theory. -/
def MartingaleObject.registered : String :=
  "MartingaleObject: (X_n)_{n≥0} with E[X_{n+1}|F_n] = X_n"

/-! ## StoppingTime Object -/

/-- A stopping time object bundles a stopping time with its filtration
    and the stopped process. -/
structure StoppingTimeObject (α : Type u) [MeasurableSpace α] where
  stoppingTime : StoppingTime α (filtration := filtration)
  filtration : Filtration α
  process : ℕ → α → ℝ
  stopped : ℕ → α → ℝ

/-- Construct the stopped process from a stopping time object. -/
noncomputable def StoppingTimeObject.mkStopped {α : Type u} [MeasurableSpace α]
    (X : ℕ → α → ℝ) (ℱ : Filtration α) (τ : StoppingTime α ℱ) : StoppingTimeObject α :=
  { stoppingTime := τ
    filtration := ℱ
    process := X
    stopped := λ n x => stoppedProcess X τ n x
  }

/-- Registration of the stopping time object theory. -/
def StoppingTimeObject.registered : String :=
  "StoppingTimeObject: τ with {τ ≤ n} ∈ F_n and stopped process X_{τ∧n}"

/-- #eval: FiltrationObject registration -/
#eval FiltrationObject.registered

/-- #eval: MartingaleObject registration -/
#eval MartingaleObject.registered

/-- #eval: StoppingTimeObject registration -/
#eval StoppingTimeObject.registered

end MiniConditionalMartingale
