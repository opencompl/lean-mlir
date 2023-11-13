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
require mathlib from git "https://github.com/leanprover-community/mathlib4" @ "3c978b8c8638105bcff542e6a617137aade4de28" -- from `bitvec-ring` branch

require Cli from git "https://github.com/mhuisi/lean4-cli.git" @ "nightly"

require partax from git "https://github.com/tydeu/lean4-partax" @ "master"

meta if get_config? env = some "dev" then -- dev is so not everyone has to build it
  require «doc-gen4» from git "https://github.com/leanprover/doc-gen4" @ "8bccb92b531248af1b6692d65486e8640c8bcd10"
