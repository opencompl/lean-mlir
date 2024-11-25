
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
section g2008h07h08hShiftOneAndOne_statements

def PR2330_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg0 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR2330_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg0, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR2330_proof : PR2330_before ⊑ PR2330_after := by
  unfold PR2330_before PR2330_after
  simp_alive_peephole
  intros
  ---BEGIN PR2330
  all_goals (try extract_goal ; sorry)
  ---END PR2330


