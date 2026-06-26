import Lake
open Lake DSL

package «mini-lebesgue-integration» where
  moreLeanArgs := #["-DwarningAsError=true"]
  moreServerArgs := #["-Dpp.unicode.fun=true"]

@[default_target]
lean_lib «MiniLebesgueIntegration» where
  globs := #[Glob.submodules `MiniLebesgueIntegration]

require «mini-object-kernel» from "..\\..\\..\\0. mini-math-kernel\\mini-object-kernel"
require «mini-measure-theory» from "..\\mini-measure-theory"
require «mini-measurable-functions» from "..\\mini-measurable-functions"
