
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
section gashrhdemand_statements
                                                    
def srem2_ashr_mask_before := [llvm|
{
^0(%arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.srem %arg6, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  %4 = llvm.and %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def srem2_ashr_mask_after := [llvm|
{
^0(%arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.srem %arg6, %0 : i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem srem2_ashr_mask_proof : srem2_ashr_mask_before ⊑ srem2_ashr_mask_after := by
  unfold srem2_ashr_mask_before srem2_ashr_mask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN srem2_ashr_mask
  all_goals (try extract_goal ; sorry)
  ---END srem2_ashr_mask


