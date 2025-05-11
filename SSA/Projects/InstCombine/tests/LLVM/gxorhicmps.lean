
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
section gxorhicmps_statements

def slt_zero_before := [llvm|
{
^0(%arg30 : i4, %arg31 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg30, %0 : i4
  %2 = llvm.icmp "slt" %arg31, %0 : i4
  %3 = llvm.xor %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_zero_after := [llvm|
{
^0(%arg30 : i4, %arg31 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.xor %arg30, %arg31 : i4
  %2 = llvm.icmp "slt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_proof : slt_zero_before ⊑ slt_zero_after := by
  unfold slt_zero_before slt_zero_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero
  all_goals (try extract_goal ; sorry)
  ---END slt_zero



def sgt_minus1_before := [llvm|
{
^0(%arg24 : i4, %arg25 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg24, %0 : i4
  %2 = llvm.icmp "sgt" %arg25, %0 : i4
  %3 = llvm.xor %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_minus1_after := [llvm|
{
^0(%arg24 : i4, %arg25 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.xor %arg24, %arg25 : i4
  %2 = llvm.icmp "slt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_minus1_proof : sgt_minus1_before ⊑ sgt_minus1_after := by
  unfold sgt_minus1_before sgt_minus1_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_minus1
  all_goals (try extract_goal ; sorry)
  ---END sgt_minus1



def slt_zero_sgt_minus1_before := [llvm|
{
^0(%arg22 : i4, %arg23 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.icmp "slt" %arg22, %0 : i4
  %3 = llvm.icmp "sgt" %arg23, %1 : i4
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_zero_sgt_minus1_after := [llvm|
{
^0(%arg22 : i4, %arg23 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg22, %arg23 : i4
  %2 = llvm.icmp "sgt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_sgt_minus1_proof : slt_zero_sgt_minus1_before ⊑ slt_zero_sgt_minus1_after := by
  unfold slt_zero_sgt_minus1_before slt_zero_sgt_minus1_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_sgt_minus1
  all_goals (try extract_goal ; sorry)
  ---END slt_zero_sgt_minus1



def test13_before := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.icmp "ult" %arg16, %arg17 : i8
  %1 = llvm.icmp "ugt" %arg16, %arg17 : i8
  %2 = llvm.xor %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.icmp "ne" %arg16, %arg17 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  intros
  ---BEGIN test13
  all_goals (try extract_goal ; sorry)
  ---END test13



def test14_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.icmp "eq" %arg14, %arg15 : i8
  %1 = llvm.icmp "ne" %arg15, %arg14 : i8
  %2 = llvm.xor %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test14_proof : test14_before ⊑ test14_after := by
  unfold test14_before test14_after
  simp_alive_peephole
  intros
  ---BEGIN test14
  all_goals (try extract_goal ; sorry)
  ---END test14



def xor_icmp_true_signed_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.icmp "sgt" %arg11, %0 : i32
  %3 = llvm.icmp "slt" %arg11, %1 : i32
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_true_signed_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_icmp_true_signed_proof : xor_icmp_true_signed_before ⊑ xor_icmp_true_signed_after := by
  unfold xor_icmp_true_signed_before xor_icmp_true_signed_after
  simp_alive_peephole
  intros
  ---BEGIN xor_icmp_true_signed
  all_goals (try extract_goal ; sorry)
  ---END xor_icmp_true_signed



def xor_icmp_true_signed_commuted_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.icmp "sgt" %arg8, %0 : i32
  %3 = llvm.icmp "slt" %arg8, %1 : i32
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_true_signed_commuted_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_icmp_true_signed_commuted_proof : xor_icmp_true_signed_commuted_before ⊑ xor_icmp_true_signed_commuted_after := by
  unfold xor_icmp_true_signed_commuted_before xor_icmp_true_signed_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN xor_icmp_true_signed_commuted
  all_goals (try extract_goal ; sorry)
  ---END xor_icmp_true_signed_commuted



def xor_icmp_true_unsigned_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.icmp "ugt" %arg7, %0 : i32
  %3 = llvm.icmp "ult" %arg7, %1 : i32
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_true_unsigned_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_icmp_true_unsigned_proof : xor_icmp_true_unsigned_before ⊑ xor_icmp_true_unsigned_after := by
  unfold xor_icmp_true_unsigned_before xor_icmp_true_unsigned_after
  simp_alive_peephole
  intros
  ---BEGIN xor_icmp_true_unsigned
  all_goals (try extract_goal ; sorry)
  ---END xor_icmp_true_unsigned



def xor_icmp_to_ne_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.icmp "sgt" %arg6, %0 : i32
  %3 = llvm.icmp "slt" %arg6, %1 : i32
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_to_ne_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.icmp "ne" %arg6, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_icmp_to_ne_proof : xor_icmp_to_ne_before ⊑ xor_icmp_to_ne_after := by
  unfold xor_icmp_to_ne_before xor_icmp_to_ne_after
  simp_alive_peephole
  intros
  ---BEGIN xor_icmp_to_ne
  all_goals (try extract_goal ; sorry)
  ---END xor_icmp_to_ne



def xor_icmp_to_icmp_add_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.icmp "sgt" %arg4, %0 : i32
  %3 = llvm.icmp "slt" %arg4, %1 : i32
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_to_icmp_add_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(-6 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.add %arg4, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_icmp_to_icmp_add_proof : xor_icmp_to_icmp_add_before ⊑ xor_icmp_to_icmp_add_after := by
  unfold xor_icmp_to_icmp_add_before xor_icmp_to_icmp_add_after
  simp_alive_peephole
  intros
  ---BEGIN xor_icmp_to_icmp_add
  all_goals (try extract_goal ; sorry)
  ---END xor_icmp_to_icmp_add



def xor_icmp_invalid_range_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.icmp "eq" %arg3, %0 : i8
  %3 = llvm.icmp "ne" %arg3, %1 : i8
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_invalid_range_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg3, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_icmp_invalid_range_proof : xor_icmp_invalid_range_before ⊑ xor_icmp_invalid_range_after := by
  unfold xor_icmp_invalid_range_before xor_icmp_invalid_range_after
  simp_alive_peephole
  intros
  ---BEGIN xor_icmp_invalid_range
  all_goals (try extract_goal ; sorry)
  ---END xor_icmp_invalid_range


