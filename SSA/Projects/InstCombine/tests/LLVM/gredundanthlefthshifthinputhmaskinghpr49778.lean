
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
section gredundanthlefthshifthinputhmaskinghpr49778_statements

def src_before := [llvm|
{
^0(%arg0 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.zext %arg0 : i1 to i32
  %2 = llvm.shl %0, %1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.shl %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_after := [llvm|
{
^0(%arg0 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.zext %arg0 : i1 to i32
  %2 = llvm.shl %0, %1 overflow<nsw> : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.shl %4, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_proof : src_before ⊑ src_after := by
  unfold src_before src_after
  simp_alive_peephole
  intros
  ---BEGIN src
  all_goals (try extract_goal ; sorry)
  ---END src


