
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
section gselect_meta_statements

def not_cond_before := [llvm|
{
^0(%arg24 : i1, %arg25 : i32, %arg26 : i32):
  %0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
  %1 = llvm.xor %arg24, %0 : i1
  %2 = "llvm.select"(%1, %arg25, %arg26) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def not_cond_after := [llvm|
{
^0(%arg24 : i1, %arg25 : i32, %arg26 : i32):
  %0 = "llvm.select"(%arg24, %arg26, %arg25) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem not_cond_proof : not_cond_before ⊑ not_cond_after := by
  unfold not_cond_before not_cond_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN not_cond
  all_goals (try extract_goal ; sorry)
  ---END not_cond



def select_add_before := [llvm|
{
^0(%arg15 : i1, %arg16 : i64, %arg17 : i64):
  %0 = llvm.add %arg16, %arg17 : i64
  %1 = "llvm.select"(%arg15, %0, %arg16) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%1) : (i64) -> ()
}
]
def select_add_after := [llvm|
{
^0(%arg15 : i1, %arg16 : i64, %arg17 : i64):
  %0 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
  %1 = "llvm.select"(%arg15, %arg17, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %2 = llvm.add %arg16, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
theorem select_add_proof : select_add_before ⊑ select_add_after := by
  unfold select_add_before select_add_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN select_add
  all_goals (try extract_goal ; sorry)
  ---END select_add



def select_sub_before := [llvm|
{
^0(%arg9 : i1, %arg10 : i17, %arg11 : i17):
  %0 = llvm.sub %arg10, %arg11 : i17
  %1 = "llvm.select"(%arg9, %0, %arg10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i17, i17) -> i17
  "llvm.return"(%1) : (i17) -> ()
}
]
def select_sub_after := [llvm|
{
^0(%arg9 : i1, %arg10 : i17, %arg11 : i17):
  %0 = "llvm.mlir.constant"() <{value = 0 : i17}> : () -> i17
  %1 = "llvm.select"(%arg9, %arg11, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i17, i17) -> i17
  %2 = llvm.sub %arg10, %1 : i17
  "llvm.return"(%2) : (i17) -> ()
}
]
theorem select_sub_proof : select_sub_before ⊑ select_sub_after := by
  unfold select_sub_before select_sub_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN select_sub
  all_goals (try extract_goal ; sorry)
  ---END select_sub



def select_ashr_before := [llvm|
{
^0(%arg6 : i1, %arg7 : i128, %arg8 : i128):
  %0 = llvm.ashr %arg7, %arg8 : i128
  %1 = "llvm.select"(%arg6, %0, %arg7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  "llvm.return"(%1) : (i128) -> ()
}
]
def select_ashr_after := [llvm|
{
^0(%arg6 : i1, %arg7 : i128, %arg8 : i128):
  %0 = "llvm.mlir.constant"() <{value = 0 : i128}> : () -> i128
  %1 = "llvm.select"(%arg6, %arg8, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  %2 = llvm.ashr %arg7, %1 : i128
  "llvm.return"(%2) : (i128) -> ()
}
]
theorem select_ashr_proof : select_ashr_before ⊑ select_ashr_after := by
  unfold select_ashr_before select_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN select_ashr
  all_goals (try extract_goal ; sorry)
  ---END select_ashr


