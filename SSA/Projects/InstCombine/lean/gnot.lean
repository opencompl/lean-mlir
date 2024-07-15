import SSA.Projects.InstCombine.lean.gnot_proof
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
                                                                       
def test1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def not_ashr_not_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.ashr %1, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def not_ashr_not_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.ashr %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem not_ashr_not_proof : not_ashr_not_before ⊑ not_ashr_not_after := by
  unfold not_ashr_not_before not_ashr_not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_ashr_not
  apply not_ashr_not_thm
  ---END not_ashr_not



def not_ashr_const_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.ashr %0, %arg0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_ashr_const_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 41 : i8}> : () -> i8
  %1 = llvm.lshr %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem not_ashr_const_proof : not_ashr_const_before ⊑ not_ashr_const_after := by
  unfold not_ashr_const_before not_ashr_const_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_ashr_const
  apply not_ashr_const_thm
  ---END not_ashr_const



def not_lshr_const_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.lshr %0, %arg0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_lshr_const_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -43 : i8}> : () -> i8
  %1 = llvm.ashr %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem not_lshr_const_proof : not_lshr_const_before ⊑ not_lshr_const_after := by
  unfold not_lshr_const_before not_lshr_const_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_lshr_const
  apply not_lshr_const_thm
  ---END not_lshr_const



def not_sub_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 123 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def not_sub_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -124 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem not_sub_proof : not_sub_before ⊑ not_sub_after := by
  unfold not_sub_before not_sub_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_sub
  apply not_sub_thm
  ---END not_sub



def not_add_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 123 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def not_add_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -124 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem not_add_proof : not_add_before ⊑ not_add_after := by
  unfold not_add_before not_add_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_add
  apply not_add_thm
  ---END not_add



def not_or_neg_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg1 : i8
  %3 = llvm.or %2, %arg0 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def not_or_neg_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.add %arg1, %0 : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.and %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem not_or_neg_proof : not_or_neg_before ⊑ not_or_neg_after := by
  unfold not_or_neg_before not_or_neg_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_neg
  apply not_or_neg_thm
  ---END not_or_neg


