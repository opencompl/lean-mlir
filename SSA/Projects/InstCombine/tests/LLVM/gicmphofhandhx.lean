
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
section gicmphofhandhx_statements

def icmp_ult_x_y_before := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.and %arg42, %arg43 : i8
  %1 = llvm.icmp "ult" %0, %arg42 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def icmp_ult_x_y_after := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.and %arg42, %arg43 : i8
  %1 = llvm.icmp "ne" %0, %arg42 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ult_x_y_proof : icmp_ult_x_y_before ⊑ icmp_ult_x_y_after := by
  unfold icmp_ult_x_y_before icmp_ult_x_y_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ult_x_y
  all_goals (try extract_goal ; sorry)
  ---END icmp_ult_x_y



def icmp_ult_x_y_2_before := [llvm|
{
^0(%arg40 : i8, %arg41 : i8):
  %0 = llvm.mul %arg40, %arg40 : i8
  %1 = llvm.and %0, %arg41 : i8
  %2 = llvm.icmp "ugt" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_ult_x_y_2_after := [llvm|
{
^0(%arg40 : i8, %arg41 : i8):
  %0 = llvm.mul %arg40, %arg40 : i8
  %1 = llvm.and %0, %arg41 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ult_x_y_2_proof : icmp_ult_x_y_2_before ⊑ icmp_ult_x_y_2_after := by
  unfold icmp_ult_x_y_2_before icmp_ult_x_y_2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ult_x_y_2
  all_goals (try extract_goal ; sorry)
  ---END icmp_ult_x_y_2



def icmp_uge_x_y_2_before := [llvm|
{
^0(%arg36 : i8, %arg37 : i8):
  %0 = llvm.mul %arg36, %arg36 : i8
  %1 = llvm.and %0, %arg37 : i8
  %2 = llvm.icmp "ule" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_uge_x_y_2_after := [llvm|
{
^0(%arg36 : i8, %arg37 : i8):
  %0 = llvm.mul %arg36, %arg36 : i8
  %1 = llvm.and %0, %arg37 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_uge_x_y_2_proof : icmp_uge_x_y_2_before ⊑ icmp_uge_x_y_2_after := by
  unfold icmp_uge_x_y_2_before icmp_uge_x_y_2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_uge_x_y_2
  all_goals (try extract_goal ; sorry)
  ---END icmp_uge_x_y_2



def icmp_sle_x_negy_before := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.or %arg29, %0 : i8
  %2 = llvm.and %1, %arg28 : i8
  %3 = llvm.icmp "sle" %2, %arg28 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle_x_negy_after := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle_x_negy_proof : icmp_sle_x_negy_before ⊑ icmp_sle_x_negy_after := by
  unfold icmp_sle_x_negy_before icmp_sle_x_negy_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle_x_negy
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle_x_negy



def icmp_eq_x_invertable_y_todo_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i1):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(24 : i8) : i8
  %2 = "llvm.select"(%arg11, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.and %arg10, %2 : i8
  %4 = llvm.icmp "eq" %arg10, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_eq_x_invertable_y_todo_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i1):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(-25 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = "llvm.select"(%arg11, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %arg10, %3 : i8
  %5 = llvm.icmp "eq" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_x_invertable_y_todo_proof : icmp_eq_x_invertable_y_todo_before ⊑ icmp_eq_x_invertable_y_todo_after := by
  unfold icmp_eq_x_invertable_y_todo_before icmp_eq_x_invertable_y_todo_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_x_invertable_y_todo
  all_goals (try extract_goal ; sorry)
  ---END icmp_eq_x_invertable_y_todo



def icmp_eq_x_invertable_y_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg9, %0 : i8
  %2 = llvm.and %arg8, %1 : i8
  %3 = llvm.icmp "eq" %arg8, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_x_invertable_y_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.and %arg8, %arg9 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_x_invertable_y_proof : icmp_eq_x_invertable_y_before ⊑ icmp_eq_x_invertable_y_after := by
  unfold icmp_eq_x_invertable_y_before icmp_eq_x_invertable_y_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_x_invertable_y
  all_goals (try extract_goal ; sorry)
  ---END icmp_eq_x_invertable_y



def icmp_eq_x_invertable_y2_todo_before := [llvm|
{
^0(%arg4 : i8, %arg5 : i1):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(24 : i8) : i8
  %2 = "llvm.select"(%arg5, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.and %arg4, %2 : i8
  %4 = llvm.icmp "eq" %2, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_eq_x_invertable_y2_todo_after := [llvm|
{
^0(%arg4 : i8, %arg5 : i1):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(-25 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i8) : i8
  %3 = "llvm.select"(%arg5, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.or %arg4, %3 : i8
  %5 = llvm.icmp "eq" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_x_invertable_y2_todo_proof : icmp_eq_x_invertable_y2_todo_before ⊑ icmp_eq_x_invertable_y2_todo_after := by
  unfold icmp_eq_x_invertable_y2_todo_before icmp_eq_x_invertable_y2_todo_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_x_invertable_y2_todo
  all_goals (try extract_goal ; sorry)
  ---END icmp_eq_x_invertable_y2_todo



def icmp_eq_x_invertable_y2_before := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg3, %0 : i8
  %2 = llvm.and %arg2, %1 : i8
  %3 = llvm.icmp "eq" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_x_invertable_y2_after := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.or %arg2, %arg3 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_x_invertable_y2_proof : icmp_eq_x_invertable_y2_before ⊑ icmp_eq_x_invertable_y2_after := by
  unfold icmp_eq_x_invertable_y2_before icmp_eq_x_invertable_y2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_x_invertable_y2
  all_goals (try extract_goal ; sorry)
  ---END icmp_eq_x_invertable_y2


