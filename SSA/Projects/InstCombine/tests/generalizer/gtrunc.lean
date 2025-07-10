import SSA.Projects.InstCombine.tests.proofs.gtrunc_proof
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
section gtrunc_statements

def test5_before := [llvm|
{
^0(%arg104 : i32):
  %0 = llvm.mlir.constant(16 : i128) : i128
  %1 = llvm.zext %arg104 : i32 to i128
  %2 = llvm.lshr %1, %0 : i128
  %3 = llvm.trunc %2 : i128 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg104 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.lshr %arg104, %0 : i32
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
^0(%arg103 : i64):
  %0 = llvm.mlir.constant(32 : i128) : i128
  %1 = llvm.zext %arg103 : i64 to i128
  %2 = llvm.lshr %1, %0 : i128
  %3 = llvm.trunc %2 : i128 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg103 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.lshr %arg103, %0 : i64
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
^0(%arg101 : i8, %arg102 : i8):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.sext %arg101 : i8 to i32
  %2 = llvm.sext %arg102 : i8 to i32
  %3 = llvm.mul %1, %2 : i32
  %4 = llvm.ashr %3, %0 : i32
  %5 = llvm.trunc %4 : i32 to i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def ashr_mul_sign_bits_after := [llvm|
{
^0(%arg101 : i8, %arg102 : i8):
  %0 = llvm.mlir.constant(3 : i16) : i16
  %1 = llvm.sext %arg101 : i8 to i16
  %2 = llvm.sext %arg102 : i8 to i16
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
^0(%arg99 : i8, %arg100 : i8):
  %0 = llvm.mlir.constant(8 : i20) : i20
  %1 = llvm.sext %arg99 : i8 to i20
  %2 = llvm.sext %arg100 : i8 to i20
  %3 = llvm.mul %1, %2 : i20
  %4 = llvm.ashr %3, %0 : i20
  %5 = llvm.trunc %4 : i20 to i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def ashr_mul_after := [llvm|
{
^0(%arg99 : i8, %arg100 : i8):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.sext %arg99 : i8 to i16
  %2 = llvm.sext %arg100 : i8 to i16
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
^0(%arg98 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i36) : i36
  %1 = llvm.mlir.constant(8 : i36) : i36
  %2 = llvm.zext %arg98 : i32 to i36
  %3 = llvm.or %2, %0 : i36
  %4 = llvm.ashr %3, %1 : i36
  %5 = llvm.trunc %4 : i36 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def trunc_ashr_after := [llvm|
{
^0(%arg98 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-8388608 : i32) : i32
  %2 = llvm.lshr %arg98, %0 : i32
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
^0(%arg96 : i64):
  %0 = llvm.mlir.constant(32 : i128) : i128
  %1 = llvm.zext %arg96 : i64 to i128
  %2 = llvm.lshr %1, %0 : i128
  %3 = llvm.trunc %2 : i128 to i92
  "llvm.return"(%3) : (i92) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg96 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.lshr %arg96, %0 : i64
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
^0(%arg94 : i32, %arg95 : i32):
  %0 = llvm.mlir.constant(32 : i128) : i128
  %1 = llvm.zext %arg94 : i32 to i128
  %2 = llvm.zext %arg95 : i32 to i128
  %3 = llvm.shl %2, %0 : i128
  %4 = llvm.or %3, %1 : i128
  %5 = llvm.trunc %4 : i128 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg94 : i32, %arg95 : i32):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.zext %arg94 : i32 to i64
  %2 = llvm.zext %arg95 : i32 to i64
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
^0(%arg87 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.and %arg87, %0 : i32
  %2 = llvm.trunc %1 : i32 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg87 : i32):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.trunc %arg87 : i32 to i8
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
^0(%arg84 : i32, %arg85 : i32):
  %0 = llvm.mlir.constant(31 : i128) : i128
  %1 = llvm.zext %arg84 : i32 to i128
  %2 = llvm.zext %arg85 : i32 to i128
  %3 = llvm.and %2, %0 : i128
  %4 = llvm.shl %1, %3 : i128
  %5 = llvm.trunc %4 : i128 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg84 : i32, %arg85 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.zext %arg84 : i32 to i64
  %2 = llvm.and %arg85, %0 : i32
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
^0(%arg76 : i32, %arg77 : i32):
  %0 = llvm.mlir.constant(31 : i128) : i128
  %1 = llvm.zext %arg76 : i32 to i128
  %2 = llvm.zext %arg77 : i32 to i128
  %3 = llvm.and %2, %0 : i128
  %4 = llvm.lshr %1, %3 : i128
  %5 = llvm.trunc %4 : i128 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg76 : i32, %arg77 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.zext %arg76 : i32 to i64
  %2 = llvm.and %arg77, %0 : i32
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
^0(%arg68 : i32, %arg69 : i32):
  %0 = llvm.mlir.constant(31 : i128) : i128
  %1 = llvm.sext %arg68 : i32 to i128
  %2 = llvm.zext %arg69 : i32 to i128
  %3 = llvm.and %2, %0 : i128
  %4 = llvm.ashr %1, %3 : i128
  %5 = llvm.trunc %4 : i128 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg68 : i32, %arg69 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sext %arg68 : i32 to i64
  %2 = llvm.and %arg69, %0 : i32
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
^0(%arg58 : i64):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.shl %arg58, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_31_i32_i64_after := [llvm|
{
^0(%arg58 : i64):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.trunc %arg58 : i64 to i32
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
^0(%arg57 : i64):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.shl %arg57, %0 overflow<nsw> : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_nsw_31_i32_i64_after := [llvm|
{
^0(%arg57 : i64):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.trunc %arg57 : i64 to i32
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
^0(%arg56 : i64):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.shl %arg56, %0 overflow<nuw> : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_nuw_31_i32_i64_after := [llvm|
{
^0(%arg56 : i64):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.trunc %arg56 : i64 to i32
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
^0(%arg55 : i64):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.shl %arg55, %0 overflow<nsw,nuw> : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_nsw_nuw_31_i32_i64_after := [llvm|
{
^0(%arg55 : i64):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.trunc %arg55 : i64 to i32
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
^0(%arg54 : i64):
  %0 = llvm.mlir.constant(15) : i64
  %1 = llvm.shl %arg54, %0 : i64
  %2 = llvm.trunc %1 : i64 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def trunc_shl_15_i16_i64_after := [llvm|
{
^0(%arg54 : i64):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.trunc %arg54 : i64 to i16
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
^0(%arg53 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.shl %arg53, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def trunc_shl_15_i16_i32_after := [llvm|
{
^0(%arg53 : i32):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.trunc %arg53 : i32 to i16
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
^0(%arg52 : i64):
  %0 = llvm.mlir.constant(7) : i64
  %1 = llvm.shl %arg52, %0 : i64
  %2 = llvm.trunc %1 : i64 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def trunc_shl_7_i8_i64_after := [llvm|
{
^0(%arg52 : i64):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.trunc %arg52 : i64 to i8
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
^0(%arg50 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.shl %arg50, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_1_i32_i64_after := [llvm|
{
^0(%arg50 : i64):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.trunc %arg50 : i64 to i32
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
^0(%arg49 : i64):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.shl %arg49, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_16_i32_i64_after := [llvm|
{
^0(%arg49 : i64):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.trunc %arg49 : i64 to i32
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
^0(%arg48 : i64):
  %0 = llvm.mlir.constant(33) : i64
  %1 = llvm.shl %arg48, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_33_i32_i64_after := [llvm|
{
^0(%arg48 : i64):
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
^0(%arg47 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.shl %arg47, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def trunc_shl_32_i32_i64_after := [llvm|
{
^0(%arg47 : i64):
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
^0(%arg41 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.mlir.constant(2) : i64
  %2 = llvm.lshr %arg41, %0 : i64
  %3 = llvm.shl %2, %1 : i64
  %4 = llvm.trunc %3 : i64 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def trunc_shl_lshr_infloop_after := [llvm|
{
^0(%arg41 : i64):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-4 : i32) : i32
  %2 = llvm.trunc %arg41 : i64 to i32
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
^0(%arg36 : i64):
  %0 = llvm.mlir.constant(3) : i64
  %1 = llvm.mlir.constant(2) : i64
  %2 = llvm.ashr %arg36, %0 : i64
  %3 = llvm.shl %2, %1 : i64
  %4 = llvm.trunc %3 : i64 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def trunc_shl_ashr_infloop_after := [llvm|
{
^0(%arg36 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.mlir.constant(-4 : i32) : i32
  %2 = llvm.lshr %arg36, %0 : i64
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
^0(%arg35 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.mlir.constant(2) : i64
  %2 = llvm.shl %arg35, %0 : i64
  %3 = llvm.shl %2, %1 : i64
  %4 = llvm.trunc %3 : i64 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def trunc_shl_shl_infloop_after := [llvm|
{
^0(%arg35 : i64):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.trunc %arg35 : i64 to i32
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
^0(%arg33 : i64, %arg34 : i64):
  %0 = llvm.mlir.constant(2) : i64
  %1 = llvm.lshr %arg33, %arg34 : i64
  %2 = llvm.shl %1, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def trunc_shl_lshr_var_after := [llvm|
{
^0(%arg33 : i64, %arg34 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.lshr %arg33, %arg34 : i64
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
^0(%arg31 : i64, %arg32 : i64):
  %0 = llvm.mlir.constant(2) : i64
  %1 = llvm.ashr %arg31, %arg32 : i64
  %2 = llvm.shl %1, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def trunc_shl_ashr_var_after := [llvm|
{
^0(%arg31 : i64, %arg32 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.ashr %arg31, %arg32 : i64
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
^0(%arg29 : i64, %arg30 : i64):
  %0 = llvm.mlir.constant(2) : i64
  %1 = llvm.shl %arg29, %arg30 : i64
  %2 = llvm.shl %1, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def trunc_shl_shl_var_after := [llvm|
{
^0(%arg29 : i64, %arg30 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg29, %arg30 : i64
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
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i16) : i16
  %3 = llvm.add %arg15, %0 overflow<nsw,nuw> : i32
  %4 = llvm.icmp "eq" %arg16, %1 : i32
  %5 = "llvm.select"(%4, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.trunc %5 : i32 to i16
  %7 = llvm.add %6, %2 overflow<nsw> : i16
  "llvm.return"(%7) : (i16) -> ()
}
]
def PR44545_after := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i16) : i16
  %2 = llvm.icmp "eq" %arg16, %0 : i32
  %3 = llvm.trunc %arg15 : i32 to i16
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



def drop_nsw_trunc_before := [llvm|
{
^0(%arg13 : i16, %arg14 : i16):
  %0 = llvm.mlir.constant(255 : i16) : i16
  %1 = llvm.and %arg13, %0 : i16
  %2 = llvm.and %1, %arg14 : i16
  %3 = llvm.trunc %2 overflow<nsw> : i16 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def drop_nsw_trunc_after := [llvm|
{
^0(%arg13 : i16, %arg14 : i16):
  %0 = llvm.and %arg13, %arg14 : i16
  %1 = llvm.trunc %0 : i16 to i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem drop_nsw_trunc_proof : drop_nsw_trunc_before ⊑ drop_nsw_trunc_after := by
  unfold drop_nsw_trunc_before drop_nsw_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN drop_nsw_trunc
  apply drop_nsw_trunc_thm
  ---END drop_nsw_trunc



def drop_nuw_trunc_before := [llvm|
{
^0(%arg11 : i16, %arg12 : i16):
  %0 = llvm.mlir.constant(255 : i16) : i16
  %1 = llvm.and %arg11, %0 : i16
  %2 = llvm.and %1, %arg12 : i16
  %3 = llvm.trunc %2 overflow<nuw> : i16 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def drop_nuw_trunc_after := [llvm|
{
^0(%arg11 : i16, %arg12 : i16):
  %0 = llvm.and %arg11, %arg12 : i16
  %1 = llvm.trunc %0 : i16 to i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem drop_nuw_trunc_proof : drop_nuw_trunc_before ⊑ drop_nuw_trunc_after := by
  unfold drop_nuw_trunc_before drop_nuw_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN drop_nuw_trunc
  apply drop_nuw_trunc_thm
  ---END drop_nuw_trunc



def drop_both_trunc_before := [llvm|
{
^0(%arg9 : i16, %arg10 : i16):
  %0 = llvm.mlir.constant(255 : i16) : i16
  %1 = llvm.and %arg9, %0 : i16
  %2 = llvm.and %1, %arg10 : i16
  %3 = llvm.trunc %2 overflow<nsw,nuw> : i16 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def drop_both_trunc_after := [llvm|
{
^0(%arg9 : i16, %arg10 : i16):
  %0 = llvm.and %arg9, %arg10 : i16
  %1 = llvm.trunc %0 : i16 to i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem drop_both_trunc_proof : drop_both_trunc_before ⊑ drop_both_trunc_after := by
  unfold drop_both_trunc_before drop_both_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN drop_both_trunc
  apply drop_both_trunc_thm
  ---END drop_both_trunc



def trunc_nuw_xor_before := [llvm|
{
^0(%arg5 : i8, %arg6 : i8):
  %0 = llvm.xor %arg5, %arg6 : i8
  %1 = llvm.trunc %0 overflow<nuw> : i8 to i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def trunc_nuw_xor_after := [llvm|
{
^0(%arg5 : i8, %arg6 : i8):
  %0 = llvm.icmp "ne" %arg5, %arg6 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_nuw_xor_proof : trunc_nuw_xor_before ⊑ trunc_nuw_xor_after := by
  unfold trunc_nuw_xor_before trunc_nuw_xor_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_nuw_xor
  apply trunc_nuw_xor_thm
  ---END trunc_nuw_xor



def trunc_nsw_xor_before := [llvm|
{
^0(%arg3 : i8, %arg4 : i8):
  %0 = llvm.xor %arg3, %arg4 : i8
  %1 = llvm.trunc %0 overflow<nsw> : i8 to i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def trunc_nsw_xor_after := [llvm|
{
^0(%arg3 : i8, %arg4 : i8):
  %0 = llvm.icmp "ne" %arg3, %arg4 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_nsw_xor_proof : trunc_nsw_xor_before ⊑ trunc_nsw_xor_after := by
  unfold trunc_nsw_xor_before trunc_nsw_xor_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_nsw_xor
  apply trunc_nsw_xor_thm
  ---END trunc_nsw_xor


