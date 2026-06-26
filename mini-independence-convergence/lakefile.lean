import Lake
open Lake DSL

package «mini-independence-convergence» where

require «mini-object-kernel» from "..\\..\\..\\0. mini-math-kernel\\mini-object-kernel"
require «mini-measure-theory» from "..\\..\\8. mini-measure-probability-integration\\mini-measure-theory"
require «mini-probability-theory» from "..\\..\\8. mini-measure-probability-integration\\mini-probability-theory"

@[default_target]
lean_lib «MiniIndependenceConvergence» where
