import SSA.Projects.InstCombine.tests.proofs.gfoldhsignbithtesthpower2_proof
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
section gfoldhsignbithtesthpower2_statements

def pow2_or_zero_is_negative_commute_before := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mul %0, %arg7 : i8
  %3 = llvm.sub %1, %2 : i8
  %4 = llvm.and %3, %2 : i8
  %5 = llvm.icmp "slt" %4, %1 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def pow2_or_zero_is_negative_commute_after := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.mul %arg7, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pow2_or_zero_is_negative_commute_proof : pow2_or_zero_is_negative_commute_before ⊑ pow2_or_zero_is_negative_commute_after := by
  unfold pow2_or_zero_is_negative_commute_before pow2_or_zero_is_negative_commute_after
  simp_alive_peephole
  intros
  ---BEGIN pow2_or_zero_is_negative_commute
  apply pow2_or_zero_is_negative_commute_thm
  ---END pow2_or_zero_is_negative_commute



def pow2_or_zero_is_not_negative_commute_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i8) : i8
  %3 = llvm.mul %0, %arg3 : i8
  %4 = llvm.sub %1, %3 : i8
  %5 = llvm.and %4, %3 : i8
  %6 = llvm.icmp "sgt" %5, %2 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def pow2_or_zero_is_not_negative_commute_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.mul %arg3, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pow2_or_zero_is_not_negative_commute_proof : pow2_or_zero_is_not_negative_commute_before ⊑ pow2_or_zero_is_not_negative_commute_after := by
  unfold pow2_or_zero_is_not_negative_commute_before pow2_or_zero_is_not_negative_commute_after
  simp_alive_peephole
  intros
  ---BEGIN pow2_or_zero_is_not_negative_commute
  apply pow2_or_zero_is_not_negative_commute_thm
  ---END pow2_or_zero_is_not_negative_commute


