import SSA.Projects.InstCombine.tests.proofs.ginstcombinehverifyhknownhbits_proof
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
section ginstcombinehverifyhknownhbits_statements

def pr110631_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{value = 48991 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.zext %2 : i32 to i64
  %4 = llvm.and %arg1, %3 : i64
  %5 = llvm.trunc %4 : i64 to i32
  %6 = llvm.trunc %5 : i32 to i16
  %7 = llvm.sext %6 : i16 to i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.trunc %8 : i32 to i16
  "llvm.return"(%9) : (i16) -> ()
}
]
def pr110631_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{value = 48991 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i16}> : () -> i16
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.trunc %arg1 : i64 to i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.trunc %4 : i32 to i16
  %6 = llvm.xor %5, %1 : i16
  "llvm.return"(%6) : (i16) -> ()
}
]
theorem pr110631_proof : pr110631_before ⊑ pr110631_after := by
  unfold pr110631_before pr110631_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN pr110631
  apply pr110631_thm
  ---END pr110631


