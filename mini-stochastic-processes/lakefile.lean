import Lake
open Lake DSL

package `«mini-stochastic-processes»` where

require `«mini-object-kernel»` from "..\\..\\..\\0. mini-math-kernel\\mini-object-kernel"
require `«mini-measure-theory»` from "..\\mini-measure-theory"
require `«mini-probability-theory»` from "..\\mini-probability-theory"
require `«mini-conditional-martingale»` from "..\\mini-conditional-martingale"

@[default_target]
lean_lib `«MiniStochasticProcesses»` where
