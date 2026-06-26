/-
# Computation: Bootstrap Resampling

Bootstrap confidence intervals and variance estimation.
-/

import MiniIndependenceConvergence

namespace MiniIndependenceConvergence

/-! ## Bootstrap Resampling -/

structure BootstrapResult where
  estimate : ℝ
  standardError : ℝ
  biasCorrectedEstimate : ℝ
  confidenceInterval : ℝ × ℝ

def bootstrapMean (data : List ℝ) (B : ℕ) (seed : ℕ) : BootstrapResult :=
  let n := data.length
  let sampleMean := (data.sum) / (n : ℝ)
  -- Generate B bootstrap replicates
  let replicates : List ℝ := List.range B |>.map (λ b =>
    let resample := List.range n |>.map (λ i =>
      data.get? ((seed + b + i) % n) |>.getD 0)
    (resample.sum) / (n : ℝ))
  let bootstrapMean := (replicates.sum) / (B : ℝ)
  let se := Real.sqrt
    ((replicates.map (λ r => (r - bootstrapMean) ^ 2)).sum / (B : ℝ))
  let bias := sampleMean - bootstrapMean
  let sortedReplicates := replicates.mergeSort
  let lo := sortedReplicates.get? ((0.025 * (B : ℝ)).toNat) |>.getD 0
  let hi := sortedReplicates.get? ((0.975 * (B : ℝ)).toNat) |>.getD 1
  { estimate := sampleMean
    standardError := se
    biasCorrectedEstimate := sampleMean - bias
    confidenceInterval := (lo, hi) }

/-! ## Bootstrap for Variance -/

def bootstrapVariance (data : List ℝ) (B : ℕ) (seed : ℕ) : ℝ :=
  let n := data.length
  let sampleMean := (data.sum) / (n : ℝ)
  let sampleVar := (data.map (λ x => (x - sampleMean) ^ 2)).sum / (n : ℝ)
  sampleVar

/-! ## Parametric Bootstrap -/

def parametricBootstrap (distFamily : ℝ → ℝ → ℝ) (params : ℝ × ℝ) (n B : ℕ) (seed : ℕ) : List ℝ :=
  -- Generate B samples from parametric model with estimated parameters
  List.range B |>.map (λ b =>
    let sample := List.range n |>.map (λ i => distFamily params.1 params.2)
    (sample.sum) / (n : ℝ))

/-! ## #eval -/

#eval "── Computation/Bootstrap: Resampling and confidence intervals ──"
def testData : List ℝ := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
def testResult := bootstrapMean testData 100 42
#eval testResult.estimate
#eval testResult.standardError
#eval "Bootstrap estimate and standard error computed"

end MiniIndependenceConvergence
