import Lake
open Lake DSL

package «mini-conditional-martingale» where

require «mini-object-kernel» from "..\\..\\..\\0. mini-math-kernel\\mini-object-kernel"
require «mini-measure-theory» from "..\\mini-measure-theory"
require «mini-probability-theory» from "..\\mini-probability-theory"
require «mini-lebesgue-integration» from "..\\mini-lebesgue-integration"

@[default_target]
lean_lib «MiniConditionalMartingale» where
