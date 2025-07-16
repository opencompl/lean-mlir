import SSA.Projects.InstCombine.tests.proofs.gicmphxorhsignbit_proof
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
section gicmphxorhsignbit_statements

def slt_to_ult_before := [llvm|
{
^0(%arg36 : i8, %arg37 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.xor %arg36, %0 : i8
  %2 = llvm.xor %arg37, %0 : i8
  %3 = llvm.icmp "slt" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_to_ult_after := [llvm|
{
^0(%arg36 : i8, %arg37 : i8):
  %0 = llvm.icmp "ult" %arg36, %arg37 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_to_ult_proof : slt_to_ult_before ⊑ slt_to_ult_after := by
  unfold slt_to_ult_before slt_to_ult_after
  simp_alive_peephole
  intros
  ---BEGIN slt_to_ult
  apply slt_to_ult_thm
  ---END slt_to_ult



def ult_to_slt_before := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.xor %arg32, %0 : i8
  %2 = llvm.xor %arg33, %0 : i8
  %3 = llvm.icmp "ult" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_to_slt_after := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.icmp "slt" %arg32, %arg33 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_to_slt_proof : ult_to_slt_before ⊑ ult_to_slt_after := by
  unfold ult_to_slt_before ult_to_slt_after
  simp_alive_peephole
  intros
  ---BEGIN ult_to_slt
  apply ult_to_slt_thm
  ---END ult_to_slt



def slt_to_ugt_before := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.xor %arg28, %0 : i8
  %2 = llvm.xor %arg29, %0 : i8
  %3 = llvm.icmp "slt" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_to_ugt_after := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.icmp "ugt" %arg28, %arg29 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_to_ugt_proof : slt_to_ugt_before ⊑ slt_to_ugt_after := by
  unfold slt_to_ugt_before slt_to_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN slt_to_ugt
  apply slt_to_ugt_thm
  ---END slt_to_ugt



def ult_to_sgt_before := [llvm|
{
^0(%arg24 : i8, %arg25 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.xor %arg24, %0 : i8
  %2 = llvm.xor %arg25, %0 : i8
  %3 = llvm.icmp "ult" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_to_sgt_after := [llvm|
{
^0(%arg24 : i8, %arg25 : i8):
  %0 = llvm.icmp "sgt" %arg24, %arg25 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_to_sgt_proof : ult_to_sgt_before ⊑ ult_to_sgt_after := by
  unfold ult_to_sgt_before ult_to_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN ult_to_sgt
  apply ult_to_sgt_thm
  ---END ult_to_sgt



def sge_to_ugt_before := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.xor %arg21, %0 : i8
  %3 = llvm.icmp "sge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_to_ugt_after := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(-114 : i8) : i8
  %1 = llvm.icmp "ugt" %arg21, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_to_ugt_proof : sge_to_ugt_before ⊑ sge_to_ugt_after := by
  unfold sge_to_ugt_before sge_to_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN sge_to_ugt
  apply sge_to_ugt_thm
  ---END sge_to_ugt



def uge_to_sgt_before := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.xor %arg19, %0 : i8
  %3 = llvm.icmp "uge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_to_sgt_after := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(-114 : i8) : i8
  %1 = llvm.icmp "sgt" %arg19, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_to_sgt_proof : uge_to_sgt_before ⊑ uge_to_sgt_after := by
  unfold uge_to_sgt_before uge_to_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN uge_to_sgt
  apply uge_to_sgt_thm
  ---END uge_to_sgt



def sge_to_ult_before := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.xor %arg17, %0 : i8
  %3 = llvm.icmp "sge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_to_ult_after := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(113 : i8) : i8
  %1 = llvm.icmp "ult" %arg17, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_to_ult_proof : sge_to_ult_before ⊑ sge_to_ult_after := by
  unfold sge_to_ult_before sge_to_ult_after
  simp_alive_peephole
  intros
  ---BEGIN sge_to_ult
  apply sge_to_ult_thm
  ---END sge_to_ult



def uge_to_slt_before := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.xor %arg15, %0 : i8
  %3 = llvm.icmp "uge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_to_slt_after := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(113 : i8) : i8
  %1 = llvm.icmp "slt" %arg15, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_to_slt_proof : uge_to_slt_before ⊑ uge_to_slt_after := by
  unfold uge_to_slt_before uge_to_slt_after
  simp_alive_peephole
  intros
  ---BEGIN uge_to_slt
  apply uge_to_slt_thm
  ---END uge_to_slt



def slt_zero_eq_i1_before := [llvm|
{
^0(%arg9 : i32, %arg10 : i1):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.zext %arg10 : i1 to i32
  %2 = llvm.lshr %arg9, %0 : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_zero_eq_i1_after := [llvm|
{
^0(%arg9 : i32, %arg10 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg9, %0 : i32
  %2 = llvm.xor %1, %arg10 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_eq_i1_proof : slt_zero_eq_i1_before ⊑ slt_zero_eq_i1_after := by
  unfold slt_zero_eq_i1_before slt_zero_eq_i1_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_eq_i1
  apply slt_zero_eq_i1_thm
  ---END slt_zero_eq_i1



def slt_zero_eq_i1_fail_before := [llvm|
{
^0(%arg7 : i32, %arg8 : i1):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.zext %arg8 : i1 to i32
  %2 = llvm.ashr %arg7, %0 : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_zero_eq_i1_fail_after := [llvm|
{
^0(%arg7 : i32, %arg8 : i1):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.zext %arg8 : i1 to i32
  %2 = llvm.ashr %arg7, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_eq_i1_fail_proof : slt_zero_eq_i1_fail_before ⊑ slt_zero_eq_i1_fail_after := by
  unfold slt_zero_eq_i1_fail_before slt_zero_eq_i1_fail_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_eq_i1_fail
  apply slt_zero_eq_i1_fail_thm
  ---END slt_zero_eq_i1_fail



def slt_zero_eq_ne_0_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "ne" %arg6, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg6, %1 : i32
  %5 = llvm.icmp "eq" %3, %4 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def slt_zero_eq_ne_0_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "slt" %arg6, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_eq_ne_0_proof : slt_zero_eq_ne_0_before ⊑ slt_zero_eq_ne_0_after := by
  unfold slt_zero_eq_ne_0_before slt_zero_eq_ne_0_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_eq_ne_0
  apply slt_zero_eq_ne_0_thm
  ---END slt_zero_eq_ne_0



def slt_zero_ne_ne_0_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "ne" %arg5, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg5, %1 : i32
  %5 = llvm.icmp "ne" %3, %4 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def slt_zero_ne_ne_0_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sgt" %arg5, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_ne_ne_0_proof : slt_zero_ne_ne_0_before ⊑ slt_zero_ne_ne_0_after := by
  unfold slt_zero_ne_ne_0_before slt_zero_ne_ne_0_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_ne_ne_0
  apply slt_zero_ne_ne_0_thm
  ---END slt_zero_ne_ne_0



def slt_zero_ne_ne_b_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.icmp "ne" %arg2, %arg3 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.lshr %arg2, %0 : i32
  %4 = llvm.icmp "ne" %2, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_zero_ne_ne_b_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg2, %arg3 : i32
  %2 = llvm.icmp "slt" %arg2, %0 : i32
  %3 = llvm.xor %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_ne_ne_b_proof : slt_zero_ne_ne_b_before ⊑ slt_zero_ne_ne_b_after := by
  unfold slt_zero_ne_ne_b_before slt_zero_ne_ne_b_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_ne_ne_b
  apply slt_zero_ne_ne_b_thm
  ---END slt_zero_ne_ne_b



def slt_zero_eq_ne_0_fail1_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "ne" %arg1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.ashr %arg1, %1 : i32
  %5 = llvm.icmp "eq" %3, %4 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def slt_zero_eq_ne_0_fail1_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "ne" %arg1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.ashr %arg1, %1 : i32
  %5 = llvm.icmp "eq" %4, %3 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_eq_ne_0_fail1_proof : slt_zero_eq_ne_0_fail1_before ⊑ slt_zero_eq_ne_0_fail1_after := by
  unfold slt_zero_eq_ne_0_fail1_before slt_zero_eq_ne_0_fail1_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_eq_ne_0_fail1
  apply slt_zero_eq_ne_0_fail1_thm
  ---END slt_zero_eq_ne_0_fail1



def slt_zero_eq_ne_0_fail2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(30 : i32) : i32
  %2 = llvm.icmp "ne" %arg0, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg0, %1 : i32
  %5 = llvm.icmp "eq" %3, %4 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def slt_zero_eq_ne_0_fail2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(30 : i32) : i32
  %2 = llvm.icmp "ne" %arg0, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg0, %1 : i32
  %5 = llvm.icmp "eq" %4, %3 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_eq_ne_0_fail2_proof : slt_zero_eq_ne_0_fail2_before ⊑ slt_zero_eq_ne_0_fail2_after := by
  unfold slt_zero_eq_ne_0_fail2_before slt_zero_eq_ne_0_fail2_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_eq_ne_0_fail2
  apply slt_zero_eq_ne_0_fail2_thm
  ---END slt_zero_eq_ne_0_fail2


