# MiniProductFubini - Advanced Documentation

## Category Theory Structure

The package organizes product measure theory categorically:

### Morphisms
- `ProductMeasurePreserving` - maps preserving product measure structure
- `ConvolutionOperator` - bounded linear operators via convolution
- `RadonNikodymMorphism` - dν/dμ as morphism between measure spaces

### Isomorphisms
- `ProductMeasureIso` - bi-measurable measure-preserving bijections
- Associativity: (μ×ν)×ρ ≅ μ×(ν×ρ)
- Commutativity: μ×ν ≅ ν×μ

### Equivalences
- `MutuallyAbsolutelyContinuous` - μ ~ ν (mutual abs. continuity)
- `MutuallySingular` - μ ⊥ ν (mutually singular)
- `LebesgueDecomposition` - unique decomposition

## Constructions

### Product Constructions
- Triple and finite products with Fubini in any order
- Infinite product measures via Kolmogorov extension
- Cylinder sets generating product sigma-algebras

### Universal Properties
- Product measure as universal bilinear integration
- L¹(G) as universal Banach algebra under convolution
- Radon-Nikodym derivative as universal density
- Kolmogorov extension as projective limit

## Bridges

### To Algebra
- L¹(G) as Banach *-algebra under convolution
- Convolution semigroups (Gaussian, Poisson/Cauchy)
- Gelfand transform and Pontryagin duality

### To Topology
- Weak convergence of product measures
- Prokhorov's theorem for product spaces
- Skorokhod representation for product weak convergence

### To Geometry / PDE
- Mollifiers and smooth approximation via convolution
- Heat kernel as convolution semigroup
- Green's functions and Poisson equation solutions

### To Computation
- Numerical Fubini (cubature, sparse grids)
- FFT-based convolution (O(N log N))
- Monte Carlo and quasi-Monte Carlo for product measures

## Computational Methods

### Numerical Integration
- Gauss-Legendre cubature (tensor product)
- Sparse grid (Smolyak) quadrature
- Adaptive Fubini with Richardson extrapolation

### Convolution Algorithms
- Direct O(N²) convolution
- FFT-based O(N log N)
- Overlap-add and overlap-save methods

### GPU Acceleration
- CUDA kernels for convolution
- cuFFT for spectral convolution
- Batch product measure evaluation

## Dependencies

- `mini-object-kernel` - object typeclass and theory registration
- `mini-measure-theory` - measures, sigma-algebras, Caratheodory
- `mini-measurable-functions` - measurable functions, simple functions
- `mini-lebesgue-integration` - Lebesgue integral, L^p spaces
