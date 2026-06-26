/-
# Computation.Approx

Computation of simple function approximations:
- Dyadic truncation approximation sₙ(x) = min(f(x), n)
- Monitor convergence of approximation
- Compute the L¹ error between f and its approximation
-/

import MiniMeasurableFunctions

namespace MiniMeasurableFunctions.Computation

open MiniMeasurableFunctions

-- Compute the dyadic approximation of a ℕ-valued function
def dyadicTruncation (f : ℕ → ℕ) (n : ℕ) (x : ℕ) : ℕ := min (f x) n

-- The error at step n
def approximationError (f : ℕ → ℕ) (n : ℕ) (x : ℕ) : ℕ := f x - min (f x) n

-- Check if the approximation has converged at step n for all x
def hasConverged (f : ℕ → ℕ) (n : ℕ) (bound : ℕ) : Bool :=
  -- If n ≥ bound and f(x) ≤ bound, then min(f(x), n) = f(x) for all x
  n ≥ bound

-- Compute the L¹ error (sum over finite domain)
def l1Error {X : Type} [Fintype X] [DecidableEq X]
    (f : X → ℕ) (approx : X → ℕ) : ℕ :=
  Finset.sum (Finset.univ : Finset X) fun x => (f x - approx x)

#eval "=== MiniMeasurableFunctions.Computation.Approx ==="

-- Example: approximate f(x) = x on {0,1,2,3,4}
#eval dyadicTruncation (fun x => x) 3 5  -- min(5, 3) = 3
#eval dyadicTruncation (fun x => x) 10 5 -- min(5, 10) = 5

#eval approximationError (fun x => x) 3 7  -- 7 - min(7,3) = 7-3 = 4
#eval approximationError (fun x => x) 10 7 -- 7 - min(7,10) = 0

#eval hasConverged (fun x => x) 10 8  -- true (10 ≥ 8)
#eval hasConverged (fun x => x) 5 8   -- false (5 < 8)

end MiniMeasurableFunctions.Computation
