# MiniMeasureTheory Examples

## Basic Examples

### Lebesgue Measure on ℝ
The Lebesgue measure λ assigns to each interval its length:
- λ([0,1]) = 1
- λ([a,b]) = b - a
- λ(Q) = 0 (countable sets have measure 0)

### Counting Measure
On a countable space, μ(A) = |A| (number of elements, ∞ if infinite).

### Dirac Measure
δ_x(A) = 1 if x ∈ A, 0 otherwise. A probability measure concentrated at x.

### Cantor Measure
A singular continuous measure on [0,1]: λ(Cantor set) = 0 but μ_C(Cantor set) = 1.
Atom-free yet singular with respect to Lebesgue.

## Counterexamples

### Vitali Set
A non-Lebesgue-measurable set constructed via Axiom of Choice
(choose one representative from each coset of ℝ/ℚ in [0,1]).

### Non-Sigma-Finite Measure
Counting measure on ℝ: uncountable union of singletons, each with measure 1,
gives infinite measure but is not sigma-finite.

### Finite but not Countably Additive
Let μ(A) = 0 if A finite, μ(A) = 1 if A cofinite.
Then μ(ℕ) = 1 but Σ μ({n}) = 0.

## Constructing Measures

### Via Carathéodory Extension
1. Start with a premeasure on an algebra (e.g., intervals)
2. Generate the outer measure
3. Restrict to Carathéodory measurable sets
4. Result is a complete measure

### Via Density (Radon-Nikodym)
Given a reference measure μ and f ≥ 0, define ν(A) = ∫_A f dμ.
Then ν ≪ μ and f = dν/dμ is the Radon-Nikodym derivative.

### Product Measure
Given (X,Σ_X,μ) and (Y,Σ_Y,ν), define (X×Y, Σ_X⊗Σ_Y, μ×ν) where:
(μ×ν)(A×B) = μ(A)ν(B) for measurable rectangles.

### Pushforward
Given f: X → Y measurable, (f_*μ)(B) = μ(f⁻¹(B)) defines a measure on Y.
