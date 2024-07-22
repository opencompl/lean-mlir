import SSA.Projects.InstCombine.tests.LLVM.gnegatedhbitmask_proof
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
                                                                       
def neg_mask1_lshr_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %3 = llvm.lshr %arg0, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.sub %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def neg_mask1_lshr_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.ashr %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem neg_mask1_lshr_proof : neg_mask1_lshr_before ⊑ neg_mask1_lshr_after := by
  unfold neg_mask1_lshr_before neg_mask1_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN neg_mask1_lshr
  apply neg_mask1_lshr_thm
  ---END neg_mask1_lshr



def sub_mask1_lshr_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 10 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.and %2, %0 : i8
  %4 = llvm.sub %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def sub_mask1_lshr_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 10 : i8}> : () -> i8
  %3 = llvm.shl %arg0, %0 : i8
  %4 = llvm.ashr %3, %1 : i8
  %5 = llvm.add %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem sub_mask1_lshr_proof : sub_mask1_lshr_before ⊑ sub_mask1_lshr_after := by
  unfold sub_mask1_lshr_before sub_mask1_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_mask1_lshr
  apply sub_mask1_lshr_thm
  ---END sub_mask1_lshr


