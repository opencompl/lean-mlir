import SSA.Projects.InstCombine.tests.proofs.gminmaxhdemandbits_proof
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
section gminmaxhdemandbits_statements

def and_umax_less_before := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(-32 : i32) : i32
  %2 = llvm.icmp "ugt" %0, %arg19 : i32
  %3 = "llvm.select"(%2, %0, %arg19) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_umax_less_after := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(-32 : i32) : i32
  %1 = llvm.and %arg19, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_umax_less_proof : and_umax_less_before ⊑ and_umax_less_after := by
  unfold and_umax_less_before and_umax_less_after
  simp_alive_peephole
  intros
  ---BEGIN and_umax_less
  apply and_umax_less_thm
  ---END and_umax_less



def and_umax_muchless_before := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(-32 : i32) : i32
  %2 = llvm.icmp "ugt" %0, %arg18 : i32
  %3 = "llvm.select"(%2, %0, %arg18) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_umax_muchless_after := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(-32 : i32) : i32
  %1 = llvm.and %arg18, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_umax_muchless_proof : and_umax_muchless_before ⊑ and_umax_muchless_after := by
  unfold and_umax_muchless_before and_umax_muchless_after
  simp_alive_peephole
  intros
  ---BEGIN and_umax_muchless
  apply and_umax_muchless_thm
  ---END and_umax_muchless



def shr_umax_before := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.icmp "ugt" %0, %arg16 : i32
  %3 = "llvm.select"(%2, %0, %arg16) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shr_umax_after := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.lshr %arg16, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shr_umax_proof : shr_umax_before ⊑ shr_umax_after := by
  unfold shr_umax_before shr_umax_after
  simp_alive_peephole
  intros
  ---BEGIN shr_umax
  apply shr_umax_thm
  ---END shr_umax



def t_0_1_before := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "ugt" %arg15, %0 : i8
  %3 = "llvm.select"(%2, %arg15, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def t_0_1_after := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.and %arg15, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t_0_1_proof : t_0_1_before ⊑ t_0_1_after := by
  unfold t_0_1_before t_0_1_after
  simp_alive_peephole
  intros
  ---BEGIN t_0_1
  apply t_0_1_thm
  ---END t_0_1



def t_0_10_before := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.icmp "ugt" %arg14, %0 : i8
  %3 = "llvm.select"(%2, %arg14, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def t_0_10_after := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.and %arg14, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t_0_10_proof : t_0_10_before ⊑ t_0_10_after := by
  unfold t_0_10_before t_0_10_after
  simp_alive_peephole
  intros
  ---BEGIN t_0_10
  apply t_0_10_thm
  ---END t_0_10



def t_1_10_before := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.icmp "ugt" %arg13, %0 : i8
  %3 = "llvm.select"(%2, %arg13, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def t_1_10_after := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.and %arg13, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t_1_10_proof : t_1_10_before ⊑ t_1_10_after := by
  unfold t_1_10_before t_1_10_after
  simp_alive_peephole
  intros
  ---BEGIN t_1_10
  apply t_1_10_thm
  ---END t_1_10



def t_2_4_before := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.icmp "ugt" %arg12, %0 : i8
  %3 = "llvm.select"(%2, %arg12, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def t_2_4_after := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.and %arg12, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t_2_4_proof : t_2_4_before ⊑ t_2_4_after := by
  unfold t_2_4_before t_2_4_after
  simp_alive_peephole
  intros
  ---BEGIN t_2_4
  apply t_2_4_thm
  ---END t_2_4



def t_2_192_before := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(-64 : i8) : i8
  %2 = llvm.icmp "ugt" %arg11, %0 : i8
  %3 = "llvm.select"(%2, %arg11, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def t_2_192_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.and %arg11, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t_2_192_proof : t_2_192_before ⊑ t_2_192_after := by
  unfold t_2_192_before t_2_192_after
  simp_alive_peephole
  intros
  ---BEGIN t_2_192
  apply t_2_192_thm
  ---END t_2_192



def t_2_63_or_before := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(63 : i8) : i8
  %2 = llvm.icmp "ugt" %arg10, %0 : i8
  %3 = "llvm.select"(%2, %arg10, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.or %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def t_2_63_or_after := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(63 : i8) : i8
  %1 = llvm.or %arg10, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t_2_63_or_proof : t_2_63_or_before ⊑ t_2_63_or_after := by
  unfold t_2_63_or_before t_2_63_or_after
  simp_alive_peephole
  intros
  ---BEGIN t_2_63_or
  apply t_2_63_or_thm
  ---END t_2_63_or



def and_umin_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(-32 : i32) : i32
  %2 = llvm.icmp "ult" %0, %arg5 : i32
  %3 = "llvm.select"(%2, %0, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_umin_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_umin_proof : and_umin_before ⊑ and_umin_after := by
  unfold and_umin_before and_umin_after
  simp_alive_peephole
  intros
  ---BEGIN and_umin
  apply and_umin_thm
  ---END and_umin



def or_umin_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "ult" %0, %arg4 : i32
  %3 = "llvm.select"(%2, %0, %arg4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_umin_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_umin_proof : or_umin_before ⊑ or_umin_after := by
  unfold or_umin_before or_umin_after
  simp_alive_peephole
  intros
  ---BEGIN or_umin
  apply or_umin_thm
  ---END or_umin



def or_min_31_30_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(-30 : i8) : i8
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.icmp "ult" %arg3, %0 : i8
  %3 = "llvm.select"(%2, %arg3, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.or %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def or_min_31_30_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.or %arg3, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_min_31_30_proof : or_min_31_30_before ⊑ or_min_31_30_after := by
  unfold or_min_31_30_before or_min_31_30_after
  simp_alive_peephole
  intros
  ---BEGIN or_min_31_30
  apply or_min_31_30_thm
  ---END or_min_31_30



def and_min_7_7_before := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(-7 : i8) : i8
  %1 = llvm.mlir.constant(-8 : i8) : i8
  %2 = llvm.icmp "ult" %arg2, %0 : i8
  %3 = "llvm.select"(%2, %arg2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def and_min_7_7_after := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.and %arg2, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_min_7_7_proof : and_min_7_7_before ⊑ and_min_7_7_after := by
  unfold and_min_7_7_before and_min_7_7_after
  simp_alive_peephole
  intros
  ---BEGIN and_min_7_7
  apply and_min_7_7_thm
  ---END and_min_7_7



def and_min_7_8_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.icmp "ult" %arg1, %0 : i8
  %2 = "llvm.select"(%1, %arg1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.and %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def and_min_7_8_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.and %arg1, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_min_7_8_proof : and_min_7_8_before ⊑ and_min_7_8_after := by
  unfold and_min_7_8_before and_min_7_8_after
  simp_alive_peephole
  intros
  ---BEGIN and_min_7_8
  apply and_min_7_8_thm
  ---END and_min_7_8


