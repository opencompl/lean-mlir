import Lake
open Lake DSL

package «SSA»

lean_lib SSA

@[default_target]
lean_exe «ssa» {
  root := `SSA
  supportInterpreter := true
}

lean_exe «tree» {
  root := `SSA.Experiment.SSAToTree
  supportInterpreter := true
}

require Mathlib from git "https://github.com/leanprover-community/mathlib4" @ "54bf6e049c974a9f9c03aea75f3f3f0a040afdc4"

meta if get_config? env = some "dev" then -- dev is so not everyone has to build it
  require «doc-gen4» from git "https://github.com/leanprover/doc-gen4" @ "main"

