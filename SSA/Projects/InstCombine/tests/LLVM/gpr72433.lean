
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
section gpr72433_statements

def widget_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(20 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.icmp "eq" %arg0, %0 : i32
  %5 = llvm.zext %4 : i1 to i32
  %6 = llvm.sub %1, %5 : i32
  %7 = llvm.mul %2, %6 : i32
  %8 = llvm.zext %4 : i1 to i32
  %9 = llvm.xor %8, %3 : i32
  %10 = llvm.add %7, %9 : i32
  %11 = llvm.mul %10, %6 : i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def widget_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(20 : i32) : i32
  %2 = llvm.icmp "ne" %arg0, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.shl %1, %3 overflow<nsw,nuw> : i32
  %5 = llvm.zext %2 : i1 to i32
  %6 = llvm.or disjoint %4, %5 : i32
  %7 = llvm.zext %2 : i1 to i32
  %8 = llvm.shl %6, %7 overflow<nsw,nuw> : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem widget_proof : widget_before ⊑ widget_after := by
  unfold widget_before widget_after
  simp_alive_peephole
  intros
  ---BEGIN widget
  all_goals (try extract_goal ; sorry)
  ---END widget


