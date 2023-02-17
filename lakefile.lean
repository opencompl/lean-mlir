import Lake
open Lake DSL

package «SSA»

lean_lib SSA

@[default_target]
lean_exe «ssa» {
  root := `SSA
  supportInterpreter := true
}

require Mathlib from git "https://github.com/leanprover-community/mathlib4" @ "master"
