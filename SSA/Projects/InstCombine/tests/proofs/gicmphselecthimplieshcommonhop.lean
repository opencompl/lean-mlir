import SSA.Projects.InstCombine.tests.proofs.gicmphselecthimplieshcommonhop_proof
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
section gicmphselecthimplieshcommonhop_statements

def sgt_3_impliesF_eq_2_before := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.icmp "sgt" %arg16, %0 : i8
  %3 = "llvm.select"(%2, %1, %arg17) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.icmp "eq" %3, %arg16 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_3_impliesF_eq_2_after := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "slt" %arg16, %0 : i8
  %3 = llvm.icmp "eq" %arg17, %arg16 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_3_impliesF_eq_2_proof : sgt_3_impliesF_eq_2_before ⊑ sgt_3_impliesF_eq_2_after := by
  unfold sgt_3_impliesF_eq_2_before sgt_3_impliesF_eq_2_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_3_impliesF_eq_2
  apply sgt_3_impliesF_eq_2_thm
  ---END sgt_3_impliesF_eq_2



def sgt_3_impliesT_sgt_2_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.icmp "sgt" %arg14, %0 : i8
  %3 = "llvm.select"(%2, %1, %arg15) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.icmp "sgt" %3, %arg14 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_3_impliesT_sgt_2_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "slt" %arg14, %0 : i8
  %3 = llvm.icmp "sgt" %arg15, %arg14 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_3_impliesT_sgt_2_proof : sgt_3_impliesT_sgt_2_before ⊑ sgt_3_impliesT_sgt_2_after := by
  unfold sgt_3_impliesT_sgt_2_before sgt_3_impliesT_sgt_2_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_3_impliesT_sgt_2
  apply sgt_3_impliesT_sgt_2_thm
  ---END sgt_3_impliesT_sgt_2



def sgt_x_impliesF_eq_smin_todo_before := [llvm|
{
^0(%arg11 : i8, %arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sgt" %arg11, %arg13 : i8
  %2 = "llvm.select"(%1, %0, %arg12) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.icmp "eq" %2, %arg11 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_x_impliesF_eq_smin_todo_after := [llvm|
{
^0(%arg11 : i8, %arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "sle" %arg11, %arg13 : i8
  %2 = llvm.icmp "eq" %arg12, %arg11 : i8
  %3 = "llvm.select"(%1, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_x_impliesF_eq_smin_todo_proof : sgt_x_impliesF_eq_smin_todo_before ⊑ sgt_x_impliesF_eq_smin_todo_after := by
  unfold sgt_x_impliesF_eq_smin_todo_before sgt_x_impliesF_eq_smin_todo_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_x_impliesF_eq_smin_todo
  apply sgt_x_impliesF_eq_smin_todo_thm
  ---END sgt_x_impliesF_eq_smin_todo



def slt_x_impliesT_ne_smin_todo_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8, %arg10 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "slt" %arg8, %arg10 : i8
  %2 = "llvm.select"(%1, %0, %arg9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.icmp "ne" %arg8, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_x_impliesT_ne_smin_todo_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8, %arg10 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "slt" %arg8, %arg10 : i8
  %2 = llvm.icmp "ne" %arg9, %arg8 : i8
  %3 = "llvm.select"(%1, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_x_impliesT_ne_smin_todo_proof : slt_x_impliesT_ne_smin_todo_before ⊑ slt_x_impliesT_ne_smin_todo_after := by
  unfold slt_x_impliesT_ne_smin_todo_before slt_x_impliesT_ne_smin_todo_after
  simp_alive_peephole
  intros
  ---BEGIN slt_x_impliesT_ne_smin_todo
  apply slt_x_impliesT_ne_smin_todo_thm
  ---END slt_x_impliesT_ne_smin_todo



def ult_x_impliesT_eq_umax_todo_before := [llvm|
{
^0(%arg5 : i8, %arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ugt" %arg7, %arg5 : i8
  %2 = "llvm.select"(%1, %0, %arg6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.icmp "ne" %2, %arg5 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_x_impliesT_eq_umax_todo_after := [llvm|
{
^0(%arg5 : i8, %arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "ugt" %arg7, %arg5 : i8
  %2 = llvm.icmp "ne" %arg6, %arg5 : i8
  %3 = "llvm.select"(%1, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_x_impliesT_eq_umax_todo_proof : ult_x_impliesT_eq_umax_todo_before ⊑ ult_x_impliesT_eq_umax_todo_after := by
  unfold ult_x_impliesT_eq_umax_todo_before ult_x_impliesT_eq_umax_todo_after
  simp_alive_peephole
  intros
  ---BEGIN ult_x_impliesT_eq_umax_todo
  apply ult_x_impliesT_eq_umax_todo_thm
  ---END ult_x_impliesT_eq_umax_todo



def ult_1_impliesF_eq_1_before := [llvm|
{
^0(%arg3 : i8, %arg4 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.icmp "ult" %arg3, %0 : i8
  %2 = "llvm.select"(%1, %0, %arg4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.icmp "eq" %arg3, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_1_impliesF_eq_1_after := [llvm|
{
^0(%arg3 : i8, %arg4 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ne" %arg3, %0 : i8
  %3 = llvm.icmp "eq" %arg4, %arg3 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_1_impliesF_eq_1_proof : ult_1_impliesF_eq_1_before ⊑ ult_1_impliesF_eq_1_after := by
  unfold ult_1_impliesF_eq_1_before ult_1_impliesF_eq_1_after
  simp_alive_peephole
  intros
  ---BEGIN ult_1_impliesF_eq_1
  apply ult_1_impliesF_eq_1_thm
  ---END ult_1_impliesF_eq_1


