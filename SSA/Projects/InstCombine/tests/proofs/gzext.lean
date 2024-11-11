import SSA.Projects.InstCombine.tests.proofs.gzext_proof
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
section gzext_statements

def test_sext_zext_before := [llvm|
{
^0(%arg105 : i16):
  %0 = llvm.zext %arg105 : i16 to i32
  %1 = llvm.sext %0 : i32 to i64
  "llvm.return"(%1) : (i64) -> ()
}
]
def test_sext_zext_after := [llvm|
{
^0(%arg105 : i16):
  %0 = llvm.zext %arg105 : i16 to i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sext_zext_proof : test_sext_zext_before ⊑ test_sext_zext_after := by
  unfold test_sext_zext_before test_sext_zext_after
  simp_alive_peephole
  intros
  ---BEGIN test_sext_zext
  apply test_sext_zext_thm
  ---END test_sext_zext



def fold_xor_zext_sandwich_before := [llvm|
{
^0(%arg101 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext %arg101 : i1 to i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.zext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def fold_xor_zext_sandwich_after := [llvm|
{
^0(%arg101 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg101, %0 : i1
  %2 = llvm.zext %1 : i1 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_xor_zext_sandwich_proof : fold_xor_zext_sandwich_before ⊑ fold_xor_zext_sandwich_after := by
  unfold fold_xor_zext_sandwich_before fold_xor_zext_sandwich_after
  simp_alive_peephole
  intros
  ---BEGIN fold_xor_zext_sandwich
  apply fold_xor_zext_sandwich_thm
  ---END fold_xor_zext_sandwich



def fold_and_zext_icmp_before := [llvm|
{
^0(%arg97 : i64, %arg98 : i64, %arg99 : i64):
  %0 = llvm.icmp "sgt" %arg97, %arg98 : i64
  %1 = llvm.zext %0 : i1 to i8
  %2 = llvm.icmp "slt" %arg97, %arg99 : i64
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.and %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def fold_and_zext_icmp_after := [llvm|
{
^0(%arg97 : i64, %arg98 : i64, %arg99 : i64):
  %0 = llvm.icmp "sgt" %arg97, %arg98 : i64
  %1 = llvm.icmp "slt" %arg97, %arg99 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.zext %2 : i1 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_and_zext_icmp_proof : fold_and_zext_icmp_before ⊑ fold_and_zext_icmp_after := by
  unfold fold_and_zext_icmp_before fold_and_zext_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN fold_and_zext_icmp
  apply fold_and_zext_icmp_thm
  ---END fold_and_zext_icmp



def fold_or_zext_icmp_before := [llvm|
{
^0(%arg94 : i64, %arg95 : i64, %arg96 : i64):
  %0 = llvm.icmp "sgt" %arg94, %arg95 : i64
  %1 = llvm.zext %0 : i1 to i8
  %2 = llvm.icmp "slt" %arg94, %arg96 : i64
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def fold_or_zext_icmp_after := [llvm|
{
^0(%arg94 : i64, %arg95 : i64, %arg96 : i64):
  %0 = llvm.icmp "sgt" %arg94, %arg95 : i64
  %1 = llvm.icmp "slt" %arg94, %arg96 : i64
  %2 = llvm.or %0, %1 : i1
  %3 = llvm.zext %2 : i1 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_or_zext_icmp_proof : fold_or_zext_icmp_before ⊑ fold_or_zext_icmp_after := by
  unfold fold_or_zext_icmp_before fold_or_zext_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN fold_or_zext_icmp
  apply fold_or_zext_icmp_thm
  ---END fold_or_zext_icmp



def fold_xor_zext_icmp_before := [llvm|
{
^0(%arg91 : i64, %arg92 : i64, %arg93 : i64):
  %0 = llvm.icmp "sgt" %arg91, %arg92 : i64
  %1 = llvm.zext %0 : i1 to i8
  %2 = llvm.icmp "slt" %arg91, %arg93 : i64
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.xor %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def fold_xor_zext_icmp_after := [llvm|
{
^0(%arg91 : i64, %arg92 : i64, %arg93 : i64):
  %0 = llvm.icmp "sgt" %arg91, %arg92 : i64
  %1 = llvm.icmp "slt" %arg91, %arg93 : i64
  %2 = llvm.xor %0, %1 : i1
  %3 = llvm.zext %2 : i1 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_xor_zext_icmp_proof : fold_xor_zext_icmp_before ⊑ fold_xor_zext_icmp_after := by
  unfold fold_xor_zext_icmp_before fold_xor_zext_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN fold_xor_zext_icmp
  apply fold_xor_zext_icmp_thm
  ---END fold_xor_zext_icmp



def fold_nested_logic_zext_icmp_before := [llvm|
{
^0(%arg87 : i64, %arg88 : i64, %arg89 : i64, %arg90 : i64):
  %0 = llvm.icmp "sgt" %arg87, %arg88 : i64
  %1 = llvm.zext %0 : i1 to i8
  %2 = llvm.icmp "slt" %arg87, %arg89 : i64
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.and %1, %3 : i8
  %5 = llvm.icmp "eq" %arg87, %arg90 : i64
  %6 = llvm.zext %5 : i1 to i8
  %7 = llvm.or %4, %6 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def fold_nested_logic_zext_icmp_after := [llvm|
{
^0(%arg87 : i64, %arg88 : i64, %arg89 : i64, %arg90 : i64):
  %0 = llvm.icmp "sgt" %arg87, %arg88 : i64
  %1 = llvm.icmp "slt" %arg87, %arg89 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg87, %arg90 : i64
  %4 = llvm.or %2, %3 : i1
  %5 = llvm.zext %4 : i1 to i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_nested_logic_zext_icmp_proof : fold_nested_logic_zext_icmp_before ⊑ fold_nested_logic_zext_icmp_after := by
  unfold fold_nested_logic_zext_icmp_before fold_nested_logic_zext_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN fold_nested_logic_zext_icmp
  apply fold_nested_logic_zext_icmp_thm
  ---END fold_nested_logic_zext_icmp



def sext_zext_apint1_before := [llvm|
{
^0(%arg86 : i77):
  %0 = llvm.zext %arg86 : i77 to i533
  %1 = llvm.sext %0 : i533 to i1024
  "llvm.return"(%1) : (i1024) -> ()
}
]
def sext_zext_apint1_after := [llvm|
{
^0(%arg86 : i77):
  %0 = llvm.zext %arg86 : i77 to i1024
  "llvm.return"(%0) : (i1024) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_apint1_proof : sext_zext_apint1_before ⊑ sext_zext_apint1_after := by
  unfold sext_zext_apint1_before sext_zext_apint1_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_apint1
  apply sext_zext_apint1_thm
  ---END sext_zext_apint1



def sext_zext_apint2_before := [llvm|
{
^0(%arg85 : i11):
  %0 = llvm.zext %arg85 : i11 to i39
  %1 = llvm.sext %0 : i39 to i47
  "llvm.return"(%1) : (i47) -> ()
}
]
def sext_zext_apint2_after := [llvm|
{
^0(%arg85 : i11):
  %0 = llvm.zext %arg85 : i11 to i47
  "llvm.return"(%0) : (i47) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_apint2_proof : sext_zext_apint2_before ⊑ sext_zext_apint2_after := by
  unfold sext_zext_apint2_before sext_zext_apint2_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_apint2
  apply sext_zext_apint2_thm
  ---END sext_zext_apint2



def masked_bit_set_before := [llvm|
{
^0(%arg83 : i32, %arg84 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg84 : i32
  %3 = llvm.and %2, %arg83 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def masked_bit_set_after := [llvm|
{
^0(%arg83 : i32, %arg84 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.lshr %arg83, %arg84 : i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_bit_set_proof : masked_bit_set_before ⊑ masked_bit_set_after := by
  unfold masked_bit_set_before masked_bit_set_after
  simp_alive_peephole
  intros
  ---BEGIN masked_bit_set
  apply masked_bit_set_thm
  ---END masked_bit_set



def masked_bit_clear_commute_before := [llvm|
{
^0(%arg77 : i32, %arg78 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.srem %0, %arg77 : i32
  %4 = llvm.shl %1, %arg78 : i32
  %5 = llvm.and %3, %4 : i32
  %6 = llvm.icmp "eq" %5, %2 : i32
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def masked_bit_clear_commute_after := [llvm|
{
^0(%arg77 : i32, %arg78 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.srem %0, %arg77 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.lshr %4, %arg78 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_bit_clear_commute_proof : masked_bit_clear_commute_before ⊑ masked_bit_clear_commute_after := by
  unfold masked_bit_clear_commute_before masked_bit_clear_commute_after
  simp_alive_peephole
  intros
  ---BEGIN masked_bit_clear_commute
  apply masked_bit_clear_commute_thm
  ---END masked_bit_clear_commute



def div_bit_set_before := [llvm|
{
^0(%arg61 : i32, %arg62 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg62 : i32
  %3 = llvm.sdiv %2, %arg61 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def div_bit_set_after := [llvm|
{
^0(%arg61 : i32, %arg62 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg62 overflow<nuw> : i32
  %3 = llvm.sdiv %2, %arg61 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem div_bit_set_proof : div_bit_set_before ⊑ div_bit_set_after := by
  unfold div_bit_set_before div_bit_set_after
  simp_alive_peephole
  intros
  ---BEGIN div_bit_set
  apply div_bit_set_thm
  ---END div_bit_set



def masked_bit_set_nonzero_cmp_before := [llvm|
{
^0(%arg59 : i32, %arg60 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg60 : i32
  %2 = llvm.and %1, %arg59 : i32
  %3 = llvm.icmp "ne" %2, %0 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def masked_bit_set_nonzero_cmp_after := [llvm|
{
^0(%arg59 : i32, %arg60 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg60 overflow<nuw> : i32
  %2 = llvm.and %1, %arg59 : i32
  %3 = llvm.icmp "ne" %2, %0 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_bit_set_nonzero_cmp_proof : masked_bit_set_nonzero_cmp_before ⊑ masked_bit_set_nonzero_cmp_after := by
  unfold masked_bit_set_nonzero_cmp_before masked_bit_set_nonzero_cmp_after
  simp_alive_peephole
  intros
  ---BEGIN masked_bit_set_nonzero_cmp
  apply masked_bit_set_nonzero_cmp_thm
  ---END masked_bit_set_nonzero_cmp



def masked_bit_wrong_pred_before := [llvm|
{
^0(%arg57 : i32, %arg58 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg58 : i32
  %3 = llvm.and %2, %arg57 : i32
  %4 = llvm.icmp "sgt" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def masked_bit_wrong_pred_after := [llvm|
{
^0(%arg57 : i32, %arg58 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg58 overflow<nuw> : i32
  %3 = llvm.and %2, %arg57 : i32
  %4 = llvm.icmp "sgt" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_bit_wrong_pred_proof : masked_bit_wrong_pred_before ⊑ masked_bit_wrong_pred_after := by
  unfold masked_bit_wrong_pred_before masked_bit_wrong_pred_after
  simp_alive_peephole
  intros
  ---BEGIN masked_bit_wrong_pred
  apply masked_bit_wrong_pred_thm
  ---END masked_bit_wrong_pred



def zext_or_masked_bit_test_before := [llvm|
{
^0(%arg54 : i32, %arg55 : i32, %arg56 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg55 : i32
  %3 = llvm.and %2, %arg54 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.icmp "eq" %arg56, %arg55 : i32
  %6 = llvm.or %4, %5 : i1
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def zext_or_masked_bit_test_after := [llvm|
{
^0(%arg54 : i32, %arg55 : i32, %arg56 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg55 overflow<nuw> : i32
  %3 = llvm.and %2, %arg54 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.icmp "eq" %arg56, %arg55 : i32
  %6 = llvm.or %4, %5 : i1
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_or_masked_bit_test_proof : zext_or_masked_bit_test_before ⊑ zext_or_masked_bit_test_after := by
  unfold zext_or_masked_bit_test_before zext_or_masked_bit_test_after
  simp_alive_peephole
  intros
  ---BEGIN zext_or_masked_bit_test
  apply zext_or_masked_bit_test_thm
  ---END zext_or_masked_bit_test



def zext_masked_bit_zero_to_smaller_bitwidth_before := [llvm|
{
^0(%arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg50 : i32
  %3 = llvm.and %2, %arg49 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def zext_masked_bit_zero_to_smaller_bitwidth_after := [llvm|
{
^0(%arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(1 : i16) : i16
  %2 = llvm.xor %arg49, %0 : i32
  %3 = llvm.lshr %2, %arg50 : i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.and %4, %1 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_masked_bit_zero_to_smaller_bitwidth_proof : zext_masked_bit_zero_to_smaller_bitwidth_before ⊑ zext_masked_bit_zero_to_smaller_bitwidth_after := by
  unfold zext_masked_bit_zero_to_smaller_bitwidth_before zext_masked_bit_zero_to_smaller_bitwidth_after
  simp_alive_peephole
  intros
  ---BEGIN zext_masked_bit_zero_to_smaller_bitwidth
  apply zext_masked_bit_zero_to_smaller_bitwidth_thm
  ---END zext_masked_bit_zero_to_smaller_bitwidth



def zext_masked_bit_nonzero_to_smaller_bitwidth_before := [llvm|
{
^0(%arg43 : i32, %arg44 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg44 : i32
  %3 = llvm.and %2, %arg43 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def zext_masked_bit_nonzero_to_smaller_bitwidth_after := [llvm|
{
^0(%arg43 : i32, %arg44 : i32):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.lshr %arg43, %arg44 : i32
  %2 = llvm.trunc %1 : i32 to i16
  %3 = llvm.and %2, %0 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_masked_bit_nonzero_to_smaller_bitwidth_proof : zext_masked_bit_nonzero_to_smaller_bitwidth_before ⊑ zext_masked_bit_nonzero_to_smaller_bitwidth_after := by
  unfold zext_masked_bit_nonzero_to_smaller_bitwidth_before zext_masked_bit_nonzero_to_smaller_bitwidth_after
  simp_alive_peephole
  intros
  ---BEGIN zext_masked_bit_nonzero_to_smaller_bitwidth
  apply zext_masked_bit_nonzero_to_smaller_bitwidth_thm
  ---END zext_masked_bit_nonzero_to_smaller_bitwidth



def zext_masked_bit_zero_to_larger_bitwidth_before := [llvm|
{
^0(%arg39 : i32, %arg40 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg40 : i32
  %3 = llvm.and %2, %arg39 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def zext_masked_bit_zero_to_larger_bitwidth_after := [llvm|
{
^0(%arg39 : i32, %arg40 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.xor %arg39, %0 : i32
  %3 = llvm.lshr %2, %arg40 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.zext nneg %4 : i32 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_masked_bit_zero_to_larger_bitwidth_proof : zext_masked_bit_zero_to_larger_bitwidth_before ⊑ zext_masked_bit_zero_to_larger_bitwidth_after := by
  unfold zext_masked_bit_zero_to_larger_bitwidth_before zext_masked_bit_zero_to_larger_bitwidth_after
  simp_alive_peephole
  intros
  ---BEGIN zext_masked_bit_zero_to_larger_bitwidth
  apply zext_masked_bit_zero_to_larger_bitwidth_thm
  ---END zext_masked_bit_zero_to_larger_bitwidth



def zext_nneg_flag_drop_before := [llvm|
{
^0(%arg7 : i8, %arg8 : i16):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(128 : i16) : i16
  %2 = llvm.and %arg7, %0 : i8
  %3 = llvm.zext nneg %2 : i8 to i16
  %4 = llvm.or %3, %arg8 : i16
  %5 = llvm.or %4, %1 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def zext_nneg_flag_drop_after := [llvm|
{
^0(%arg7 : i8, %arg8 : i16):
  %0 = llvm.mlir.constant(128 : i16) : i16
  %1 = llvm.zext %arg7 : i8 to i16
  %2 = llvm.or %arg8, %1 : i16
  %3 = llvm.or %2, %0 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_flag_drop_proof : zext_nneg_flag_drop_before ⊑ zext_nneg_flag_drop_after := by
  unfold zext_nneg_flag_drop_before zext_nneg_flag_drop_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_flag_drop
  apply zext_nneg_flag_drop_thm
  ---END zext_nneg_flag_drop



def zext_nneg_redundant_and_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(127 : i32) : i32
  %1 = llvm.zext nneg %arg6 : i8 to i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def zext_nneg_redundant_and_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.zext nneg %arg6 : i8 to i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_redundant_and_proof : zext_nneg_redundant_and_before ⊑ zext_nneg_redundant_and_after := by
  unfold zext_nneg_redundant_and_before zext_nneg_redundant_and_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_redundant_and
  apply zext_nneg_redundant_and_thm
  ---END zext_nneg_redundant_and



def zext_nneg_signbit_extract_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.zext nneg %arg4 : i32 to i64
  %2 = llvm.lshr %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def zext_nneg_signbit_extract_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(0) : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_signbit_extract_proof : zext_nneg_signbit_extract_before ⊑ zext_nneg_signbit_extract_after := by
  unfold zext_nneg_signbit_extract_before zext_nneg_signbit_extract_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_signbit_extract
  apply zext_nneg_signbit_extract_thm
  ---END zext_nneg_signbit_extract



def zext_nneg_i1_before := [llvm|
{
^0(%arg2 : i1):
  %0 = llvm.zext nneg %arg2 : i1 to i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def zext_nneg_i1_after := [llvm|
{
^0(%arg2 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_i1_proof : zext_nneg_i1_before ⊑ zext_nneg_i1_after := by
  unfold zext_nneg_i1_before zext_nneg_i1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_i1
  apply zext_nneg_i1_thm
  ---END zext_nneg_i1


