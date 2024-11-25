
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
section gicmphsub_statements

def test_nuw_and_unsigned_pred_before := [llvm|
{
^0(%arg57 : i64):
  %0 = llvm.mlir.constant(10) : i64
  %1 = llvm.mlir.constant(3) : i64
  %2 = llvm.sub %0, %arg57 overflow<nuw> : i64
  %3 = llvm.icmp "ult" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_nuw_and_unsigned_pred_after := [llvm|
{
^0(%arg57 : i64):
  %0 = llvm.mlir.constant(7) : i64
  %1 = llvm.icmp "ugt" %arg57, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_nuw_and_unsigned_pred_proof : test_nuw_and_unsigned_pred_before ⊑ test_nuw_and_unsigned_pred_after := by
  unfold test_nuw_and_unsigned_pred_before test_nuw_and_unsigned_pred_after
  simp_alive_peephole
  intros
  ---BEGIN test_nuw_and_unsigned_pred
  all_goals (try extract_goal ; sorry)
  ---END test_nuw_and_unsigned_pred



def test_nsw_and_signed_pred_before := [llvm|
{
^0(%arg56 : i64):
  %0 = llvm.mlir.constant(3) : i64
  %1 = llvm.mlir.constant(10) : i64
  %2 = llvm.sub %0, %arg56 overflow<nsw> : i64
  %3 = llvm.icmp "sgt" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_nsw_and_signed_pred_after := [llvm|
{
^0(%arg56 : i64):
  %0 = llvm.mlir.constant(-7) : i64
  %1 = llvm.icmp "slt" %arg56, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_nsw_and_signed_pred_proof : test_nsw_and_signed_pred_before ⊑ test_nsw_and_signed_pred_after := by
  unfold test_nsw_and_signed_pred_before test_nsw_and_signed_pred_after
  simp_alive_peephole
  intros
  ---BEGIN test_nsw_and_signed_pred
  all_goals (try extract_goal ; sorry)
  ---END test_nsw_and_signed_pred



def test_nuw_nsw_and_unsigned_pred_before := [llvm|
{
^0(%arg55 : i64):
  %0 = llvm.mlir.constant(10) : i64
  %1 = llvm.mlir.constant(3) : i64
  %2 = llvm.sub %0, %arg55 overflow<nsw,nuw> : i64
  %3 = llvm.icmp "ule" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_nuw_nsw_and_unsigned_pred_after := [llvm|
{
^0(%arg55 : i64):
  %0 = llvm.mlir.constant(6) : i64
  %1 = llvm.icmp "ugt" %arg55, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_nuw_nsw_and_unsigned_pred_proof : test_nuw_nsw_and_unsigned_pred_before ⊑ test_nuw_nsw_and_unsigned_pred_after := by
  unfold test_nuw_nsw_and_unsigned_pred_before test_nuw_nsw_and_unsigned_pred_after
  simp_alive_peephole
  intros
  ---BEGIN test_nuw_nsw_and_unsigned_pred
  all_goals (try extract_goal ; sorry)
  ---END test_nuw_nsw_and_unsigned_pred



def test_nuw_nsw_and_signed_pred_before := [llvm|
{
^0(%arg54 : i64):
  %0 = llvm.mlir.constant(10) : i64
  %1 = llvm.mlir.constant(3) : i64
  %2 = llvm.sub %0, %arg54 overflow<nsw,nuw> : i64
  %3 = llvm.icmp "slt" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_nuw_nsw_and_signed_pred_after := [llvm|
{
^0(%arg54 : i64):
  %0 = llvm.mlir.constant(7) : i64
  %1 = llvm.icmp "ugt" %arg54, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_nuw_nsw_and_signed_pred_proof : test_nuw_nsw_and_signed_pred_before ⊑ test_nuw_nsw_and_signed_pred_after := by
  unfold test_nuw_nsw_and_signed_pred_before test_nuw_nsw_and_signed_pred_after
  simp_alive_peephole
  intros
  ---BEGIN test_nuw_nsw_and_signed_pred
  all_goals (try extract_goal ; sorry)
  ---END test_nuw_nsw_and_signed_pred



def test_negative_nuw_and_signed_pred_before := [llvm|
{
^0(%arg53 : i64):
  %0 = llvm.mlir.constant(10) : i64
  %1 = llvm.mlir.constant(3) : i64
  %2 = llvm.sub %0, %arg53 overflow<nuw> : i64
  %3 = llvm.icmp "slt" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_negative_nuw_and_signed_pred_after := [llvm|
{
^0(%arg53 : i64):
  %0 = llvm.mlir.constant(7) : i64
  %1 = llvm.icmp "ugt" %arg53, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_negative_nuw_and_signed_pred_proof : test_negative_nuw_and_signed_pred_before ⊑ test_negative_nuw_and_signed_pred_after := by
  unfold test_negative_nuw_and_signed_pred_before test_negative_nuw_and_signed_pred_after
  simp_alive_peephole
  intros
  ---BEGIN test_negative_nuw_and_signed_pred
  all_goals (try extract_goal ; sorry)
  ---END test_negative_nuw_and_signed_pred



def test_negative_nsw_and_unsigned_pred_before := [llvm|
{
^0(%arg52 : i64):
  %0 = llvm.mlir.constant(10) : i64
  %1 = llvm.mlir.constant(3) : i64
  %2 = llvm.sub %0, %arg52 overflow<nsw> : i64
  %3 = llvm.icmp "ult" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_negative_nsw_and_unsigned_pred_after := [llvm|
{
^0(%arg52 : i64):
  %0 = llvm.mlir.constant(-8) : i64
  %1 = llvm.mlir.constant(3) : i64
  %2 = llvm.add %arg52, %0 : i64
  %3 = llvm.icmp "ult" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_negative_nsw_and_unsigned_pred_proof : test_negative_nsw_and_unsigned_pred_before ⊑ test_negative_nsw_and_unsigned_pred_after := by
  unfold test_negative_nsw_and_unsigned_pred_before test_negative_nsw_and_unsigned_pred_after
  simp_alive_peephole
  intros
  ---BEGIN test_negative_nsw_and_unsigned_pred
  all_goals (try extract_goal ; sorry)
  ---END test_negative_nsw_and_unsigned_pred



def test_negative_combined_sub_unsigned_overflow_before := [llvm|
{
^0(%arg51 : i64):
  %0 = llvm.mlir.constant(10) : i64
  %1 = llvm.mlir.constant(11) : i64
  %2 = llvm.sub %0, %arg51 overflow<nuw> : i64
  %3 = llvm.icmp "ult" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_negative_combined_sub_unsigned_overflow_after := [llvm|
{
^0(%arg51 : i64):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_negative_combined_sub_unsigned_overflow_proof : test_negative_combined_sub_unsigned_overflow_before ⊑ test_negative_combined_sub_unsigned_overflow_after := by
  unfold test_negative_combined_sub_unsigned_overflow_before test_negative_combined_sub_unsigned_overflow_after
  simp_alive_peephole
  intros
  ---BEGIN test_negative_combined_sub_unsigned_overflow
  all_goals (try extract_goal ; sorry)
  ---END test_negative_combined_sub_unsigned_overflow



def test_negative_combined_sub_signed_overflow_before := [llvm|
{
^0(%arg50 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg50 overflow<nsw> : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_negative_combined_sub_signed_overflow_after := [llvm|
{
^0(%arg50 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_negative_combined_sub_signed_overflow_proof : test_negative_combined_sub_signed_overflow_before ⊑ test_negative_combined_sub_signed_overflow_after := by
  unfold test_negative_combined_sub_signed_overflow_before test_negative_combined_sub_signed_overflow_after
  simp_alive_peephole
  intros
  ---BEGIN test_negative_combined_sub_signed_overflow
  all_goals (try extract_goal ; sorry)
  ---END test_negative_combined_sub_signed_overflow



def test_sub_0_Y_eq_0_before := [llvm|
{
^0(%arg49 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg49 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_sub_0_Y_eq_0_after := [llvm|
{
^0(%arg49 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg49, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_0_Y_eq_0_proof : test_sub_0_Y_eq_0_before ⊑ test_sub_0_Y_eq_0_after := by
  unfold test_sub_0_Y_eq_0_before test_sub_0_Y_eq_0_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_0_Y_eq_0
  all_goals (try extract_goal ; sorry)
  ---END test_sub_0_Y_eq_0



def test_sub_0_Y_ne_0_before := [llvm|
{
^0(%arg48 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg48 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_sub_0_Y_ne_0_after := [llvm|
{
^0(%arg48 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg48, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_0_Y_ne_0_proof : test_sub_0_Y_ne_0_before ⊑ test_sub_0_Y_ne_0_after := by
  unfold test_sub_0_Y_ne_0_before test_sub_0_Y_ne_0_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_0_Y_ne_0
  all_goals (try extract_goal ; sorry)
  ---END test_sub_0_Y_ne_0



def test_sub_4_Y_ne_4_before := [llvm|
{
^0(%arg47 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.sub %0, %arg47 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_sub_4_Y_ne_4_after := [llvm|
{
^0(%arg47 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg47, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_4_Y_ne_4_proof : test_sub_4_Y_ne_4_before ⊑ test_sub_4_Y_ne_4_after := by
  unfold test_sub_4_Y_ne_4_before test_sub_4_Y_ne_4_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_4_Y_ne_4
  all_goals (try extract_goal ; sorry)
  ---END test_sub_4_Y_ne_4



def test_sub_127_Y_eq_127_before := [llvm|
{
^0(%arg46 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.sub %0, %arg46 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_sub_127_Y_eq_127_after := [llvm|
{
^0(%arg46 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg46, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_127_Y_eq_127_proof : test_sub_127_Y_eq_127_before ⊑ test_sub_127_Y_eq_127_after := by
  unfold test_sub_127_Y_eq_127_before test_sub_127_Y_eq_127_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_127_Y_eq_127
  all_goals (try extract_goal ; sorry)
  ---END test_sub_127_Y_eq_127



def test_sub_255_Y_eq_255_before := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.sub %0, %arg45 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_sub_255_Y_eq_255_after := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg45, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_255_Y_eq_255_proof : test_sub_255_Y_eq_255_before ⊑ test_sub_255_Y_eq_255_after := by
  unfold test_sub_255_Y_eq_255_before test_sub_255_Y_eq_255_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_255_Y_eq_255
  all_goals (try extract_goal ; sorry)
  ---END test_sub_255_Y_eq_255



def neg_sgt_42_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.sub %0, %arg39 : i32
  %3 = llvm.icmp "sgt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_sgt_42_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(-43 : i32) : i32
  %2 = llvm.add %arg39, %0 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_sgt_42_proof : neg_sgt_42_before ⊑ neg_sgt_42_after := by
  unfold neg_sgt_42_before neg_sgt_42_after
  simp_alive_peephole
  intros
  ---BEGIN neg_sgt_42
  all_goals (try extract_goal ; sorry)
  ---END neg_sgt_42



def neg_slt_42_before := [llvm|
{
^0(%arg30 : i128):
  %0 = llvm.mlir.constant(0 : i128) : i128
  %1 = llvm.mlir.constant(42 : i128) : i128
  %2 = llvm.sub %0, %arg30 : i128
  %3 = llvm.icmp "slt" %2, %1 : i128
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_slt_42_after := [llvm|
{
^0(%arg30 : i128):
  %0 = llvm.mlir.constant(-1 : i128) : i128
  %1 = llvm.mlir.constant(-43 : i128) : i128
  %2 = llvm.add %arg30, %0 : i128
  %3 = llvm.icmp "sgt" %2, %1 : i128
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_slt_42_proof : neg_slt_42_before ⊑ neg_slt_42_after := by
  unfold neg_slt_42_before neg_slt_42_after
  simp_alive_peephole
  intros
  ---BEGIN neg_slt_42
  all_goals (try extract_goal ; sorry)
  ---END neg_slt_42



def neg_slt_n1_before := [llvm|
{
^0(%arg27 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg27 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_slt_n1_after := [llvm|
{
^0(%arg27 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg27, %0 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_slt_n1_proof : neg_slt_n1_before ⊑ neg_slt_n1_after := by
  unfold neg_slt_n1_before neg_slt_n1_after
  simp_alive_peephole
  intros
  ---BEGIN neg_slt_n1
  all_goals (try extract_goal ; sorry)
  ---END neg_slt_n1



def neg_slt_0_before := [llvm|
{
^0(%arg26 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg26 : i8
  %2 = llvm.icmp "slt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def neg_slt_0_after := [llvm|
{
^0(%arg26 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.add %arg26, %0 : i8
  %2 = llvm.icmp "sgt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_slt_0_proof : neg_slt_0_before ⊑ neg_slt_0_after := by
  unfold neg_slt_0_before neg_slt_0_after
  simp_alive_peephole
  intros
  ---BEGIN neg_slt_0
  all_goals (try extract_goal ; sorry)
  ---END neg_slt_0



def neg_slt_1_before := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.sub %0, %arg25 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_slt_1_after := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(-127 : i8) : i8
  %1 = llvm.icmp "ult" %arg25, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_slt_1_proof : neg_slt_1_before ⊑ neg_slt_1_after := by
  unfold neg_slt_1_before neg_slt_1_after
  simp_alive_peephole
  intros
  ---BEGIN neg_slt_1
  all_goals (try extract_goal ; sorry)
  ---END neg_slt_1



def neg_sgt_n1_before := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg24 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_sgt_n1_after := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg24, %0 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_sgt_n1_proof : neg_sgt_n1_before ⊑ neg_sgt_n1_after := by
  unfold neg_sgt_n1_before neg_sgt_n1_after
  simp_alive_peephole
  intros
  ---BEGIN neg_sgt_n1
  all_goals (try extract_goal ; sorry)
  ---END neg_sgt_n1



def neg_sgt_0_before := [llvm|
{
^0(%arg23 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg23 : i8
  %2 = llvm.icmp "sgt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def neg_sgt_0_after := [llvm|
{
^0(%arg23 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "ugt" %arg23, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_sgt_0_proof : neg_sgt_0_before ⊑ neg_sgt_0_after := by
  unfold neg_sgt_0_before neg_sgt_0_after
  simp_alive_peephole
  intros
  ---BEGIN neg_sgt_0
  all_goals (try extract_goal ; sorry)
  ---END neg_sgt_0



def neg_sgt_1_before := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.sub %0, %arg22 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_sgt_1_after := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.add %arg22, %0 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_sgt_1_proof : neg_sgt_1_before ⊑ neg_sgt_1_after := by
  unfold neg_sgt_1_before neg_sgt_1_after
  simp_alive_peephole
  intros
  ---BEGIN neg_sgt_1
  all_goals (try extract_goal ; sorry)
  ---END neg_sgt_1



def neg_nsw_slt_n1_before := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg21 overflow<nsw> : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_nsw_slt_n1_after := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg21, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_nsw_slt_n1_proof : neg_nsw_slt_n1_before ⊑ neg_nsw_slt_n1_after := by
  unfold neg_nsw_slt_n1_before neg_nsw_slt_n1_after
  simp_alive_peephole
  intros
  ---BEGIN neg_nsw_slt_n1
  all_goals (try extract_goal ; sorry)
  ---END neg_nsw_slt_n1



def neg_nsw_slt_0_before := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg20 overflow<nsw> : i8
  %2 = llvm.icmp "slt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def neg_nsw_slt_0_after := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "sgt" %arg20, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_nsw_slt_0_proof : neg_nsw_slt_0_before ⊑ neg_nsw_slt_0_after := by
  unfold neg_nsw_slt_0_before neg_nsw_slt_0_after
  simp_alive_peephole
  intros
  ---BEGIN neg_nsw_slt_0
  all_goals (try extract_goal ; sorry)
  ---END neg_nsw_slt_0



def neg_nsw_slt_1_before := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.sub %0, %arg19 overflow<nsw> : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_nsw_slt_1_after := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg19, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_nsw_slt_1_proof : neg_nsw_slt_1_before ⊑ neg_nsw_slt_1_after := by
  unfold neg_nsw_slt_1_before neg_nsw_slt_1_after
  simp_alive_peephole
  intros
  ---BEGIN neg_nsw_slt_1
  all_goals (try extract_goal ; sorry)
  ---END neg_nsw_slt_1



def neg_nsw_sgt_n1_before := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg18 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_nsw_sgt_n1_after := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.icmp "slt" %arg18, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_nsw_sgt_n1_proof : neg_nsw_sgt_n1_before ⊑ neg_nsw_sgt_n1_after := by
  unfold neg_nsw_sgt_n1_before neg_nsw_sgt_n1_after
  simp_alive_peephole
  intros
  ---BEGIN neg_nsw_sgt_n1
  all_goals (try extract_goal ; sorry)
  ---END neg_nsw_sgt_n1



def neg_nsw_sgt_0_before := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg17 overflow<nsw> : i8
  %2 = llvm.icmp "sgt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def neg_nsw_sgt_0_after := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg17, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_nsw_sgt_0_proof : neg_nsw_sgt_0_before ⊑ neg_nsw_sgt_0_after := by
  unfold neg_nsw_sgt_0_before neg_nsw_sgt_0_after
  simp_alive_peephole
  intros
  ---BEGIN neg_nsw_sgt_0
  all_goals (try extract_goal ; sorry)
  ---END neg_nsw_sgt_0



def neg_nsw_sgt_1_before := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.sub %0, %arg16 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_nsw_sgt_1_after := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "slt" %arg16, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_nsw_sgt_1_proof : neg_nsw_sgt_1_before ⊑ neg_nsw_sgt_1_after := by
  unfold neg_nsw_sgt_1_before neg_nsw_sgt_1_after
  simp_alive_peephole
  intros
  ---BEGIN neg_nsw_sgt_1
  all_goals (try extract_goal ; sorry)
  ---END neg_nsw_sgt_1



def PR60818_ne_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg5 : i32
  %2 = llvm.icmp "ne" %1, %arg5 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def PR60818_ne_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg5, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR60818_ne_proof : PR60818_ne_before ⊑ PR60818_ne_after := by
  unfold PR60818_ne_before PR60818_ne_after
  simp_alive_peephole
  intros
  ---BEGIN PR60818_ne
  all_goals (try extract_goal ; sorry)
  ---END PR60818_ne



def PR60818_eq_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg4 : i32
  %2 = llvm.icmp "eq" %1, %arg4 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def PR60818_eq_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg4, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR60818_eq_proof : PR60818_eq_before ⊑ PR60818_eq_after := by
  unfold PR60818_eq_before PR60818_eq_after
  simp_alive_peephole
  intros
  ---BEGIN PR60818_eq
  all_goals (try extract_goal ; sorry)
  ---END PR60818_eq



def PR60818_eq_commuted_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(43 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mul %arg3, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  %4 = llvm.icmp "eq" %2, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR60818_eq_commuted_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(43 : i32) : i32
  %1 = llvm.mlir.constant(2147483647 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mul %arg3, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR60818_eq_commuted_proof : PR60818_eq_commuted_before ⊑ PR60818_eq_commuted_after := by
  unfold PR60818_eq_commuted_before PR60818_eq_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN PR60818_eq_commuted
  all_goals (try extract_goal ; sorry)
  ---END PR60818_eq_commuted



def PR60818_sgt_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg0 : i32
  %2 = llvm.icmp "sgt" %1, %arg0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def PR60818_sgt_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg0 : i32
  %2 = llvm.icmp "slt" %arg0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR60818_sgt_proof : PR60818_sgt_before ⊑ PR60818_sgt_after := by
  unfold PR60818_sgt_before PR60818_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN PR60818_sgt
  all_goals (try extract_goal ; sorry)
  ---END PR60818_sgt


