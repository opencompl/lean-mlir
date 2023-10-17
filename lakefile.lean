import Lake
open Lake DSL

package «SSA» where

@[default_target]
lean_lib SSA {
  roots := #[`SSA]
}

lean_exe mlirnatural {
  root := `SSA.MLIRNatural
}
-- -- PROJECTS
-- -- ========
--
-- lean_lib «AliveAll» {
--   roots := #[`Projects.AliveAll]
-- }
--
-- lean_lib «Tensor1D» {
--   roots := #[`Projects.Tensor1D.Tensor1D]
-- }
--
-- lean_lib «InstCombine» {
--   srcDir := "Projects/InstCombine"
--   roots := #[`InstCombinePeepholeRewrites]
--   roots := #[`InstCombinePeepholeRewrites]
-- }
--
-- -- Experiments
-- -- ===========
--
-- lean_lib «Bits» {
--   roots := #[`Experiment.Bits.Decide]
-- }

-- NOTE: this must be 'm'mathlib, as indicated from:
--  https://github.com/leanprover-community/mathlib4#using-mathlib4-as-a-dependency
require mathlib from git "https://github.com/leanprover-community/mathlib4" @ "c5594244d6b6e5e0c0a479a4501c34b0ea194fce"

require Cli from git "https://github.com/mhuisi/lean4-cli.git" @ "nightly"

meta if get_config? env = some "dev" then -- dev is so not everyone has to build it
  require «doc-gen4» from git "https://github.com/leanprover/doc-gen4" @ "34165f3"
