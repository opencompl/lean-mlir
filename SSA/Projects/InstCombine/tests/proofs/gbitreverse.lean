import SSA.Projects.InstCombine.tests.proofs.gbitreverse_proof
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
section gbitreverse_statements

def rev8_mul_and_lshr_before := [llvm|
{
^0(%arg29 : i8):
  %0 = llvm.mlir.constant(2050) : i64
  %1 = llvm.mlir.constant(139536) : i64
  %2 = llvm.mlir.constant(32800) : i64
  %3 = llvm.mlir.constant(558144) : i64
  %4 = llvm.mlir.constant(65793) : i64
  %5 = llvm.mlir.constant(16) : i64
  %6 = llvm.zext %arg29 : i8 to i64
  %7 = llvm.mul %6, %0 overflow<nsw,nuw> : i64
  %8 = llvm.and %7, %1 : i64
  %9 = llvm.mul %6, %2 overflow<nsw,nuw> : i64
  %10 = llvm.and %9, %3 : i64
  %11 = llvm.or %8, %10 : i64
  %12 = llvm.mul %11, %4 overflow<nsw,nuw> : i64
  %13 = llvm.lshr %12, %5 : i64
  %14 = llvm.trunc %13 : i64 to i8
  "llvm.return"(%14) : (i8) -> ()
}
]
def rev8_mul_and_lshr_after := [llvm|
{
^0(%arg29 : i8):
  %0 = llvm.mlir.constant(2050) : i64
  %1 = llvm.mlir.constant(139536) : i64
  %2 = llvm.mlir.constant(32800) : i64
  %3 = llvm.mlir.constant(558144) : i64
  %4 = llvm.mlir.constant(65793) : i64
  %5 = llvm.mlir.constant(16) : i64
  %6 = llvm.zext %arg29 : i8 to i64
  %7 = llvm.mul %6, %0 overflow<nsw,nuw> : i64
  %8 = llvm.and %7, %1 : i64
  %9 = llvm.mul %6, %2 overflow<nsw,nuw> : i64
  %10 = llvm.and %9, %3 : i64
  %11 = llvm.or disjoint %8, %10 : i64
  %12 = llvm.mul %11, %4 overflow<nsw,nuw> : i64
  %13 = llvm.lshr %12, %5 : i64
  %14 = llvm.trunc %13 : i64 to i8
  "llvm.return"(%14) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rev8_mul_and_lshr_proof : rev8_mul_and_lshr_before ⊑ rev8_mul_and_lshr_after := by
  unfold rev8_mul_and_lshr_before rev8_mul_and_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN rev8_mul_and_lshr
  apply rev8_mul_and_lshr_thm
  ---END rev8_mul_and_lshr


