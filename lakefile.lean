import Lake
open Lake DSL

package «SSA» where
  precompileModules := true

lean_lib SSA

@[default_target]
lean_lib «alive» {
  roots := #[`Alive]
}

-- NOTE: this must be 'm'mathlib, as indicated from:
--  https://github.com/leanprover-community/mathlib4#using-mathlib4-as-a-dependency
require mathlib from git "https://github.com/leanprover-community/mathlib4" @ "72b511e"

meta if get_config? env = some "dev" then -- dev is so not everyone has to build it
  require «doc-gen4» from git "https://github.com/leanprover/doc-gen4" @ "b9421b9"

