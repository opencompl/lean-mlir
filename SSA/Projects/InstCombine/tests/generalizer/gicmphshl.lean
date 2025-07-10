import SSA.Projects.InstCombine.tests.proofs.gicmphshl_proof
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
section gicmphshl_statements

def shl_nuw_eq_0_before := [llvm|
{
^0(%arg34 : i8, %arg35 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.shl %arg34, %arg35 overflow<nuw> : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nuw_eq_0_after := [llvm|
{
^0(%arg34 : i8, %arg35 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg34, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nuw_eq_0_proof : shl_nuw_eq_0_before ⊑ shl_nuw_eq_0_after := by
  unfold shl_nuw_eq_0_before shl_nuw_eq_0_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nuw_eq_0
  apply shl_nuw_eq_0_thm
  ---END shl_nuw_eq_0



def shl_nsw_slt_1_before := [llvm|
{
^0(%arg26 : i8, %arg27 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %arg26, %arg27 overflow<nsw> : i8
  %2 = llvm.icmp "slt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nsw_slt_1_after := [llvm|
{
^0(%arg26 : i8, %arg27 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.icmp "slt" %arg26, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_slt_1_proof : shl_nsw_slt_1_before ⊑ shl_nsw_slt_1_after := by
  unfold shl_nsw_slt_1_before shl_nsw_slt_1_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_slt_1
  apply shl_nsw_slt_1_thm
  ---END shl_nsw_slt_1



def shl_nsw_sgt_n1_before := [llvm|
{
^0(%arg18 : i8, %arg19 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %arg18, %arg19 overflow<nsw> : i8
  %2 = llvm.icmp "sgt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nsw_sgt_n1_after := [llvm|
{
^0(%arg18 : i8, %arg19 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg18, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_sgt_n1_proof : shl_nsw_sgt_n1_before ⊑ shl_nsw_sgt_n1_after := by
  unfold shl_nsw_sgt_n1_before shl_nsw_sgt_n1_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_sgt_n1
  apply shl_nsw_sgt_n1_thm
  ---END shl_nsw_sgt_n1



def shl_nsw_nuw_ult_Csle0_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(-19 : i8) : i8
  %1 = llvm.shl %arg14, %arg15 overflow<nsw,nuw> : i8
  %2 = llvm.icmp "ult" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nsw_nuw_ult_Csle0_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(-19 : i8) : i8
  %1 = llvm.icmp "ult" %arg14, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_nuw_ult_Csle0_proof : shl_nsw_nuw_ult_Csle0_before ⊑ shl_nsw_nuw_ult_Csle0_after := by
  unfold shl_nsw_nuw_ult_Csle0_before shl_nsw_nuw_ult_Csle0_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_nuw_ult_Csle0
  apply shl_nsw_nuw_ult_Csle0_thm
  ---END shl_nsw_nuw_ult_Csle0



def shl_nsw_ule_Csle0_fail_missing_flag_before := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(-19 : i8) : i8
  %1 = llvm.shl %arg12, %arg13 overflow<nsw> : i8
  %2 = llvm.icmp "ule" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nsw_ule_Csle0_fail_missing_flag_after := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(-18 : i8) : i8
  %1 = llvm.shl %arg12, %arg13 overflow<nsw> : i8
  %2 = llvm.icmp "ult" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_ule_Csle0_fail_missing_flag_proof : shl_nsw_ule_Csle0_fail_missing_flag_before ⊑ shl_nsw_ule_Csle0_fail_missing_flag_after := by
  unfold shl_nsw_ule_Csle0_fail_missing_flag_before shl_nsw_ule_Csle0_fail_missing_flag_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_ule_Csle0_fail_missing_flag
  apply shl_nsw_ule_Csle0_fail_missing_flag_thm
  ---END shl_nsw_ule_Csle0_fail_missing_flag



def shl_nsw_nuw_uge_Csle0_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(-120 : i8) : i8
  %1 = llvm.shl %arg10, %arg11 overflow<nsw,nuw> : i8
  %2 = llvm.icmp "uge" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nsw_nuw_uge_Csle0_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(-121 : i8) : i8
  %1 = llvm.icmp "ugt" %arg10, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_nuw_uge_Csle0_proof : shl_nsw_nuw_uge_Csle0_before ⊑ shl_nsw_nuw_uge_Csle0_after := by
  unfold shl_nsw_nuw_uge_Csle0_before shl_nsw_nuw_uge_Csle0_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_nuw_uge_Csle0
  apply shl_nsw_nuw_uge_Csle0_thm
  ---END shl_nsw_nuw_uge_Csle0


