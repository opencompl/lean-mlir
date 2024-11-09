
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
section gJavaCompare_statements

def le_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.icmp "slt" %arg0, %arg1 : i32
  %6 = "llvm.select"(%5, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.icmp "sle" %6, %1 : i32
  "llvm.return"(%7) : (i1) -> ()
}
]
def le_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.icmp "sle" %arg0, %arg1 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem le_proof : le_before ⊑ le_after := by
  unfold le_before le_after
  simp_alive_peephole
  intros
  ---BEGIN le
  all_goals (try extract_goal ; sorry)
  ---END le


