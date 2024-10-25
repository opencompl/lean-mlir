import SSA.Projects.InstCombine.tests.proofs.gpr34349_proof
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
section gpr34349_statements

def fast_div_201_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 71 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 8 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %4 = llvm.zext %arg0 : i8 to i16
  %5 = llvm.mul %4, %0 : i16
  %6 = llvm.lshr %5, %1 : i16
  %7 = llvm.trunc %6 : i16 to i8
  %8 = llvm.sub %arg0, %7 : i8
  %9 = llvm.lshr %8, %2 : i8
  %10 = llvm.add %7, %9 : i8
  %11 = llvm.lshr %10, %3 : i8
  "llvm.return"(%11) : (i8) -> ()
}
]
def fast_div_201_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 71 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 8 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %4 = llvm.zext %arg0 : i8 to i16
  %5 = llvm.mul %4, %0 overflow<nsw,nuw> : i16
  %6 = llvm.lshr %5, %1 : i16
  %7 = llvm.trunc %6 : i16 to i8
  %8 = llvm.sub %arg0, %7 : i8
  %9 = llvm.lshr %8, %2 : i8
  %10 = llvm.add %9, %7 overflow<nuw> : i8
  %11 = llvm.lshr %10, %3 : i8
  "llvm.return"(%11) : (i8) -> ()
}
]
theorem fast_div_201_proof : fast_div_201_before ⊑ fast_div_201_after := by
  unfold fast_div_201_before fast_div_201_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN fast_div_201
  apply fast_div_201_thm
  ---END fast_div_201


