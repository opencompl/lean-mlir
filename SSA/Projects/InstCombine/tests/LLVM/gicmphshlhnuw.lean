
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
section gicmphshlhnuw_statements

def icmp_ugt_32_before := [llvm|
{
^0(%arg18 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.mlir.constant(4294967295) : i64
  %2 = llvm.shl %arg18, %0 overflow<nuw> : i64
  %3 = llvm.icmp "ugt" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ugt_32_after := [llvm|
{
^0(%arg18 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "ne" %arg18, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ugt_32_proof : icmp_ugt_32_before ⊑ icmp_ugt_32_after := by
  unfold icmp_ugt_32_before icmp_ugt_32_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ugt_32
  all_goals (try extract_goal ; sorry)
  ---END icmp_ugt_32



def icmp_ule_64_before := [llvm|
{
^0(%arg17 : i128):
  %0 = llvm.mlir.constant(64 : i128) : i128
  %1 = llvm.mlir.constant(18446744073709551615 : i128) : i128
  %2 = llvm.shl %arg17, %0 overflow<nuw> : i128
  %3 = llvm.icmp "ule" %2, %1 : i128
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ule_64_after := [llvm|
{
^0(%arg17 : i128):
  %0 = llvm.mlir.constant(0 : i128) : i128
  %1 = llvm.icmp "eq" %arg17, %0 : i128
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ule_64_proof : icmp_ule_64_before ⊑ icmp_ule_64_after := by
  unfold icmp_ule_64_before icmp_ule_64_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ule_64
  all_goals (try extract_goal ; sorry)
  ---END icmp_ule_64



def icmp_ugt_16_before := [llvm|
{
^0(%arg16 : i64):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.mlir.constant(1048575) : i64
  %2 = llvm.shl %arg16, %0 overflow<nuw> : i64
  %3 = llvm.icmp "ugt" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ugt_16_after := [llvm|
{
^0(%arg16 : i64):
  %0 = llvm.mlir.constant(15) : i64
  %1 = llvm.icmp "ugt" %arg16, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ugt_16_proof : icmp_ugt_16_before ⊑ icmp_ugt_16_after := by
  unfold icmp_ugt_16_before icmp_ugt_16_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ugt_16
  all_goals (try extract_goal ; sorry)
  ---END icmp_ugt_16



def icmp_ult_8_before := [llvm|
{
^0(%arg12 : i64):
  %0 = llvm.mlir.constant(8) : i64
  %1 = llvm.mlir.constant(4095) : i64
  %2 = llvm.shl %arg12, %0 overflow<nuw> : i64
  %3 = llvm.icmp "ult" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ult_8_after := [llvm|
{
^0(%arg12 : i64):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.icmp "ult" %arg12, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ult_8_proof : icmp_ult_8_before ⊑ icmp_ult_8_after := by
  unfold icmp_ult_8_before icmp_ult_8_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ult_8
  all_goals (try extract_goal ; sorry)
  ---END icmp_ult_8



def fold_icmp_shl_nuw_c1_before := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(4 : i32) : i32
  %4 = llvm.lshr %arg9, %0 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.shl %2, %5 overflow<nuw> : i32
  %7 = llvm.icmp "ult" %6, %3 : i32
  "llvm.return"(%7) : (i1) -> ()
}
]
def fold_icmp_shl_nuw_c1_after := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(61440 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg9, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_icmp_shl_nuw_c1_proof : fold_icmp_shl_nuw_c1_before ⊑ fold_icmp_shl_nuw_c1_after := by
  unfold fold_icmp_shl_nuw_c1_before fold_icmp_shl_nuw_c1_after
  simp_alive_peephole
  intros
  ---BEGIN fold_icmp_shl_nuw_c1
  all_goals (try extract_goal ; sorry)
  ---END fold_icmp_shl_nuw_c1



def fold_icmp_shl_nuw_c2_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(64 : i32) : i32
  %2 = llvm.shl %0, %arg8 overflow<nuw> : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def fold_icmp_shl_nuw_c2_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ult" %arg8, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_icmp_shl_nuw_c2_proof : fold_icmp_shl_nuw_c2_before ⊑ fold_icmp_shl_nuw_c2_after := by
  unfold fold_icmp_shl_nuw_c2_before fold_icmp_shl_nuw_c2_after
  simp_alive_peephole
  intros
  ---BEGIN fold_icmp_shl_nuw_c2
  all_goals (try extract_goal ; sorry)
  ---END fold_icmp_shl_nuw_c2



def fold_icmp_shl_nuw_c2_non_pow2_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(48 : i32) : i32
  %1 = llvm.mlir.constant(192 : i32) : i32
  %2 = llvm.shl %0, %arg7 overflow<nuw> : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def fold_icmp_shl_nuw_c2_non_pow2_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ult" %arg7, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_icmp_shl_nuw_c2_non_pow2_proof : fold_icmp_shl_nuw_c2_non_pow2_before ⊑ fold_icmp_shl_nuw_c2_non_pow2_after := by
  unfold fold_icmp_shl_nuw_c2_non_pow2_before fold_icmp_shl_nuw_c2_non_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN fold_icmp_shl_nuw_c2_non_pow2
  all_goals (try extract_goal ; sorry)
  ---END fold_icmp_shl_nuw_c2_non_pow2



def fold_icmp_shl_nuw_c2_div_non_pow2_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(60 : i32) : i32
  %2 = llvm.shl %0, %arg6 overflow<nuw> : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def fold_icmp_shl_nuw_c2_div_non_pow2_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.icmp "ult" %arg6, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_icmp_shl_nuw_c2_div_non_pow2_proof : fold_icmp_shl_nuw_c2_div_non_pow2_before ⊑ fold_icmp_shl_nuw_c2_div_non_pow2_after := by
  unfold fold_icmp_shl_nuw_c2_div_non_pow2_before fold_icmp_shl_nuw_c2_div_non_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN fold_icmp_shl_nuw_c2_div_non_pow2
  all_goals (try extract_goal ; sorry)
  ---END fold_icmp_shl_nuw_c2_div_non_pow2



def fold_icmp_shl_nuw_c3_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(48 : i32) : i32
  %1 = llvm.mlir.constant(144 : i32) : i32
  %2 = llvm.shl %0, %arg5 overflow<nuw> : i32
  %3 = llvm.icmp "uge" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def fold_icmp_shl_nuw_c3_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ugt" %arg5, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_icmp_shl_nuw_c3_proof : fold_icmp_shl_nuw_c3_before ⊑ fold_icmp_shl_nuw_c3_after := by
  unfold fold_icmp_shl_nuw_c3_before fold_icmp_shl_nuw_c3_after
  simp_alive_peephole
  intros
  ---BEGIN fold_icmp_shl_nuw_c3
  all_goals (try extract_goal ; sorry)
  ---END fold_icmp_shl_nuw_c3



def fold_icmp_shl_nuw_c2_indivisible_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(63 : i32) : i32
  %2 = llvm.shl %0, %arg4 overflow<nuw> : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def fold_icmp_shl_nuw_c2_indivisible_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ult" %arg4, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_icmp_shl_nuw_c2_indivisible_proof : fold_icmp_shl_nuw_c2_indivisible_before ⊑ fold_icmp_shl_nuw_c2_indivisible_after := by
  unfold fold_icmp_shl_nuw_c2_indivisible_before fold_icmp_shl_nuw_c2_indivisible_after
  simp_alive_peephole
  intros
  ---BEGIN fold_icmp_shl_nuw_c2_indivisible
  all_goals (try extract_goal ; sorry)
  ---END fold_icmp_shl_nuw_c2_indivisible



def fold_icmp_shl_nuw_c2_precondition1_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(63 : i32) : i32
  %2 = llvm.shl %0, %arg2 overflow<nuw> : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def fold_icmp_shl_nuw_c2_precondition1_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_icmp_shl_nuw_c2_precondition1_proof : fold_icmp_shl_nuw_c2_precondition1_before ⊑ fold_icmp_shl_nuw_c2_precondition1_after := by
  unfold fold_icmp_shl_nuw_c2_precondition1_before fold_icmp_shl_nuw_c2_precondition1_after
  simp_alive_peephole
  intros
  ---BEGIN fold_icmp_shl_nuw_c2_precondition1
  all_goals (try extract_goal ; sorry)
  ---END fold_icmp_shl_nuw_c2_precondition1



def fold_icmp_shl_nuw_c2_precondition2_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(127 : i32) : i32
  %1 = llvm.mlir.constant(63 : i32) : i32
  %2 = llvm.shl %0, %arg1 overflow<nuw> : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def fold_icmp_shl_nuw_c2_precondition2_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_icmp_shl_nuw_c2_precondition2_proof : fold_icmp_shl_nuw_c2_precondition2_before ⊑ fold_icmp_shl_nuw_c2_precondition2_after := by
  unfold fold_icmp_shl_nuw_c2_precondition2_before fold_icmp_shl_nuw_c2_precondition2_after
  simp_alive_peephole
  intros
  ---BEGIN fold_icmp_shl_nuw_c2_precondition2
  all_goals (try extract_goal ; sorry)
  ---END fold_icmp_shl_nuw_c2_precondition2



def fold_icmp_shl_nuw_c2_precondition3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg0 overflow<nuw> : i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def fold_icmp_shl_nuw_c2_precondition3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_icmp_shl_nuw_c2_precondition3_proof : fold_icmp_shl_nuw_c2_precondition3_before ⊑ fold_icmp_shl_nuw_c2_precondition3_after := by
  unfold fold_icmp_shl_nuw_c2_precondition3_before fold_icmp_shl_nuw_c2_precondition3_after
  simp_alive_peephole
  intros
  ---BEGIN fold_icmp_shl_nuw_c2_precondition3
  all_goals (try extract_goal ; sorry)
  ---END fold_icmp_shl_nuw_c2_precondition3


