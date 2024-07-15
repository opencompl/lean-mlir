import SSA.Projects.InstCombine.tests.LLVM.gshlhdemand_proof
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
                                                                       
def set_shl_mask_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 196609 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 65536 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.shl %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def set_shl_mask_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65537 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 65536 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.shl %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem set_shl_mask_proof : set_shl_mask_before ⊑ set_shl_mask_after := by
  unfold set_shl_mask_before set_shl_mask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN set_shl_mask
  apply set_shl_mask_thm
  ---END set_shl_mask


