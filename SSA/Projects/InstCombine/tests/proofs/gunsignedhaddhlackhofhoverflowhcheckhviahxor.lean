import SSA.Projects.InstCombine.tests.proofs.gunsignedhaddhlackhofhoverflowhcheckhviahxor_proof
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
section gunsignedhaddhlackhofhoverflowhcheckhviahxor_statements

def t3_no_extrause_before := [llvm|
{
^0(%arg18 : i8, %arg19 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg19, %0 : i8
  %2 = llvm.icmp "uge" %1, %arg18 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def t3_no_extrause_after := [llvm|
{
^0(%arg18 : i8, %arg19 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg19, %0 : i8
  %2 = llvm.icmp "ule" %arg18, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t3_no_extrause_proof : t3_no_extrause_before ⊑ t3_no_extrause_after := by
  unfold t3_no_extrause_before t3_no_extrause_after
  simp_alive_peephole
  intros
  ---BEGIN t3_no_extrause
  apply t3_no_extrause_thm
  ---END t3_no_extrause


