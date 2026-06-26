# API Reference

## Core.Basic

| Definition | Description |
|-----------|-------------|
| `TimeSet` | Time index set for a stochastic process |
| `continuousTimeSet` | T = {r | r >= 0} |
| `discreteTimeSet` | T = N |
| `StochasticProcess` | {X_t}_{t in T} on probability space |
| `samplePath` | t -> X_t(omega) for fixed omega |
| `isContinuousTime` | Check if process is continuous-time |
| `isDiscreteTime` | Check if process is discrete-time |
| `MarkovChain` | Markov process with transition kernel |
| `transitionMatrix` | Explicit matrix for finite state space |
| `chapmanKolmogorov` | Chapman-Kolmogorov equation |
| `nStepTransition` | n-step transition probability |
| `BrownianMotion` | Wiener process: B_0=0, independent Gaussian increments |
| `scaleBrownian` | B -> c*B |
| `TwoSidedBrownianMotion` | Brownian motion indexed by R |
| `PoissonProcess` | Counting process with Poisson increments |
| `poissonMean` | E[N_t] = lambda*t |
| `StationaryProcess` | Shift-invariant distribution |
| `ErgodicProcess` | All shift-invariant events are trivial |
| `GaussianProcess` | All finite-dimensional distributions are normal |
| `OrnsteinUhlenbeckProcess` | Stationary Gaussian Markov process |

## Core.Laws

| Definition | Description |
|-----------|-------------|
| `markovProperty` | Future independent of past given present |
| `chapmanKolmogorovEquation` | P^{(n+m)} = P^{(n)} * P^{(m)} |
| `brownianScaling` | B_{ct} ~ sqrt(c) B_t |
| `brownianReflection` | P(max B_s >= a) = 2 P(B_t >= a) |
| `blumenthalZeroOneLaw` | Germ sigma-algebra is trivial |
| `poissonInterarrivalTimes` | Interarrival times are i.i.d. Exponential |
| `strongMarkovPropertyBrownian` | Markov property at stopping times |
| `kolmogorovContinuityCriterion` | Moment condition -> continuous modification |

## Properties.Invariants

| Definition | Description |
|-----------|-------------|
| `StationaryDistribution` | pi P = pi |
| `isReversible` | pi(x) P(x,y) = pi(y) P(y,x) |
| `detailedBalance` | Continuous-time version |
| `totalVariationDistance` | TV(μ, ν) = (1/2) sum |μ(x) - ν(x)| |
| `mixingTime` | Smallest t with TV <= epsilon |
| `spectralGap` | 1 - |lambda_2| |
| `ergodicAverage` | (1/n) sum f(X_k) |
| `expectedHittingTime` | E[inf{n: X_n in A}] |
| `firstReturnTime` | inf{n >= 1: X_n = x} |

## Theorems

| Theorem | Description |
|---------|-------------|
| `strongMarkovProperty` | Brownian motion restarts at stopping times |
| `reflectionPrinciple` | P(sup B_s >= a) = 2 P(B_t >= a) |
| `lawOfIteratedLogarithm` | limsup B_t/sqrt(2t log log t) = 1 |
| `kolmogorovContinuityTheorem` | Existence of continuous modification |
| `ergodicTheorem` | Birkhoff: time average = ensemble average |
| `doobMaximalInequality` | P(max X_k >= lambda) <= E[X_n]/lambda |
| `doobUpcrossingLemma` | Bounds expected upcrossings |
| `levyItoDecomposition` | Levy = drift + BM + large jumps + small jumps |
| `continuousLevyIsBrownianWithDrift` | Continuous Levy = b t + sigma B_t |
| `levyCharacterization` | [M]_t = t -> M is Brownian |
| `dambisDubinsSchwarzTheorem` | Continuous martingale = time-changed BM |
| `donskerInvariancePrinciple` | Random walk -> Brownian motion |
| `kolmogorovExtensionTheorem` | Existence from finite-dimensional dists |
