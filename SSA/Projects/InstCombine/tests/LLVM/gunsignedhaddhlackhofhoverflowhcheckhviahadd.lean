
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
section gunsignedhaddhlackhofhoverflowhcheckhviahadd_statements

def t6_no_extrause_before := [llvm|
{
^0(%arg19 : i8, %arg20 : i8):
  %0 = llvm.add %arg19, %arg20 : i8
  %1 = llvm.icmp "uge" %0, %arg20 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def t6_no_extrause_after := [llvm|
{
^0(%arg19 : i8, %arg20 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg20, %0 : i8
  %2 = llvm.icmp "ule" %arg19, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t6_no_extrause_proof : t6_no_extrause_before ⊑ t6_no_extrause_after := by
  unfold t6_no_extrause_before t6_no_extrause_after
  simp_alive_peephole
  intros
  ---BEGIN t6_no_extrause
  all_goals (try extract_goal ; sorry)
  ---END t6_no_extrause


