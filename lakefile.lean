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


lean_exe opt {
  root := `SSA.Projects.InstCombine.LLVM.Opt
  -- `supportInterpreter` flag needed to link executable with the Lean frontend
  supportInterpreter := true
}

lean_exe ssaLLVMEnumerator {
  root := `SSA.Projects.InstCombine.LLVM.Enumerator
}

-- PROJECTS
-- ========

/-- Separate lib since it takes quite a while to compile -/
lean_lib AliveExamples {
  roots := #[`SSA.Projects.InstCombine.AliveAutoGenerated]
}

lean_lib AliveScaling {
  roots := #[`SSA.Projects.InstCombine.ScalingTest]
}

require mathlib from git "https://github.com/leanprover-community/mathlib4" @ "425cfb611d01983cd3a1c7cae4d117630bedecf0"
require Cli from git "https://github.com/mhuisi/lean4-cli.git" @ "nightly"
meta if get_config? doc = some "on" then -- dev is so not everyone has to build it
  require «doc-gen4» from git "https://github.com/leanprover/doc-gen4" @ "main"
