import SSA.Projects.InstCombine.tests.proofs.gicmphofhtrunchext_proof
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
section gicmphofhtrunchext_statements

def trunc_unsigned_nuw_before := [llvm|
{
^0(%arg60 : i16, %arg61 : i16):
  %0 = llvm.trunc %arg60 overflow<nuw> : i16 to i8
  %1 = llvm.trunc %arg61 overflow<nuw> : i16 to i8
  %2 = llvm.icmp "ult" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_unsigned_nuw_after := [llvm|
{
^0(%arg60 : i16, %arg61 : i16):
  %0 = llvm.icmp "ult" %arg60, %arg61 : i16
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_unsigned_nuw_proof : trunc_unsigned_nuw_before ⊑ trunc_unsigned_nuw_after := by
  unfold trunc_unsigned_nuw_before trunc_unsigned_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_unsigned_nuw
  apply trunc_unsigned_nuw_thm
  ---END trunc_unsigned_nuw



def trunc_unsigned_nsw_before := [llvm|
{
^0(%arg58 : i16, %arg59 : i16):
  %0 = llvm.trunc %arg58 overflow<nsw> : i16 to i8
  %1 = llvm.trunc %arg59 overflow<nsw> : i16 to i8
  %2 = llvm.icmp "ult" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_unsigned_nsw_after := [llvm|
{
^0(%arg58 : i16, %arg59 : i16):
  %0 = llvm.icmp "ult" %arg58, %arg59 : i16
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_unsigned_nsw_proof : trunc_unsigned_nsw_before ⊑ trunc_unsigned_nsw_after := by
  unfold trunc_unsigned_nsw_before trunc_unsigned_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_unsigned_nsw
  apply trunc_unsigned_nsw_thm
  ---END trunc_unsigned_nsw



def trunc_unsigned_both_before := [llvm|
{
^0(%arg56 : i16, %arg57 : i16):
  %0 = llvm.trunc %arg56 overflow<nsw,nuw> : i16 to i8
  %1 = llvm.trunc %arg57 overflow<nsw,nuw> : i16 to i8
  %2 = llvm.icmp "ult" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_unsigned_both_after := [llvm|
{
^0(%arg56 : i16, %arg57 : i16):
  %0 = llvm.icmp "ult" %arg56, %arg57 : i16
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_unsigned_both_proof : trunc_unsigned_both_before ⊑ trunc_unsigned_both_after := by
  unfold trunc_unsigned_both_before trunc_unsigned_both_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_unsigned_both
  apply trunc_unsigned_both_thm
  ---END trunc_unsigned_both



def trunc_signed_nsw_before := [llvm|
{
^0(%arg50 : i16, %arg51 : i16):
  %0 = llvm.trunc %arg50 overflow<nsw> : i16 to i8
  %1 = llvm.trunc %arg51 overflow<nsw> : i16 to i8
  %2 = llvm.icmp "slt" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_signed_nsw_after := [llvm|
{
^0(%arg50 : i16, %arg51 : i16):
  %0 = llvm.icmp "slt" %arg50, %arg51 : i16
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_signed_nsw_proof : trunc_signed_nsw_before ⊑ trunc_signed_nsw_after := by
  unfold trunc_signed_nsw_before trunc_signed_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_signed_nsw
  apply trunc_signed_nsw_thm
  ---END trunc_signed_nsw



def trunc_signed_both_before := [llvm|
{
^0(%arg48 : i16, %arg49 : i16):
  %0 = llvm.trunc %arg48 overflow<nsw,nuw> : i16 to i8
  %1 = llvm.trunc %arg49 overflow<nsw,nuw> : i16 to i8
  %2 = llvm.icmp "slt" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_signed_both_after := [llvm|
{
^0(%arg48 : i16, %arg49 : i16):
  %0 = llvm.icmp "slt" %arg48, %arg49 : i16
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_signed_both_proof : trunc_signed_both_before ⊑ trunc_signed_both_after := by
  unfold trunc_signed_both_before trunc_signed_both_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_signed_both
  apply trunc_signed_both_thm
  ---END trunc_signed_both



def trunc_equality_nuw_before := [llvm|
{
^0(%arg44 : i16, %arg45 : i16):
  %0 = llvm.trunc %arg44 overflow<nuw> : i16 to i8
  %1 = llvm.trunc %arg45 overflow<nuw> : i16 to i8
  %2 = llvm.icmp "eq" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_equality_nuw_after := [llvm|
{
^0(%arg44 : i16, %arg45 : i16):
  %0 = llvm.icmp "eq" %arg44, %arg45 : i16
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_equality_nuw_proof : trunc_equality_nuw_before ⊑ trunc_equality_nuw_after := by
  unfold trunc_equality_nuw_before trunc_equality_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_equality_nuw
  apply trunc_equality_nuw_thm
  ---END trunc_equality_nuw



def trunc_equality_nsw_before := [llvm|
{
^0(%arg42 : i16, %arg43 : i16):
  %0 = llvm.trunc %arg42 overflow<nsw> : i16 to i8
  %1 = llvm.trunc %arg43 overflow<nsw> : i16 to i8
  %2 = llvm.icmp "eq" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_equality_nsw_after := [llvm|
{
^0(%arg42 : i16, %arg43 : i16):
  %0 = llvm.icmp "eq" %arg42, %arg43 : i16
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_equality_nsw_proof : trunc_equality_nsw_before ⊑ trunc_equality_nsw_after := by
  unfold trunc_equality_nsw_before trunc_equality_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_equality_nsw
  apply trunc_equality_nsw_thm
  ---END trunc_equality_nsw



def trunc_equality_both_before := [llvm|
{
^0(%arg40 : i16, %arg41 : i16):
  %0 = llvm.trunc %arg40 overflow<nsw,nuw> : i16 to i8
  %1 = llvm.trunc %arg41 overflow<nsw,nuw> : i16 to i8
  %2 = llvm.icmp "eq" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_equality_both_after := [llvm|
{
^0(%arg40 : i16, %arg41 : i16):
  %0 = llvm.icmp "eq" %arg40, %arg41 : i16
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_equality_both_proof : trunc_equality_both_before ⊑ trunc_equality_both_after := by
  unfold trunc_equality_both_before trunc_equality_both_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_equality_both
  apply trunc_equality_both_thm
  ---END trunc_equality_both



def trunc_unsigned_nuw_zext_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i8):
  %0 = llvm.trunc %arg36 overflow<nuw> : i32 to i16
  %1 = llvm.zext %arg37 : i8 to i16
  %2 = llvm.icmp "ult" %0, %1 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_unsigned_nuw_zext_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i8):
  %0 = llvm.zext %arg37 : i8 to i32
  %1 = llvm.icmp "ult" %arg36, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_unsigned_nuw_zext_proof : trunc_unsigned_nuw_zext_before ⊑ trunc_unsigned_nuw_zext_after := by
  unfold trunc_unsigned_nuw_zext_before trunc_unsigned_nuw_zext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_unsigned_nuw_zext
  apply trunc_unsigned_nuw_zext_thm
  ---END trunc_unsigned_nuw_zext



def trunc_unsigned_nsw_zext_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i8):
  %0 = llvm.trunc %arg32 overflow<nsw> : i32 to i16
  %1 = llvm.zext %arg33 : i8 to i16
  %2 = llvm.icmp "ult" %0, %1 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_unsigned_nsw_zext_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i8):
  %0 = llvm.zext %arg33 : i8 to i32
  %1 = llvm.icmp "ult" %arg32, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_unsigned_nsw_zext_proof : trunc_unsigned_nsw_zext_before ⊑ trunc_unsigned_nsw_zext_after := by
  unfold trunc_unsigned_nsw_zext_before trunc_unsigned_nsw_zext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_unsigned_nsw_zext
  apply trunc_unsigned_nsw_zext_thm
  ---END trunc_unsigned_nsw_zext



def trunc_unsigned_nsw_sext_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i8):
  %0 = llvm.trunc %arg30 overflow<nsw> : i32 to i16
  %1 = llvm.sext %arg31 : i8 to i16
  %2 = llvm.icmp "ult" %0, %1 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_unsigned_nsw_sext_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i8):
  %0 = llvm.sext %arg31 : i8 to i32
  %1 = llvm.icmp "ult" %arg30, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_unsigned_nsw_sext_proof : trunc_unsigned_nsw_sext_before ⊑ trunc_unsigned_nsw_sext_after := by
  unfold trunc_unsigned_nsw_sext_before trunc_unsigned_nsw_sext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_unsigned_nsw_sext
  apply trunc_unsigned_nsw_sext_thm
  ---END trunc_unsigned_nsw_sext



def trunc_signed_nsw_sext_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i8):
  %0 = llvm.trunc %arg28 overflow<nsw> : i32 to i16
  %1 = llvm.sext %arg29 : i8 to i16
  %2 = llvm.icmp "slt" %0, %1 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_signed_nsw_sext_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i8):
  %0 = llvm.sext %arg29 : i8 to i32
  %1 = llvm.icmp "slt" %arg28, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_signed_nsw_sext_proof : trunc_signed_nsw_sext_before ⊑ trunc_signed_nsw_sext_after := by
  unfold trunc_signed_nsw_sext_before trunc_signed_nsw_sext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_signed_nsw_sext
  apply trunc_signed_nsw_sext_thm
  ---END trunc_signed_nsw_sext



def trunc_signed_nsw_zext_before := [llvm|
{
^0(%arg26 : i32, %arg27 : i8):
  %0 = llvm.trunc %arg26 overflow<nsw> : i32 to i16
  %1 = llvm.zext %arg27 : i8 to i16
  %2 = llvm.icmp "slt" %0, %1 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_signed_nsw_zext_after := [llvm|
{
^0(%arg26 : i32, %arg27 : i8):
  %0 = llvm.zext %arg27 : i8 to i32
  %1 = llvm.icmp "slt" %arg26, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_signed_nsw_zext_proof : trunc_signed_nsw_zext_before ⊑ trunc_signed_nsw_zext_after := by
  unfold trunc_signed_nsw_zext_before trunc_signed_nsw_zext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_signed_nsw_zext
  apply trunc_signed_nsw_zext_thm
  ---END trunc_signed_nsw_zext



def trunc_equality_nuw_zext_before := [llvm|
{
^0(%arg20 : i32, %arg21 : i8):
  %0 = llvm.trunc %arg20 overflow<nuw> : i32 to i16
  %1 = llvm.zext %arg21 : i8 to i16
  %2 = llvm.icmp "ne" %0, %1 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_equality_nuw_zext_after := [llvm|
{
^0(%arg20 : i32, %arg21 : i8):
  %0 = llvm.zext %arg21 : i8 to i32
  %1 = llvm.icmp "ne" %arg20, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_equality_nuw_zext_proof : trunc_equality_nuw_zext_before ⊑ trunc_equality_nuw_zext_after := by
  unfold trunc_equality_nuw_zext_before trunc_equality_nuw_zext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_equality_nuw_zext
  apply trunc_equality_nuw_zext_thm
  ---END trunc_equality_nuw_zext



def trunc_equality_nsw_zext_before := [llvm|
{
^0(%arg16 : i32, %arg17 : i8):
  %0 = llvm.trunc %arg16 overflow<nsw> : i32 to i16
  %1 = llvm.zext %arg17 : i8 to i16
  %2 = llvm.icmp "ne" %0, %1 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_equality_nsw_zext_after := [llvm|
{
^0(%arg16 : i32, %arg17 : i8):
  %0 = llvm.zext %arg17 : i8 to i32
  %1 = llvm.icmp "ne" %arg16, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_equality_nsw_zext_proof : trunc_equality_nsw_zext_before ⊑ trunc_equality_nsw_zext_after := by
  unfold trunc_equality_nsw_zext_before trunc_equality_nsw_zext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_equality_nsw_zext
  apply trunc_equality_nsw_zext_thm
  ---END trunc_equality_nsw_zext



def trunc_equality_nsw_sext_before := [llvm|
{
^0(%arg14 : i32, %arg15 : i8):
  %0 = llvm.trunc %arg14 overflow<nsw> : i32 to i16
  %1 = llvm.sext %arg15 : i8 to i16
  %2 = llvm.icmp "ne" %0, %1 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_equality_nsw_sext_after := [llvm|
{
^0(%arg14 : i32, %arg15 : i8):
  %0 = llvm.sext %arg15 : i8 to i32
  %1 = llvm.icmp "ne" %arg14, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_equality_nsw_sext_proof : trunc_equality_nsw_sext_before ⊑ trunc_equality_nsw_sext_after := by
  unfold trunc_equality_nsw_sext_before trunc_equality_nsw_sext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_equality_nsw_sext
  apply trunc_equality_nsw_sext_thm
  ---END trunc_equality_nsw_sext



def trunc_equality_both_sext_before := [llvm|
{
^0(%arg12 : i32, %arg13 : i8):
  %0 = llvm.trunc %arg12 overflow<nsw,nuw> : i32 to i16
  %1 = llvm.sext %arg13 : i8 to i16
  %2 = llvm.icmp "ne" %0, %1 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
def trunc_equality_both_sext_after := [llvm|
{
^0(%arg12 : i32, %arg13 : i8):
  %0 = llvm.sext %arg13 : i8 to i32
  %1 = llvm.icmp "ne" %arg12, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_equality_both_sext_proof : trunc_equality_both_sext_before ⊑ trunc_equality_both_sext_after := by
  unfold trunc_equality_both_sext_before trunc_equality_both_sext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_equality_both_sext
  apply trunc_equality_both_sext_thm
  ---END trunc_equality_both_sext



def test_eq1_before := [llvm|
{
^0(%arg10 : i32, %arg11 : i16):
  %0 = llvm.trunc %arg10 overflow<nsw> : i32 to i8
  %1 = llvm.trunc %arg11 overflow<nsw> : i16 to i8
  %2 = llvm.icmp "eq" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_eq1_after := [llvm|
{
^0(%arg10 : i32, %arg11 : i16):
  %0 = llvm.sext %arg11 : i16 to i32
  %1 = llvm.icmp "eq" %arg10, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_eq1_proof : test_eq1_before ⊑ test_eq1_after := by
  unfold test_eq1_before test_eq1_after
  simp_alive_peephole
  intros
  ---BEGIN test_eq1
  apply test_eq1_thm
  ---END test_eq1



def test_eq2_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i16):
  %0 = llvm.trunc %arg8 overflow<nsw> : i32 to i8
  %1 = llvm.trunc %arg9 overflow<nsw> : i16 to i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_eq2_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i16):
  %0 = llvm.trunc %arg8 : i32 to i16
  %1 = llvm.icmp "eq" %arg9, %0 : i16
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_eq2_proof : test_eq2_before ⊑ test_eq2_after := by
  unfold test_eq2_before test_eq2_after
  simp_alive_peephole
  intros
  ---BEGIN test_eq2
  apply test_eq2_thm
  ---END test_eq2



def test_ult_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i16):
  %0 = llvm.trunc %arg6 overflow<nsw> : i32 to i8
  %1 = llvm.trunc %arg7 overflow<nsw> : i16 to i8
  %2 = llvm.icmp "ult" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_ult_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i16):
  %0 = llvm.sext %arg7 : i16 to i32
  %1 = llvm.icmp "ult" %arg6, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ult_proof : test_ult_before ⊑ test_ult_after := by
  unfold test_ult_before test_ult_after
  simp_alive_peephole
  intros
  ---BEGIN test_ult
  apply test_ult_thm
  ---END test_ult



def test_slt_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i16):
  %0 = llvm.trunc %arg4 overflow<nsw> : i32 to i8
  %1 = llvm.trunc %arg5 overflow<nsw> : i16 to i8
  %2 = llvm.icmp "slt" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_slt_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i16):
  %0 = llvm.sext %arg5 : i16 to i32
  %1 = llvm.icmp "slt" %arg4, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_slt_proof : test_slt_before ⊑ test_slt_after := by
  unfold test_slt_before test_slt_after
  simp_alive_peephole
  intros
  ---BEGIN test_slt
  apply test_slt_thm
  ---END test_slt



def test_ult_nuw_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i16):
  %0 = llvm.trunc %arg2 overflow<nsw,nuw> : i32 to i8
  %1 = llvm.trunc %arg3 overflow<nsw,nuw> : i16 to i8
  %2 = llvm.icmp "ult" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_ult_nuw_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i16):
  %0 = llvm.zext %arg3 : i16 to i32
  %1 = llvm.icmp "ult" %arg2, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ult_nuw_proof : test_ult_nuw_before ⊑ test_ult_nuw_after := by
  unfold test_ult_nuw_before test_ult_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN test_ult_nuw
  apply test_ult_nuw_thm
  ---END test_ult_nuw



def test_slt_nuw_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i16):
  %0 = llvm.trunc %arg0 overflow<nsw,nuw> : i32 to i8
  %1 = llvm.trunc %arg1 overflow<nsw,nuw> : i16 to i8
  %2 = llvm.icmp "slt" %0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_slt_nuw_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i16):
  %0 = llvm.zext %arg1 : i16 to i32
  %1 = llvm.icmp "slt" %arg0, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_slt_nuw_proof : test_slt_nuw_before ⊑ test_slt_nuw_after := by
  unfold test_slt_nuw_before test_slt_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN test_slt_nuw
  apply test_slt_nuw_thm
  ---END test_slt_nuw


