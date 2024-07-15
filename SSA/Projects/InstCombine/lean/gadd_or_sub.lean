import SSA.Projects.InstCombine.lean.gadd_or_sub_proof
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
                                                                       
def add_or_sub_comb_i32_commuted1_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.add %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_or_sub_comb_i32_commuted1_nuw_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem add_or_sub_comb_i32_commuted1_nuw_proof : add_or_sub_comb_i32_commuted1_nuw_before ⊑ add_or_sub_comb_i32_commuted1_nuw_after := by
  unfold add_or_sub_comb_i32_commuted1_nuw_before add_or_sub_comb_i32_commuted1_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_or_sub_comb_i32_commuted1_nuw
  apply add_or_sub_comb_i32_commuted1_nuw_thm
  ---END add_or_sub_comb_i32_commuted1_nuw



def add_or_sub_comb_i8_commuted2_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.mul %arg0, %arg0 : i8
  %2 = llvm.sub %0, %1 : i8
  %3 = llvm.or %2, %1 : i8
  %4 = llvm.add %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def add_or_sub_comb_i8_commuted2_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.mul %arg0, %arg0 : i8
  %2 = llvm.add %1, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem add_or_sub_comb_i8_commuted2_nsw_proof : add_or_sub_comb_i8_commuted2_nsw_before ⊑ add_or_sub_comb_i8_commuted2_nsw_after := by
  unfold add_or_sub_comb_i8_commuted2_nsw_before add_or_sub_comb_i8_commuted2_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_or_sub_comb_i8_commuted2_nsw
  apply add_or_sub_comb_i8_commuted2_nsw_thm
  ---END add_or_sub_comb_i8_commuted2_nsw



def add_or_sub_comb_i128_commuted3_nuw_nsw_before := [llvm|
{
^0(%arg0 : i128):
  %0 = "llvm.mlir.constant"() <{value = 0 : i128}> : () -> i128
  %1 = llvm.mul %arg0, %arg0 : i128
  %2 = llvm.sub %0, %1 : i128
  %3 = llvm.or %1, %2 : i128
  %4 = llvm.add %3, %1 : i128
  "llvm.return"(%4) : (i128) -> ()
}
]
def add_or_sub_comb_i128_commuted3_nuw_nsw_after := [llvm|
{
^0(%arg0 : i128):
  %0 = llvm.mul %arg0, %arg0 : i128
  "llvm.return"(%0) : (i128) -> ()
}
]
theorem add_or_sub_comb_i128_commuted3_nuw_nsw_proof : add_or_sub_comb_i128_commuted3_nuw_nsw_before ⊑ add_or_sub_comb_i128_commuted3_nuw_nsw_after := by
  unfold add_or_sub_comb_i128_commuted3_nuw_nsw_before add_or_sub_comb_i128_commuted3_nuw_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_or_sub_comb_i128_commuted3_nuw_nsw
  apply add_or_sub_comb_i128_commuted3_nuw_nsw_thm
  ---END add_or_sub_comb_i128_commuted3_nuw_nsw



def add_or_sub_comb_i64_commuted4_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
  %1 = llvm.mul %arg0, %arg0 : i64
  %2 = llvm.sub %0, %1 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.add %1, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def add_or_sub_comb_i64_commuted4_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
  %1 = llvm.mul %arg0, %arg0 : i64
  %2 = llvm.add %1, %0 : i64
  %3 = llvm.and %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
theorem add_or_sub_comb_i64_commuted4_proof : add_or_sub_comb_i64_commuted4_before ⊑ add_or_sub_comb_i64_commuted4_after := by
  unfold add_or_sub_comb_i64_commuted4_before add_or_sub_comb_i64_commuted4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_or_sub_comb_i64_commuted4
  apply add_or_sub_comb_i64_commuted4_thm
  ---END add_or_sub_comb_i64_commuted4


