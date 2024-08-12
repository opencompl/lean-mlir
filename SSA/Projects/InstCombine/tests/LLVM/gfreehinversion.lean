import SSA.Projects.InstCombine.tests.LLVM.gfreehinversion_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def lshr_not_nneg2_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.lshr %2, %1 : i8
  %4 = llvm.xor %3, %0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def lshr_not_nneg2_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -128 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem lshr_not_nneg2_proof : lshr_not_nneg2_before ⊑ lshr_not_nneg2_after := by
  unfold lshr_not_nneg2_before lshr_not_nneg2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_not_nneg2
  apply lshr_not_nneg2_thm
  ---END lshr_not_nneg2


