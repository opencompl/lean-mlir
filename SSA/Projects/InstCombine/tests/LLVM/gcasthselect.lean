
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

open MLIR AST
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
section gcasthselect_statements

def trunc_before := [llvm|
{
^0(%arg15 : i32, %arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.icmp "ult" %arg15, %arg16 : i32
  %2 = "llvm.select"(%1, %0, %arg17) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.trunc %2 : i32 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def trunc_after := [llvm|
{
^0(%arg15 : i32, %arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.icmp "ult" %arg15, %arg16 : i32
  %2 = llvm.trunc %arg17 : i32 to i16
  %3 = "llvm.select"(%1, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_proof : trunc_before ⊑ trunc_after := by
  unfold trunc_before trunc_after
  simp_alive_peephole
  intros
  ---BEGIN trunc
  all_goals (try extract_goal ; sorry)
  ---END trunc


