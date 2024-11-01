
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
section gicmphofhorhx_statements

def or_ugt_before := [llvm|
{
^0(%arg58 : i8, %arg59 : i8):
  %0 = llvm.or %arg58, %arg59 : i8
  %1 = llvm.icmp "ugt" %0, %arg58 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def or_ugt_after := [llvm|
{
^0(%arg58 : i8, %arg59 : i8):
  %0 = llvm.or %arg58, %arg59 : i8
  %1 = llvm.icmp "ne" %0, %arg58 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_ugt_proof : or_ugt_before ⊑ or_ugt_after := by
  unfold or_ugt_before or_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN or_ugt
  all_goals (try extract_goal ; sorry)
  ---END or_ugt



def or_eq_notY_eq_0_before := [llvm|
{
^0(%arg45 : i8, %arg46 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg46, %0 : i8
  %2 = llvm.or %arg45, %1 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_eq_notY_eq_0_after := [llvm|
{
^0(%arg45 : i8, %arg46 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.and %arg45, %arg46 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_eq_notY_eq_0_proof : or_eq_notY_eq_0_before ⊑ or_eq_notY_eq_0_after := by
  unfold or_eq_notY_eq_0_before or_eq_notY_eq_0_after
  simp_alive_peephole
  intros
  ---BEGIN or_eq_notY_eq_0
  all_goals (try extract_goal ; sorry)
  ---END or_eq_notY_eq_0



def or_ne_notY_eq_1s_before := [llvm|
{
^0(%arg41 : i8, %arg42 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg42, %0 : i8
  %2 = llvm.or %arg41, %1 : i8
  %3 = llvm.icmp "ne" %2, %arg41 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_ne_notY_eq_1s_after := [llvm|
{
^0(%arg41 : i8, %arg42 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.or %arg41, %arg42 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_ne_notY_eq_1s_proof : or_ne_notY_eq_1s_before ⊑ or_ne_notY_eq_1s_after := by
  unfold or_ne_notY_eq_1s_before or_ne_notY_eq_1s_after
  simp_alive_peephole
  intros
  ---BEGIN or_ne_notY_eq_1s
  all_goals (try extract_goal ; sorry)
  ---END or_ne_notY_eq_1s



def or_ne_notY_eq_1s_fail_bad_not_before := [llvm|
{
^0(%arg39 : i8, %arg40 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.xor %arg40, %0 : i8
  %2 = llvm.or %arg39, %1 : i8
  %3 = llvm.icmp "ne" %2, %arg39 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_ne_notY_eq_1s_fail_bad_not_after := [llvm|
{
^0(%arg39 : i8, %arg40 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.xor %arg40, %0 : i8
  %3 = llvm.or %arg39, %2 : i8
  %4 = llvm.icmp "ne" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_ne_notY_eq_1s_fail_bad_not_proof : or_ne_notY_eq_1s_fail_bad_not_before ⊑ or_ne_notY_eq_1s_fail_bad_not_after := by
  unfold or_ne_notY_eq_1s_fail_bad_not_before or_ne_notY_eq_1s_fail_bad_not_after
  simp_alive_peephole
  intros
  ---BEGIN or_ne_notY_eq_1s_fail_bad_not
  all_goals (try extract_goal ; sorry)
  ---END or_ne_notY_eq_1s_fail_bad_not



def or_simplify_ule_before := [llvm|
{
^0(%arg18 : i8, %arg19 : i8, %arg20 : i1):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.or %arg18, %0 : i8
  %3 = llvm.and %arg19, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = llvm.icmp "ule" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_ule_after := [llvm|
{
^0(%arg18 : i8, %arg19 : i8, %arg20 : i1):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.and %arg19, %0 : i8
  %3 = llvm.or %arg18, %arg19 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.icmp "ule" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_simplify_ule_proof : or_simplify_ule_before ⊑ or_simplify_ule_after := by
  unfold or_simplify_ule_before or_simplify_ule_after
  simp_alive_peephole
  intros
  ---BEGIN or_simplify_ule
  all_goals (try extract_goal ; sorry)
  ---END or_simplify_ule



def or_simplify_uge_before := [llvm|
{
^0(%arg15 : i8, %arg16 : i8, %arg17 : i1):
  %0 = llvm.mlir.constant(-127 : i8) : i8
  %1 = llvm.mlir.constant(127 : i8) : i8
  %2 = llvm.or %arg15, %0 : i8
  %3 = llvm.and %arg16, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = llvm.icmp "uge" %3, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_uge_after := [llvm|
{
^0(%arg15 : i8, %arg16 : i8, %arg17 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_simplify_uge_proof : or_simplify_uge_before ⊑ or_simplify_uge_after := by
  unfold or_simplify_uge_before or_simplify_uge_after
  simp_alive_peephole
  intros
  ---BEGIN or_simplify_uge
  all_goals (try extract_goal ; sorry)
  ---END or_simplify_uge



def or_simplify_ule_fail_before := [llvm|
{
^0(%arg13 : i8, %arg14 : i8):
  %0 = llvm.mlir.constant(64 : i8) : i8
  %1 = llvm.mlir.constant(127 : i8) : i8
  %2 = llvm.or %arg13, %0 : i8
  %3 = llvm.and %arg14, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = llvm.icmp "ule" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_ule_fail_after := [llvm|
{
^0(%arg13 : i8, %arg14 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(64 : i8) : i8
  %2 = llvm.and %arg14, %0 : i8
  %3 = llvm.or %arg13, %2 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.icmp "ule" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_simplify_ule_fail_proof : or_simplify_ule_fail_before ⊑ or_simplify_ule_fail_after := by
  unfold or_simplify_ule_fail_before or_simplify_ule_fail_after
  simp_alive_peephole
  intros
  ---BEGIN or_simplify_ule_fail
  all_goals (try extract_goal ; sorry)
  ---END or_simplify_ule_fail



def or_simplify_ugt_before := [llvm|
{
^0(%arg11 : i8, %arg12 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.or %arg11, %0 : i8
  %3 = llvm.and %arg12, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = llvm.icmp "ugt" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_ugt_after := [llvm|
{
^0(%arg11 : i8, %arg12 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.and %arg12, %0 : i8
  %3 = llvm.or %arg11, %arg12 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.icmp "ugt" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_simplify_ugt_proof : or_simplify_ugt_before ⊑ or_simplify_ugt_after := by
  unfold or_simplify_ugt_before or_simplify_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN or_simplify_ugt
  all_goals (try extract_goal ; sorry)
  ---END or_simplify_ugt



def or_simplify_ult_before := [llvm|
{
^0(%arg9 : i8, %arg10 : i8):
  %0 = llvm.mlir.constant(36 : i8) : i8
  %1 = llvm.mlir.constant(-5 : i8) : i8
  %2 = llvm.or %arg9, %0 : i8
  %3 = llvm.and %arg10, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = llvm.icmp "ult" %3, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_ult_after := [llvm|
{
^0(%arg9 : i8, %arg10 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.mlir.constant(36 : i8) : i8
  %2 = llvm.and %arg10, %0 : i8
  %3 = llvm.or %arg9, %arg10 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.icmp "ult" %2, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_simplify_ult_proof : or_simplify_ult_before ⊑ or_simplify_ult_after := by
  unfold or_simplify_ult_before or_simplify_ult_after
  simp_alive_peephole
  intros
  ---BEGIN or_simplify_ult
  all_goals (try extract_goal ; sorry)
  ---END or_simplify_ult



def or_simplify_ugt_fail_before := [llvm|
{
^0(%arg7 : i8, %arg8 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.and %arg7, %0 : i8
  %3 = llvm.or %arg8, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = llvm.icmp "ugt" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_ugt_fail_after := [llvm|
{
^0(%arg7 : i8, %arg8 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.or %arg8, %0 : i8
  %2 = llvm.or %arg7, %1 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_simplify_ugt_fail_proof : or_simplify_ugt_fail_before ⊑ or_simplify_ugt_fail_after := by
  unfold or_simplify_ugt_fail_before or_simplify_ugt_fail_after
  simp_alive_peephole
  intros
  ---BEGIN or_simplify_ugt_fail
  all_goals (try extract_goal ; sorry)
  ---END or_simplify_ugt_fail



def icmp_eq_x_invertable_y2_todo_before := [llvm|
{
^0(%arg3 : i8, %arg4 : i1, %arg5 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.xor %arg5, %0 : i8
  %3 = "llvm.select"(%arg4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.or %arg3, %3 : i8
  %5 = llvm.icmp "eq" %3, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_eq_x_invertable_y2_todo_after := [llvm|
{
^0(%arg3 : i8, %arg4 : i1, %arg5 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = "llvm.select"(%arg4, %0, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.and %arg3, %2 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
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
^0(%arg1 : i8, %arg2 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg2, %0 : i8
  %2 = llvm.or %arg1, %1 : i8
  %3 = llvm.icmp "eq" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_x_invertable_y2_after := [llvm|
{
^0(%arg1 : i8, %arg2 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.and %arg1, %arg2 : i8
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



def PR38139_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.or %arg0, %0 : i8
  %2 = llvm.icmp "ne" %1, %arg0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def PR38139_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.icmp "ult" %arg0, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR38139_proof : PR38139_before ⊑ PR38139_after := by
  unfold PR38139_before PR38139_after
  simp_alive_peephole
  intros
  ---BEGIN PR38139
  all_goals (try extract_goal ; sorry)
  ---END PR38139


