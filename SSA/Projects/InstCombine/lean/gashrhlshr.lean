import SSA.Projects.InstCombine.lean.gashrhlshr_proof
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
                                                                       
def ashr_known_pos_exact_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 127 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  %2 = llvm.ashr %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def ashr_known_pos_exact_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 127 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  %2 = llvm.lshr %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem ashr_known_pos_exact_proof : ashr_known_pos_exact_before ⊑ ashr_known_pos_exact_after := by
  unfold ashr_known_pos_exact_before ashr_known_pos_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN ashr_known_pos_exact
  apply ashr_known_pos_exact_thm
  ---END ashr_known_pos_exact


