import Lake
open Lake DSL

package «mini-product-fubini» where
  moreLeanArgs := #["-DwarningAsError=true"]
  moreServerArgs := #["-Dpp.unicode.fun=true"]

@[default_target]
lean_lib «MiniProductFubini» where
  globs := #[Glob.submodules `MiniProductFubini]

require «mini-object-kernel» from "..\\..\\..\\0. mini-math-kernel\\mini-object-kernel"
require «mini-measure-theory» from "..\\mini-measure-theory"
require «mini-measurable-functions» from "..\\mini-measurable-functions"
require «mini-lebesgue-integration» from "..\\mini-lebesgue-integration"
