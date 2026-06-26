import Lake
open Lake DSL

package «mini-measurable-functions» where

require «mini-object-kernel» from "..\\..\\..\\0. mini-math-kernel\\mini-object-kernel"
require «mini-measure-theory» from "..\\mini-measure-theory"

@[default_target]
lean_lib «MiniMeasurableFunctions» where
