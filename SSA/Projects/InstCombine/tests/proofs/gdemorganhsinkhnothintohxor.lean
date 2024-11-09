import SSA.Projects.InstCombine.tests.proofs.gdemorganhsinkhnothintohxor_proof
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
section gdemorganhsinkhnothintohxor_statements

def positive_easyinvert_before := [llvm|
{
^0(%arg7 : i16, %arg8 : i8):
  %0 = llvm.mlir.constant(0 : i16) : i16
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "slt" %arg7, %0 : i16
  %4 = llvm.icmp "slt" %arg8, %1 : i8
  %5 = llvm.xor %4, %3 : i1
  %6 = llvm.xor %5, %2 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def positive_easyinvert_after := [llvm|
{
^0(%arg7 : i16, %arg8 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i16) : i16
  %2 = llvm.icmp "slt" %arg8, %0 : i8
  %3 = llvm.icmp "sgt" %arg7, %1 : i16
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_easyinvert_proof : positive_easyinvert_before ⊑ positive_easyinvert_after := by
  unfold positive_easyinvert_before positive_easyinvert_after
  simp_alive_peephole
  intros
  ---BEGIN positive_easyinvert
  apply positive_easyinvert_thm
  ---END positive_easyinvert


