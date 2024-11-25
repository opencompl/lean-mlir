import SSA.Projects.InstCombine.tests.proofs.gsext_proof
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
section gsext_statements

def test4_before := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.udiv %arg33, %0 : i32
  %2 = llvm.sext %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.udiv %arg33, %0 : i32
  %2 = llvm.zext nneg %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  intros
  ---BEGIN test4
  apply test4_thm
  ---END test4



def test5_before := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(30000 : i32) : i32
  %1 = llvm.urem %arg32, %0 : i32
  %2 = llvm.sext %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(30000 : i32) : i32
  %1 = llvm.urem %arg32, %0 : i32
  %2 = llvm.zext nneg %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
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
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.lshr %arg31, %0 : i32
  %2 = llvm.mul %1, %0 : i32
  %3 = llvm.sext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.lshr %arg31, %0 : i32
  %2 = llvm.mul %1, %0 overflow<nsw,nuw> : i32
  %3 = llvm.zext nneg %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
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
^0(%arg30 : i32):
  %0 = llvm.mlir.constant(511 : i32) : i32
  %1 = llvm.mlir.constant(20000 : i32) : i32
  %2 = llvm.and %arg30, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  %4 = llvm.sext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg30 : i32):
  %0 = llvm.mlir.constant(511 : i32) : i32
  %1 = llvm.mlir.constant(20000 : i32) : i32
  %2 = llvm.and %arg30, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nsw,nuw> : i32
  %4 = llvm.zext nneg %3 : i32 to i64
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



def test10_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.trunc %arg23 : i32 to i8
  %2 = llvm.shl %1, %0 : i8
  %3 = llvm.ashr %2, %0 : i8
  %4 = llvm.sext %3 : i8 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.shl %arg23, %0 : i32
  %2 = llvm.ashr exact %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
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



def test13_before := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg13, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.sext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.lshr %arg13, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.add %4, %2 overflow<nsw> : i32
  "llvm.return"(%5) : (i32) -> ()
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



def test14_before := [llvm|
{
^0(%arg12 : i16):
  %0 = llvm.mlir.constant(16 : i16) : i16
  %1 = llvm.and %arg12, %0 : i16
  %2 = llvm.icmp "ne" %1, %0 : i16
  %3 = llvm.sext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg12 : i16):
  %0 = llvm.mlir.constant(4 : i16) : i16
  %1 = llvm.mlir.constant(1 : i16) : i16
  %2 = llvm.mlir.constant(-1 : i16) : i16
  %3 = llvm.lshr %arg12, %0 : i16
  %4 = llvm.and %3, %1 : i16
  %5 = llvm.add %4, %2 overflow<nsw> : i16
  %6 = llvm.sext %5 : i16 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test14_proof : test14_before ⊑ test14_after := by
  unfold test14_before test14_after
  simp_alive_peephole
  intros
  ---BEGIN test14
  apply test14_thm
  ---END test14



def test15_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg11, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.sext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(27 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.shl %arg11, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
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
^0(%arg10 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.and %arg10, %0 : i16
  %2 = llvm.icmp "eq" %1, %0 : i16
  %3 = llvm.sext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg10 : i16):
  %0 = llvm.mlir.constant(12 : i16) : i16
  %1 = llvm.mlir.constant(15 : i16) : i16
  %2 = llvm.shl %arg10, %0 : i16
  %3 = llvm.ashr %2, %1 : i16
  %4 = llvm.sext %3 : i16 to i32
  "llvm.return"(%4) : (i32) -> ()
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



def test17_before := [llvm|
{
^0(%arg9 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sext %arg9 : i1 to i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test17_after := [llvm|
{
^0(%arg9 : i1):
  %0 = llvm.zext %arg9 : i1 to i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test17_proof : test17_before ⊑ test17_after := by
  unfold test17_before test17_after
  simp_alive_peephole
  intros
  ---BEGIN test17
  apply test17_thm
  ---END test17



def test19_before := [llvm|
{
^0(%arg7 : i10):
  %0 = llvm.mlir.constant(2 : i3) : i3
  %1 = llvm.trunc %arg7 : i10 to i3
  %2 = llvm.shl %1, %0 : i3
  %3 = llvm.ashr %2, %0 : i3
  %4 = llvm.sext %3 : i3 to i10
  "llvm.return"(%4) : (i10) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg7 : i10):
  %0 = llvm.mlir.constant(1 : i3) : i3
  %1 = llvm.mlir.constant(0 : i3) : i3
  %2 = llvm.trunc %arg7 : i10 to i3
  %3 = llvm.and %2, %0 : i3
  %4 = llvm.sub %1, %3 overflow<nsw> : i3
  %5 = llvm.sext %4 : i3 to i10
  "llvm.return"(%5) : (i10) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test19_proof : test19_before ⊑ test19_after := by
  unfold test19_before test19_after
  simp_alive_peephole
  intros
  ---BEGIN test19
  apply test19_thm
  ---END test19



def smear_set_bit_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.trunc %arg6 : i32 to i8
  %2 = llvm.ashr %1, %0 : i8
  %3 = llvm.sext %2 : i8 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def smear_set_bit_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.shl %arg6, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem smear_set_bit_proof : smear_set_bit_before ⊑ smear_set_bit_after := by
  unfold smear_set_bit_before smear_set_bit_after
  simp_alive_peephole
  intros
  ---BEGIN smear_set_bit
  apply smear_set_bit_thm
  ---END smear_set_bit



def smear_set_bit_different_dest_type_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.trunc %arg2 : i32 to i8
  %2 = llvm.ashr %1, %0 : i8
  %3 = llvm.sext %2 : i8 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def smear_set_bit_different_dest_type_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.shl %arg2, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  %4 = llvm.trunc %3 overflow<nsw> : i32 to i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem smear_set_bit_different_dest_type_proof : smear_set_bit_different_dest_type_before ⊑ smear_set_bit_different_dest_type_after := by
  unfold smear_set_bit_different_dest_type_before smear_set_bit_different_dest_type_after
  simp_alive_peephole
  intros
  ---BEGIN smear_set_bit_different_dest_type
  apply smear_set_bit_different_dest_type_thm
  ---END smear_set_bit_different_dest_type



def smear_set_bit_different_dest_type_wider_dst_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.trunc %arg0 : i32 to i8
  %2 = llvm.ashr %1, %0 : i8
  %3 = llvm.sext %2 : i8 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def smear_set_bit_different_dest_type_wider_dst_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  %4 = llvm.sext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem smear_set_bit_different_dest_type_wider_dst_proof : smear_set_bit_different_dest_type_wider_dst_before ⊑ smear_set_bit_different_dest_type_wider_dst_after := by
  unfold smear_set_bit_different_dest_type_wider_dst_before smear_set_bit_different_dest_type_wider_dst_after
  simp_alive_peephole
  intros
  ---BEGIN smear_set_bit_different_dest_type_wider_dst
  apply smear_set_bit_different_dest_type_wider_dst_thm
  ---END smear_set_bit_different_dest_type_wider_dst


