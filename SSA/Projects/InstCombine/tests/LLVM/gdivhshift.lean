import SSA.Projects.InstCombine.tests.LLVM.gdivhshift_proof
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
                                                                       
def t7_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  %2 = llvm.sdiv %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def t7_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem t7_proof : t7_before ⊑ t7_after := by
  unfold t7_before t7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t7
  apply t7_thm
  ---END t7



def t10_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.shl %arg0, %arg1 : i32
  %1 = llvm.sdiv %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def t10_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg1 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t10_proof : t10_before ⊑ t10_after := by
  unfold t10_before t10_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t10
  apply t10_thm
  ---END t10



def sdiv_mul_shl_nsw_before := [llvm|
{
^0(%arg0 : i5, %arg1 : i5, %arg2 : i5):
  %0 = llvm.mul %arg0, %arg1 : i5
  %1 = llvm.shl %arg0, %arg2 : i5
  %2 = llvm.sdiv %0, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sdiv_mul_shl_nsw_after := [llvm|
{
^0(%arg0 : i5, %arg1 : i5, %arg2 : i5):
  %0 = "llvm.mlir.constant"() <{value = 1 : i5}> : () -> i5
  %1 = llvm.shl %0, %arg2 : i5
  %2 = llvm.sdiv %arg1, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
theorem sdiv_mul_shl_nsw_proof : sdiv_mul_shl_nsw_before ⊑ sdiv_mul_shl_nsw_after := by
  unfold sdiv_mul_shl_nsw_before sdiv_mul_shl_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sdiv_mul_shl_nsw
  apply sdiv_mul_shl_nsw_thm
  ---END sdiv_mul_shl_nsw



def sdiv_mul_shl_nsw_exact_commute1_before := [llvm|
{
^0(%arg0 : i5, %arg1 : i5, %arg2 : i5):
  %0 = llvm.mul %arg1, %arg0 : i5
  %1 = llvm.shl %arg0, %arg2 : i5
  %2 = llvm.sdiv %0, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sdiv_mul_shl_nsw_exact_commute1_after := [llvm|
{
^0(%arg0 : i5, %arg1 : i5, %arg2 : i5):
  %0 = "llvm.mlir.constant"() <{value = 1 : i5}> : () -> i5
  %1 = llvm.shl %0, %arg2 : i5
  %2 = llvm.sdiv %arg1, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
theorem sdiv_mul_shl_nsw_exact_commute1_proof : sdiv_mul_shl_nsw_exact_commute1_before ⊑ sdiv_mul_shl_nsw_exact_commute1_after := by
  unfold sdiv_mul_shl_nsw_exact_commute1_before sdiv_mul_shl_nsw_exact_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sdiv_mul_shl_nsw_exact_commute1
  apply sdiv_mul_shl_nsw_exact_commute1_thm
  ---END sdiv_mul_shl_nsw_exact_commute1



def sdiv_shl_shl_nsw2_nuw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.shl %arg0, %arg2 : i8
  %1 = llvm.shl %arg1, %arg2 : i8
  %2 = llvm.sdiv %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sdiv_shl_shl_nsw2_nuw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sdiv %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem sdiv_shl_shl_nsw2_nuw_proof : sdiv_shl_shl_nsw2_nuw_before ⊑ sdiv_shl_shl_nsw2_nuw_after := by
  unfold sdiv_shl_shl_nsw2_nuw_before sdiv_shl_shl_nsw2_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sdiv_shl_shl_nsw2_nuw
  apply sdiv_shl_shl_nsw2_nuw_thm
  ---END sdiv_shl_shl_nsw2_nuw



def sdiv_shl_pair_const_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.shl %arg0, %1 : i32
  %4 = llvm.sdiv %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def sdiv_shl_pair_const_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem sdiv_shl_pair_const_proof : sdiv_shl_pair_const_before ⊑ sdiv_shl_pair_const_after := by
  unfold sdiv_shl_pair_const_before sdiv_shl_pair_const_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sdiv_shl_pair_const
  apply sdiv_shl_pair_const_thm
  ---END sdiv_shl_pair_const



def sdiv_shl_pair1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.shl %arg0, %arg1 : i32
  %1 = llvm.shl %arg0, %arg2 : i32
  %2 = llvm.sdiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sdiv_shl_pair1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg1 : i32
  %2 = llvm.lshr %1, %arg2 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sdiv_shl_pair1_proof : sdiv_shl_pair1_before ⊑ sdiv_shl_pair1_after := by
  unfold sdiv_shl_pair1_before sdiv_shl_pair1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sdiv_shl_pair1
  apply sdiv_shl_pair1_thm
  ---END sdiv_shl_pair1



def sdiv_shl_pair2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.shl %arg0, %arg1 : i32
  %1 = llvm.shl %arg0, %arg2 : i32
  %2 = llvm.sdiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sdiv_shl_pair2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg1 : i32
  %2 = llvm.lshr %1, %arg2 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sdiv_shl_pair2_proof : sdiv_shl_pair2_before ⊑ sdiv_shl_pair2_after := by
  unfold sdiv_shl_pair2_before sdiv_shl_pair2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sdiv_shl_pair2
  apply sdiv_shl_pair2_thm
  ---END sdiv_shl_pair2



def sdiv_shl_pair3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.shl %arg0, %arg1 : i32
  %1 = llvm.shl %arg0, %arg2 : i32
  %2 = llvm.sdiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sdiv_shl_pair3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg1 : i32
  %2 = llvm.lshr %1, %arg2 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sdiv_shl_pair3_proof : sdiv_shl_pair3_before ⊑ sdiv_shl_pair3_after := by
  unfold sdiv_shl_pair3_before sdiv_shl_pair3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sdiv_shl_pair3
  apply sdiv_shl_pair3_thm
  ---END sdiv_shl_pair3


