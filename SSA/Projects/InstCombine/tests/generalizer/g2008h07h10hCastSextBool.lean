import SSA.Projects.InstCombine.tests.proofs.g2008h07h10hCastSextBool_proof
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
section g2008h07h10hCastSextBool_statements

def PR2539_A_before := [llvm|
{
^0(%arg1 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext %arg1 : i1 to i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def PR2539_A_after := [llvm|
{
^0(%arg1 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg1, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR2539_A_proof : PR2539_A_before ⊑ PR2539_A_after := by
  unfold PR2539_A_before PR2539_A_after
  simp_alive_peephole
  intros
  ---BEGIN PR2539_A
  apply PR2539_A_thm
  ---END PR2539_A



def PR2539_B_before := [llvm|
{
^0(%arg0 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "slt" %arg0, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def PR2539_B_after := [llvm|
{
^0(%arg0 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR2539_B_proof : PR2539_B_before ⊑ PR2539_B_after := by
  unfold PR2539_B_before PR2539_B_after
  simp_alive_peephole
  intros
  ---BEGIN PR2539_B
  apply PR2539_B_thm
  ---END PR2539_B


