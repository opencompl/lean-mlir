import SSA.Projects.InstCombine.tests.proofs.g2006h10h19hSignedToUnsignedCastAndConsth2_proof
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
section g2006h10h19hSignedToUnsignedCastAndConsth2_statements

def eq_signed_to_small_unsigned_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(17 : i32) : i32
  %1 = llvm.sext %arg0 : i8 to i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def eq_signed_to_small_unsigned_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.icmp "eq" %arg0, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_signed_to_small_unsigned_proof : eq_signed_to_small_unsigned_before ⊑ eq_signed_to_small_unsigned_after := by
  unfold eq_signed_to_small_unsigned_before eq_signed_to_small_unsigned_after
  simp_alive_peephole
  intros
  ---BEGIN eq_signed_to_small_unsigned
  apply eq_signed_to_small_unsigned_thm
  ---END eq_signed_to_small_unsigned


