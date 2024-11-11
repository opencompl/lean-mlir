import SSA.Projects.InstCombine.tests.proofs.gicmphexthext_proof
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
section gicmphexthext_statements

def zext_zext_sgt_before := [llvm|
{
^0(%arg84 : i8, %arg85 : i8):
  %0 = llvm.zext %arg84 : i8 to i32
  %1 = llvm.zext %arg85 : i8 to i32
  %2 = llvm.icmp "sgt" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def zext_zext_sgt_after := [llvm|
{
^0(%arg84 : i8, %arg85 : i8):
  %0 = llvm.icmp "ugt" %arg84, %arg85 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_zext_sgt_proof : zext_zext_sgt_before ⊑ zext_zext_sgt_after := by
  unfold zext_zext_sgt_before zext_zext_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN zext_zext_sgt
  apply zext_zext_sgt_thm
  ---END zext_zext_sgt



def zext_zext_eq_before := [llvm|
{
^0(%arg80 : i8, %arg81 : i8):
  %0 = llvm.zext %arg80 : i8 to i32
  %1 = llvm.zext %arg81 : i8 to i32
  %2 = llvm.icmp "eq" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def zext_zext_eq_after := [llvm|
{
^0(%arg80 : i8, %arg81 : i8):
  %0 = llvm.icmp "eq" %arg80, %arg81 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_zext_eq_proof : zext_zext_eq_before ⊑ zext_zext_eq_after := by
  unfold zext_zext_eq_before zext_zext_eq_after
  simp_alive_peephole
  intros
  ---BEGIN zext_zext_eq
  apply zext_zext_eq_thm
  ---END zext_zext_eq



def zext_zext_sle_op0_narrow_before := [llvm|
{
^0(%arg78 : i8, %arg79 : i16):
  %0 = llvm.zext %arg78 : i8 to i32
  %1 = llvm.zext %arg79 : i16 to i32
  %2 = llvm.icmp "sle" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def zext_zext_sle_op0_narrow_after := [llvm|
{
^0(%arg78 : i8, %arg79 : i16):
  %0 = llvm.zext %arg78 : i8 to i16
  %1 = llvm.icmp "uge" %arg79, %0 : i16
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_zext_sle_op0_narrow_proof : zext_zext_sle_op0_narrow_before ⊑ zext_zext_sle_op0_narrow_after := by
  unfold zext_zext_sle_op0_narrow_before zext_zext_sle_op0_narrow_after
  simp_alive_peephole
  intros
  ---BEGIN zext_zext_sle_op0_narrow
  apply zext_zext_sle_op0_narrow_thm
  ---END zext_zext_sle_op0_narrow



def zext_zext_ule_op0_wide_before := [llvm|
{
^0(%arg76 : i9, %arg77 : i8):
  %0 = llvm.zext %arg76 : i9 to i32
  %1 = llvm.zext %arg77 : i8 to i32
  %2 = llvm.icmp "ule" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def zext_zext_ule_op0_wide_after := [llvm|
{
^0(%arg76 : i9, %arg77 : i8):
  %0 = llvm.zext %arg77 : i8 to i9
  %1 = llvm.icmp "ule" %arg76, %0 : i9
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_zext_ule_op0_wide_proof : zext_zext_ule_op0_wide_before ⊑ zext_zext_ule_op0_wide_after := by
  unfold zext_zext_ule_op0_wide_before zext_zext_ule_op0_wide_after
  simp_alive_peephole
  intros
  ---BEGIN zext_zext_ule_op0_wide
  apply zext_zext_ule_op0_wide_thm
  ---END zext_zext_ule_op0_wide



def sext_sext_slt_before := [llvm|
{
^0(%arg74 : i8, %arg75 : i8):
  %0 = llvm.sext %arg74 : i8 to i32
  %1 = llvm.sext %arg75 : i8 to i32
  %2 = llvm.icmp "slt" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sext_sext_slt_after := [llvm|
{
^0(%arg74 : i8, %arg75 : i8):
  %0 = llvm.icmp "slt" %arg74, %arg75 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_sext_slt_proof : sext_sext_slt_before ⊑ sext_sext_slt_after := by
  unfold sext_sext_slt_before sext_sext_slt_after
  simp_alive_peephole
  intros
  ---BEGIN sext_sext_slt
  apply sext_sext_slt_thm
  ---END sext_sext_slt



def sext_sext_ult_before := [llvm|
{
^0(%arg72 : i8, %arg73 : i8):
  %0 = llvm.sext %arg72 : i8 to i32
  %1 = llvm.sext %arg73 : i8 to i32
  %2 = llvm.icmp "ult" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sext_sext_ult_after := [llvm|
{
^0(%arg72 : i8, %arg73 : i8):
  %0 = llvm.icmp "ult" %arg72, %arg73 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_sext_ult_proof : sext_sext_ult_before ⊑ sext_sext_ult_after := by
  unfold sext_sext_ult_before sext_sext_ult_after
  simp_alive_peephole
  intros
  ---BEGIN sext_sext_ult
  apply sext_sext_ult_thm
  ---END sext_sext_ult



def sext_sext_ne_before := [llvm|
{
^0(%arg70 : i8, %arg71 : i8):
  %0 = llvm.sext %arg70 : i8 to i32
  %1 = llvm.sext %arg71 : i8 to i32
  %2 = llvm.icmp "ne" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sext_sext_ne_after := [llvm|
{
^0(%arg70 : i8, %arg71 : i8):
  %0 = llvm.icmp "ne" %arg70, %arg71 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_sext_ne_proof : sext_sext_ne_before ⊑ sext_sext_ne_after := by
  unfold sext_sext_ne_before sext_sext_ne_after
  simp_alive_peephole
  intros
  ---BEGIN sext_sext_ne
  apply sext_sext_ne_thm
  ---END sext_sext_ne



def sext_sext_sge_op0_narrow_before := [llvm|
{
^0(%arg68 : i5, %arg69 : i8):
  %0 = llvm.sext %arg68 : i5 to i32
  %1 = llvm.sext %arg69 : i8 to i32
  %2 = llvm.icmp "sge" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sext_sext_sge_op0_narrow_after := [llvm|
{
^0(%arg68 : i5, %arg69 : i8):
  %0 = llvm.sext %arg68 : i5 to i8
  %1 = llvm.icmp "sle" %arg69, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_sext_sge_op0_narrow_proof : sext_sext_sge_op0_narrow_before ⊑ sext_sext_sge_op0_narrow_after := by
  unfold sext_sext_sge_op0_narrow_before sext_sext_sge_op0_narrow_after
  simp_alive_peephole
  intros
  ---BEGIN sext_sext_sge_op0_narrow
  apply sext_sext_sge_op0_narrow_thm
  ---END sext_sext_sge_op0_narrow



def zext_nneg_sext_sgt_before := [llvm|
{
^0(%arg62 : i8, %arg63 : i8):
  %0 = llvm.zext nneg %arg62 : i8 to i32
  %1 = llvm.sext %arg63 : i8 to i32
  %2 = llvm.icmp "sgt" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def zext_nneg_sext_sgt_after := [llvm|
{
^0(%arg62 : i8, %arg63 : i8):
  %0 = llvm.icmp "sgt" %arg62, %arg63 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_sext_sgt_proof : zext_nneg_sext_sgt_before ⊑ zext_nneg_sext_sgt_after := by
  unfold zext_nneg_sext_sgt_before zext_nneg_sext_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_sext_sgt
  apply zext_nneg_sext_sgt_thm
  ---END zext_nneg_sext_sgt



def zext_nneg_sext_ugt_before := [llvm|
{
^0(%arg58 : i8, %arg59 : i8):
  %0 = llvm.zext nneg %arg58 : i8 to i32
  %1 = llvm.sext %arg59 : i8 to i32
  %2 = llvm.icmp "ugt" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def zext_nneg_sext_ugt_after := [llvm|
{
^0(%arg58 : i8, %arg59 : i8):
  %0 = llvm.icmp "ugt" %arg58, %arg59 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_sext_ugt_proof : zext_nneg_sext_ugt_before ⊑ zext_nneg_sext_ugt_after := by
  unfold zext_nneg_sext_ugt_before zext_nneg_sext_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_sext_ugt
  apply zext_nneg_sext_ugt_thm
  ---END zext_nneg_sext_ugt



def zext_nneg_sext_eq_before := [llvm|
{
^0(%arg54 : i8, %arg55 : i8):
  %0 = llvm.zext nneg %arg54 : i8 to i32
  %1 = llvm.sext %arg55 : i8 to i32
  %2 = llvm.icmp "eq" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def zext_nneg_sext_eq_after := [llvm|
{
^0(%arg54 : i8, %arg55 : i8):
  %0 = llvm.icmp "eq" %arg54, %arg55 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_sext_eq_proof : zext_nneg_sext_eq_before ⊑ zext_nneg_sext_eq_after := by
  unfold zext_nneg_sext_eq_before zext_nneg_sext_eq_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_sext_eq
  apply zext_nneg_sext_eq_thm
  ---END zext_nneg_sext_eq



def zext_nneg_sext_sle_op0_narrow_before := [llvm|
{
^0(%arg50 : i8, %arg51 : i16):
  %0 = llvm.zext nneg %arg50 : i8 to i32
  %1 = llvm.sext %arg51 : i16 to i32
  %2 = llvm.icmp "sle" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def zext_nneg_sext_sle_op0_narrow_after := [llvm|
{
^0(%arg50 : i8, %arg51 : i16):
  %0 = llvm.sext %arg50 : i8 to i16
  %1 = llvm.icmp "sge" %arg51, %0 : i16
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_sext_sle_op0_narrow_proof : zext_nneg_sext_sle_op0_narrow_before ⊑ zext_nneg_sext_sle_op0_narrow_after := by
  unfold zext_nneg_sext_sle_op0_narrow_before zext_nneg_sext_sle_op0_narrow_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_sext_sle_op0_narrow
  apply zext_nneg_sext_sle_op0_narrow_thm
  ---END zext_nneg_sext_sle_op0_narrow



def zext_nneg_sext_ule_op0_wide_before := [llvm|
{
^0(%arg46 : i9, %arg47 : i8):
  %0 = llvm.zext nneg %arg46 : i9 to i32
  %1 = llvm.sext %arg47 : i8 to i32
  %2 = llvm.icmp "ule" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def zext_nneg_sext_ule_op0_wide_after := [llvm|
{
^0(%arg46 : i9, %arg47 : i8):
  %0 = llvm.sext %arg47 : i8 to i9
  %1 = llvm.icmp "ule" %arg46, %0 : i9
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_sext_ule_op0_wide_proof : zext_nneg_sext_ule_op0_wide_before ⊑ zext_nneg_sext_ule_op0_wide_after := by
  unfold zext_nneg_sext_ule_op0_wide_before zext_nneg_sext_ule_op0_wide_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_sext_ule_op0_wide
  apply zext_nneg_sext_ule_op0_wide_thm
  ---END zext_nneg_sext_ule_op0_wide



def sext_zext_nneg_slt_before := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.sext %arg42 : i8 to i32
  %1 = llvm.zext nneg %arg43 : i8 to i32
  %2 = llvm.icmp "slt" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sext_zext_nneg_slt_after := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.icmp "slt" %arg42, %arg43 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_nneg_slt_proof : sext_zext_nneg_slt_before ⊑ sext_zext_nneg_slt_after := by
  unfold sext_zext_nneg_slt_before sext_zext_nneg_slt_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_nneg_slt
  apply sext_zext_nneg_slt_thm
  ---END sext_zext_nneg_slt



def sext_zext_nneg_ult_before := [llvm|
{
^0(%arg38 : i8, %arg39 : i8):
  %0 = llvm.sext %arg38 : i8 to i32
  %1 = llvm.zext nneg %arg39 : i8 to i32
  %2 = llvm.icmp "ult" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sext_zext_nneg_ult_after := [llvm|
{
^0(%arg38 : i8, %arg39 : i8):
  %0 = llvm.icmp "ult" %arg38, %arg39 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_nneg_ult_proof : sext_zext_nneg_ult_before ⊑ sext_zext_nneg_ult_after := by
  unfold sext_zext_nneg_ult_before sext_zext_nneg_ult_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_nneg_ult
  apply sext_zext_nneg_ult_thm
  ---END sext_zext_nneg_ult



def sext_zext_nneg_sge_op0_narrow_before := [llvm|
{
^0(%arg30 : i5, %arg31 : i8):
  %0 = llvm.sext %arg30 : i5 to i32
  %1 = llvm.zext nneg %arg31 : i8 to i32
  %2 = llvm.icmp "sge" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sext_zext_nneg_sge_op0_narrow_after := [llvm|
{
^0(%arg30 : i5, %arg31 : i8):
  %0 = llvm.sext %arg30 : i5 to i8
  %1 = llvm.icmp "sle" %arg31, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_nneg_sge_op0_narrow_proof : sext_zext_nneg_sge_op0_narrow_before ⊑ sext_zext_nneg_sge_op0_narrow_after := by
  unfold sext_zext_nneg_sge_op0_narrow_before sext_zext_nneg_sge_op0_narrow_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_nneg_sge_op0_narrow
  apply sext_zext_nneg_sge_op0_narrow_thm
  ---END sext_zext_nneg_sge_op0_narrow



def sext_zext_nneg_uge_op0_wide_before := [llvm|
{
^0(%arg26 : i16, %arg27 : i8):
  %0 = llvm.sext %arg26 : i16 to i32
  %1 = llvm.zext nneg %arg27 : i8 to i32
  %2 = llvm.icmp "uge" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sext_zext_nneg_uge_op0_wide_after := [llvm|
{
^0(%arg26 : i16, %arg27 : i8):
  %0 = llvm.sext %arg27 : i8 to i16
  %1 = llvm.icmp "uge" %arg26, %0 : i16
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_nneg_uge_op0_wide_proof : sext_zext_nneg_uge_op0_wide_before ⊑ sext_zext_nneg_uge_op0_wide_after := by
  unfold sext_zext_nneg_uge_op0_wide_before sext_zext_nneg_uge_op0_wide_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_nneg_uge_op0_wide
  apply sext_zext_nneg_uge_op0_wide_thm
  ---END sext_zext_nneg_uge_op0_wide



def zext_sext_sgt_known_nonneg_before := [llvm|
{
^0(%arg24 : i8, %arg25 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.udiv %0, %arg24 : i8
  %2 = llvm.zext %1 : i8 to i32
  %3 = llvm.sext %arg25 : i8 to i32
  %4 = llvm.icmp "sgt" %2, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_sgt_known_nonneg_after := [llvm|
{
^0(%arg24 : i8, %arg25 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.udiv %0, %arg24 : i8
  %2 = llvm.icmp "sgt" %1, %arg25 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_sgt_known_nonneg_proof : zext_sext_sgt_known_nonneg_before ⊑ zext_sext_sgt_known_nonneg_after := by
  unfold zext_sext_sgt_known_nonneg_before zext_sext_sgt_known_nonneg_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_sgt_known_nonneg
  apply zext_sext_sgt_known_nonneg_thm
  ---END zext_sext_sgt_known_nonneg



def zext_sext_ugt_known_nonneg_before := [llvm|
{
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.and %arg22, %0 : i8
  %2 = llvm.zext %1 : i8 to i32
  %3 = llvm.sext %arg23 : i8 to i32
  %4 = llvm.icmp "ugt" %2, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_ugt_known_nonneg_after := [llvm|
{
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.and %arg22, %0 : i8
  %2 = llvm.icmp "ugt" %1, %arg23 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_ugt_known_nonneg_proof : zext_sext_ugt_known_nonneg_before ⊑ zext_sext_ugt_known_nonneg_after := by
  unfold zext_sext_ugt_known_nonneg_before zext_sext_ugt_known_nonneg_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_ugt_known_nonneg
  apply zext_sext_ugt_known_nonneg_thm
  ---END zext_sext_ugt_known_nonneg



def zext_sext_eq_known_nonneg_before := [llvm|
{
^0(%arg20 : i8, %arg21 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.lshr %arg20, %0 : i8
  %2 = llvm.zext %1 : i8 to i32
  %3 = llvm.sext %arg21 : i8 to i32
  %4 = llvm.icmp "eq" %2, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_eq_known_nonneg_after := [llvm|
{
^0(%arg20 : i8, %arg21 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.lshr %arg20, %0 : i8
  %2 = llvm.icmp "eq" %1, %arg21 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_eq_known_nonneg_proof : zext_sext_eq_known_nonneg_before ⊑ zext_sext_eq_known_nonneg_after := by
  unfold zext_sext_eq_known_nonneg_before zext_sext_eq_known_nonneg_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_eq_known_nonneg
  apply zext_sext_eq_known_nonneg_thm
  ---END zext_sext_eq_known_nonneg



def zext_sext_sle_known_nonneg_op0_narrow_before := [llvm|
{
^0(%arg18 : i8, %arg19 : i16):
  %0 = llvm.mlir.constant(12 : i8) : i8
  %1 = llvm.and %arg18, %0 : i8
  %2 = llvm.zext %1 : i8 to i32
  %3 = llvm.sext %arg19 : i16 to i32
  %4 = llvm.icmp "sle" %2, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_sle_known_nonneg_op0_narrow_after := [llvm|
{
^0(%arg18 : i8, %arg19 : i16):
  %0 = llvm.mlir.constant(12 : i8) : i8
  %1 = llvm.and %arg18, %0 : i8
  %2 = llvm.zext nneg %1 : i8 to i16
  %3 = llvm.icmp "sge" %arg19, %2 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_sle_known_nonneg_op0_narrow_proof : zext_sext_sle_known_nonneg_op0_narrow_before ⊑ zext_sext_sle_known_nonneg_op0_narrow_after := by
  unfold zext_sext_sle_known_nonneg_op0_narrow_before zext_sext_sle_known_nonneg_op0_narrow_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_sle_known_nonneg_op0_narrow
  apply zext_sext_sle_known_nonneg_op0_narrow_thm
  ---END zext_sext_sle_known_nonneg_op0_narrow



def zext_sext_ule_known_nonneg_op0_wide_before := [llvm|
{
^0(%arg16 : i9, %arg17 : i8):
  %0 = llvm.mlir.constant(254 : i9) : i9
  %1 = llvm.urem %arg16, %0 : i9
  %2 = llvm.zext %1 : i9 to i32
  %3 = llvm.sext %arg17 : i8 to i32
  %4 = llvm.icmp "ule" %2, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_ule_known_nonneg_op0_wide_after := [llvm|
{
^0(%arg16 : i9, %arg17 : i8):
  %0 = llvm.mlir.constant(254 : i9) : i9
  %1 = llvm.urem %arg16, %0 : i9
  %2 = llvm.sext %arg17 : i8 to i9
  %3 = llvm.icmp "ule" %1, %2 : i9
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_ule_known_nonneg_op0_wide_proof : zext_sext_ule_known_nonneg_op0_wide_before ⊑ zext_sext_ule_known_nonneg_op0_wide_after := by
  unfold zext_sext_ule_known_nonneg_op0_wide_before zext_sext_ule_known_nonneg_op0_wide_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_ule_known_nonneg_op0_wide
  apply zext_sext_ule_known_nonneg_op0_wide_thm
  ---END zext_sext_ule_known_nonneg_op0_wide



def sext_zext_slt_known_nonneg_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(126 : i8) : i8
  %1 = llvm.sext %arg14 : i8 to i32
  %2 = llvm.and %arg15, %0 : i8
  %3 = llvm.zext %2 : i8 to i32
  %4 = llvm.icmp "slt" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sext_zext_slt_known_nonneg_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(126 : i8) : i8
  %1 = llvm.and %arg15, %0 : i8
  %2 = llvm.icmp "slt" %arg14, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_slt_known_nonneg_proof : sext_zext_slt_known_nonneg_before ⊑ sext_zext_slt_known_nonneg_after := by
  unfold sext_zext_slt_known_nonneg_before sext_zext_slt_known_nonneg_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_slt_known_nonneg
  apply sext_zext_slt_known_nonneg_thm
  ---END sext_zext_slt_known_nonneg



def sext_zext_ult_known_nonneg_before := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.sext %arg12 : i8 to i32
  %2 = llvm.lshr %arg13, %0 : i8
  %3 = llvm.zext %2 : i8 to i32
  %4 = llvm.icmp "ult" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sext_zext_ult_known_nonneg_after := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.lshr %arg13, %0 : i8
  %2 = llvm.icmp "ult" %arg12, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_ult_known_nonneg_proof : sext_zext_ult_known_nonneg_before ⊑ sext_zext_ult_known_nonneg_after := by
  unfold sext_zext_ult_known_nonneg_before sext_zext_ult_known_nonneg_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_ult_known_nonneg
  apply sext_zext_ult_known_nonneg_thm
  ---END sext_zext_ult_known_nonneg



def sext_zext_ne_known_nonneg_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.sext %arg10 : i8 to i32
  %2 = llvm.udiv %arg11, %0 : i8
  %3 = llvm.zext %2 : i8 to i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sext_zext_ne_known_nonneg_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.udiv %arg11, %0 : i8
  %2 = llvm.icmp "ne" %arg10, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_ne_known_nonneg_proof : sext_zext_ne_known_nonneg_before ⊑ sext_zext_ne_known_nonneg_after := by
  unfold sext_zext_ne_known_nonneg_before sext_zext_ne_known_nonneg_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_ne_known_nonneg
  apply sext_zext_ne_known_nonneg_thm
  ---END sext_zext_ne_known_nonneg



def sext_zext_uge_known_nonneg_op0_wide_before := [llvm|
{
^0(%arg6 : i16, %arg7 : i8):
  %0 = llvm.mlir.constant(12 : i8) : i8
  %1 = llvm.sext %arg6 : i16 to i32
  %2 = llvm.and %arg7, %0 : i8
  %3 = llvm.zext %2 : i8 to i32
  %4 = llvm.icmp "uge" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sext_zext_uge_known_nonneg_op0_wide_after := [llvm|
{
^0(%arg6 : i16, %arg7 : i8):
  %0 = llvm.mlir.constant(12 : i8) : i8
  %1 = llvm.and %arg7, %0 : i8
  %2 = llvm.zext nneg %1 : i8 to i16
  %3 = llvm.icmp "uge" %arg6, %2 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_uge_known_nonneg_op0_wide_proof : sext_zext_uge_known_nonneg_op0_wide_before ⊑ sext_zext_uge_known_nonneg_op0_wide_after := by
  unfold sext_zext_uge_known_nonneg_op0_wide_before sext_zext_uge_known_nonneg_op0_wide_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_uge_known_nonneg_op0_wide
  apply sext_zext_uge_known_nonneg_op0_wide_thm
  ---END sext_zext_uge_known_nonneg_op0_wide



def zext_eq_sext_before := [llvm|
{
^0(%arg4 : i1, %arg5 : i1):
  %0 = llvm.zext %arg4 : i1 to i32
  %1 = llvm.sext %arg5 : i1 to i32
  %2 = llvm.icmp "eq" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def zext_eq_sext_after := [llvm|
{
^0(%arg4 : i1, %arg5 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.or %arg4, %arg5 : i1
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_eq_sext_proof : zext_eq_sext_before ⊑ zext_eq_sext_after := by
  unfold zext_eq_sext_before zext_eq_sext_after
  simp_alive_peephole
  intros
  ---BEGIN zext_eq_sext
  apply zext_eq_sext_thm
  ---END zext_eq_sext


