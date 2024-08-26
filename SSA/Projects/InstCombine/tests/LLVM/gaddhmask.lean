import SSA.Projects.InstCombine.tests.LLVM.gaddhmask_proof
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
                                                                       
def add_mask_ashr28_i32_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 28 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_mask_ashr28_i32_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 28 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem add_mask_ashr28_i32_proof : add_mask_ashr28_i32_before ⊑ add_mask_ashr28_i32_after := by
  unfold add_mask_ashr28_i32_before add_mask_ashr28_i32_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_mask_ashr28_i32
  apply add_mask_ashr28_i32_thm
  ---END add_mask_ashr28_i32


