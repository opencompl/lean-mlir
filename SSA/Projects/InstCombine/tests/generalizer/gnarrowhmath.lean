import SSA.Projects.InstCombine.tests.proofs.gnarrowhmath_proof
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
section gnarrowhmath_statements

def sext_sext_add_before := [llvm|
{
^0(%arg42 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.ashr %arg42, %0 : i32
  %3 = llvm.ashr %arg42, %1 : i32
  %4 = llvm.sext %2 : i32 to i64
  %5 = llvm.sext %3 : i32 to i64
  %6 = llvm.add %4, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def sext_sext_add_after := [llvm|
{
^0(%arg42 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.ashr %arg42, %0 : i32
  %3 = llvm.ashr %arg42, %1 : i32
  %4 = llvm.add %2, %3 overflow<nsw> : i32
  %5 = llvm.sext %4 : i32 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_sext_add_proof : sext_sext_add_before ⊑ sext_sext_add_after := by
  unfold sext_sext_add_before sext_sext_add_after
  simp_alive_peephole
  intros
  ---BEGIN sext_sext_add
  apply sext_sext_add_thm
  ---END sext_sext_add



def sext_zext_add_mismatched_exts_before := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.ashr %arg41, %0 : i32
  %3 = llvm.lshr %arg41, %1 : i32
  %4 = llvm.sext %2 : i32 to i64
  %5 = llvm.zext %3 : i32 to i64
  %6 = llvm.add %4, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def sext_zext_add_mismatched_exts_after := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.ashr %arg41, %0 : i32
  %3 = llvm.lshr %arg41, %1 : i32
  %4 = llvm.sext %2 : i32 to i64
  %5 = llvm.zext nneg %3 : i32 to i64
  %6 = llvm.add %4, %5 overflow<nsw> : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_add_mismatched_exts_proof : sext_zext_add_mismatched_exts_before ⊑ sext_zext_add_mismatched_exts_after := by
  unfold sext_zext_add_mismatched_exts_before sext_zext_add_mismatched_exts_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_add_mismatched_exts
  apply sext_zext_add_mismatched_exts_thm
  ---END sext_zext_add_mismatched_exts



def sext_sext_add_mismatched_types_before := [llvm|
{
^0(%arg39 : i16, %arg40 : i32):
  %0 = llvm.mlir.constant(7 : i16) : i16
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.ashr %arg39, %0 : i16
  %3 = llvm.ashr %arg40, %1 : i32
  %4 = llvm.sext %2 : i16 to i64
  %5 = llvm.sext %3 : i32 to i64
  %6 = llvm.add %4, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def sext_sext_add_mismatched_types_after := [llvm|
{
^0(%arg39 : i16, %arg40 : i32):
  %0 = llvm.mlir.constant(7 : i16) : i16
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.ashr %arg39, %0 : i16
  %3 = llvm.ashr %arg40, %1 : i32
  %4 = llvm.sext %2 : i16 to i64
  %5 = llvm.sext %3 : i32 to i64
  %6 = llvm.add %4, %5 overflow<nsw> : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_sext_add_mismatched_types_proof : sext_sext_add_mismatched_types_before ⊑ sext_sext_add_mismatched_types_after := by
  unfold sext_sext_add_mismatched_types_before sext_sext_add_mismatched_types_after
  simp_alive_peephole
  intros
  ---BEGIN sext_sext_add_mismatched_types
  apply sext_sext_add_mismatched_types_thm
  ---END sext_sext_add_mismatched_types



def test5_before := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(1073741823) : i64
  %2 = llvm.ashr %arg31, %0 : i32
  %3 = llvm.sext %2 : i32 to i64
  %4 = llvm.add %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(1073741823 : i32) : i32
  %2 = llvm.ashr %arg31, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  %4 = llvm.sext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
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
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1073741824) : i64
  %2 = llvm.ashr %arg27, %0 : i32
  %3 = llvm.sext %2 : i32 to i64
  %4 = llvm.add %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1073741824 : i32) : i32
  %2 = llvm.ashr %arg27, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  %4 = llvm.sext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
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



def test7_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2147483647) : i64
  %2 = llvm.lshr %arg23, %0 : i32
  %3 = llvm.zext %2 : i32 to i64
  %4 = llvm.add %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2147483647 : i32) : i32
  %2 = llvm.lshr %arg23, %0 : i32
  %3 = llvm.add %2, %1 overflow<nuw> : i32
  %4 = llvm.zext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
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
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(32767) : i64
  %2 = llvm.ashr %arg20, %0 : i32
  %3 = llvm.sext %2 : i32 to i64
  %4 = llvm.mul %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(32767 : i32) : i32
  %2 = llvm.ashr %arg20, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw> : i32
  %4 = llvm.sext %3 : i32 to i64
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
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(-32767) : i64
  %2 = llvm.ashr %arg16, %0 : i32
  %3 = llvm.sext %2 : i32 to i64
  %4 = llvm.mul %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(-32767 : i32) : i32
  %2 = llvm.ashr %arg16, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw> : i32
  %4 = llvm.sext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
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



def test10_before := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(65535) : i64
  %2 = llvm.lshr %arg13, %0 : i32
  %3 = llvm.zext %2 : i32 to i64
  %4 = llvm.mul %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.lshr %arg13, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nuw> : i32
  %4 = llvm.zext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  intros
  ---BEGIN test10
  apply test10_thm
  ---END test10



def test15_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(8) : i64
  %2 = llvm.ashr %arg6, %0 : i32
  %3 = llvm.sext %2 : i32 to i64
  %4 = llvm.sub %1, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.ashr %arg6, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nsw> : i32
  %4 = llvm.sext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15_proof : test15_before ⊑ test15_after := by
  unfold test15_before test15_after
  simp_alive_peephole
  intros
  ---BEGIN test15
  apply test15_thm
  ---END test15



def test16_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(4294967294) : i64
  %2 = llvm.lshr %arg4, %0 : i32
  %3 = llvm.zext %2 : i32 to i64
  %4 = llvm.sub %1, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.lshr %arg4, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nuw> : i32
  %4 = llvm.zext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test16_proof : test16_before ⊑ test16_after := by
  unfold test16_before test16_after
  simp_alive_peephole
  intros
  ---BEGIN test16
  apply test16_thm
  ---END test16


