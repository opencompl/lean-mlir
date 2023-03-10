import Lake
open Lake DSL

package «SSA»

lean_lib SSA

@[default_target]
lean_exe «ssa» {
  root := `SSA
  supportInterpreter := true
}

require Mathlib from git "https://github.com/leanprover-community/mathlib4" @ "54bf6e049c974a9f9c03aea75f3f3f0a040afdc4"
