
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
section gshifthadd_statements

def shl_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg78 : i16):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.zext %arg78 : i16 to i32
  %3 = llvm.add %2, %0 : i32
  %4 = llvm.shl %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shl_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg78 : i16):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.zext nneg %arg78 : i16 to i32
  %2 = llvm.shl %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_C1_add_A_C2_i32_proof : shl_C1_add_A_C2_i32_before ⊑ shl_C1_add_A_C2_i32_after := by
  unfold shl_C1_add_A_C2_i32_before shl_C1_add_A_C2_i32_after
  simp_alive_peephole
  intros
  ---BEGIN shl_C1_add_A_C2_i32
  all_goals (try extract_goal ; sorry)
  ---END shl_C1_add_A_C2_i32



def ashr_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg77 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.mlir.constant(6 : i32) : i32
  %3 = llvm.and %arg77, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.ashr %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def ashr_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg77 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_C1_add_A_C2_i32_proof : ashr_C1_add_A_C2_i32_before ⊑ ashr_C1_add_A_C2_i32_after := by
  unfold ashr_C1_add_A_C2_i32_before ashr_C1_add_A_C2_i32_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_C1_add_A_C2_i32
  all_goals (try extract_goal ; sorry)
  ---END ashr_C1_add_A_C2_i32



def lshr_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg76 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.mlir.constant(6 : i32) : i32
  %3 = llvm.and %arg76, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.shl %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lshr_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg76 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(192 : i32) : i32
  %2 = llvm.and %arg76, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_C1_add_A_C2_i32_proof : lshr_C1_add_A_C2_i32_before ⊑ lshr_C1_add_A_C2_i32_after := by
  unfold lshr_C1_add_A_C2_i32_before lshr_C1_add_A_C2_i32_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_C1_add_A_C2_i32
  all_goals (try extract_goal ; sorry)
  ---END lshr_C1_add_A_C2_i32



def shl_add_nuw_before := [llvm|
{
^0(%arg69 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.add %arg69, %0 overflow<nuw> : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_add_nuw_after := [llvm|
{
^0(%arg69 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.shl %0, %arg69 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_nuw_proof : shl_add_nuw_before ⊑ shl_add_nuw_after := by
  unfold shl_add_nuw_before shl_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_add_nuw



def shl_nuw_add_nuw_before := [llvm|
{
^0(%arg65 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.add %arg65, %0 overflow<nuw> : i32
  %2 = llvm.shl %0, %1 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_nuw_add_nuw_after := [llvm|
{
^0(%arg65 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %0, %arg65 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nuw_add_nuw_proof : shl_nuw_add_nuw_before ⊑ shl_nuw_add_nuw_after := by
  unfold shl_nuw_add_nuw_before shl_nuw_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nuw_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_nuw_add_nuw



def shl_nsw_add_nuw_before := [llvm|
{
^0(%arg64 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.add %arg64, %0 overflow<nuw> : i32
  %3 = llvm.shl %1, %2 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_add_nuw_after := [llvm|
{
^0(%arg64 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.shl %0, %arg64 overflow<nsw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_add_nuw_proof : shl_nsw_add_nuw_before ⊑ shl_nsw_add_nuw_after := by
  unfold shl_nsw_add_nuw_before shl_nsw_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_add_nuw



def lshr_exact_add_nuw_before := [llvm|
{
^0(%arg63 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.add %arg63, %0 overflow<nuw> : i32
  %3 = llvm.lshr exact %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_exact_add_nuw_after := [llvm|
{
^0(%arg63 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.lshr exact %0, %arg63 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_exact_add_nuw_proof : lshr_exact_add_nuw_before ⊑ lshr_exact_add_nuw_after := by
  unfold lshr_exact_add_nuw_before lshr_exact_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_exact_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END lshr_exact_add_nuw



def ashr_exact_add_nuw_before := [llvm|
{
^0(%arg62 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-4 : i32) : i32
  %2 = llvm.add %arg62, %0 overflow<nuw> : i32
  %3 = llvm.ashr exact %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_exact_add_nuw_after := [llvm|
{
^0(%arg62 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.ashr exact %0, %arg62 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_exact_add_nuw_proof : ashr_exact_add_nuw_before ⊑ ashr_exact_add_nuw_after := by
  unfold ashr_exact_add_nuw_before ashr_exact_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_exact_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END ashr_exact_add_nuw



def lshr_exact_add_negative_shift_positive_before := [llvm|
{
^0(%arg56 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.add %arg56, %0 : i32
  %3 = llvm.lshr exact %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_exact_add_negative_shift_positive_after := [llvm|
{
^0(%arg56 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.lshr exact %0, %arg56 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_exact_add_negative_shift_positive_proof : lshr_exact_add_negative_shift_positive_before ⊑ lshr_exact_add_negative_shift_positive_after := by
  unfold lshr_exact_add_negative_shift_positive_before lshr_exact_add_negative_shift_positive_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_exact_add_negative_shift_positive
  all_goals (try extract_goal ; sorry)
  ---END lshr_exact_add_negative_shift_positive



def ashr_exact_add_negative_shift_negative_before := [llvm|
{
^0(%arg49 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.add %arg49, %0 : i32
  %3 = llvm.ashr exact %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_exact_add_negative_shift_negative_after := [llvm|
{
^0(%arg49 : i32):
  %0 = llvm.mlir.constant(-4 : i32) : i32
  %1 = llvm.ashr exact %0, %arg49 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_exact_add_negative_shift_negative_proof : ashr_exact_add_negative_shift_negative_before ⊑ ashr_exact_add_negative_shift_negative_after := by
  unfold ashr_exact_add_negative_shift_negative_before ashr_exact_add_negative_shift_negative_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_exact_add_negative_shift_negative
  all_goals (try extract_goal ; sorry)
  ---END ashr_exact_add_negative_shift_negative



def shl_nsw_add_negative_before := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.add %arg45, %0 : i32
  %3 = llvm.shl %1, %2 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_add_negative_after := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg45 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_add_negative_proof : shl_nsw_add_negative_before ⊑ shl_nsw_add_negative_after := by
  unfold shl_nsw_add_negative_before shl_nsw_add_negative_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_add_negative
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_add_negative



def shl_nsw_add_negative_invalid_constant3_before := [llvm|
{
^0(%arg39 : i4):
  %0 = llvm.mlir.constant(-8 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.add %arg39, %0 : i4
  %3 = llvm.shl %1, %2 overflow<nsw> : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def shl_nsw_add_negative_invalid_constant3_after := [llvm|
{
^0(%arg39 : i4):
  %0 = llvm.mlir.constant(-8 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.xor %arg39, %0 : i4
  %3 = llvm.shl %1, %2 overflow<nsw> : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_add_negative_invalid_constant3_proof : shl_nsw_add_negative_invalid_constant3_before ⊑ shl_nsw_add_negative_invalid_constant3_after := by
  unfold shl_nsw_add_negative_invalid_constant3_before shl_nsw_add_negative_invalid_constant3_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_add_negative_invalid_constant3
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_add_negative_invalid_constant3



def lshr_2_add_zext_basic_before := [llvm|
{
^0(%arg37 : i1, %arg38 : i1):
  %0 = llvm.mlir.constant(1 : i2) : i2
  %1 = llvm.zext %arg37 : i1 to i2
  %2 = llvm.zext %arg38 : i1 to i2
  %3 = llvm.add %1, %2 : i2
  %4 = llvm.lshr %3, %0 : i2
  "llvm.return"(%4) : (i2) -> ()
}
]
def lshr_2_add_zext_basic_after := [llvm|
{
^0(%arg37 : i1, %arg38 : i1):
  %0 = llvm.and %arg37, %arg38 : i1
  %1 = llvm.zext %0 : i1 to i2
  "llvm.return"(%1) : (i2) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_2_add_zext_basic_proof : lshr_2_add_zext_basic_before ⊑ lshr_2_add_zext_basic_after := by
  unfold lshr_2_add_zext_basic_before lshr_2_add_zext_basic_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_2_add_zext_basic
  all_goals (try extract_goal ; sorry)
  ---END lshr_2_add_zext_basic



def ashr_2_add_zext_basic_before := [llvm|
{
^0(%arg35 : i1, %arg36 : i1):
  %0 = llvm.mlir.constant(1 : i2) : i2
  %1 = llvm.zext %arg35 : i1 to i2
  %2 = llvm.zext %arg36 : i1 to i2
  %3 = llvm.add %1, %2 : i2
  %4 = llvm.ashr %3, %0 : i2
  "llvm.return"(%4) : (i2) -> ()
}
]
def ashr_2_add_zext_basic_after := [llvm|
{
^0(%arg35 : i1, %arg36 : i1):
  %0 = llvm.mlir.constant(1 : i2) : i2
  %1 = llvm.zext %arg35 : i1 to i2
  %2 = llvm.zext %arg36 : i1 to i2
  %3 = llvm.add %1, %2 overflow<nuw> : i2
  %4 = llvm.ashr %3, %0 : i2
  "llvm.return"(%4) : (i2) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_2_add_zext_basic_proof : ashr_2_add_zext_basic_before ⊑ ashr_2_add_zext_basic_after := by
  unfold ashr_2_add_zext_basic_before ashr_2_add_zext_basic_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_2_add_zext_basic
  all_goals (try extract_goal ; sorry)
  ---END ashr_2_add_zext_basic



def lshr_16_add_zext_basic_before := [llvm|
{
^0(%arg33 : i16, %arg34 : i16):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.zext %arg33 : i16 to i32
  %2 = llvm.zext %arg34 : i16 to i32
  %3 = llvm.add %1, %2 : i32
  %4 = llvm.lshr %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def lshr_16_add_zext_basic_after := [llvm|
{
^0(%arg33 : i16, %arg34 : i16):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.xor %arg33, %0 : i16
  %2 = llvm.icmp "ugt" %arg34, %1 : i16
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_16_add_zext_basic_proof : lshr_16_add_zext_basic_before ⊑ lshr_16_add_zext_basic_after := by
  unfold lshr_16_add_zext_basic_before lshr_16_add_zext_basic_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_16_add_zext_basic
  all_goals (try extract_goal ; sorry)
  ---END lshr_16_add_zext_basic



def lshr_16_add_zext_basic_multiuse_before := [llvm|
{
^0(%arg31 : i16, %arg32 : i16):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.zext %arg31 : i16 to i32
  %2 = llvm.zext %arg32 : i16 to i32
  %3 = llvm.add %1, %2 : i32
  %4 = llvm.lshr %3, %0 : i32
  %5 = llvm.or %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lshr_16_add_zext_basic_multiuse_after := [llvm|
{
^0(%arg31 : i16, %arg32 : i16):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.zext %arg31 : i16 to i32
  %2 = llvm.zext %arg32 : i16 to i32
  %3 = llvm.add %1, %2 overflow<nsw,nuw> : i32
  %4 = llvm.lshr %3, %0 : i32
  %5 = llvm.or %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_16_add_zext_basic_multiuse_proof : lshr_16_add_zext_basic_multiuse_before ⊑ lshr_16_add_zext_basic_multiuse_after := by
  unfold lshr_16_add_zext_basic_multiuse_before lshr_16_add_zext_basic_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_16_add_zext_basic_multiuse
  all_goals (try extract_goal ; sorry)
  ---END lshr_16_add_zext_basic_multiuse



def lshr_16_add_known_16_leading_zeroes_before := [llvm|
{
^0(%arg29 : i32, %arg30 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.and %arg29, %0 : i32
  %3 = llvm.and %arg30, %0 : i32
  %4 = llvm.add %2, %3 : i32
  %5 = llvm.lshr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lshr_16_add_known_16_leading_zeroes_after := [llvm|
{
^0(%arg29 : i32, %arg30 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.and %arg29, %0 : i32
  %3 = llvm.and %arg30, %0 : i32
  %4 = llvm.add %2, %3 overflow<nsw,nuw> : i32
  %5 = llvm.lshr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_16_add_known_16_leading_zeroes_proof : lshr_16_add_known_16_leading_zeroes_before ⊑ lshr_16_add_known_16_leading_zeroes_after := by
  unfold lshr_16_add_known_16_leading_zeroes_before lshr_16_add_known_16_leading_zeroes_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_16_add_known_16_leading_zeroes
  all_goals (try extract_goal ; sorry)
  ---END lshr_16_add_known_16_leading_zeroes



def lshr_16_add_not_known_16_leading_zeroes_before := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = llvm.mlir.constant(131071 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.mlir.constant(16 : i32) : i32
  %3 = llvm.and %arg27, %0 : i32
  %4 = llvm.and %arg28, %1 : i32
  %5 = llvm.add %3, %4 : i32
  %6 = llvm.lshr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def lshr_16_add_not_known_16_leading_zeroes_after := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = llvm.mlir.constant(131071 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.mlir.constant(16 : i32) : i32
  %3 = llvm.and %arg27, %0 : i32
  %4 = llvm.and %arg28, %1 : i32
  %5 = llvm.add %3, %4 overflow<nsw,nuw> : i32
  %6 = llvm.lshr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_16_add_not_known_16_leading_zeroes_proof : lshr_16_add_not_known_16_leading_zeroes_before ⊑ lshr_16_add_not_known_16_leading_zeroes_after := by
  unfold lshr_16_add_not_known_16_leading_zeroes_before lshr_16_add_not_known_16_leading_zeroes_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_16_add_not_known_16_leading_zeroes
  all_goals (try extract_goal ; sorry)
  ---END lshr_16_add_not_known_16_leading_zeroes



def lshr_32_add_zext_basic_before := [llvm|
{
^0(%arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.zext %arg25 : i32 to i64
  %2 = llvm.zext %arg26 : i32 to i64
  %3 = llvm.add %1, %2 : i64
  %4 = llvm.lshr %3, %0 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def lshr_32_add_zext_basic_after := [llvm|
{
^0(%arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg25, %0 : i32
  %2 = llvm.icmp "ugt" %arg26, %1 : i32
  %3 = llvm.zext %2 : i1 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_32_add_zext_basic_proof : lshr_32_add_zext_basic_before ⊑ lshr_32_add_zext_basic_after := by
  unfold lshr_32_add_zext_basic_before lshr_32_add_zext_basic_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_32_add_zext_basic
  all_goals (try extract_goal ; sorry)
  ---END lshr_32_add_zext_basic



def lshr_32_add_zext_basic_multiuse_before := [llvm|
{
^0(%arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.zext %arg23 : i32 to i64
  %2 = llvm.zext %arg24 : i32 to i64
  %3 = llvm.add %1, %2 : i64
  %4 = llvm.lshr %3, %0 : i64
  %5 = llvm.or %4, %2 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def lshr_32_add_zext_basic_multiuse_after := [llvm|
{
^0(%arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.zext %arg23 : i32 to i64
  %2 = llvm.zext %arg24 : i32 to i64
  %3 = llvm.add %1, %2 overflow<nsw,nuw> : i64
  %4 = llvm.lshr %3, %0 : i64
  %5 = llvm.or %4, %2 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_32_add_zext_basic_multiuse_proof : lshr_32_add_zext_basic_multiuse_before ⊑ lshr_32_add_zext_basic_multiuse_after := by
  unfold lshr_32_add_zext_basic_multiuse_before lshr_32_add_zext_basic_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_32_add_zext_basic_multiuse
  all_goals (try extract_goal ; sorry)
  ---END lshr_32_add_zext_basic_multiuse



def lshr_31_i32_add_zext_basic_before := [llvm|
{
^0(%arg21 : i32, %arg22 : i32):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.zext %arg21 : i32 to i64
  %2 = llvm.zext %arg22 : i32 to i64
  %3 = llvm.add %1, %2 : i64
  %4 = llvm.lshr %3, %0 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def lshr_31_i32_add_zext_basic_after := [llvm|
{
^0(%arg21 : i32, %arg22 : i32):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.zext %arg21 : i32 to i64
  %2 = llvm.zext %arg22 : i32 to i64
  %3 = llvm.add %1, %2 overflow<nsw,nuw> : i64
  %4 = llvm.lshr %3, %0 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_31_i32_add_zext_basic_proof : lshr_31_i32_add_zext_basic_before ⊑ lshr_31_i32_add_zext_basic_after := by
  unfold lshr_31_i32_add_zext_basic_before lshr_31_i32_add_zext_basic_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_31_i32_add_zext_basic
  all_goals (try extract_goal ; sorry)
  ---END lshr_31_i32_add_zext_basic



def lshr_33_i32_add_zext_basic_before := [llvm|
{
^0(%arg19 : i32, %arg20 : i32):
  %0 = llvm.mlir.constant(33) : i64
  %1 = llvm.zext %arg19 : i32 to i64
  %2 = llvm.zext %arg20 : i32 to i64
  %3 = llvm.add %1, %2 : i64
  %4 = llvm.lshr %3, %0 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def lshr_33_i32_add_zext_basic_after := [llvm|
{
^0(%arg19 : i32, %arg20 : i32):
  %0 = llvm.mlir.constant(0) : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_33_i32_add_zext_basic_proof : lshr_33_i32_add_zext_basic_before ⊑ lshr_33_i32_add_zext_basic_after := by
  unfold lshr_33_i32_add_zext_basic_before lshr_33_i32_add_zext_basic_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_33_i32_add_zext_basic
  all_goals (try extract_goal ; sorry)
  ---END lshr_33_i32_add_zext_basic



def lshr_16_to_64_add_zext_basic_before := [llvm|
{
^0(%arg17 : i16, %arg18 : i16):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.zext %arg17 : i16 to i64
  %2 = llvm.zext %arg18 : i16 to i64
  %3 = llvm.add %1, %2 : i64
  %4 = llvm.lshr %3, %0 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def lshr_16_to_64_add_zext_basic_after := [llvm|
{
^0(%arg17 : i16, %arg18 : i16):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.xor %arg17, %0 : i16
  %2 = llvm.icmp "ugt" %arg18, %1 : i16
  %3 = llvm.zext %2 : i1 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_16_to_64_add_zext_basic_proof : lshr_16_to_64_add_zext_basic_before ⊑ lshr_16_to_64_add_zext_basic_after := by
  unfold lshr_16_to_64_add_zext_basic_before lshr_16_to_64_add_zext_basic_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_16_to_64_add_zext_basic
  all_goals (try extract_goal ; sorry)
  ---END lshr_16_to_64_add_zext_basic



def lshr_32_add_known_32_leading_zeroes_before := [llvm|
{
^0(%arg15 : i64, %arg16 : i64):
  %0 = llvm.mlir.constant(4294967295) : i64
  %1 = llvm.mlir.constant(32) : i64
  %2 = llvm.and %arg15, %0 : i64
  %3 = llvm.and %arg16, %0 : i64
  %4 = llvm.add %2, %3 : i64
  %5 = llvm.lshr %4, %1 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def lshr_32_add_known_32_leading_zeroes_after := [llvm|
{
^0(%arg15 : i64, %arg16 : i64):
  %0 = llvm.mlir.constant(4294967295) : i64
  %1 = llvm.mlir.constant(32) : i64
  %2 = llvm.and %arg15, %0 : i64
  %3 = llvm.and %arg16, %0 : i64
  %4 = llvm.add %2, %3 overflow<nsw,nuw> : i64
  %5 = llvm.lshr %4, %1 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_32_add_known_32_leading_zeroes_proof : lshr_32_add_known_32_leading_zeroes_before ⊑ lshr_32_add_known_32_leading_zeroes_after := by
  unfold lshr_32_add_known_32_leading_zeroes_before lshr_32_add_known_32_leading_zeroes_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_32_add_known_32_leading_zeroes
  all_goals (try extract_goal ; sorry)
  ---END lshr_32_add_known_32_leading_zeroes



def lshr_32_add_not_known_32_leading_zeroes_before := [llvm|
{
^0(%arg13 : i64, %arg14 : i64):
  %0 = llvm.mlir.constant(8589934591) : i64
  %1 = llvm.mlir.constant(4294967295) : i64
  %2 = llvm.mlir.constant(32) : i64
  %3 = llvm.and %arg13, %0 : i64
  %4 = llvm.and %arg14, %1 : i64
  %5 = llvm.add %3, %4 : i64
  %6 = llvm.lshr %5, %2 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def lshr_32_add_not_known_32_leading_zeroes_after := [llvm|
{
^0(%arg13 : i64, %arg14 : i64):
  %0 = llvm.mlir.constant(8589934591) : i64
  %1 = llvm.mlir.constant(4294967295) : i64
  %2 = llvm.mlir.constant(32) : i64
  %3 = llvm.and %arg13, %0 : i64
  %4 = llvm.and %arg14, %1 : i64
  %5 = llvm.add %3, %4 overflow<nsw,nuw> : i64
  %6 = llvm.lshr %5, %2 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_32_add_not_known_32_leading_zeroes_proof : lshr_32_add_not_known_32_leading_zeroes_before ⊑ lshr_32_add_not_known_32_leading_zeroes_after := by
  unfold lshr_32_add_not_known_32_leading_zeroes_before lshr_32_add_not_known_32_leading_zeroes_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_32_add_not_known_32_leading_zeroes
  all_goals (try extract_goal ; sorry)
  ---END lshr_32_add_not_known_32_leading_zeroes



def ashr_16_add_zext_basic_before := [llvm|
{
^0(%arg11 : i16, %arg12 : i16):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.zext %arg11 : i16 to i32
  %2 = llvm.zext %arg12 : i16 to i32
  %3 = llvm.add %1, %2 : i32
  %4 = llvm.lshr %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_16_add_zext_basic_after := [llvm|
{
^0(%arg11 : i16, %arg12 : i16):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.xor %arg11, %0 : i16
  %2 = llvm.icmp "ugt" %arg12, %1 : i16
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_16_add_zext_basic_proof : ashr_16_add_zext_basic_before ⊑ ashr_16_add_zext_basic_after := by
  unfold ashr_16_add_zext_basic_before ashr_16_add_zext_basic_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_16_add_zext_basic
  all_goals (try extract_goal ; sorry)
  ---END ashr_16_add_zext_basic



def ashr_32_add_zext_basic_before := [llvm|
{
^0(%arg9 : i32, %arg10 : i32):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.zext %arg9 : i32 to i64
  %2 = llvm.zext %arg10 : i32 to i64
  %3 = llvm.add %1, %2 : i64
  %4 = llvm.ashr %3, %0 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def ashr_32_add_zext_basic_after := [llvm|
{
^0(%arg9 : i32, %arg10 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg9, %0 : i32
  %2 = llvm.icmp "ugt" %arg10, %1 : i32
  %3 = llvm.zext %2 : i1 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_32_add_zext_basic_proof : ashr_32_add_zext_basic_before ⊑ ashr_32_add_zext_basic_after := by
  unfold ashr_32_add_zext_basic_before ashr_32_add_zext_basic_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_32_add_zext_basic
  all_goals (try extract_goal ; sorry)
  ---END ashr_32_add_zext_basic



def ashr_16_to_64_add_zext_basic_before := [llvm|
{
^0(%arg7 : i16, %arg8 : i16):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.zext %arg7 : i16 to i64
  %2 = llvm.zext %arg8 : i16 to i64
  %3 = llvm.add %1, %2 : i64
  %4 = llvm.ashr %3, %0 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def ashr_16_to_64_add_zext_basic_after := [llvm|
{
^0(%arg7 : i16, %arg8 : i16):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.xor %arg7, %0 : i16
  %2 = llvm.icmp "ugt" %arg8, %1 : i16
  %3 = llvm.zext %2 : i1 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_16_to_64_add_zext_basic_proof : ashr_16_to_64_add_zext_basic_before ⊑ ashr_16_to_64_add_zext_basic_after := by
  unfold ashr_16_to_64_add_zext_basic_before ashr_16_to_64_add_zext_basic_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_16_to_64_add_zext_basic
  all_goals (try extract_goal ; sorry)
  ---END ashr_16_to_64_add_zext_basic



def lshr_32_add_zext_trunc_before := [llvm|
{
^0(%arg5 : i32, %arg6 : i32):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.zext %arg5 : i32 to i64
  %2 = llvm.zext %arg6 : i32 to i64
  %3 = llvm.add %1, %2 : i64
  %4 = llvm.trunc %3 : i64 to i32
  %5 = llvm.lshr %3, %0 : i64
  %6 = llvm.trunc %5 : i64 to i32
  %7 = llvm.add %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def lshr_32_add_zext_trunc_after := [llvm|
{
^0(%arg5 : i32, %arg6 : i32):
  %0 = llvm.add %arg5, %arg6 : i32
  %1 = llvm.icmp "ult" %0, %arg5 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.add %0, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_32_add_zext_trunc_proof : lshr_32_add_zext_trunc_before ⊑ lshr_32_add_zext_trunc_after := by
  unfold lshr_32_add_zext_trunc_before lshr_32_add_zext_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_32_add_zext_trunc
  all_goals (try extract_goal ; sorry)
  ---END lshr_32_add_zext_trunc



def shl_fold_or_disjoint_cnt_before := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.or disjoint %arg2, %0 : i8
  %3 = llvm.shl %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_fold_or_disjoint_cnt_after := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.shl %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_fold_or_disjoint_cnt_proof : shl_fold_or_disjoint_cnt_before ⊑ shl_fold_or_disjoint_cnt_after := by
  unfold shl_fold_or_disjoint_cnt_before shl_fold_or_disjoint_cnt_after
  simp_alive_peephole
  intros
  ---BEGIN shl_fold_or_disjoint_cnt
  all_goals (try extract_goal ; sorry)
  ---END shl_fold_or_disjoint_cnt


