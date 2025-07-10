import SSA.Projects.InstCombine.tests.proofs.gtrunchinseltpoison_proof
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
section gtrunchinseltpoison_statements

def test5_before := [llvm|
{
^0(%arg89 : i32):
  %0 = llvm.mlir.constant(16 : i128) : i128
  %1 = llvm.zext %arg89 : i32 to i128
  %2 = llvm.lshr %1, %0 : i128
  %3 = llvm.trunc %2 : i128 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg89 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.lshr %arg89, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  intros
  ---BEGIN test5
  apply test5_thm
  ---END test5



def test6_before := [llvm|
{
^0(%arg88 : i64):
  %0 = llvm.mlir.constant(32 : i128) : i128
  %1 = llvm.zext %arg88 : i64 to i128
  %2 = llvm.lshr %1, %0 : i128
  %3 = llvm.trunc %2 : i128 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg88 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.lshr %arg88, %0 : i64
  %2 = llvm.trunc %1 overflow<nuw> : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  intros
  ---BEGIN test6
  apply test6_thm
  ---END test6



def ashr_mul_sign_bits_before := [llvm|
{
^0(%arg86 : i8, %arg87 : i8):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.sext %arg86 : i8 to i32
  %2 = llvm.sext %arg87 : i8 to i32
  %3 = llvm.mul %1, %2 : i32
  %4 = llvm.ashr %3, %0 : i32
  %5 = llvm.trunc %4 : i32 to i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def ashr_mul_sign_bits_after := [llvm|
{
^0(%arg86 : i8, %arg87 : i8):
  %0 = llvm.mlir.constant(3 : i16) : i16
  %1 = llvm.sext %arg86 : i8 to i16
  %2 = llvm.sext %arg87 : i8 to i16
  %3 = llvm.mul %1, %2 overflow<nsw> : i16
  %4 = llvm.ashr %3, %0 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_mul_sign_bits_proof : ashr_mul_sign_bits_before ⊑ ashr_mul_sign_bits_after := by
  unfold ashr_mul_sign_bits_before ashr_mul_sign_bits_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_mul_sign_bits
  apply ashr_mul_sign_bits_thm
  ---END ashr_mul_sign_bits



def ashr_mul_before := [llvm|
{
^0(%arg84 : i8, %arg85 : i8):
  %0 = llvm.mlir.constant(8 : i20) : i20
  %1 = llvm.sext %arg84 : i8 to i20
  %2 = llvm.sext %arg85 : i8 to i20
  %3 = llvm.mul %1, %2 : i20
  %4 = llvm.ashr %3, %0 : i20
  %5 = llvm.trunc %4 : i20 to i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def ashr_mul_after := [llvm|
{
^0(%arg84 : i8, %arg85 : i8):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.sext %arg84 : i8 to i16
  %2 = llvm.sext %arg85 : i8 to i16
  %3 = llvm.mul %1, %2 overflow<nsw> : i16
  %4 = llvm.ashr %3, %0 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_mul_proof : ashr_mul_before ⊑ ashr_mul_after := by
  unfold ashr_mul_before ashr_mul_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_mul
  apply ashr_mul_thm
  ---END ashr_mul



def trunc_ashr_before := [llvm|
{
^0(%arg83 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i36) : i36
  %1 = llvm.mlir.constant(8 : i36) : i36
  %2 = llvm.zext %arg83 : i32 to i36
  %3 = llvm.or %2, %0 : i36
  %4 = llvm.ashr %3, %1 : i36
  %5 = llvm.trunc %4 : i36 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def trunc_ashr_after := [llvm|
{
^0(%arg83 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-8388608 : i32) : i32
  %2 = llvm.lshr %arg83, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_ashr_proof : trunc_ashr_before ⊑ trunc_ashr_after := by
  unfold trunc_ashr_before trunc_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_ashr
  apply trunc_ashr_thm
  ---END trunc_ashr



def test7_before := [llvm|
{
^0(%arg81 : i64):
  %0 = llvm.mlir.constant(32 : i128) : i128
  %1 = llvm.zext %arg81 : i64 to i128
  %2 = llvm.lshr %1, %0 : i128
  %3 = llvm.trunc %2 : i128 to i92
  "llvm.return"(%3) : (i92) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg81 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.lshr %arg81, %0 : i64
  %2 = llvm.zext nneg %1 : i64 to i92
  "llvm.return"(%2) : (i92) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  intros
  ---BEGIN test7
  apply test7_thm
  ---END test7



def test8_before := [llvm|
{
^0(%arg79 : i32, %arg80 : i32):
  %0 = llvm.mlir.constant(32 : i128) : i128
  %1 = llvm.zext %arg79 : i32 to i128
  %2 = llvm.zext %arg80 : i32 to i128
  %3 = llvm.shl %2, %0 : i128
  %4 = llvm.or %3, %1 : i128
  %5 = llvm.trunc %4 : i128 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg79 : i32, %arg80 : i32):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.zext %arg79 : i32 to i64
  %2 = llvm.zext %arg80 : i32 to i64
  %3 = llvm.shl %2, %0 overflow<nuw> : i64
  %4 = llvm.or disjoint %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  intros
  ---BEGIN test8
  apply test8_thm
  ---END test8



def test9_before := [llvm|
{
^0(%arg72 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.and %arg72, %0 : i32
  %2 = llvm.trunc %1 : i32 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg72 : i32):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.trunc %arg72 : i32 to i8
  %2 = llvm.and %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  intros
  ---BEGIN test9
  apply test9_thm
  ---END test9



def test11_before := [llvm|
{
^0(%arg69 : i32, %arg70 : i32):
  %0 = llvm.mlir.constant(31 : i128) : i128
  %1 = llvm.zext %arg69 : i32 to i128
  %2 = llvm.zext %arg70 : i32 to i128
  %3 = llvm.and %2, %0 : i128
  %4 = llvm.shl %1, %3 : i128
  %5 = llvm.trunc %4 : i128 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg69 : i32, %arg70 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.zext %arg69 : i32 to i64
  %2 = llvm.and %arg70, %0 : i32
  %3 = llvm.zext nneg %2 : i32 to i64
  %4 = llvm.shl %1, %3 overflow<nsw,nuw> : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  intros
  ---BEGIN test11
  apply test11_thm
  ---END test11



def test12_before := [llvm|
{
^0(%arg61 : i32, %arg62 : i32):
  %0 = llvm.mlir.constant(31 : i128) : i128
  %1 = llvm.zext %arg61 : i32 to i128
  %2 = llvm.zext %arg62 : i32 to i128
  %3 = llvm.and %2, %0 : i128
  %4 = llvm.lshr %1, %3 : i128
  %5 = llvm.trunc %4 : i128 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg61 : i32, %arg62 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.zext %arg61 : i32 to i64
  %2 = llvm.and %arg62, %0 : i32
  %3 = llvm.zext nneg %2 : i32 to i64
  %4 = llvm.lshr %1, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  intros
  ---BEGIN test12
  apply test12_thm
  ---END test12



def test13_before := [llvm|
{
^0(%arg53 : i32, %arg54 : i32):
  %0 = llvm.mlir.constant(31 : i128) : i128
  %1 = llvm.sext %arg53 : i32 to i128
  %2 = llvm.zext %arg54 : i32 to i128
  %3 = llvm.and %2, %0 : i128
  %4 = llvm.ashr %1, %3 : i128
  %5 = llvm.trunc %4 : i128 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg53 : i32, %arg54 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sext %arg53 : i32 to i64
  %2 = llvm.and %arg54, %0 : i32
  %3 = llvm.zext nneg %2 : i32 to i64
  %4 = llvm.ashr %1, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  intros
  ---BEGIN test13
  apply test13_thm
  ---END test13



def trunc_shl_31_i32_i64_before := [llvm|
{
^0(%arg43 : i64):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.shl %arg43, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_31_i32_i64_after := [llvm|
{
^0(%arg43 : i64):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.trunc %arg43 : i64 to i32
  %2 = llvm.shl %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_31_i32_i64_proof : trunc_shl_31_i32_i64_before ⊑ trunc_shl_31_i32_i64_after := by
  unfold trunc_shl_31_i32_i64_before trunc_shl_31_i32_i64_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_31_i32_i64
  apply trunc_shl_31_i32_i64_thm
  ---END trunc_shl_31_i32_i64



def trunc_shl_nsw_31_i32_i64_before := [llvm|
{
^0(%arg42 : i64):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.shl %arg42, %0 overflow<nsw> : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_nsw_31_i32_i64_after := [llvm|
{
^0(%arg42 : i64):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.trunc %arg42 : i64 to i32
  %2 = llvm.shl %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_nsw_31_i32_i64_proof : trunc_shl_nsw_31_i32_i64_before ⊑ trunc_shl_nsw_31_i32_i64_after := by
  unfold trunc_shl_nsw_31_i32_i64_before trunc_shl_nsw_31_i32_i64_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_nsw_31_i32_i64
  apply trunc_shl_nsw_31_i32_i64_thm
  ---END trunc_shl_nsw_31_i32_i64



def trunc_shl_nuw_31_i32_i64_before := [llvm|
{
^0(%arg41 : i64):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.shl %arg41, %0 overflow<nuw> : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_nuw_31_i32_i64_after := [llvm|
{
^0(%arg41 : i64):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.trunc %arg41 : i64 to i32
  %2 = llvm.shl %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_nuw_31_i32_i64_proof : trunc_shl_nuw_31_i32_i64_before ⊑ trunc_shl_nuw_31_i32_i64_after := by
  unfold trunc_shl_nuw_31_i32_i64_before trunc_shl_nuw_31_i32_i64_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_nuw_31_i32_i64
  apply trunc_shl_nuw_31_i32_i64_thm
  ---END trunc_shl_nuw_31_i32_i64



def trunc_shl_nsw_nuw_31_i32_i64_before := [llvm|
{
^0(%arg40 : i64):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.shl %arg40, %0 overflow<nsw,nuw> : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_nsw_nuw_31_i32_i64_after := [llvm|
{
^0(%arg40 : i64):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.trunc %arg40 : i64 to i32
  %2 = llvm.shl %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_nsw_nuw_31_i32_i64_proof : trunc_shl_nsw_nuw_31_i32_i64_before ⊑ trunc_shl_nsw_nuw_31_i32_i64_after := by
  unfold trunc_shl_nsw_nuw_31_i32_i64_before trunc_shl_nsw_nuw_31_i32_i64_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_nsw_nuw_31_i32_i64
  apply trunc_shl_nsw_nuw_31_i32_i64_thm
  ---END trunc_shl_nsw_nuw_31_i32_i64



def trunc_shl_15_i16_i64_before := [llvm|
{
^0(%arg39 : i64):
  %0 = llvm.mlir.constant(15) : i64
  %1 = llvm.shl %arg39, %0 : i64
  %2 = llvm.trunc %1 : i64 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def trunc_shl_15_i16_i64_after := [llvm|
{
^0(%arg39 : i64):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.trunc %arg39 : i64 to i16
  %2 = llvm.shl %1, %0 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_15_i16_i64_proof : trunc_shl_15_i16_i64_before ⊑ trunc_shl_15_i16_i64_after := by
  unfold trunc_shl_15_i16_i64_before trunc_shl_15_i16_i64_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_15_i16_i64
  apply trunc_shl_15_i16_i64_thm
  ---END trunc_shl_15_i16_i64



def trunc_shl_15_i16_i32_before := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.shl %arg38, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def trunc_shl_15_i16_i32_after := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.trunc %arg38 : i32 to i16
  %2 = llvm.shl %1, %0 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_15_i16_i32_proof : trunc_shl_15_i16_i32_before ⊑ trunc_shl_15_i16_i32_after := by
  unfold trunc_shl_15_i16_i32_before trunc_shl_15_i16_i32_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_15_i16_i32
  apply trunc_shl_15_i16_i32_thm
  ---END trunc_shl_15_i16_i32



def trunc_shl_7_i8_i64_before := [llvm|
{
^0(%arg37 : i64):
  %0 = llvm.mlir.constant(7) : i64
  %1 = llvm.shl %arg37, %0 : i64
  %2 = llvm.trunc %1 : i64 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def trunc_shl_7_i8_i64_after := [llvm|
{
^0(%arg37 : i64):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.trunc %arg37 : i64 to i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_7_i8_i64_proof : trunc_shl_7_i8_i64_before ⊑ trunc_shl_7_i8_i64_after := by
  unfold trunc_shl_7_i8_i64_before trunc_shl_7_i8_i64_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_7_i8_i64
  apply trunc_shl_7_i8_i64_thm
  ---END trunc_shl_7_i8_i64



def trunc_shl_1_i32_i64_before := [llvm|
{
^0(%arg35 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.shl %arg35, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_1_i32_i64_after := [llvm|
{
^0(%arg35 : i64):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.trunc %arg35 : i64 to i32
  %2 = llvm.shl %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_1_i32_i64_proof : trunc_shl_1_i32_i64_before ⊑ trunc_shl_1_i32_i64_after := by
  unfold trunc_shl_1_i32_i64_before trunc_shl_1_i32_i64_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_1_i32_i64
  apply trunc_shl_1_i32_i64_thm
  ---END trunc_shl_1_i32_i64



def trunc_shl_16_i32_i64_before := [llvm|
{
^0(%arg34 : i64):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.shl %arg34, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_16_i32_i64_after := [llvm|
{
^0(%arg34 : i64):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.trunc %arg34 : i64 to i32
  %2 = llvm.shl %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_16_i32_i64_proof : trunc_shl_16_i32_i64_before ⊑ trunc_shl_16_i32_i64_after := by
  unfold trunc_shl_16_i32_i64_before trunc_shl_16_i32_i64_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_16_i32_i64
  apply trunc_shl_16_i32_i64_thm
  ---END trunc_shl_16_i32_i64



def trunc_shl_33_i32_i64_before := [llvm|
{
^0(%arg33 : i64):
  %0 = llvm.mlir.constant(33) : i64
  %1 = llvm.shl %arg33, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_33_i32_i64_after := [llvm|
{
^0(%arg33 : i64):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_33_i32_i64_proof : trunc_shl_33_i32_i64_before ⊑ trunc_shl_33_i32_i64_after := by
  unfold trunc_shl_33_i32_i64_before trunc_shl_33_i32_i64_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_33_i32_i64
  apply trunc_shl_33_i32_i64_thm
  ---END trunc_shl_33_i32_i64



def trunc_shl_32_i32_i64_before := [llvm|
{
^0(%arg32 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.shl %arg32, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_32_i32_i64_after := [llvm|
{
^0(%arg32 : i64):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_32_i32_i64_proof : trunc_shl_32_i32_i64_before ⊑ trunc_shl_32_i32_i64_after := by
  unfold trunc_shl_32_i32_i64_before trunc_shl_32_i32_i64_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_32_i32_i64
  apply trunc_shl_32_i32_i64_thm
  ---END trunc_shl_32_i32_i64



def trunc_shl_lshr_infloop_before := [llvm|
{
^0(%arg26 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.mlir.constant(2) : i64
  %2 = llvm.lshr %arg26, %0 : i64
  %3 = llvm.shl %2, %1 : i64
  %4 = llvm.trunc %3 : i64 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def trunc_shl_lshr_infloop_after := [llvm|
{
^0(%arg26 : i64):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-4 : i32) : i32
  %2 = llvm.trunc %arg26 : i64 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_lshr_infloop_proof : trunc_shl_lshr_infloop_before ⊑ trunc_shl_lshr_infloop_after := by
  unfold trunc_shl_lshr_infloop_before trunc_shl_lshr_infloop_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_lshr_infloop
  apply trunc_shl_lshr_infloop_thm
  ---END trunc_shl_lshr_infloop



def trunc_shl_ashr_infloop_before := [llvm|
{
^0(%arg21 : i64):
  %0 = llvm.mlir.constant(3) : i64
  %1 = llvm.mlir.constant(2) : i64
  %2 = llvm.ashr %arg21, %0 : i64
  %3 = llvm.shl %2, %1 : i64
  %4 = llvm.trunc %3 : i64 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def trunc_shl_ashr_infloop_after := [llvm|
{
^0(%arg21 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.mlir.constant(-4 : i32) : i32
  %2 = llvm.lshr %arg21, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_ashr_infloop_proof : trunc_shl_ashr_infloop_before ⊑ trunc_shl_ashr_infloop_after := by
  unfold trunc_shl_ashr_infloop_before trunc_shl_ashr_infloop_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_ashr_infloop
  apply trunc_shl_ashr_infloop_thm
  ---END trunc_shl_ashr_infloop



def trunc_shl_shl_infloop_before := [llvm|
{
^0(%arg20 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.mlir.constant(2) : i64
  %2 = llvm.shl %arg20, %0 : i64
  %3 = llvm.shl %2, %1 : i64
  %4 = llvm.trunc %3 : i64 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def trunc_shl_shl_infloop_after := [llvm|
{
^0(%arg20 : i64):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.trunc %arg20 : i64 to i32
  %2 = llvm.shl %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_shl_infloop_proof : trunc_shl_shl_infloop_before ⊑ trunc_shl_shl_infloop_after := by
  unfold trunc_shl_shl_infloop_before trunc_shl_shl_infloop_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_shl_infloop
  apply trunc_shl_shl_infloop_thm
  ---END trunc_shl_shl_infloop



def trunc_shl_lshr_var_before := [llvm|
{
^0(%arg18 : i64, %arg19 : i64):
  %0 = llvm.mlir.constant(2) : i64
  %1 = llvm.lshr %arg18, %arg19 : i64
  %2 = llvm.shl %1, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def trunc_shl_lshr_var_after := [llvm|
{
^0(%arg18 : i64, %arg19 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.lshr %arg18, %arg19 : i64
  %2 = llvm.trunc %1 : i64 to i32
  %3 = llvm.shl %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_lshr_var_proof : trunc_shl_lshr_var_before ⊑ trunc_shl_lshr_var_after := by
  unfold trunc_shl_lshr_var_before trunc_shl_lshr_var_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_lshr_var
  apply trunc_shl_lshr_var_thm
  ---END trunc_shl_lshr_var



def trunc_shl_ashr_var_before := [llvm|
{
^0(%arg16 : i64, %arg17 : i64):
  %0 = llvm.mlir.constant(2) : i64
  %1 = llvm.ashr %arg16, %arg17 : i64
  %2 = llvm.shl %1, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def trunc_shl_ashr_var_after := [llvm|
{
^0(%arg16 : i64, %arg17 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.ashr %arg16, %arg17 : i64
  %2 = llvm.trunc %1 : i64 to i32
  %3 = llvm.shl %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_ashr_var_proof : trunc_shl_ashr_var_before ⊑ trunc_shl_ashr_var_after := by
  unfold trunc_shl_ashr_var_before trunc_shl_ashr_var_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_ashr_var
  apply trunc_shl_ashr_var_thm
  ---END trunc_shl_ashr_var



def trunc_shl_shl_var_before := [llvm|
{
^0(%arg14 : i64, %arg15 : i64):
  %0 = llvm.mlir.constant(2) : i64
  %1 = llvm.shl %arg14, %arg15 : i64
  %2 = llvm.shl %1, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def trunc_shl_shl_var_after := [llvm|
{
^0(%arg14 : i64, %arg15 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg14, %arg15 : i64
  %2 = llvm.trunc %1 : i64 to i32
  %3 = llvm.shl %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_shl_var_proof : trunc_shl_shl_var_before ⊑ trunc_shl_shl_var_after := by
  unfold trunc_shl_shl_var_before trunc_shl_shl_var_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_shl_var
  apply trunc_shl_shl_var_thm
  ---END trunc_shl_shl_var



def PR44545_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i16) : i16
  %3 = llvm.add %arg0, %0 overflow<nsw,nuw> : i32
  %4 = llvm.icmp "eq" %arg1, %1 : i32
  %5 = "llvm.select"(%4, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.trunc %5 : i32 to i16
  %7 = llvm.add %6, %2 overflow<nsw> : i16
  "llvm.return"(%7) : (i16) -> ()
}
]
def PR44545_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i16) : i16
  %2 = llvm.icmp "eq" %arg1, %0 : i32
  %3 = llvm.trunc %arg0 : i32 to i16
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR44545_proof : PR44545_before ⊑ PR44545_after := by
  unfold PR44545_before PR44545_after
  simp_alive_peephole
  intros
  ---BEGIN PR44545
  apply PR44545_thm
  ---END PR44545


