
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
section gbinophselecthcasthofhselecthcond_statements

def add_select_zext_before := [llvm|
{
^0(%arg29 : i1):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = "llvm.select"(%arg29, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %3 = llvm.zext %arg29 : i1 to i64
  %4 = llvm.add %2, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def add_select_zext_after := [llvm|
{
^0(%arg29 : i1):
  %0 = llvm.mlir.constant(65) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = "llvm.select"(%arg29, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_select_zext_proof : add_select_zext_before ⊑ add_select_zext_after := by
  unfold add_select_zext_before add_select_zext_after
  simp_alive_peephole
  intros
  ---BEGIN add_select_zext
  all_goals (try extract_goal ; sorry)
  ---END add_select_zext



def add_select_sext_before := [llvm|
{
^0(%arg28 : i1):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = "llvm.select"(%arg28, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %3 = llvm.sext %arg28 : i1 to i64
  %4 = llvm.add %2, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def add_select_sext_after := [llvm|
{
^0(%arg28 : i1):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = "llvm.select"(%arg28, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_select_sext_proof : add_select_sext_before ⊑ add_select_sext_after := by
  unfold add_select_sext_before add_select_sext_after
  simp_alive_peephole
  intros
  ---BEGIN add_select_sext
  all_goals (try extract_goal ; sorry)
  ---END add_select_sext



def add_select_not_zext_before := [llvm|
{
^0(%arg27 : i1):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = llvm.mlir.constant(true) : i1
  %3 = "llvm.select"(%arg27, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %4 = llvm.xor %arg27, %2 : i1
  %5 = llvm.zext %4 : i1 to i64
  %6 = llvm.add %3, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def add_select_not_zext_after := [llvm|
{
^0(%arg27 : i1):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(2) : i64
  %2 = "llvm.select"(%arg27, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_select_not_zext_proof : add_select_not_zext_before ⊑ add_select_not_zext_after := by
  unfold add_select_not_zext_before add_select_not_zext_after
  simp_alive_peephole
  intros
  ---BEGIN add_select_not_zext
  all_goals (try extract_goal ; sorry)
  ---END add_select_not_zext



def add_select_not_sext_before := [llvm|
{
^0(%arg26 : i1):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = llvm.mlir.constant(true) : i1
  %3 = "llvm.select"(%arg26, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %4 = llvm.xor %arg26, %2 : i1
  %5 = llvm.sext %4 : i1 to i64
  %6 = llvm.add %3, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def add_select_not_sext_after := [llvm|
{
^0(%arg26 : i1):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = "llvm.select"(%arg26, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_select_not_sext_proof : add_select_not_sext_before ⊑ add_select_not_sext_after := by
  unfold add_select_not_sext_before add_select_not_sext_after
  simp_alive_peephole
  intros
  ---BEGIN add_select_not_sext
  all_goals (try extract_goal ; sorry)
  ---END add_select_not_sext



def sub_select_sext_before := [llvm|
{
^0(%arg24 : i1, %arg25 : i64):
  %0 = llvm.mlir.constant(64) : i64
  %1 = "llvm.select"(%arg24, %0, %arg25) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %2 = llvm.sext %arg24 : i1 to i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def sub_select_sext_after := [llvm|
{
^0(%arg24 : i1, %arg25 : i64):
  %0 = llvm.mlir.constant(65) : i64
  %1 = "llvm.select"(%arg24, %0, %arg25) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_select_sext_proof : sub_select_sext_before ⊑ sub_select_sext_after := by
  unfold sub_select_sext_before sub_select_sext_after
  simp_alive_peephole
  intros
  ---BEGIN sub_select_sext
  all_goals (try extract_goal ; sorry)
  ---END sub_select_sext



def sub_select_not_zext_before := [llvm|
{
^0(%arg22 : i1, %arg23 : i64):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg22, %arg23, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %3 = llvm.xor %arg22, %1 : i1
  %4 = llvm.zext %3 : i1 to i64
  %5 = llvm.sub %2, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def sub_select_not_zext_after := [llvm|
{
^0(%arg22 : i1, %arg23 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = "llvm.select"(%arg22, %arg23, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_select_not_zext_proof : sub_select_not_zext_before ⊑ sub_select_not_zext_after := by
  unfold sub_select_not_zext_before sub_select_not_zext_after
  simp_alive_peephole
  intros
  ---BEGIN sub_select_not_zext
  all_goals (try extract_goal ; sorry)
  ---END sub_select_not_zext



def sub_select_not_sext_before := [llvm|
{
^0(%arg20 : i1, %arg21 : i64):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg20, %arg21, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %3 = llvm.xor %arg20, %1 : i1
  %4 = llvm.sext %3 : i1 to i64
  %5 = llvm.sub %2, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def sub_select_not_sext_after := [llvm|
{
^0(%arg20 : i1, %arg21 : i64):
  %0 = llvm.mlir.constant(65) : i64
  %1 = "llvm.select"(%arg20, %arg21, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_select_not_sext_proof : sub_select_not_sext_before ⊑ sub_select_not_sext_after := by
  unfold sub_select_not_sext_before sub_select_not_sext_after
  simp_alive_peephole
  intros
  ---BEGIN sub_select_not_sext
  all_goals (try extract_goal ; sorry)
  ---END sub_select_not_sext



def mul_select_zext_before := [llvm|
{
^0(%arg18 : i1, %arg19 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = "llvm.select"(%arg18, %arg19, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %2 = llvm.zext %arg18 : i1 to i64
  %3 = llvm.mul %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def mul_select_zext_after := [llvm|
{
^0(%arg18 : i1, %arg19 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = "llvm.select"(%arg18, %arg19, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_select_zext_proof : mul_select_zext_before ⊑ mul_select_zext_after := by
  unfold mul_select_zext_before mul_select_zext_after
  simp_alive_peephole
  intros
  ---BEGIN mul_select_zext
  all_goals (try extract_goal ; sorry)
  ---END mul_select_zext



def mul_select_sext_before := [llvm|
{
^0(%arg17 : i1):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = "llvm.select"(%arg17, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %3 = llvm.sext %arg17 : i1 to i64
  %4 = llvm.mul %2, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def mul_select_sext_after := [llvm|
{
^0(%arg17 : i1):
  %0 = llvm.mlir.constant(-64) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = "llvm.select"(%arg17, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_select_sext_proof : mul_select_sext_before ⊑ mul_select_sext_after := by
  unfold mul_select_sext_before mul_select_sext_after
  simp_alive_peephole
  intros
  ---BEGIN mul_select_sext
  all_goals (try extract_goal ; sorry)
  ---END mul_select_sext



def select_zext_different_condition_before := [llvm|
{
^0(%arg15 : i1, %arg16 : i1):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = "llvm.select"(%arg15, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %3 = llvm.zext %arg16 : i1 to i64
  %4 = llvm.add %2, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def select_zext_different_condition_after := [llvm|
{
^0(%arg15 : i1, %arg16 : i1):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = "llvm.select"(%arg15, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %3 = llvm.zext %arg16 : i1 to i64
  %4 = llvm.add %2, %3 overflow<nsw,nuw> : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_zext_different_condition_proof : select_zext_different_condition_before ⊑ select_zext_different_condition_after := by
  unfold select_zext_different_condition_before select_zext_different_condition_after
  simp_alive_peephole
  intros
  ---BEGIN select_zext_different_condition
  all_goals (try extract_goal ; sorry)
  ---END select_zext_different_condition



def multiuse_add_before := [llvm|
{
^0(%arg13 : i1):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = "llvm.select"(%arg13, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %3 = llvm.zext %arg13 : i1 to i64
  %4 = llvm.add %2, %3 : i64
  %5 = llvm.add %4, %1 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def multiuse_add_after := [llvm|
{
^0(%arg13 : i1):
  %0 = llvm.mlir.constant(66) : i64
  %1 = llvm.mlir.constant(2) : i64
  %2 = "llvm.select"(%arg13, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem multiuse_add_proof : multiuse_add_before ⊑ multiuse_add_after := by
  unfold multiuse_add_before multiuse_add_after
  simp_alive_peephole
  intros
  ---BEGIN multiuse_add
  all_goals (try extract_goal ; sorry)
  ---END multiuse_add



def multiuse_select_before := [llvm|
{
^0(%arg12 : i1):
  %0 = llvm.mlir.constant(64) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = "llvm.select"(%arg12, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %3 = llvm.zext %arg12 : i1 to i64
  %4 = llvm.sub %2, %3 : i64
  %5 = llvm.mul %2, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def multiuse_select_after := [llvm|
{
^0(%arg12 : i1):
  %0 = llvm.mlir.constant(4032) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = "llvm.select"(%arg12, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem multiuse_select_proof : multiuse_select_before ⊑ multiuse_select_after := by
  unfold multiuse_select_before multiuse_select_after
  simp_alive_peephole
  intros
  ---BEGIN multiuse_select
  all_goals (try extract_goal ; sorry)
  ---END multiuse_select



def select_non_const_sides_before := [llvm|
{
^0(%arg9 : i1, %arg10 : i64, %arg11 : i64):
  %0 = llvm.zext %arg9 : i1 to i64
  %1 = "llvm.select"(%arg9, %arg10, %arg11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %2 = llvm.sub %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def select_non_const_sides_after := [llvm|
{
^0(%arg9 : i1, %arg10 : i64, %arg11 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.add %arg10, %0 : i64
  %2 = "llvm.select"(%arg9, %1, %arg11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_non_const_sides_proof : select_non_const_sides_before ⊑ select_non_const_sides_after := by
  unfold select_non_const_sides_before select_non_const_sides_after
  simp_alive_peephole
  intros
  ---BEGIN select_non_const_sides
  all_goals (try extract_goal ; sorry)
  ---END select_non_const_sides



def sub_select_sext_op_swapped_non_const_args_before := [llvm|
{
^0(%arg6 : i1, %arg7 : i6, %arg8 : i6):
  %0 = "llvm.select"(%arg6, %arg7, %arg8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i6, i6) -> i6
  %1 = llvm.sext %arg6 : i1 to i6
  %2 = llvm.sub %1, %0 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_select_sext_op_swapped_non_const_args_after := [llvm|
{
^0(%arg6 : i1, %arg7 : i6, %arg8 : i6):
  %0 = llvm.mlir.constant(-1 : i6) : i6
  %1 = llvm.mlir.constant(0 : i6) : i6
  %2 = llvm.xor %arg7, %0 : i6
  %3 = llvm.sub %1, %arg8 : i6
  %4 = "llvm.select"(%arg6, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i6, i6) -> i6
  "llvm.return"(%4) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_select_sext_op_swapped_non_const_args_proof : sub_select_sext_op_swapped_non_const_args_before ⊑ sub_select_sext_op_swapped_non_const_args_after := by
  unfold sub_select_sext_op_swapped_non_const_args_before sub_select_sext_op_swapped_non_const_args_after
  simp_alive_peephole
  intros
  ---BEGIN sub_select_sext_op_swapped_non_const_args
  all_goals (try extract_goal ; sorry)
  ---END sub_select_sext_op_swapped_non_const_args



def sub_select_zext_op_swapped_non_const_args_before := [llvm|
{
^0(%arg3 : i1, %arg4 : i6, %arg5 : i6):
  %0 = "llvm.select"(%arg3, %arg4, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i6, i6) -> i6
  %1 = llvm.zext %arg3 : i1 to i6
  %2 = llvm.sub %1, %0 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_select_zext_op_swapped_non_const_args_after := [llvm|
{
^0(%arg3 : i1, %arg4 : i6, %arg5 : i6):
  %0 = llvm.mlir.constant(1 : i6) : i6
  %1 = llvm.mlir.constant(0 : i6) : i6
  %2 = llvm.sub %0, %arg4 : i6
  %3 = llvm.sub %1, %arg5 : i6
  %4 = "llvm.select"(%arg3, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i6, i6) -> i6
  "llvm.return"(%4) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_select_zext_op_swapped_non_const_args_proof : sub_select_zext_op_swapped_non_const_args_before ⊑ sub_select_zext_op_swapped_non_const_args_after := by
  unfold sub_select_zext_op_swapped_non_const_args_before sub_select_zext_op_swapped_non_const_args_after
  simp_alive_peephole
  intros
  ---BEGIN sub_select_zext_op_swapped_non_const_args
  all_goals (try extract_goal ; sorry)
  ---END sub_select_zext_op_swapped_non_const_args


