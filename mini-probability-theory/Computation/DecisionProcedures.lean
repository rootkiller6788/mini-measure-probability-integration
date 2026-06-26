/-
# MiniProbabilityTheory: Computation / Decision Procedures

Decision procedures for probabilistic reasoning: hypothesis testing,
confidence intervals, Bayesian inference, and model selection.
-/

import MiniProbabilityTheory

namespace MiniProbabilityTheory.DecisionProcedures

/-! ## Hypothesis Testing -/

#eval "Neyman-Pearson lemma: optimal tests"
#eval "Likelihood ratio tests"
#eval "p-values and significance levels"
#eval "Type I and Type II errors"
#eval "Power analysis and sample size"

/-! ## Confidence Intervals -/

#eval "Exact confidence intervals (pivotal quantities)"
#eval "Asymptotic confidence intervals (Wald, score, LR)"
#eval "Bootstrap confidence intervals"
#eval "Simultaneous confidence bands"

/-! ## Bayesian Inference -/

#eval "Prior and posterior distributions"
#eval "Conjugate priors (Normal-Normal, Beta-Binomial, Gamma-Poisson)"
#eval "Bayes factors for model comparison"
#eval "Credible intervals vs confidence intervals"
#eval "Jeffreys prior: non-informative prior"

/-! ## Model Selection -/

#eval "AIC: Akaike Information Criterion"
#eval "BIC: Bayesian Information Criterion"
#eval "Cross-validation"
#eval "Regularization: Lasso, Ridge"

/-! ## Statistical Decision Theory -/

#eval "Loss functions and risk"
#eval "Admissibility and minimaxity"
#eval "Stein's paradox: James-Stein estimator"
#eval "Complete class theorem"

/-! ## Information Criteria -/

#eval "KL divergence for model comparison"
#eval "Fisher information and efficiency"
#eval "Cramer-Rao lower bound for estimators"
#eval "Asymptotic efficiency of MLE"

end MiniProbabilityTheory.DecisionProcedures
