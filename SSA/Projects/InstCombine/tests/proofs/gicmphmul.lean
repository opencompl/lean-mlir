import SSA.Projects.InstCombine.tests.proofs.gicmphmul_proof
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
section gicmphmul_statements

def squared_nsw_eq0_before := [llvm|
{
^0(%arg185 : i5):
  %0 = llvm.mlir.constant(0 : i5) : i5
  %1 = llvm.mul %arg185, %arg185 overflow<nsw> : i5
  %2 = llvm.icmp "eq" %1, %0 : i5
  "llvm.return"(%2) : (i1) -> ()
}
]
def squared_nsw_eq0_after := [llvm|
{
^0(%arg185 : i5):
  %0 = llvm.mlir.constant(0 : i5) : i5
  %1 = llvm.icmp "eq" %arg185, %0 : i5
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem squared_nsw_eq0_proof : squared_nsw_eq0_before ⊑ squared_nsw_eq0_after := by
  unfold squared_nsw_eq0_before squared_nsw_eq0_after
  simp_alive_peephole
  intros
  ---BEGIN squared_nsw_eq0
  apply squared_nsw_eq0_thm
  ---END squared_nsw_eq0



def squared_nsw_sgt0_before := [llvm|
{
^0(%arg178 : i5):
  %0 = llvm.mlir.constant(0 : i5) : i5
  %1 = llvm.mul %arg178, %arg178 overflow<nsw> : i5
  %2 = llvm.icmp "sgt" %1, %0 : i5
  "llvm.return"(%2) : (i1) -> ()
}
]
def squared_nsw_sgt0_after := [llvm|
{
^0(%arg178 : i5):
  %0 = llvm.mlir.constant(0 : i5) : i5
  %1 = llvm.icmp "ne" %arg178, %0 : i5
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem squared_nsw_sgt0_proof : squared_nsw_sgt0_before ⊑ squared_nsw_sgt0_after := by
  unfold squared_nsw_sgt0_before squared_nsw_sgt0_after
  simp_alive_peephole
  intros
  ---BEGIN squared_nsw_sgt0
  apply squared_nsw_sgt0_thm
  ---END squared_nsw_sgt0



def slt_positive_multip_rem_zero_before := [llvm|
{
^0(%arg177 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg177, %0 overflow<nsw> : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_positive_multip_rem_zero_after := [llvm|
{
^0(%arg177 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.icmp "slt" %arg177, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_positive_multip_rem_zero_proof : slt_positive_multip_rem_zero_before ⊑ slt_positive_multip_rem_zero_after := by
  unfold slt_positive_multip_rem_zero_before slt_positive_multip_rem_zero_after
  simp_alive_peephole
  intros
  ---BEGIN slt_positive_multip_rem_zero
  apply slt_positive_multip_rem_zero_thm
  ---END slt_positive_multip_rem_zero



def slt_negative_multip_rem_zero_before := [llvm|
{
^0(%arg176 : i8):
  %0 = llvm.mlir.constant(-7 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg176, %0 overflow<nsw> : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_negative_multip_rem_zero_after := [llvm|
{
^0(%arg176 : i8):
  %0 = llvm.mlir.constant(-3 : i8) : i8
  %1 = llvm.icmp "sgt" %arg176, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_negative_multip_rem_zero_proof : slt_negative_multip_rem_zero_before ⊑ slt_negative_multip_rem_zero_after := by
  unfold slt_negative_multip_rem_zero_before slt_negative_multip_rem_zero_after
  simp_alive_peephole
  intros
  ---BEGIN slt_negative_multip_rem_zero
  apply slt_negative_multip_rem_zero_thm
  ---END slt_negative_multip_rem_zero



def slt_positive_multip_rem_nz_before := [llvm|
{
^0(%arg175 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg175, %0 overflow<nsw> : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_positive_multip_rem_nz_after := [llvm|
{
^0(%arg175 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.icmp "slt" %arg175, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_positive_multip_rem_nz_proof : slt_positive_multip_rem_nz_before ⊑ slt_positive_multip_rem_nz_after := by
  unfold slt_positive_multip_rem_nz_before slt_positive_multip_rem_nz_after
  simp_alive_peephole
  intros
  ---BEGIN slt_positive_multip_rem_nz
  apply slt_positive_multip_rem_nz_thm
  ---END slt_positive_multip_rem_nz



def ult_rem_zero_before := [llvm|
{
^0(%arg174 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg174, %0 overflow<nuw> : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_rem_zero_after := [llvm|
{
^0(%arg174 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.icmp "ult" %arg174, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_rem_zero_proof : ult_rem_zero_before ⊑ ult_rem_zero_after := by
  unfold ult_rem_zero_before ult_rem_zero_after
  simp_alive_peephole
  intros
  ---BEGIN ult_rem_zero
  apply ult_rem_zero_thm
  ---END ult_rem_zero



def ult_rem_zero_nsw_before := [llvm|
{
^0(%arg173 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg173, %0 overflow<nsw,nuw> : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_rem_zero_nsw_after := [llvm|
{
^0(%arg173 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.icmp "ult" %arg173, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_rem_zero_nsw_proof : ult_rem_zero_nsw_before ⊑ ult_rem_zero_nsw_after := by
  unfold ult_rem_zero_nsw_before ult_rem_zero_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN ult_rem_zero_nsw
  apply ult_rem_zero_nsw_thm
  ---END ult_rem_zero_nsw



def ult_rem_nz_before := [llvm|
{
^0(%arg172 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg172, %0 overflow<nuw> : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_rem_nz_after := [llvm|
{
^0(%arg172 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.icmp "ult" %arg172, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_rem_nz_proof : ult_rem_nz_before ⊑ ult_rem_nz_after := by
  unfold ult_rem_nz_before ult_rem_nz_after
  simp_alive_peephole
  intros
  ---BEGIN ult_rem_nz
  apply ult_rem_nz_thm
  ---END ult_rem_nz



def ult_rem_nz_nsw_before := [llvm|
{
^0(%arg171 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg171, %0 overflow<nsw,nuw> : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_rem_nz_nsw_after := [llvm|
{
^0(%arg171 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.icmp "ult" %arg171, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_rem_nz_nsw_proof : ult_rem_nz_nsw_before ⊑ ult_rem_nz_nsw_after := by
  unfold ult_rem_nz_nsw_before ult_rem_nz_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN ult_rem_nz_nsw
  apply ult_rem_nz_nsw_thm
  ---END ult_rem_nz_nsw



def sgt_positive_multip_rem_zero_before := [llvm|
{
^0(%arg170 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg170, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_positive_multip_rem_zero_after := [llvm|
{
^0(%arg170 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.icmp "sgt" %arg170, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_positive_multip_rem_zero_proof : sgt_positive_multip_rem_zero_before ⊑ sgt_positive_multip_rem_zero_after := by
  unfold sgt_positive_multip_rem_zero_before sgt_positive_multip_rem_zero_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_positive_multip_rem_zero
  apply sgt_positive_multip_rem_zero_thm
  ---END sgt_positive_multip_rem_zero



def sgt_negative_multip_rem_zero_before := [llvm|
{
^0(%arg169 : i8):
  %0 = llvm.mlir.constant(-7 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg169, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_negative_multip_rem_zero_after := [llvm|
{
^0(%arg169 : i8):
  %0 = llvm.mlir.constant(-3 : i8) : i8
  %1 = llvm.icmp "slt" %arg169, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_negative_multip_rem_zero_proof : sgt_negative_multip_rem_zero_before ⊑ sgt_negative_multip_rem_zero_after := by
  unfold sgt_negative_multip_rem_zero_before sgt_negative_multip_rem_zero_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_negative_multip_rem_zero
  apply sgt_negative_multip_rem_zero_thm
  ---END sgt_negative_multip_rem_zero



def sgt_positive_multip_rem_nz_before := [llvm|
{
^0(%arg168 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg168, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_positive_multip_rem_nz_after := [llvm|
{
^0(%arg168 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "sgt" %arg168, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_positive_multip_rem_nz_proof : sgt_positive_multip_rem_nz_before ⊑ sgt_positive_multip_rem_nz_after := by
  unfold sgt_positive_multip_rem_nz_before sgt_positive_multip_rem_nz_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_positive_multip_rem_nz
  apply sgt_positive_multip_rem_nz_thm
  ---END sgt_positive_multip_rem_nz



def ugt_rem_zero_before := [llvm|
{
^0(%arg167 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg167, %0 overflow<nuw> : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_rem_zero_after := [llvm|
{
^0(%arg167 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.icmp "ugt" %arg167, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_rem_zero_proof : ugt_rem_zero_before ⊑ ugt_rem_zero_after := by
  unfold ugt_rem_zero_before ugt_rem_zero_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_rem_zero
  apply ugt_rem_zero_thm
  ---END ugt_rem_zero



def ugt_rem_zero_nsw_before := [llvm|
{
^0(%arg166 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg166, %0 overflow<nsw,nuw> : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_rem_zero_nsw_after := [llvm|
{
^0(%arg166 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.icmp "ugt" %arg166, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_rem_zero_nsw_proof : ugt_rem_zero_nsw_before ⊑ ugt_rem_zero_nsw_after := by
  unfold ugt_rem_zero_nsw_before ugt_rem_zero_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_rem_zero_nsw
  apply ugt_rem_zero_nsw_thm
  ---END ugt_rem_zero_nsw



def ugt_rem_nz_before := [llvm|
{
^0(%arg165 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg165, %0 overflow<nuw> : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_rem_nz_after := [llvm|
{
^0(%arg165 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "ugt" %arg165, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_rem_nz_proof : ugt_rem_nz_before ⊑ ugt_rem_nz_after := by
  unfold ugt_rem_nz_before ugt_rem_nz_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_rem_nz
  apply ugt_rem_nz_thm
  ---END ugt_rem_nz



def ugt_rem_nz_nsw_before := [llvm|
{
^0(%arg164 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg164, %0 overflow<nsw,nuw> : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_rem_nz_nsw_after := [llvm|
{
^0(%arg164 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "ugt" %arg164, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_rem_nz_nsw_proof : ugt_rem_nz_nsw_before ⊑ ugt_rem_nz_nsw_after := by
  unfold ugt_rem_nz_nsw_before ugt_rem_nz_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_rem_nz_nsw
  apply ugt_rem_nz_nsw_thm
  ---END ugt_rem_nz_nsw



def eq_nsw_rem_zero_before := [llvm|
{
^0(%arg163 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.mul %arg163, %0 overflow<nsw> : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_nsw_rem_zero_after := [llvm|
{
^0(%arg163 : i8):
  %0 = llvm.mlir.constant(-4 : i8) : i8
  %1 = llvm.icmp "eq" %arg163, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_nsw_rem_zero_proof : eq_nsw_rem_zero_before ⊑ eq_nsw_rem_zero_after := by
  unfold eq_nsw_rem_zero_before eq_nsw_rem_zero_after
  simp_alive_peephole
  intros
  ---BEGIN eq_nsw_rem_zero
  apply eq_nsw_rem_zero_thm
  ---END eq_nsw_rem_zero



def eq_nsw_rem_nz_before := [llvm|
{
^0(%arg158 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-11 : i8) : i8
  %2 = llvm.mul %arg158, %0 overflow<nsw> : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_nsw_rem_nz_after := [llvm|
{
^0(%arg158 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_nsw_rem_nz_proof : eq_nsw_rem_nz_before ⊑ eq_nsw_rem_nz_after := by
  unfold eq_nsw_rem_nz_before eq_nsw_rem_nz_after
  simp_alive_peephole
  intros
  ---BEGIN eq_nsw_rem_nz
  apply eq_nsw_rem_nz_thm
  ---END eq_nsw_rem_nz



def ne_nsw_rem_nz_before := [llvm|
{
^0(%arg157 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-126 : i8) : i8
  %2 = llvm.mul %arg157, %0 overflow<nsw> : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ne_nsw_rem_nz_after := [llvm|
{
^0(%arg157 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_nsw_rem_nz_proof : ne_nsw_rem_nz_before ⊑ ne_nsw_rem_nz_after := by
  unfold ne_nsw_rem_nz_before ne_nsw_rem_nz_after
  simp_alive_peephole
  intros
  ---BEGIN ne_nsw_rem_nz
  apply ne_nsw_rem_nz_thm
  ---END ne_nsw_rem_nz



def ne_nuw_rem_zero_before := [llvm|
{
^0(%arg153 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-126 : i8) : i8
  %2 = llvm.mul %arg153, %0 overflow<nuw> : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ne_nuw_rem_zero_after := [llvm|
{
^0(%arg153 : i8):
  %0 = llvm.mlir.constant(26 : i8) : i8
  %1 = llvm.icmp "ne" %arg153, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_nuw_rem_zero_proof : ne_nuw_rem_zero_before ⊑ ne_nuw_rem_zero_after := by
  unfold ne_nuw_rem_zero_before ne_nuw_rem_zero_after
  simp_alive_peephole
  intros
  ---BEGIN ne_nuw_rem_zero
  apply ne_nuw_rem_zero_thm
  ---END ne_nuw_rem_zero



def eq_nuw_rem_nz_before := [llvm|
{
^0(%arg151 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.mul %arg151, %0 overflow<nuw> : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_nuw_rem_nz_after := [llvm|
{
^0(%arg151 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_nuw_rem_nz_proof : eq_nuw_rem_nz_before ⊑ eq_nuw_rem_nz_after := by
  unfold eq_nuw_rem_nz_before eq_nuw_rem_nz_after
  simp_alive_peephole
  intros
  ---BEGIN eq_nuw_rem_nz
  apply eq_nuw_rem_nz_thm
  ---END eq_nuw_rem_nz



def ne_nuw_rem_nz_before := [llvm|
{
^0(%arg150 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-30 : i8) : i8
  %2 = llvm.mul %arg150, %0 overflow<nuw> : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ne_nuw_rem_nz_after := [llvm|
{
^0(%arg150 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_nuw_rem_nz_proof : ne_nuw_rem_nz_before ⊑ ne_nuw_rem_nz_after := by
  unfold ne_nuw_rem_nz_before ne_nuw_rem_nz_after
  simp_alive_peephole
  intros
  ---BEGIN ne_nuw_rem_nz
  apply ne_nuw_rem_nz_thm
  ---END ne_nuw_rem_nz



def sgt_minnum_before := [llvm|
{
^0(%arg146 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.mul %arg146, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_minnum_after := [llvm|
{
^0(%arg146 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_minnum_proof : sgt_minnum_before ⊑ sgt_minnum_after := by
  unfold sgt_minnum_before sgt_minnum_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_minnum
  apply sgt_minnum_thm
  ---END sgt_minnum



def ule_bignum_before := [llvm|
{
^0(%arg145 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mul %arg145, %0 : i8
  %3 = llvm.icmp "ule" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_bignum_after := [llvm|
{
^0(%arg145 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg145, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_bignum_proof : ule_bignum_before ⊑ ule_bignum_after := by
  unfold ule_bignum_before ule_bignum_after
  simp_alive_peephole
  intros
  ---BEGIN ule_bignum
  apply ule_bignum_thm
  ---END ule_bignum



def sgt_mulzero_before := [llvm|
{
^0(%arg144 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(21 : i8) : i8
  %2 = llvm.mul %arg144, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_mulzero_after := [llvm|
{
^0(%arg144 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_mulzero_proof : sgt_mulzero_before ⊑ sgt_mulzero_after := by
  unfold sgt_mulzero_before sgt_mulzero_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_mulzero
  apply sgt_mulzero_thm
  ---END sgt_mulzero



def eq_rem_zero_nonuw_before := [llvm|
{
^0(%arg143 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.mul %arg143, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_rem_zero_nonuw_after := [llvm|
{
^0(%arg143 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "eq" %arg143, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_rem_zero_nonuw_proof : eq_rem_zero_nonuw_before ⊑ eq_rem_zero_nonuw_after := by
  unfold eq_rem_zero_nonuw_before eq_rem_zero_nonuw_after
  simp_alive_peephole
  intros
  ---BEGIN eq_rem_zero_nonuw
  apply eq_rem_zero_nonuw_thm
  ---END eq_rem_zero_nonuw



def ne_rem_zero_nonuw_before := [llvm|
{
^0(%arg142 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(30 : i8) : i8
  %2 = llvm.mul %arg142, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ne_rem_zero_nonuw_after := [llvm|
{
^0(%arg142 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.icmp "ne" %arg142, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_rem_zero_nonuw_proof : ne_rem_zero_nonuw_before ⊑ ne_rem_zero_nonuw_after := by
  unfold ne_rem_zero_nonuw_before ne_rem_zero_nonuw_after
  simp_alive_peephole
  intros
  ---BEGIN ne_rem_zero_nonuw
  apply ne_rem_zero_nonuw_thm
  ---END ne_rem_zero_nonuw



def mul_constant_eq_before := [llvm|
{
^0(%arg140 : i32, %arg141 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mul %arg140, %0 : i32
  %2 = llvm.mul %arg141, %0 : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_constant_eq_after := [llvm|
{
^0(%arg140 : i32, %arg141 : i32):
  %0 = llvm.icmp "eq" %arg140, %arg141 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_constant_eq_proof : mul_constant_eq_before ⊑ mul_constant_eq_after := by
  unfold mul_constant_eq_before mul_constant_eq_after
  simp_alive_peephole
  intros
  ---BEGIN mul_constant_eq
  apply mul_constant_eq_thm
  ---END mul_constant_eq



def mul_constant_eq_nsw_before := [llvm|
{
^0(%arg130 : i32, %arg131 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mul %arg130, %0 overflow<nsw> : i32
  %2 = llvm.mul %arg131, %0 overflow<nsw> : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_constant_eq_nsw_after := [llvm|
{
^0(%arg130 : i32, %arg131 : i32):
  %0 = llvm.icmp "eq" %arg130, %arg131 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_constant_eq_nsw_proof : mul_constant_eq_nsw_before ⊑ mul_constant_eq_nsw_after := by
  unfold mul_constant_eq_nsw_before mul_constant_eq_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN mul_constant_eq_nsw
  apply mul_constant_eq_nsw_thm
  ---END mul_constant_eq_nsw



def mul_constant_nuw_eq_before := [llvm|
{
^0(%arg120 : i32, %arg121 : i32):
  %0 = llvm.mlir.constant(22 : i32) : i32
  %1 = llvm.mul %arg120, %0 overflow<nuw> : i32
  %2 = llvm.mul %arg121, %0 overflow<nuw> : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_constant_nuw_eq_after := [llvm|
{
^0(%arg120 : i32, %arg121 : i32):
  %0 = llvm.icmp "eq" %arg120, %arg121 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_constant_nuw_eq_proof : mul_constant_nuw_eq_before ⊑ mul_constant_nuw_eq_after := by
  unfold mul_constant_nuw_eq_before mul_constant_nuw_eq_after
  simp_alive_peephole
  intros
  ---BEGIN mul_constant_nuw_eq
  apply mul_constant_nuw_eq_thm
  ---END mul_constant_nuw_eq



def mul_constant_partial_nuw_eq_before := [llvm|
{
^0(%arg104 : i32, %arg105 : i32):
  %0 = llvm.mlir.constant(44 : i32) : i32
  %1 = llvm.mul %arg104, %0 : i32
  %2 = llvm.mul %arg105, %0 overflow<nuw> : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_constant_partial_nuw_eq_after := [llvm|
{
^0(%arg104 : i32, %arg105 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.xor %arg104, %arg105 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_constant_partial_nuw_eq_proof : mul_constant_partial_nuw_eq_before ⊑ mul_constant_partial_nuw_eq_after := by
  unfold mul_constant_partial_nuw_eq_before mul_constant_partial_nuw_eq_after
  simp_alive_peephole
  intros
  ---BEGIN mul_constant_partial_nuw_eq
  apply mul_constant_partial_nuw_eq_thm
  ---END mul_constant_partial_nuw_eq



def mul_constant_mismatch_wrap_eq_before := [llvm|
{
^0(%arg102 : i32, %arg103 : i32):
  %0 = llvm.mlir.constant(54 : i32) : i32
  %1 = llvm.mul %arg102, %0 overflow<nsw> : i32
  %2 = llvm.mul %arg103, %0 overflow<nuw> : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_constant_mismatch_wrap_eq_after := [llvm|
{
^0(%arg102 : i32, %arg103 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.xor %arg102, %arg103 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_constant_mismatch_wrap_eq_proof : mul_constant_mismatch_wrap_eq_before ⊑ mul_constant_mismatch_wrap_eq_after := by
  unfold mul_constant_mismatch_wrap_eq_before mul_constant_mismatch_wrap_eq_after
  simp_alive_peephole
  intros
  ---BEGIN mul_constant_mismatch_wrap_eq
  apply mul_constant_mismatch_wrap_eq_thm
  ---END mul_constant_mismatch_wrap_eq



def eq_mul_constants_with_tz_before := [llvm|
{
^0(%arg100 : i32, %arg101 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mul %arg100, %0 : i32
  %2 = llvm.mul %arg101, %0 : i32
  %3 = llvm.icmp "ne" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_mul_constants_with_tz_after := [llvm|
{
^0(%arg100 : i32, %arg101 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.xor %arg100, %arg101 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_mul_constants_with_tz_proof : eq_mul_constants_with_tz_before ⊑ eq_mul_constants_with_tz_after := by
  unfold eq_mul_constants_with_tz_before eq_mul_constants_with_tz_after
  simp_alive_peephole
  intros
  ---BEGIN eq_mul_constants_with_tz
  apply eq_mul_constants_with_tz_thm
  ---END eq_mul_constants_with_tz



def mul_of_bool_before := [llvm|
{
^0(%arg95 : i32, %arg96 : i8):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.and %arg95, %0 : i32
  %3 = llvm.zext %arg96 : i8 to i32
  %4 = llvm.mul %2, %3 : i32
  %5 = llvm.icmp "ugt" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_of_bool_after := [llvm|
{
^0(%arg95 : i32, %arg96 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_of_bool_proof : mul_of_bool_before ⊑ mul_of_bool_after := by
  unfold mul_of_bool_before mul_of_bool_after
  simp_alive_peephole
  intros
  ---BEGIN mul_of_bool
  apply mul_of_bool_thm
  ---END mul_of_bool



def mul_of_bool_commute_before := [llvm|
{
^0(%arg93 : i32, %arg94 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.and %arg93, %0 : i32
  %3 = llvm.and %arg94, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  %5 = llvm.icmp "ugt" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_of_bool_commute_after := [llvm|
{
^0(%arg93 : i32, %arg94 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_of_bool_commute_proof : mul_of_bool_commute_before ⊑ mul_of_bool_commute_after := by
  unfold mul_of_bool_commute_before mul_of_bool_commute_after
  simp_alive_peephole
  intros
  ---BEGIN mul_of_bool_commute
  apply mul_of_bool_commute_thm
  ---END mul_of_bool_commute



def mul_of_bools_before := [llvm|
{
^0(%arg91 : i32, %arg92 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.and %arg91, %0 : i32
  %3 = llvm.and %arg92, %0 : i32
  %4 = llvm.mul %2, %3 : i32
  %5 = llvm.icmp "ult" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_of_bools_after := [llvm|
{
^0(%arg91 : i32, %arg92 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_of_bools_proof : mul_of_bools_before ⊑ mul_of_bools_after := by
  unfold mul_of_bools_before mul_of_bools_after
  simp_alive_peephole
  intros
  ---BEGIN mul_of_bools
  apply mul_of_bools_thm
  ---END mul_of_bools



def not_mul_of_bool_before := [llvm|
{
^0(%arg89 : i32, %arg90 : i8):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.and %arg89, %0 : i32
  %3 = llvm.zext %arg90 : i8 to i32
  %4 = llvm.mul %2, %3 : i32
  %5 = llvm.icmp "ugt" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def not_mul_of_bool_after := [llvm|
{
^0(%arg89 : i32, %arg90 : i8):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.and %arg89, %0 : i32
  %3 = llvm.zext %arg90 : i8 to i32
  %4 = llvm.mul %2, %3 overflow<nsw,nuw> : i32
  %5 = llvm.icmp "ugt" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_mul_of_bool_proof : not_mul_of_bool_before ⊑ not_mul_of_bool_after := by
  unfold not_mul_of_bool_before not_mul_of_bool_after
  simp_alive_peephole
  intros
  ---BEGIN not_mul_of_bool
  apply not_mul_of_bool_thm
  ---END not_mul_of_bool



def not_mul_of_bool_commute_before := [llvm|
{
^0(%arg87 : i32, %arg88 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.lshr %arg87, %0 : i32
  %3 = llvm.and %arg88, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  %5 = llvm.icmp "ugt" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def not_mul_of_bool_commute_after := [llvm|
{
^0(%arg87 : i32, %arg88 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.lshr %arg87, %0 : i32
  %3 = llvm.and %arg88, %1 : i32
  %4 = llvm.mul %3, %2 overflow<nsw,nuw> : i32
  %5 = llvm.icmp "ugt" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_mul_of_bool_commute_proof : not_mul_of_bool_commute_before ⊑ not_mul_of_bool_commute_after := by
  unfold not_mul_of_bool_commute_before not_mul_of_bool_commute_after
  simp_alive_peephole
  intros
  ---BEGIN not_mul_of_bool_commute
  apply not_mul_of_bool_commute_thm
  ---END not_mul_of_bool_commute



def mul_of_bool_no_lz_other_op_before := [llvm|
{
^0(%arg85 : i32, %arg86 : i8):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.and %arg85, %0 : i32
  %3 = llvm.sext %arg86 : i8 to i32
  %4 = llvm.mul %2, %3 overflow<nsw,nuw> : i32
  %5 = llvm.icmp "sgt" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_of_bool_no_lz_other_op_after := [llvm|
{
^0(%arg85 : i32, %arg86 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_of_bool_no_lz_other_op_proof : mul_of_bool_no_lz_other_op_before ⊑ mul_of_bool_no_lz_other_op_after := by
  unfold mul_of_bool_no_lz_other_op_before mul_of_bool_no_lz_other_op_after
  simp_alive_peephole
  intros
  ---BEGIN mul_of_bool_no_lz_other_op
  apply mul_of_bool_no_lz_other_op_thm
  ---END mul_of_bool_no_lz_other_op



def mul_of_pow2_before := [llvm|
{
^0(%arg83 : i32, %arg84 : i8):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(510 : i32) : i32
  %2 = llvm.and %arg83, %0 : i32
  %3 = llvm.zext %arg84 : i8 to i32
  %4 = llvm.mul %2, %3 : i32
  %5 = llvm.icmp "ugt" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_of_pow2_after := [llvm|
{
^0(%arg83 : i32, %arg84 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_of_pow2_proof : mul_of_pow2_before ⊑ mul_of_pow2_after := by
  unfold mul_of_pow2_before mul_of_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN mul_of_pow2
  apply mul_of_pow2_thm
  ---END mul_of_pow2



def mul_of_pow2_commute_before := [llvm|
{
^0(%arg81 : i32, %arg82 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.mlir.constant(1020 : i32) : i32
  %3 = llvm.and %arg81, %0 : i32
  %4 = llvm.and %arg82, %1 : i32
  %5 = llvm.mul %4, %3 : i32
  %6 = llvm.icmp "ugt" %5, %2 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
def mul_of_pow2_commute_after := [llvm|
{
^0(%arg81 : i32, %arg82 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_of_pow2_commute_proof : mul_of_pow2_commute_before ⊑ mul_of_pow2_commute_after := by
  unfold mul_of_pow2_commute_before mul_of_pow2_commute_after
  simp_alive_peephole
  intros
  ---BEGIN mul_of_pow2_commute
  apply mul_of_pow2_commute_thm
  ---END mul_of_pow2_commute



def mul_of_pow2s_before := [llvm|
{
^0(%arg79 : i32, %arg80 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.and %arg79, %0 : i32
  %4 = llvm.and %arg80, %1 : i32
  %5 = llvm.mul %3, %4 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def mul_of_pow2s_after := [llvm|
{
^0(%arg79 : i32, %arg80 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_of_pow2s_proof : mul_of_pow2s_before ⊑ mul_of_pow2s_after := by
  unfold mul_of_pow2s_before mul_of_pow2s_after
  simp_alive_peephole
  intros
  ---BEGIN mul_of_pow2s
  apply mul_of_pow2s_thm
  ---END mul_of_pow2s



def not_mul_of_pow2_before := [llvm|
{
^0(%arg77 : i32, %arg78 : i8):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(1530 : i32) : i32
  %2 = llvm.and %arg77, %0 : i32
  %3 = llvm.zext %arg78 : i8 to i32
  %4 = llvm.mul %2, %3 : i32
  %5 = llvm.icmp "ugt" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def not_mul_of_pow2_after := [llvm|
{
^0(%arg77 : i32, %arg78 : i8):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(1530 : i32) : i32
  %2 = llvm.and %arg77, %0 : i32
  %3 = llvm.zext %arg78 : i8 to i32
  %4 = llvm.mul %2, %3 overflow<nsw,nuw> : i32
  %5 = llvm.icmp "ugt" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_mul_of_pow2_proof : not_mul_of_pow2_before ⊑ not_mul_of_pow2_after := by
  unfold not_mul_of_pow2_before not_mul_of_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN not_mul_of_pow2
  apply not_mul_of_pow2_thm
  ---END not_mul_of_pow2



def not_mul_of_pow2_commute_before := [llvm|
{
^0(%arg75 : i32, %arg76 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.mlir.constant(3060 : i32) : i32
  %3 = llvm.and %arg75, %0 : i32
  %4 = llvm.and %arg76, %1 : i32
  %5 = llvm.mul %4, %3 : i32
  %6 = llvm.icmp "ugt" %5, %2 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
def not_mul_of_pow2_commute_after := [llvm|
{
^0(%arg75 : i32, %arg76 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.mlir.constant(3060 : i32) : i32
  %3 = llvm.and %arg75, %0 : i32
  %4 = llvm.and %arg76, %1 : i32
  %5 = llvm.mul %4, %3 overflow<nsw,nuw> : i32
  %6 = llvm.icmp "ugt" %5, %2 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_mul_of_pow2_commute_proof : not_mul_of_pow2_commute_before ⊑ not_mul_of_pow2_commute_after := by
  unfold not_mul_of_pow2_commute_before not_mul_of_pow2_commute_after
  simp_alive_peephole
  intros
  ---BEGIN not_mul_of_pow2_commute
  apply not_mul_of_pow2_commute_thm
  ---END not_mul_of_pow2_commute



def splat_mul_known_lz_before := [llvm|
{
^0(%arg72 : i32):
  %0 = llvm.mlir.constant(18446744078004518913 : i128) : i128
  %1 = llvm.mlir.constant(96 : i128) : i128
  %2 = llvm.mlir.constant(0 : i128) : i128
  %3 = llvm.zext %arg72 : i32 to i128
  %4 = llvm.mul %3, %0 : i128
  %5 = llvm.lshr %4, %1 : i128
  %6 = llvm.icmp "eq" %5, %2 : i128
  "llvm.return"(%6) : (i1) -> ()
}
]
def splat_mul_known_lz_after := [llvm|
{
^0(%arg72 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem splat_mul_known_lz_proof : splat_mul_known_lz_before ⊑ splat_mul_known_lz_after := by
  unfold splat_mul_known_lz_before splat_mul_known_lz_after
  simp_alive_peephole
  intros
  ---BEGIN splat_mul_known_lz
  apply splat_mul_known_lz_thm
  ---END splat_mul_known_lz



def splat_mul_unknown_lz_before := [llvm|
{
^0(%arg71 : i32):
  %0 = llvm.mlir.constant(18446744078004518913 : i128) : i128
  %1 = llvm.mlir.constant(95 : i128) : i128
  %2 = llvm.mlir.constant(0 : i128) : i128
  %3 = llvm.zext %arg71 : i32 to i128
  %4 = llvm.mul %3, %0 : i128
  %5 = llvm.lshr %4, %1 : i128
  %6 = llvm.icmp "eq" %5, %2 : i128
  "llvm.return"(%6) : (i1) -> ()
}
]
def splat_mul_unknown_lz_after := [llvm|
{
^0(%arg71 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg71, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem splat_mul_unknown_lz_proof : splat_mul_unknown_lz_before ⊑ splat_mul_unknown_lz_after := by
  unfold splat_mul_unknown_lz_before splat_mul_unknown_lz_after
  simp_alive_peephole
  intros
  ---BEGIN splat_mul_unknown_lz
  apply splat_mul_unknown_lz_thm
  ---END splat_mul_unknown_lz



def reused_mul_nuw_xy_z_selectnonzero_ugt_before := [llvm|
{
^0(%arg39 : i8, %arg40 : i8, %arg41 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ne" %arg41, %0 : i8
  %3 = llvm.mul %arg39, %arg41 overflow<nuw> : i8
  %4 = llvm.mul %arg40, %arg41 overflow<nuw> : i8
  %5 = llvm.icmp "ugt" %4, %3 : i8
  %6 = "llvm.select"(%2, %5, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def reused_mul_nuw_xy_z_selectnonzero_ugt_after := [llvm|
{
^0(%arg39 : i8, %arg40 : i8, %arg41 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "eq" %arg41, %0 : i8
  %3 = llvm.mul %arg39, %arg41 overflow<nuw> : i8
  %4 = llvm.mul %arg40, %arg41 overflow<nuw> : i8
  %5 = llvm.icmp "ugt" %4, %3 : i8
  %6 = "llvm.select"(%2, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem reused_mul_nuw_xy_z_selectnonzero_ugt_proof : reused_mul_nuw_xy_z_selectnonzero_ugt_before ⊑ reused_mul_nuw_xy_z_selectnonzero_ugt_after := by
  unfold reused_mul_nuw_xy_z_selectnonzero_ugt_before reused_mul_nuw_xy_z_selectnonzero_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN reused_mul_nuw_xy_z_selectnonzero_ugt
  apply reused_mul_nuw_xy_z_selectnonzero_ugt_thm
  ---END reused_mul_nuw_xy_z_selectnonzero_ugt



def icmp_eq_mul_nsw_nonequal_before := [llvm|
{
^0(%arg34 : i8, %arg35 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.add %arg34, %0 : i8
  %2 = llvm.mul %arg34, %arg35 overflow<nsw> : i8
  %3 = llvm.mul %1, %arg35 overflow<nsw> : i8
  %4 = llvm.icmp "eq" %2, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_eq_mul_nsw_nonequal_after := [llvm|
{
^0(%arg34 : i8, %arg35 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg35, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_mul_nsw_nonequal_proof : icmp_eq_mul_nsw_nonequal_before ⊑ icmp_eq_mul_nsw_nonequal_after := by
  unfold icmp_eq_mul_nsw_nonequal_before icmp_eq_mul_nsw_nonequal_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_mul_nsw_nonequal
  apply icmp_eq_mul_nsw_nonequal_thm
  ---END icmp_eq_mul_nsw_nonequal



def icmp_eq_mul_nuw_nonequal_before := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.add %arg32, %0 : i8
  %2 = llvm.mul %arg32, %arg33 overflow<nuw> : i8
  %3 = llvm.mul %1, %arg33 overflow<nuw> : i8
  %4 = llvm.icmp "eq" %2, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_eq_mul_nuw_nonequal_after := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg33, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_mul_nuw_nonequal_proof : icmp_eq_mul_nuw_nonequal_before ⊑ icmp_eq_mul_nuw_nonequal_after := by
  unfold icmp_eq_mul_nuw_nonequal_before icmp_eq_mul_nuw_nonequal_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_mul_nuw_nonequal
  apply icmp_eq_mul_nuw_nonequal_thm
  ---END icmp_eq_mul_nuw_nonequal



def icmp_eq_mul_nsw_nonequal_commuted_before := [llvm|
{
^0(%arg30 : i8, %arg31 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.add %arg30, %0 : i8
  %2 = llvm.mul %arg30, %arg31 overflow<nsw> : i8
  %3 = llvm.mul %arg31, %1 overflow<nsw> : i8
  %4 = llvm.icmp "eq" %2, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_eq_mul_nsw_nonequal_commuted_after := [llvm|
{
^0(%arg30 : i8, %arg31 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg31, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_mul_nsw_nonequal_commuted_proof : icmp_eq_mul_nsw_nonequal_commuted_before ⊑ icmp_eq_mul_nsw_nonequal_commuted_after := by
  unfold icmp_eq_mul_nsw_nonequal_commuted_before icmp_eq_mul_nsw_nonequal_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_mul_nsw_nonequal_commuted
  apply icmp_eq_mul_nsw_nonequal_commuted_thm
  ---END icmp_eq_mul_nsw_nonequal_commuted



def icmp_ne_mul_nsw_nonequal_before := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.add %arg28, %0 : i8
  %2 = llvm.mul %arg28, %arg29 overflow<nsw> : i8
  %3 = llvm.mul %1, %arg29 overflow<nsw> : i8
  %4 = llvm.icmp "ne" %2, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_ne_mul_nsw_nonequal_after := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg29, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_mul_nsw_nonequal_proof : icmp_ne_mul_nsw_nonequal_before ⊑ icmp_ne_mul_nsw_nonequal_after := by
  unfold icmp_ne_mul_nsw_nonequal_before icmp_ne_mul_nsw_nonequal_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_mul_nsw_nonequal
  apply icmp_ne_mul_nsw_nonequal_thm
  ---END icmp_ne_mul_nsw_nonequal



def icmp_mul_nsw_slt_before := [llvm|
{
^0(%arg19 : i8, %arg20 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mul %arg19, %0 overflow<nsw> : i8
  %2 = llvm.mul %arg20, %0 overflow<nsw> : i8
  %3 = llvm.icmp "slt" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_mul_nsw_slt_after := [llvm|
{
^0(%arg19 : i8, %arg20 : i8):
  %0 = llvm.icmp "slt" %arg19, %arg20 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_mul_nsw_slt_proof : icmp_mul_nsw_slt_before ⊑ icmp_mul_nsw_slt_after := by
  unfold icmp_mul_nsw_slt_before icmp_mul_nsw_slt_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_mul_nsw_slt
  apply icmp_mul_nsw_slt_thm
  ---END icmp_mul_nsw_slt



def icmp_mul_nsw_sle_before := [llvm|
{
^0(%arg17 : i8, %arg18 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mul %arg17, %0 overflow<nsw> : i8
  %2 = llvm.mul %arg18, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sle" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_mul_nsw_sle_after := [llvm|
{
^0(%arg17 : i8, %arg18 : i8):
  %0 = llvm.icmp "sle" %arg17, %arg18 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_mul_nsw_sle_proof : icmp_mul_nsw_sle_before ⊑ icmp_mul_nsw_sle_after := by
  unfold icmp_mul_nsw_sle_before icmp_mul_nsw_sle_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_mul_nsw_sle
  apply icmp_mul_nsw_sle_thm
  ---END icmp_mul_nsw_sle



def icmp_mul_nsw_sgt_before := [llvm|
{
^0(%arg15 : i8, %arg16 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mul %arg15, %0 overflow<nsw> : i8
  %2 = llvm.mul %arg16, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_mul_nsw_sgt_after := [llvm|
{
^0(%arg15 : i8, %arg16 : i8):
  %0 = llvm.icmp "sgt" %arg15, %arg16 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_mul_nsw_sgt_proof : icmp_mul_nsw_sgt_before ⊑ icmp_mul_nsw_sgt_after := by
  unfold icmp_mul_nsw_sgt_before icmp_mul_nsw_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_mul_nsw_sgt
  apply icmp_mul_nsw_sgt_thm
  ---END icmp_mul_nsw_sgt



def icmp_mul_nsw_sge_before := [llvm|
{
^0(%arg13 : i8, %arg14 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mul %arg13, %0 overflow<nsw> : i8
  %2 = llvm.mul %arg14, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sge" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_mul_nsw_sge_after := [llvm|
{
^0(%arg13 : i8, %arg14 : i8):
  %0 = llvm.icmp "sge" %arg13, %arg14 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_mul_nsw_sge_proof : icmp_mul_nsw_sge_before ⊑ icmp_mul_nsw_sge_after := by
  unfold icmp_mul_nsw_sge_before icmp_mul_nsw_sge_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_mul_nsw_sge
  apply icmp_mul_nsw_sge_thm
  ---END icmp_mul_nsw_sge



def icmp_mul_nsw_slt_neg_before := [llvm|
{
^0(%arg11 : i8, %arg12 : i8):
  %0 = llvm.mlir.constant(-7 : i8) : i8
  %1 = llvm.mul %arg11, %0 overflow<nsw> : i8
  %2 = llvm.mul %arg12, %0 overflow<nsw> : i8
  %3 = llvm.icmp "slt" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_mul_nsw_slt_neg_after := [llvm|
{
^0(%arg11 : i8, %arg12 : i8):
  %0 = llvm.icmp "sgt" %arg11, %arg12 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_mul_nsw_slt_neg_proof : icmp_mul_nsw_slt_neg_before ⊑ icmp_mul_nsw_slt_neg_after := by
  unfold icmp_mul_nsw_slt_neg_before icmp_mul_nsw_slt_neg_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_mul_nsw_slt_neg
  apply icmp_mul_nsw_slt_neg_thm
  ---END icmp_mul_nsw_slt_neg


