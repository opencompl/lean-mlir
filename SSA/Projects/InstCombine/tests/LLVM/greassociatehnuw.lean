import SSA.Projects.InstCombine.tests.LLVM.greassociatehnuw_proof
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
                                                                       
def reassoc_add_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 64 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def reassoc_add_nuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 68 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem reassoc_add_nuw_proof : reassoc_add_nuw_before ⊑ reassoc_add_nuw_after := by
  unfold reassoc_add_nuw_before reassoc_add_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN reassoc_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END reassoc_add_nuw



def reassoc_sub_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 64 : i32}> : () -> i32
  %2 = llvm.sub %arg0, %0 : i32
  %3 = llvm.sub %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def reassoc_sub_nuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -68 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem reassoc_sub_nuw_proof : reassoc_sub_nuw_before ⊑ reassoc_sub_nuw_after := by
  unfold reassoc_sub_nuw_before reassoc_sub_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN reassoc_sub_nuw
  all_goals (try extract_goal ; sorry)
  ---END reassoc_sub_nuw



def reassoc_mul_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 65 : i32}> : () -> i32
  %2 = llvm.mul %arg0, %0 : i32
  %3 = llvm.mul %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def reassoc_mul_nuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 260 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem reassoc_mul_nuw_proof : reassoc_mul_nuw_before ⊑ reassoc_mul_nuw_after := by
  unfold reassoc_mul_nuw_before reassoc_mul_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN reassoc_mul_nuw
  all_goals (try extract_goal ; sorry)
  ---END reassoc_mul_nuw



def no_reassoc_add_nuw_none_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 64 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def no_reassoc_add_nuw_none_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 68 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem no_reassoc_add_nuw_none_proof : no_reassoc_add_nuw_none_before ⊑ no_reassoc_add_nuw_none_after := by
  unfold no_reassoc_add_nuw_none_before no_reassoc_add_nuw_none_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN no_reassoc_add_nuw_none
  all_goals (try extract_goal ; sorry)
  ---END no_reassoc_add_nuw_none



def no_reassoc_add_none_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 64 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def no_reassoc_add_none_nuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 68 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem no_reassoc_add_none_nuw_proof : no_reassoc_add_none_nuw_before ⊑ no_reassoc_add_none_nuw_after := by
  unfold no_reassoc_add_none_nuw_before no_reassoc_add_none_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN no_reassoc_add_none_nuw
  all_goals (try extract_goal ; sorry)
  ---END no_reassoc_add_none_nuw



def reassoc_x2_add_nuw_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.add %arg1, %1 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def reassoc_x2_add_nuw_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 12 : i32}> : () -> i32
  %1 = llvm.add %arg0, %arg1 : i32
  %2 = llvm.add %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem reassoc_x2_add_nuw_proof : reassoc_x2_add_nuw_before ⊑ reassoc_x2_add_nuw_after := by
  unfold reassoc_x2_add_nuw_before reassoc_x2_add_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN reassoc_x2_add_nuw
  apply reassoc_x2_add_nuw_thm
  ---END reassoc_x2_add_nuw



def reassoc_x2_mul_nuw_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 9 : i32}> : () -> i32
  %2 = llvm.mul %arg0, %0 : i32
  %3 = llvm.mul %arg1, %1 : i32
  %4 = llvm.mul %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def reassoc_x2_mul_nuw_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 45 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %arg1 : i32
  %2 = llvm.mul %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem reassoc_x2_mul_nuw_proof : reassoc_x2_mul_nuw_before ⊑ reassoc_x2_mul_nuw_after := by
  unfold reassoc_x2_mul_nuw_before reassoc_x2_mul_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN reassoc_x2_mul_nuw
  apply reassoc_x2_mul_nuw_thm
  ---END reassoc_x2_mul_nuw



def reassoc_x2_sub_nuw_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.sub %arg0, %0 : i32
  %3 = llvm.sub %arg1, %1 : i32
  %4 = llvm.sub %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def reassoc_x2_sub_nuw_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = llvm.sub %arg0, %arg1 : i32
  %2 = llvm.add %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem reassoc_x2_sub_nuw_proof : reassoc_x2_sub_nuw_before ⊑ reassoc_x2_sub_nuw_after := by
  unfold reassoc_x2_sub_nuw_before reassoc_x2_sub_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN reassoc_x2_sub_nuw
  all_goals (try extract_goal ; sorry)
  ---END reassoc_x2_sub_nuw



def tryFactorization_add_nuw_mul_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.add %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_nuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_add_nuw_mul_nuw_proof : tryFactorization_add_nuw_mul_nuw_before ⊑ tryFactorization_add_nuw_mul_nuw_after := by
  unfold tryFactorization_add_nuw_mul_nuw_before tryFactorization_add_nuw_mul_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_add_nuw_mul_nuw
  apply tryFactorization_add_nuw_mul_nuw_thm
  ---END tryFactorization_add_nuw_mul_nuw



def tryFactorization_add_nuw_mul_nuw_int_max_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147483647 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.add %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_nuw_int_max_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_add_nuw_mul_nuw_int_max_proof : tryFactorization_add_nuw_mul_nuw_int_max_before ⊑ tryFactorization_add_nuw_mul_nuw_int_max_after := by
  unfold tryFactorization_add_nuw_mul_nuw_int_max_before tryFactorization_add_nuw_mul_nuw_int_max_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_add_nuw_mul_nuw_int_max
  apply tryFactorization_add_nuw_mul_nuw_int_max_thm
  ---END tryFactorization_add_nuw_mul_nuw_int_max



def tryFactorization_add_mul_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.add %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_mul_nuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_add_mul_nuw_proof : tryFactorization_add_mul_nuw_before ⊑ tryFactorization_add_mul_nuw_after := by
  unfold tryFactorization_add_mul_nuw_before tryFactorization_add_mul_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_add_mul_nuw
  apply tryFactorization_add_mul_nuw_thm
  ---END tryFactorization_add_mul_nuw



def tryFactorization_add_nuw_mul_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.add %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_add_nuw_mul_proof : tryFactorization_add_nuw_mul_before ⊑ tryFactorization_add_nuw_mul_after := by
  unfold tryFactorization_add_nuw_mul_before tryFactorization_add_nuw_mul_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_add_nuw_mul
  apply tryFactorization_add_nuw_mul_thm
  ---END tryFactorization_add_nuw_mul



def tryFactorization_add_nuw_mul_nuw_mul_nuw_var_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.mul %arg0, %arg1 : i32
  %1 = llvm.mul %arg0, %arg2 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_nuw_mul_nuw_var_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.add %arg1, %arg2 : i32
  %1 = llvm.mul %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_add_nuw_mul_nuw_mul_nuw_var_proof : tryFactorization_add_nuw_mul_nuw_mul_nuw_var_before ⊑ tryFactorization_add_nuw_mul_nuw_mul_nuw_var_after := by
  unfold tryFactorization_add_nuw_mul_nuw_mul_nuw_var_before tryFactorization_add_nuw_mul_nuw_mul_nuw_var_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_add_nuw_mul_nuw_mul_nuw_var
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_nuw_mul_nuw_mul_nuw_var



def tryFactorization_add_nuw_mul_mul_nuw_var_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.mul %arg0, %arg1 : i32
  %1 = llvm.mul %arg0, %arg2 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_mul_nuw_var_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.add %arg1, %arg2 : i32
  %1 = llvm.mul %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_add_nuw_mul_mul_nuw_var_proof : tryFactorization_add_nuw_mul_mul_nuw_var_before ⊑ tryFactorization_add_nuw_mul_mul_nuw_var_after := by
  unfold tryFactorization_add_nuw_mul_mul_nuw_var_before tryFactorization_add_nuw_mul_mul_nuw_var_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_add_nuw_mul_mul_nuw_var
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_nuw_mul_mul_nuw_var



def tryFactorization_add_nuw_mul_nuw_mul_var_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.mul %arg0, %arg1 : i32
  %1 = llvm.mul %arg0, %arg2 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_nuw_mul_nuw_mul_var_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.add %arg1, %arg2 : i32
  %1 = llvm.mul %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_add_nuw_mul_nuw_mul_var_proof : tryFactorization_add_nuw_mul_nuw_mul_var_before ⊑ tryFactorization_add_nuw_mul_nuw_mul_var_after := by
  unfold tryFactorization_add_nuw_mul_nuw_mul_var_before tryFactorization_add_nuw_mul_nuw_mul_var_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_add_nuw_mul_nuw_mul_var
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_nuw_mul_nuw_mul_var



def tryFactorization_add_mul_nuw_mul_var_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.mul %arg0, %arg1 : i32
  %1 = llvm.mul %arg0, %arg2 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def tryFactorization_add_mul_nuw_mul_var_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.add %arg1, %arg2 : i32
  %1 = llvm.mul %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_add_mul_nuw_mul_var_proof : tryFactorization_add_mul_nuw_mul_var_before ⊑ tryFactorization_add_mul_nuw_mul_var_after := by
  unfold tryFactorization_add_mul_nuw_mul_var_before tryFactorization_add_mul_nuw_mul_var_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_add_mul_nuw_mul_var
  all_goals (try extract_goal ; sorry)
  ---END tryFactorization_add_mul_nuw_mul_var


