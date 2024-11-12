import SSA.Projects.InstCombine.tests.proofs.gcast_proof
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
section gcast_statements

def test2_before := [llvm|
{
^0(%arg196 : i8):
  %0 = llvm.zext %arg196 : i8 to i16
  %1 = llvm.zext %0 : i16 to i32
  %2 = llvm.zext %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg196 : i8):
  %0 = llvm.zext %arg196 : i8 to i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  apply test2_thm
  ---END test2



def test3_before := [llvm|
{
^0(%arg195 : i64):
  %0 = llvm.trunc %arg195 : i64 to i8
  %1 = llvm.zext %0 : i8 to i64
  "llvm.return"(%1) : (i64) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg195 : i64):
  %0 = llvm.mlir.constant(255) : i64
  %1 = llvm.and %arg195, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  intros
  ---BEGIN test3
  apply test3_thm
  ---END test3



def test4_before := [llvm|
{
^0(%arg193 : i32, %arg194 : i32):
  %0 = llvm.icmp "slt" %arg193, %arg194 : i32
  %1 = llvm.zext %0 : i1 to i8
  %2 = llvm.zext %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg193 : i32, %arg194 : i32):
  %0 = llvm.icmp "slt" %arg193, %arg194 : i32
  %1 = llvm.zext %0 : i1 to i32
  "llvm.return"(%1) : (i32) -> ()
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
^0(%arg192 : i1):
  %0 = llvm.zext %arg192 : i1 to i8
  %1 = llvm.zext %0 : i8 to i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg192 : i1):
  %0 = llvm.zext %arg192 : i1 to i32
  "llvm.return"(%0) : (i32) -> ()
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



def test7_before := [llvm|
{
^0(%arg190 : i1):
  %0 = llvm.zext %arg190 : i1 to i32
  %1 = llvm.sext %0 : i32 to i64
  "llvm.return"(%1) : (i64) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg190 : i1):
  %0 = llvm.zext %arg190 : i1 to i64
  "llvm.return"(%0) : (i64) -> ()
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



def test9_before := [llvm|
{
^0(%arg188 : i16):
  %0 = llvm.sext %arg188 : i16 to i32
  %1 = llvm.trunc %0 : i32 to i16
  "llvm.return"(%1) : (i16) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg188 : i16):
  "llvm.return"(%arg188) : (i16) -> ()
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
^0(%arg187 : i16):
  %0 = llvm.sext %arg187 : i16 to i32
  %1 = llvm.trunc %0 : i32 to i16
  "llvm.return"(%1) : (i16) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg187 : i16):
  "llvm.return"(%arg187) : (i16) -> ()
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



def test17_before := [llvm|
{
^0(%arg180 : i1):
  %0 = llvm.zext %arg180 : i1 to i32
  %1 = llvm.trunc %0 : i32 to i16
  "llvm.return"(%1) : (i16) -> ()
}
]
def test17_after := [llvm|
{
^0(%arg180 : i1):
  %0 = llvm.zext %arg180 : i1 to i16
  "llvm.return"(%0) : (i16) -> ()
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



def test18_before := [llvm|
{
^0(%arg179 : i8):
  %0 = llvm.sext %arg179 : i8 to i32
  %1 = llvm.trunc %0 : i32 to i16
  "llvm.return"(%1) : (i16) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg179 : i8):
  %0 = llvm.sext %arg179 : i8 to i16
  "llvm.return"(%0) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test18_proof : test18_before ⊑ test18_after := by
  unfold test18_before test18_after
  simp_alive_peephole
  intros
  ---BEGIN test18
  apply test18_thm
  ---END test18



def test19_before := [llvm|
{
^0(%arg178 : i32):
  %0 = llvm.mlir.constant(12345) : i64
  %1 = llvm.sext %arg178 : i32 to i64
  %2 = llvm.icmp "slt" %1, %0 : i64
  "llvm.return"(%2) : (i1) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg178 : i32):
  %0 = llvm.mlir.constant(12345 : i32) : i32
  %1 = llvm.icmp "slt" %arg178, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
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



def test20_before := [llvm|
{
^0(%arg175 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.zext %arg175 : i1 to i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def test20_after := [llvm|
{
^0(%arg175 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test20_proof : test20_before ⊑ test20_after := by
  unfold test20_before test20_after
  simp_alive_peephole
  intros
  ---BEGIN test20
  apply test20_thm
  ---END test20



def test21_before := [llvm|
{
^0(%arg174 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.trunc %arg174 : i32 to i8
  %2 = llvm.sext %1 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test21_after := [llvm|
{
^0(%arg174 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.and %arg174, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test21_proof : test21_before ⊑ test21_after := by
  unfold test21_before test21_after
  simp_alive_peephole
  intros
  ---BEGIN test21
  apply test21_thm
  ---END test21



def test22_before := [llvm|
{
^0(%arg173 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.trunc %arg173 : i32 to i8
  %2 = llvm.sext %1 : i8 to i32
  %3 = llvm.shl %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test22_after := [llvm|
{
^0(%arg173 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.shl %arg173, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test22_proof : test22_before ⊑ test22_after := by
  unfold test22_before test22_after
  simp_alive_peephole
  intros
  ---BEGIN test22
  apply test22_thm
  ---END test22



def test23_before := [llvm|
{
^0(%arg172 : i32):
  %0 = llvm.trunc %arg172 : i32 to i16
  %1 = llvm.zext %0 : i16 to i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test23_after := [llvm|
{
^0(%arg172 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.and %arg172, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test23_proof : test23_before ⊑ test23_after := by
  unfold test23_before test23_after
  simp_alive_peephole
  intros
  ---BEGIN test23
  apply test23_thm
  ---END test23



def test24_before := [llvm|
{
^0(%arg171 : i1):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(1234 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = "llvm.select"(%arg171, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ne" %3, %2 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def test24_after := [llvm|
{
^0(%arg171 : i1):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test24_proof : test24_before ⊑ test24_after := by
  unfold test24_before test24_after
  simp_alive_peephole
  intros
  ---BEGIN test24
  apply test24_thm
  ---END test24



def test29_before := [llvm|
{
^0(%arg166 : i32, %arg167 : i32):
  %0 = llvm.trunc %arg166 : i32 to i8
  %1 = llvm.trunc %arg167 : i32 to i8
  %2 = llvm.or %1, %0 : i8
  %3 = llvm.zext %2 : i8 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test29_after := [llvm|
{
^0(%arg166 : i32, %arg167 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.or %arg167, %arg166 : i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test29_proof : test29_before ⊑ test29_after := by
  unfold test29_before test29_after
  simp_alive_peephole
  intros
  ---BEGIN test29
  apply test29_thm
  ---END test29



def test31_before := [llvm|
{
^0(%arg164 : i64):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(10 : i32) : i32
  %2 = llvm.trunc %arg164 : i64 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def test31_after := [llvm|
{
^0(%arg164 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.mlir.constant(10) : i64
  %2 = llvm.and %arg164, %0 : i64
  %3 = llvm.icmp "eq" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test31_proof : test31_before ⊑ test31_after := by
  unfold test31_before test31_after
  simp_alive_peephole
  intros
  ---BEGIN test31
  apply test31_thm
  ---END test31



def test34_before := [llvm|
{
^0(%arg160 : i16):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.zext %arg160 : i16 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def test34_after := [llvm|
{
^0(%arg160 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.lshr %arg160, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test34_proof : test34_before ⊑ test34_after := by
  unfold test34_before test34_after
  simp_alive_peephole
  intros
  ---BEGIN test34
  apply test34_thm
  ---END test34



def test36_before := [llvm|
{
^0(%arg158 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.lshr %arg158, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def test36_after := [llvm|
{
^0(%arg158 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg158, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test36_proof : test36_before ⊑ test36_after := by
  unfold test36_before test36_after
  simp_alive_peephole
  intros
  ---BEGIN test36
  apply test36_thm
  ---END test36



def test37_before := [llvm|
{
^0(%arg156 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(512 : i32) : i32
  %2 = llvm.mlir.constant(11 : i8) : i8
  %3 = llvm.lshr %arg156, %0 : i32
  %4 = llvm.or %3, %1 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.icmp "eq" %5, %2 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def test37_after := [llvm|
{
^0(%arg156 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test37_proof : test37_before ⊑ test37_after := by
  unfold test37_before test37_after
  simp_alive_peephole
  intros
  ---BEGIN test37
  apply test37_thm
  ---END test37



def test38_before := [llvm|
{
^0(%arg155 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg155, %0 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.zext %4 : i8 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test38_after := [llvm|
{
^0(%arg155 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.icmp "ne" %arg155, %0 : i32
  %2 = llvm.zext %1 : i1 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test38_proof : test38_before ⊑ test38_after := by
  unfold test38_before test38_after
  simp_alive_peephole
  intros
  ---BEGIN test38
  apply test38_thm
  ---END test38



def test40_before := [llvm|
{
^0(%arg153 : i16):
  %0 = llvm.mlir.constant(9 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.zext %arg153 : i16 to i32
  %3 = llvm.lshr %2, %0 : i32
  %4 = llvm.shl %2, %1 : i32
  %5 = llvm.or %3, %4 : i32
  %6 = llvm.trunc %5 : i32 to i16
  "llvm.return"(%6) : (i16) -> ()
}
]
def test40_after := [llvm|
{
^0(%arg153 : i16):
  %0 = llvm.mlir.constant(9 : i16) : i16
  %1 = llvm.mlir.constant(8 : i16) : i16
  %2 = llvm.lshr %arg153, %0 : i16
  %3 = llvm.shl %arg153, %1 : i16
  %4 = llvm.or disjoint %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test40_proof : test40_before ⊑ test40_after := by
  unfold test40_before test40_after
  simp_alive_peephole
  intros
  ---BEGIN test40
  apply test40_thm
  ---END test40



def test42_before := [llvm|
{
^0(%arg146 : i32):
  %0 = llvm.trunc %arg146 : i32 to i8
  %1 = llvm.zext %0 : i8 to i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test42_after := [llvm|
{
^0(%arg146 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.and %arg146, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test42_proof : test42_before ⊑ test42_after := by
  unfold test42_before test42_after
  simp_alive_peephole
  intros
  ---BEGIN test42
  apply test42_thm
  ---END test42



def test43_before := [llvm|
{
^0(%arg145 : i8):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.zext %arg145 : i8 to i32
  %2 = llvm.add %1, %0 : i32
  %3 = llvm.sext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test43_after := [llvm|
{
^0(%arg145 : i8):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.zext %arg145 : i8 to i32
  %2 = llvm.add %1, %0 overflow<nsw> : i32
  %3 = llvm.sext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test43_proof : test43_before ⊑ test43_after := by
  unfold test43_before test43_after
  simp_alive_peephole
  intros
  ---BEGIN test43
  apply test43_thm
  ---END test43



def test44_before := [llvm|
{
^0(%arg144 : i8):
  %0 = llvm.mlir.constant(1234 : i16) : i16
  %1 = llvm.zext %arg144 : i8 to i16
  %2 = llvm.or %1, %0 : i16
  %3 = llvm.zext %2 : i16 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test44_after := [llvm|
{
^0(%arg144 : i8):
  %0 = llvm.mlir.constant(1234 : i16) : i16
  %1 = llvm.zext %arg144 : i8 to i16
  %2 = llvm.or %1, %0 : i16
  %3 = llvm.zext nneg %2 : i16 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test44_proof : test44_before ⊑ test44_after := by
  unfold test44_before test44_after
  simp_alive_peephole
  intros
  ---BEGIN test44
  apply test44_thm
  ---END test44



def test46_before := [llvm|
{
^0(%arg141 : i64):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.trunc %arg141 : i64 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test46_after := [llvm|
{
^0(%arg141 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(10752 : i32) : i32
  %2 = llvm.trunc %arg141 : i64 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.zext nneg %4 : i32 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test46_proof : test46_before ⊑ test46_after := by
  unfold test46_before test46_after
  simp_alive_peephole
  intros
  ---BEGIN test46
  apply test46_thm
  ---END test46



def test47_before := [llvm|
{
^0(%arg139 : i8):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.sext %arg139 : i8 to i32
  %2 = llvm.or %1, %0 : i32
  %3 = llvm.zext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test47_after := [llvm|
{
^0(%arg139 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.or %arg139, %0 : i8
  %2 = llvm.sext %1 : i8 to i32
  %3 = llvm.zext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test47_proof : test47_before ⊑ test47_after := by
  unfold test47_before test47_after
  simp_alive_peephole
  intros
  ---BEGIN test47
  apply test47_thm
  ---END test47



def test48_before := [llvm|
{
^0(%arg137 : i8, %arg138 : i8):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.zext %arg138 : i8 to i32
  %2 = llvm.zext %arg137 : i8 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.or %3, %2 : i32
  %5 = llvm.zext %4 : i32 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test48_after := [llvm|
{
^0(%arg137 : i8, %arg138 : i8):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.zext %arg137 : i8 to i32
  %2 = llvm.shl %1, %0 overflow<nsw,nuw> : i32
  %3 = llvm.or disjoint %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test48_proof : test48_before ⊑ test48_after := by
  unfold test48_before test48_after
  simp_alive_peephole
  intros
  ---BEGIN test48
  apply test48_thm
  ---END test48



def test51_before := [llvm|
{
^0(%arg133 : i64, %arg134 : i1):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.trunc %arg133 : i64 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.or %2, %1 : i32
  %5 = "llvm.select"(%arg134, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.sext %5 : i32 to i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def test51_after := [llvm|
{
^0(%arg133 : i64, %arg134 : i1):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.trunc %arg133 : i64 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.xor %arg134, %1 : i1
  %5 = llvm.zext %4 : i1 to i32
  %6 = llvm.or disjoint %3, %5 : i32
  %7 = llvm.sext %6 : i32 to i64
  "llvm.return"(%7) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test51_proof : test51_before ⊑ test51_after := by
  unfold test51_before test51_after
  simp_alive_peephole
  intros
  ---BEGIN test51
  apply test51_thm
  ---END test51



def test52_before := [llvm|
{
^0(%arg132 : i64):
  %0 = llvm.mlir.constant(-32574 : i16) : i16
  %1 = llvm.mlir.constant(-25350 : i16) : i16
  %2 = llvm.trunc %arg132 : i64 to i16
  %3 = llvm.or %2, %0 : i16
  %4 = llvm.and %3, %1 : i16
  %5 = llvm.zext %4 : i16 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test52_after := [llvm|
{
^0(%arg132 : i64):
  %0 = llvm.mlir.constant(7224 : i16) : i16
  %1 = llvm.mlir.constant(-32574 : i16) : i16
  %2 = llvm.trunc %arg132 : i64 to i16
  %3 = llvm.and %2, %0 : i16
  %4 = llvm.or disjoint %3, %1 : i16
  %5 = llvm.zext %4 : i16 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test52_proof : test52_before ⊑ test52_after := by
  unfold test52_before test52_after
  simp_alive_peephole
  intros
  ---BEGIN test52
  apply test52_thm
  ---END test52



def test53_before := [llvm|
{
^0(%arg131 : i32):
  %0 = llvm.mlir.constant(-32574 : i16) : i16
  %1 = llvm.mlir.constant(-25350 : i16) : i16
  %2 = llvm.trunc %arg131 : i32 to i16
  %3 = llvm.or %2, %0 : i16
  %4 = llvm.and %3, %1 : i16
  %5 = llvm.zext %4 : i16 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test53_after := [llvm|
{
^0(%arg131 : i32):
  %0 = llvm.mlir.constant(7224 : i16) : i16
  %1 = llvm.mlir.constant(-32574 : i16) : i16
  %2 = llvm.trunc %arg131 : i32 to i16
  %3 = llvm.and %2, %0 : i16
  %4 = llvm.or disjoint %3, %1 : i16
  %5 = llvm.zext %4 : i16 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test53_proof : test53_before ⊑ test53_after := by
  unfold test53_before test53_after
  simp_alive_peephole
  intros
  ---BEGIN test53
  apply test53_thm
  ---END test53



def test54_before := [llvm|
{
^0(%arg130 : i64):
  %0 = llvm.mlir.constant(-32574 : i16) : i16
  %1 = llvm.mlir.constant(-25350 : i16) : i16
  %2 = llvm.trunc %arg130 : i64 to i16
  %3 = llvm.or %2, %0 : i16
  %4 = llvm.and %3, %1 : i16
  %5 = llvm.sext %4 : i16 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test54_after := [llvm|
{
^0(%arg130 : i64):
  %0 = llvm.mlir.constant(7224 : i16) : i16
  %1 = llvm.mlir.constant(-32574 : i16) : i16
  %2 = llvm.trunc %arg130 : i64 to i16
  %3 = llvm.and %2, %0 : i16
  %4 = llvm.or disjoint %3, %1 : i16
  %5 = llvm.sext %4 : i16 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test54_proof : test54_before ⊑ test54_after := by
  unfold test54_before test54_after
  simp_alive_peephole
  intros
  ---BEGIN test54
  apply test54_thm
  ---END test54



def test55_before := [llvm|
{
^0(%arg129 : i32):
  %0 = llvm.mlir.constant(-32574 : i16) : i16
  %1 = llvm.mlir.constant(-25350 : i16) : i16
  %2 = llvm.trunc %arg129 : i32 to i16
  %3 = llvm.or %2, %0 : i16
  %4 = llvm.and %3, %1 : i16
  %5 = llvm.sext %4 : i16 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test55_after := [llvm|
{
^0(%arg129 : i32):
  %0 = llvm.mlir.constant(7224 : i16) : i16
  %1 = llvm.mlir.constant(-32574 : i16) : i16
  %2 = llvm.trunc %arg129 : i32 to i16
  %3 = llvm.and %2, %0 : i16
  %4 = llvm.or disjoint %3, %1 : i16
  %5 = llvm.sext %4 : i16 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test55_proof : test55_before ⊑ test55_after := by
  unfold test55_before test55_after
  simp_alive_peephole
  intros
  ---BEGIN test55
  apply test55_thm
  ---END test55



def test56_before := [llvm|
{
^0(%arg128 : i16):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.sext %arg128 : i16 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.zext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test56_after := [llvm|
{
^0(%arg128 : i16):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.sext %arg128 : i16 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.zext nneg %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test56_proof : test56_before ⊑ test56_after := by
  unfold test56_before test56_after
  simp_alive_peephole
  intros
  ---BEGIN test56
  apply test56_thm
  ---END test56



def test57_before := [llvm|
{
^0(%arg126 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.trunc %arg126 : i64 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.zext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test57_after := [llvm|
{
^0(%arg126 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.trunc %arg126 : i64 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.zext nneg %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test57_proof : test57_before ⊑ test57_after := by
  unfold test57_before test57_after
  simp_alive_peephole
  intros
  ---BEGIN test57
  apply test57_thm
  ---END test57



def test58_before := [llvm|
{
^0(%arg124 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.trunc %arg124 : i64 to i32
  %3 = llvm.lshr %2, %0 : i32
  %4 = llvm.or %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test58_after := [llvm|
{
^0(%arg124 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.trunc %arg124 : i64 to i32
  %3 = llvm.lshr %2, %0 : i32
  %4 = llvm.or %3, %1 : i32
  %5 = llvm.zext nneg %4 : i32 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test58_proof : test58_before ⊑ test58_after := by
  unfold test58_before test58_after
  simp_alive_peephole
  intros
  ---BEGIN test58
  apply test58_thm
  ---END test58



def test59_before := [llvm|
{
^0(%arg122 : i8, %arg123 : i8):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(48 : i32) : i32
  %2 = llvm.zext %arg122 : i8 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.zext %arg123 : i8 to i32
  %6 = llvm.lshr %5, %0 : i32
  %7 = llvm.or %6, %4 : i32
  %8 = llvm.zext %7 : i32 to i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test59_after := [llvm|
{
^0(%arg122 : i8, %arg123 : i8):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(48 : i32) : i32
  %2 = llvm.mlir.constant(4 : i8) : i8
  %3 = llvm.zext %arg122 : i8 to i32
  %4 = llvm.shl %3, %0 overflow<nsw,nuw> : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.lshr %arg123, %2 : i8
  %7 = llvm.zext nneg %6 : i8 to i32
  %8 = llvm.or disjoint %5, %7 : i32
  %9 = llvm.zext nneg %8 : i32 to i64
  "llvm.return"(%9) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test59_proof : test59_before ⊑ test59_after := by
  unfold test59_before test59_after
  simp_alive_peephole
  intros
  ---BEGIN test59
  apply test59_thm
  ---END test59



def test67_before := [llvm|
{
^0(%arg113 : i1, %arg114 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(24 : i32) : i32
  %2 = llvm.mlir.constant(-16777216 : i32) : i32
  %3 = llvm.mlir.constant(0 : i8) : i8
  %4 = llvm.zext %arg113 : i1 to i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %arg114, %5 : i32
  %7 = llvm.shl %6, %1 overflow<nsw,nuw> : i32
  %8 = llvm.xor %7, %2 : i32
  %9 = llvm.ashr exact %8, %1 : i32
  %10 = llvm.trunc %9 : i32 to i8
  %11 = llvm.icmp "eq" %10, %3 : i8
  "llvm.return"(%11) : (i1) -> ()
}
]
def test67_after := [llvm|
{
^0(%arg113 : i1, %arg114 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test67_proof : test67_before ⊑ test67_after := by
  unfold test67_before test67_after
  simp_alive_peephole
  intros
  ---BEGIN test67
  apply test67_thm
  ---END test67



def test82_before := [llvm|
{
^0(%arg64 : i64):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.trunc %arg64 : i64 to i32
  %3 = llvm.lshr %2, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test82_after := [llvm|
{
^0(%arg64 : i64):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-512 : i32) : i32
  %2 = llvm.trunc %arg64 : i64 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test82_proof : test82_before ⊑ test82_after := by
  unfold test82_before test82_after
  simp_alive_peephole
  intros
  ---BEGIN test82
  apply test82_thm
  ---END test82



def test83_before := [llvm|
{
^0(%arg62 : i16, %arg63 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.sext %arg62 : i16 to i32
  %2 = llvm.add %arg63, %0 overflow<nsw> : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.shl %1, %3 : i32
  %5 = llvm.zext %4 : i32 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test83_after := [llvm|
{
^0(%arg62 : i16, %arg63 : i64):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.sext %arg62 : i16 to i32
  %2 = llvm.trunc %arg63 : i64 to i32
  %3 = llvm.add %2, %0 : i32
  %4 = llvm.shl %1, %3 : i32
  %5 = llvm.zext %4 : i32 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test83_proof : test83_before ⊑ test83_after := by
  unfold test83_before test83_after
  simp_alive_peephole
  intros
  ---BEGIN test83
  apply test83_thm
  ---END test83



def test84_before := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(-16777216 : i32) : i32
  %1 = llvm.mlir.constant(23 : i32) : i32
  %2 = llvm.add %arg61, %0 overflow<nsw> : i32
  %3 = llvm.lshr exact %2, %1 : i32
  %4 = llvm.trunc %3 : i32 to i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def test84_after := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(2130706432 : i32) : i32
  %1 = llvm.mlir.constant(23 : i32) : i32
  %2 = llvm.add %arg61, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  %4 = llvm.trunc %3 : i32 to i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test84_proof : test84_before ⊑ test84_after := by
  unfold test84_before test84_after
  simp_alive_peephole
  intros
  ---BEGIN test84
  apply test84_thm
  ---END test84



def test85_before := [llvm|
{
^0(%arg60 : i32):
  %0 = llvm.mlir.constant(-16777216 : i32) : i32
  %1 = llvm.mlir.constant(23 : i32) : i32
  %2 = llvm.add %arg60, %0 overflow<nuw> : i32
  %3 = llvm.lshr exact %2, %1 : i32
  %4 = llvm.trunc %3 : i32 to i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def test85_after := [llvm|
{
^0(%arg60 : i32):
  %0 = llvm.mlir.constant(2130706432 : i32) : i32
  %1 = llvm.mlir.constant(23 : i32) : i32
  %2 = llvm.add %arg60, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  %4 = llvm.trunc %3 : i32 to i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test85_proof : test85_before ⊑ test85_after := by
  unfold test85_before test85_after
  simp_alive_peephole
  intros
  ---BEGIN test85
  apply test85_thm
  ---END test85



def test86_before := [llvm|
{
^0(%arg59 : i16):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.sext %arg59 : i16 to i32
  %2 = llvm.ashr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def test86_after := [llvm|
{
^0(%arg59 : i16):
  %0 = llvm.mlir.constant(4 : i16) : i16
  %1 = llvm.ashr %arg59, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test86_proof : test86_before ⊑ test86_after := by
  unfold test86_before test86_after
  simp_alive_peephole
  intros
  ---BEGIN test86
  apply test86_thm
  ---END test86



def test87_before := [llvm|
{
^0(%arg58 : i16):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.sext %arg58 : i16 to i32
  %2 = llvm.mul %1, %0 overflow<nsw> : i32
  %3 = llvm.ashr %2, %0 : i32
  %4 = llvm.trunc %3 : i32 to i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def test87_after := [llvm|
{
^0(%arg58 : i16):
  %0 = llvm.mlir.constant(12 : i16) : i16
  %1 = llvm.ashr %arg58, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test87_proof : test87_before ⊑ test87_after := by
  unfold test87_before test87_after
  simp_alive_peephole
  intros
  ---BEGIN test87
  apply test87_thm
  ---END test87



def test88_before := [llvm|
{
^0(%arg57 : i16):
  %0 = llvm.mlir.constant(18 : i32) : i32
  %1 = llvm.sext %arg57 : i16 to i32
  %2 = llvm.ashr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def test88_after := [llvm|
{
^0(%arg57 : i16):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.ashr %arg57, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test88_proof : test88_before ⊑ test88_after := by
  unfold test88_before test88_after
  simp_alive_peephole
  intros
  ---BEGIN test88
  apply test88_thm
  ---END test88



def PR23309_before := [llvm|
{
^0(%arg53 : i32, %arg54 : i32):
  %0 = llvm.mlir.constant(-4 : i32) : i32
  %1 = llvm.add %arg53, %0 : i32
  %2 = llvm.sub %1, %arg54 overflow<nsw> : i32
  %3 = llvm.trunc %2 : i32 to i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def PR23309_after := [llvm|
{
^0(%arg53 : i32, %arg54 : i32):
  %0 = llvm.sub %arg53, %arg54 : i32
  %1 = llvm.trunc %0 : i32 to i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR23309_proof : PR23309_before ⊑ PR23309_after := by
  unfold PR23309_before PR23309_after
  simp_alive_peephole
  intros
  ---BEGIN PR23309
  apply PR23309_thm
  ---END PR23309



def PR23309v2_before := [llvm|
{
^0(%arg51 : i32, %arg52 : i32):
  %0 = llvm.mlir.constant(-4 : i32) : i32
  %1 = llvm.add %arg51, %0 : i32
  %2 = llvm.add %1, %arg52 overflow<nuw> : i32
  %3 = llvm.trunc %2 : i32 to i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def PR23309v2_after := [llvm|
{
^0(%arg51 : i32, %arg52 : i32):
  %0 = llvm.add %arg51, %arg52 : i32
  %1 = llvm.trunc %0 : i32 to i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR23309v2_proof : PR23309v2_before ⊑ PR23309v2_after := by
  unfold PR23309v2_before PR23309v2_after
  simp_alive_peephole
  intros
  ---BEGIN PR23309v2
  apply PR23309v2_thm
  ---END PR23309v2



def PR24763_before := [llvm|
{
^0(%arg50 : i8):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.sext %arg50 : i8 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def PR24763_after := [llvm|
{
^0(%arg50 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.ashr %arg50, %0 : i8
  %2 = llvm.sext %1 : i8 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR24763_proof : PR24763_before ⊑ PR24763_after := by
  unfold PR24763_before PR24763_after
  simp_alive_peephole
  intros
  ---BEGIN PR24763
  apply PR24763_thm
  ---END PR24763



def test91_before := [llvm|
{
^0(%arg49 : i64):
  %0 = llvm.mlir.constant(48 : i96) : i96
  %1 = llvm.sext %arg49 : i64 to i96
  %2 = llvm.lshr %1, %0 : i96
  %3 = llvm.trunc %2 : i96 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test91_after := [llvm|
{
^0(%arg49 : i64):
  %0 = llvm.mlir.constant(48 : i96) : i96
  %1 = llvm.sext %arg49 : i64 to i96
  %2 = llvm.lshr %1, %0 : i96
  %3 = llvm.trunc %2 overflow<nsw,nuw> : i96 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test91_proof : test91_before ⊑ test91_after := by
  unfold test91_before test91_after
  simp_alive_peephole
  intros
  ---BEGIN test91
  apply test91_thm
  ---END test91



def test92_before := [llvm|
{
^0(%arg48 : i64):
  %0 = llvm.mlir.constant(32 : i96) : i96
  %1 = llvm.sext %arg48 : i64 to i96
  %2 = llvm.lshr %1, %0 : i96
  %3 = llvm.trunc %2 : i96 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test92_after := [llvm|
{
^0(%arg48 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.ashr %arg48, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test92_proof : test92_before ⊑ test92_after := by
  unfold test92_before test92_after
  simp_alive_peephole
  intros
  ---BEGIN test92
  apply test92_thm
  ---END test92



def test93_before := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(64 : i96) : i96
  %1 = llvm.sext %arg47 : i32 to i96
  %2 = llvm.lshr %1, %0 : i96
  %3 = llvm.trunc %2 : i96 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test93_after := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.ashr %arg47, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test93_proof : test93_before ⊑ test93_after := by
  unfold test93_before test93_after
  simp_alive_peephole
  intros
  ---BEGIN test93
  apply test93_thm
  ---END test93



def trunc_lshr_sext_before := [llvm|
{
^0(%arg46 : i8):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.sext %arg46 : i8 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def trunc_lshr_sext_after := [llvm|
{
^0(%arg46 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.ashr %arg46, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_sext_proof : trunc_lshr_sext_before ⊑ trunc_lshr_sext_after := by
  unfold trunc_lshr_sext_before trunc_lshr_sext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr_sext
  apply trunc_lshr_sext_thm
  ---END trunc_lshr_sext



def trunc_lshr_sext_exact_before := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.sext %arg45 : i8 to i32
  %2 = llvm.lshr exact %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def trunc_lshr_sext_exact_after := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.ashr exact %arg45, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_sext_exact_proof : trunc_lshr_sext_exact_before ⊑ trunc_lshr_sext_exact_after := by
  unfold trunc_lshr_sext_exact_before trunc_lshr_sext_exact_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr_sext_exact
  apply trunc_lshr_sext_exact_thm
  ---END trunc_lshr_sext_exact



def trunc_lshr_sext_wide_input_before := [llvm|
{
^0(%arg33 : i16):
  %0 = llvm.mlir.constant(9 : i32) : i32
  %1 = llvm.sext %arg33 : i16 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def trunc_lshr_sext_wide_input_after := [llvm|
{
^0(%arg33 : i16):
  %0 = llvm.mlir.constant(9 : i16) : i16
  %1 = llvm.ashr %arg33, %0 : i16
  %2 = llvm.trunc %1 overflow<nsw> : i16 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_sext_wide_input_proof : trunc_lshr_sext_wide_input_before ⊑ trunc_lshr_sext_wide_input_after := by
  unfold trunc_lshr_sext_wide_input_before trunc_lshr_sext_wide_input_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr_sext_wide_input
  apply trunc_lshr_sext_wide_input_thm
  ---END trunc_lshr_sext_wide_input



def trunc_lshr_sext_wide_input_exact_before := [llvm|
{
^0(%arg32 : i16):
  %0 = llvm.mlir.constant(9 : i32) : i32
  %1 = llvm.sext %arg32 : i16 to i32
  %2 = llvm.lshr exact %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def trunc_lshr_sext_wide_input_exact_after := [llvm|
{
^0(%arg32 : i16):
  %0 = llvm.mlir.constant(9 : i16) : i16
  %1 = llvm.ashr exact %arg32, %0 : i16
  %2 = llvm.trunc %1 overflow<nsw> : i16 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_sext_wide_input_exact_proof : trunc_lshr_sext_wide_input_exact_before ⊑ trunc_lshr_sext_wide_input_exact_after := by
  unfold trunc_lshr_sext_wide_input_exact_before trunc_lshr_sext_wide_input_exact_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr_sext_wide_input_exact
  apply trunc_lshr_sext_wide_input_exact_thm
  ---END trunc_lshr_sext_wide_input_exact



def trunc_lshr_sext_narrow_input_before := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.sext %arg24 : i8 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def trunc_lshr_sext_narrow_input_after := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.ashr %arg24, %0 : i8
  %2 = llvm.sext %1 : i8 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_sext_narrow_input_proof : trunc_lshr_sext_narrow_input_before ⊑ trunc_lshr_sext_narrow_input_after := by
  unfold trunc_lshr_sext_narrow_input_before trunc_lshr_sext_narrow_input_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr_sext_narrow_input
  apply trunc_lshr_sext_narrow_input_thm
  ---END trunc_lshr_sext_narrow_input



def trunc_lshr_zext_before := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.zext %arg12 : i8 to i32
  %2 = llvm.lshr %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def trunc_lshr_zext_after := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.lshr %arg12, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_zext_proof : trunc_lshr_zext_before ⊑ trunc_lshr_zext_after := by
  unfold trunc_lshr_zext_before trunc_lshr_zext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr_zext
  apply trunc_lshr_zext_thm
  ---END trunc_lshr_zext



def trunc_lshr_zext_exact_before := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.zext %arg11 : i8 to i32
  %2 = llvm.lshr exact %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def trunc_lshr_zext_exact_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.lshr %arg11, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_zext_exact_proof : trunc_lshr_zext_exact_before ⊑ trunc_lshr_zext_exact_after := by
  unfold trunc_lshr_zext_exact_before trunc_lshr_zext_exact_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr_zext_exact
  apply trunc_lshr_zext_exact_thm
  ---END trunc_lshr_zext_exact



def pr33078_1_before := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.sext %arg5 : i8 to i16
  %2 = llvm.lshr %1, %0 : i16
  %3 = llvm.trunc %2 : i16 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def pr33078_1_after := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.ashr %arg5, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr33078_1_proof : pr33078_1_before ⊑ pr33078_1_after := by
  unfold pr33078_1_before pr33078_1_after
  simp_alive_peephole
  intros
  ---BEGIN pr33078_1
  apply pr33078_1_thm
  ---END pr33078_1



def pr33078_2_before := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(4 : i16) : i16
  %1 = llvm.sext %arg4 : i8 to i16
  %2 = llvm.lshr %1, %0 : i16
  %3 = llvm.trunc %2 : i16 to i12
  "llvm.return"(%3) : (i12) -> ()
}
]
def pr33078_2_after := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.ashr %arg4, %0 : i8
  %2 = llvm.sext %1 : i8 to i12
  "llvm.return"(%2) : (i12) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr33078_2_proof : pr33078_2_before ⊑ pr33078_2_after := by
  unfold pr33078_2_before pr33078_2_after
  simp_alive_peephole
  intros
  ---BEGIN pr33078_2
  apply pr33078_2_thm
  ---END pr33078_2



def pr33078_3_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(12 : i16) : i16
  %1 = llvm.sext %arg3 : i8 to i16
  %2 = llvm.lshr %1, %0 : i16
  %3 = llvm.trunc %2 : i16 to i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def pr33078_3_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(12 : i16) : i16
  %1 = llvm.sext %arg3 : i8 to i16
  %2 = llvm.lshr %1, %0 : i16
  %3 = llvm.trunc %2 overflow<nuw> : i16 to i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr33078_3_proof : pr33078_3_before ⊑ pr33078_3_after := by
  unfold pr33078_3_before pr33078_3_after
  simp_alive_peephole
  intros
  ---BEGIN pr33078_3
  apply pr33078_3_thm
  ---END pr33078_3



def pr33078_4_before := [llvm|
{
^0(%arg2 : i3):
  %0 = llvm.mlir.constant(13 : i16) : i16
  %1 = llvm.sext %arg2 : i3 to i16
  %2 = llvm.lshr %1, %0 : i16
  %3 = llvm.trunc %2 : i16 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def pr33078_4_after := [llvm|
{
^0(%arg2 : i3):
  %0 = llvm.mlir.constant(13 : i16) : i16
  %1 = llvm.sext %arg2 : i3 to i16
  %2 = llvm.lshr %1, %0 : i16
  %3 = llvm.trunc %2 overflow<nsw,nuw> : i16 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr33078_4_proof : pr33078_4_before ⊑ pr33078_4_after := by
  unfold pr33078_4_before pr33078_4_after
  simp_alive_peephole
  intros
  ---BEGIN pr33078_4
  apply pr33078_4_thm
  ---END pr33078_4



def test94_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.icmp "eq" %arg1, %0 : i32
  %3 = llvm.sext %2 : i1 to i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.sext %4 : i8 to i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test94_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.icmp "ne" %arg1, %0 : i32
  %2 = llvm.sext %1 : i1 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test94_proof : test94_before ⊑ test94_after := by
  unfold test94_before test94_after
  simp_alive_peephole
  intros
  ---BEGIN test94
  apply test94_thm
  ---END test94



def test95_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(40 : i8) : i8
  %3 = llvm.trunc %arg0 : i32 to i8
  %4 = llvm.lshr %3, %0 : i8
  %5 = llvm.and %4, %1 : i8
  %6 = llvm.or %5, %2 : i8
  %7 = llvm.zext %6 : i8 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test95_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(40 : i8) : i8
  %3 = llvm.trunc %arg0 : i32 to i8
  %4 = llvm.lshr %3, %0 : i8
  %5 = llvm.and %4, %1 : i8
  %6 = llvm.or disjoint %5, %2 : i8
  %7 = llvm.zext nneg %6 : i8 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test95_proof : test95_before ⊑ test95_after := by
  unfold test95_before test95_after
  simp_alive_peephole
  intros
  ---BEGIN test95
  apply test95_thm
  ---END test95


