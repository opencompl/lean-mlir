import SSA.Projects.InstCombine.lean.gaddhmaskhneg_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def dec_mask_neg_i32_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def dec_mask_neg_i32_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem dec_mask_neg_i32_proof : dec_mask_neg_i32_before ⊑ dec_mask_neg_i32_after := by
  unfold dec_mask_neg_i32_before dec_mask_neg_i32_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN dec_mask_neg_i32
  apply dec_mask_neg_i32_thm
  ---END dec_mask_neg_i32



def dec_mask_commute_neg_i32_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %3 = llvm.sdiv %0, %arg0 : i32
  %4 = llvm.sub %1, %3 : i32
  %5 = llvm.and %3, %4 : i32
  %6 = llvm.add %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def dec_mask_commute_neg_i32_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.add %2, %1 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem dec_mask_commute_neg_i32_proof : dec_mask_commute_neg_i32_before ⊑ dec_mask_commute_neg_i32_after := by
  unfold dec_mask_commute_neg_i32_before dec_mask_commute_neg_i32_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN dec_mask_commute_neg_i32
  apply dec_mask_commute_neg_i32_thm
  ---END dec_mask_commute_neg_i32



def dec_commute_mask_neg_i32_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def dec_commute_mask_neg_i32_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem dec_commute_mask_neg_i32_proof : dec_commute_mask_neg_i32_before ⊑ dec_commute_mask_neg_i32_after := by
  unfold dec_commute_mask_neg_i32_before dec_commute_mask_neg_i32_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN dec_commute_mask_neg_i32
  apply dec_commute_mask_neg_i32_thm
  ---END dec_commute_mask_neg_i32


