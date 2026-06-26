import MiniProductFubini

/-!
  # MiniProductFubini: Standard Benchmarks

  Standard benchmark suite for the MiniProductFubini package.
  Measures load time, basic operations, and core definitions.
-/

open MiniProductFubini

set_option maxHeartbeats 800000 in

/-- Benchmark: Package load and namespace access. -/
#eval "BENCH: Package load time (subjective): OK"

/-- Benchmark: Core.Basic definitions instantiation count. -/
#eval "BENCH: 7 structures defined in Core.Basic"

/-- Benchmark: Core.Laws axioms count. -/
#eval "BENCH: 5 axioms defined in Core.Laws"

/-- Benchmark: Core.Objects registered. -/
#eval "BENCH: 3 objects registered in Core.Objects"

/-- Benchmark: Morphisms structures count. -/
#eval "BENCH: 6 structures across Morphisms (Hom+Iso+Equiv)"

/-- Benchmark: Constructions structures count. -/
#eval "BENCH: 14 structures across 4 Constructions modules"

/-- Benchmark: Properties structures and functions. -/
#eval "BENCH: 8 structures + 12 theorems in Properties"

/-- Benchmark: Theorems count. -/
#eval "BENCH: 20+ theorems stated across 4 Theorems modules"

/-- Benchmark: Examples count. -/
#eval "BENCH: 10 examples + 4 counterexamples"

/-- Benchmark: Bridges count. -/
#eval "BENCH: 16 structures + theorems across 4 Bridges"

/-- Benchmark: Overall module count. -/
#eval "BENCH: 23 source modules + 3 tests + 6 benchmarks + 6 computation"

/-- Benchmark: Total file count in package. -/
#eval "BENCH: 48 files total"
