
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
section gicmphshlhnsw_statements

def icmp_shl_nsw_sgt_before := [llvm|
{
^0(%arg30 : i32):
  %0 = llvm.mlir.constant(21 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %arg30, %0 overflow<nsw> : i32
  %3 = llvm.icmp "sgt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_shl_nsw_sgt_after := [llvm|
{
^0(%arg30 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sgt" %arg30, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_shl_nsw_sgt_proof : icmp_shl_nsw_sgt_before ⊑ icmp_shl_nsw_sgt_after := by
  unfold icmp_shl_nsw_sgt_before icmp_shl_nsw_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_shl_nsw_sgt
  all_goals (try extract_goal ; sorry)
  ---END icmp_shl_nsw_sgt



def icmp_shl_nsw_sge0_before := [llvm|
{
^0(%arg29 : i32):
  %0 = llvm.mlir.constant(21 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %arg29, %0 overflow<nsw> : i32
  %3 = llvm.icmp "sge" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_shl_nsw_sge0_after := [llvm|
{
^0(%arg29 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg29, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_shl_nsw_sge0_proof : icmp_shl_nsw_sge0_before ⊑ icmp_shl_nsw_sge0_after := by
  unfold icmp_shl_nsw_sge0_before icmp_shl_nsw_sge0_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_shl_nsw_sge0
  all_goals (try extract_goal ; sorry)
  ---END icmp_shl_nsw_sge0



def icmp_shl_nsw_sge1_before := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(21 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.shl %arg28, %0 overflow<nsw> : i32
  %3 = llvm.icmp "sge" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_shl_nsw_sge1_after := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sgt" %arg28, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_shl_nsw_sge1_proof : icmp_shl_nsw_sge1_before ⊑ icmp_shl_nsw_sge1_after := by
  unfold icmp_shl_nsw_sge1_before icmp_shl_nsw_sge1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_shl_nsw_sge1
  all_goals (try extract_goal ; sorry)
  ---END icmp_shl_nsw_sge1



def icmp_shl_nsw_eq_before := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %arg26, %0 overflow<nsw> : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_shl_nsw_eq_after := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg26, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_shl_nsw_eq_proof : icmp_shl_nsw_eq_before ⊑ icmp_shl_nsw_eq_after := by
  unfold icmp_shl_nsw_eq_before icmp_shl_nsw_eq_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_shl_nsw_eq
  all_goals (try extract_goal ; sorry)
  ---END icmp_shl_nsw_eq



def icmp_sgt1_before := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.shl %arg24, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt1_after := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.icmp "ne" %arg24, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sgt1_proof : icmp_sgt1_before ⊑ icmp_sgt1_after := by
  unfold icmp_sgt1_before icmp_sgt1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sgt1
  all_goals (try extract_goal ; sorry)
  ---END icmp_sgt1



def icmp_sgt2_before := [llvm|
{
^0(%arg23 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.shl %arg23, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt2_after := [llvm|
{
^0(%arg23 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.icmp "sgt" %arg23, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sgt2_proof : icmp_sgt2_before ⊑ icmp_sgt2_after := by
  unfold icmp_sgt2_before icmp_sgt2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sgt2
  all_goals (try extract_goal ; sorry)
  ---END icmp_sgt2



def icmp_sgt3_before := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-16 : i8) : i8
  %2 = llvm.shl %arg22, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt3_after := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.icmp "sgt" %arg22, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sgt3_proof : icmp_sgt3_before ⊑ icmp_sgt3_after := by
  unfold icmp_sgt3_before icmp_sgt3_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sgt3
  all_goals (try extract_goal ; sorry)
  ---END icmp_sgt3



def icmp_sgt4_before := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.shl %arg21, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt4_after := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg21, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sgt4_proof : icmp_sgt4_before ⊑ icmp_sgt4_after := by
  unfold icmp_sgt4_before icmp_sgt4_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sgt4
  all_goals (try extract_goal ; sorry)
  ---END icmp_sgt4



def icmp_sgt5_before := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %arg20, %0 overflow<nsw> : i8
  %2 = llvm.icmp "sgt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_sgt5_after := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "sgt" %arg20, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sgt5_proof : icmp_sgt5_before ⊑ icmp_sgt5_after := by
  unfold icmp_sgt5_before icmp_sgt5_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sgt5
  all_goals (try extract_goal ; sorry)
  ---END icmp_sgt5



def icmp_sgt6_before := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(16 : i8) : i8
  %2 = llvm.shl %arg19, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt6_after := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(8 : i8) : i8
  %1 = llvm.icmp "sgt" %arg19, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sgt6_proof : icmp_sgt6_before ⊑ icmp_sgt6_after := by
  unfold icmp_sgt6_before icmp_sgt6_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sgt6
  all_goals (try extract_goal ; sorry)
  ---END icmp_sgt6



def icmp_sgt7_before := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(124 : i8) : i8
  %2 = llvm.shl %arg18, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt7_after := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(62 : i8) : i8
  %1 = llvm.icmp "sgt" %arg18, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sgt7_proof : icmp_sgt7_before ⊑ icmp_sgt7_after := by
  unfold icmp_sgt7_before icmp_sgt7_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sgt7
  all_goals (try extract_goal ; sorry)
  ---END icmp_sgt7



def icmp_sgt8_before := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(125 : i8) : i8
  %2 = llvm.shl %arg17, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt8_after := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(63 : i8) : i8
  %1 = llvm.icmp "eq" %arg17, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sgt8_proof : icmp_sgt8_before ⊑ icmp_sgt8_after := by
  unfold icmp_sgt8_before icmp_sgt8_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sgt8
  all_goals (try extract_goal ; sorry)
  ---END icmp_sgt8



def icmp_sgt9_before := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.shl %arg16, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt9_after := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg16, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sgt9_proof : icmp_sgt9_before ⊑ icmp_sgt9_after := by
  unfold icmp_sgt9_before icmp_sgt9_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sgt9
  all_goals (try extract_goal ; sorry)
  ---END icmp_sgt9



def icmp_sgt10_before := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.shl %arg15, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt10_after := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg15, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sgt10_proof : icmp_sgt10_before ⊑ icmp_sgt10_after := by
  unfold icmp_sgt10_before icmp_sgt10_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sgt10
  all_goals (try extract_goal ; sorry)
  ---END icmp_sgt10



def icmp_sgt11_before := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.shl %arg14, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt11_after := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg14, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sgt11_proof : icmp_sgt11_before ⊑ icmp_sgt11_after := by
  unfold icmp_sgt11_before icmp_sgt11_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sgt11
  all_goals (try extract_goal ; sorry)
  ---END icmp_sgt11



def icmp_sle1_before := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.shl %arg12, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle1_after := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.icmp "eq" %arg12, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle1_proof : icmp_sle1_before ⊑ icmp_sle1_after := by
  unfold icmp_sle1_before icmp_sle1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle1
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle1



def icmp_sle2_before := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.shl %arg11, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle2_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(-63 : i8) : i8
  %1 = llvm.icmp "slt" %arg11, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle2_proof : icmp_sle2_before ⊑ icmp_sle2_after := by
  unfold icmp_sle2_before icmp_sle2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle2
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle2



def icmp_sle3_before := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-16 : i8) : i8
  %2 = llvm.shl %arg10, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle3_after := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(-7 : i8) : i8
  %1 = llvm.icmp "slt" %arg10, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle3_proof : icmp_sle3_before ⊑ icmp_sle3_after := by
  unfold icmp_sle3_before icmp_sle3_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle3
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle3



def icmp_sle4_before := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.shl %arg9, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle4_after := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg9, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle4_proof : icmp_sle4_before ⊑ icmp_sle4_after := by
  unfold icmp_sle4_before icmp_sle4_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle4
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle4



def icmp_sle5_before := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %arg8, %0 overflow<nsw> : i8
  %2 = llvm.icmp "sle" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_sle5_after := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.icmp "slt" %arg8, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle5_proof : icmp_sle5_before ⊑ icmp_sle5_after := by
  unfold icmp_sle5_before icmp_sle5_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle5
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle5



def icmp_sle6_before := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(16 : i8) : i8
  %2 = llvm.shl %arg7, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle6_after := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(9 : i8) : i8
  %1 = llvm.icmp "slt" %arg7, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle6_proof : icmp_sle6_before ⊑ icmp_sle6_after := by
  unfold icmp_sle6_before icmp_sle6_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle6
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle6



def icmp_sle7_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(124 : i8) : i8
  %2 = llvm.shl %arg6, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle7_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(63 : i8) : i8
  %1 = llvm.icmp "slt" %arg6, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle7_proof : icmp_sle7_before ⊑ icmp_sle7_after := by
  unfold icmp_sle7_before icmp_sle7_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle7
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle7



def icmp_sle8_before := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(125 : i8) : i8
  %2 = llvm.shl %arg5, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle8_after := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(63 : i8) : i8
  %1 = llvm.icmp "ne" %arg5, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle8_proof : icmp_sle8_before ⊑ icmp_sle8_after := by
  unfold icmp_sle8_before icmp_sle8_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle8
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle8



def icmp_sle9_before := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.shl %arg4, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle9_after := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg4, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle9_proof : icmp_sle9_before ⊑ icmp_sle9_after := by
  unfold icmp_sle9_before icmp_sle9_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle9
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle9



def icmp_sle10_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.shl %arg3, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle10_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg3, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle10_proof : icmp_sle10_before ⊑ icmp_sle10_after := by
  unfold icmp_sle10_before icmp_sle10_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle10
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle10



def icmp_sle11_before := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.shl %arg2, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle11_after := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg2, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_sle11_proof : icmp_sle11_before ⊑ icmp_sle11_after := by
  unfold icmp_sle11_before icmp_sle11_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_sle11
  all_goals (try extract_goal ; sorry)
  ---END icmp_sle11



def icmp_eq1_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(12 : i8) : i8
  %2 = llvm.shl %arg1, %0 overflow<nsw> : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq1_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.icmp "eq" %arg1, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq1_proof : icmp_eq1_before ⊑ icmp_eq1_after := by
  unfold icmp_eq1_before icmp_eq1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq1
  all_goals (try extract_goal ; sorry)
  ---END icmp_eq1



def icmp_ne1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.shl %arg0, %0 overflow<nsw> : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.icmp "ne" %arg0, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne1_proof : icmp_ne1_before ⊑ icmp_ne1_after := by
  unfold icmp_ne1_before icmp_ne1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne1
  all_goals (try extract_goal ; sorry)
  ---END icmp_ne1


