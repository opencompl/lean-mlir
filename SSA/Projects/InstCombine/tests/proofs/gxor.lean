import SSA.Projects.InstCombine.tests.proofs.gxor_proof
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
section gxor_statements

def test0_before := [llvm|
{
^0(%arg210 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.xor %arg210, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg210 : i1):
  "llvm.return"(%arg210) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test0_proof : test0_before ⊑ test0_after := by
  unfold test0_before test0_after
  simp_alive_peephole
  intros
  ---BEGIN test0
  apply test0_thm
  ---END test0



def test1_before := [llvm|
{
^0(%arg209 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.xor %arg209, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg209 : i32):
  "llvm.return"(%arg209) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  apply test1_thm
  ---END test1



def test2_before := [llvm|
{
^0(%arg208 : i1):
  %0 = llvm.xor %arg208, %arg208 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg208 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
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
^0(%arg207 : i32):
  %0 = llvm.xor %arg207, %arg207 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg207 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
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
^0(%arg206 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %0, %arg206 : i32
  %2 = llvm.xor %arg206, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg206 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
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
^0(%arg205 : i32):
  %0 = llvm.mlir.constant(123 : i32) : i32
  %1 = llvm.or %arg205, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg205 : i32):
  %0 = llvm.mlir.constant(-124 : i32) : i32
  %1 = llvm.and %arg205, %0 : i32
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
^0(%arg204 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.xor %arg204, %0 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg204 : i8):
  "llvm.return"(%arg204) : (i8) -> ()
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
^0(%arg202 : i32, %arg203 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.and %arg202, %0 : i32
  %3 = llvm.and %arg203, %1 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg202 : i32, %arg203 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.and %arg202, %0 : i32
  %3 = llvm.and %arg203, %1 : i32
  %4 = llvm.or disjoint %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
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
^0(%arg200 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(34 : i8) : i8
  %2 = llvm.xor %arg200, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg200 : i8):
  %0 = llvm.mlir.constant(89 : i8) : i8
  %1 = llvm.icmp "eq" %arg200, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
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
^0(%arg198 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.and %arg198, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg198 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.and %arg198, %0 : i8
  %3 = llvm.or disjoint %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
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



def test11_before := [llvm|
{
^0(%arg197 : i8):
  %0 = llvm.mlir.constant(12 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.or %arg197, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg197 : i8):
  %0 = llvm.mlir.constant(-13 : i8) : i8
  %1 = llvm.mlir.constant(8 : i8) : i8
  %2 = llvm.and %arg197, %0 : i8
  %3 = llvm.or disjoint %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
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
^0(%arg196 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.xor %arg196, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg196 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "ne" %arg196, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
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



def test18_before := [llvm|
{
^0(%arg194 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(123 : i32) : i32
  %2 = llvm.xor %arg194, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg194 : i32):
  %0 = llvm.mlir.constant(124 : i32) : i32
  %1 = llvm.add %arg194, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
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
^0(%arg192 : i32, %arg193 : i32):
  %0 = llvm.xor %arg192, %arg193 : i32
  %1 = llvm.xor %0, %arg192 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg192 : i32, %arg193 : i32):
  "llvm.return"(%arg193) : (i32) -> ()
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



def test22_before := [llvm|
{
^0(%arg189 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.xor %arg189, %0 : i1
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.xor %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test22_after := [llvm|
{
^0(%arg189 : i1):
  %0 = llvm.zext %arg189 : i1 to i32
  "llvm.return"(%0) : (i32) -> ()
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



def fold_zext_xor_sandwich_before := [llvm|
{
^0(%arg188 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.xor %arg188, %0 : i1
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.xor %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def fold_zext_xor_sandwich_after := [llvm|
{
^0(%arg188 : i1):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.zext %arg188 : i1 to i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_zext_xor_sandwich_proof : fold_zext_xor_sandwich_before ⊑ fold_zext_xor_sandwich_after := by
  unfold fold_zext_xor_sandwich_before fold_zext_xor_sandwich_after
  simp_alive_peephole
  intros
  ---BEGIN fold_zext_xor_sandwich
  apply fold_zext_xor_sandwich_thm
  ---END fold_zext_xor_sandwich



def test23_before := [llvm|
{
^0(%arg185 : i32, %arg186 : i32):
  %0 = llvm.xor %arg186, %arg185 : i32
  %1 = llvm.icmp "eq" %0, %arg185 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
def test23_after := [llvm|
{
^0(%arg185 : i32, %arg186 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg186, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
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
^0(%arg183 : i32, %arg184 : i32):
  %0 = llvm.xor %arg184, %arg183 : i32
  %1 = llvm.icmp "ne" %0, %arg183 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
def test24_after := [llvm|
{
^0(%arg183 : i32, %arg184 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg184, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
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



def test25_before := [llvm|
{
^0(%arg181 : i32, %arg182 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg182, %0 : i32
  %2 = llvm.and %1, %arg181 : i32
  %3 = llvm.xor %2, %arg181 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test25_after := [llvm|
{
^0(%arg181 : i32, %arg182 : i32):
  %0 = llvm.and %arg181, %arg182 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test25_proof : test25_before ⊑ test25_after := by
  unfold test25_before test25_after
  simp_alive_peephole
  intros
  ---BEGIN test25
  apply test25_thm
  ---END test25



def test27_before := [llvm|
{
^0(%arg178 : i32, %arg179 : i32, %arg180 : i32):
  %0 = llvm.xor %arg180, %arg178 : i32
  %1 = llvm.xor %arg180, %arg179 : i32
  %2 = llvm.icmp "eq" %0, %1 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test27_after := [llvm|
{
^0(%arg178 : i32, %arg179 : i32, %arg180 : i32):
  %0 = llvm.icmp "eq" %arg178, %arg179 : i32
  %1 = llvm.zext %0 : i1 to i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test27_proof : test27_before ⊑ test27_after := by
  unfold test27_before test27_after
  simp_alive_peephole
  intros
  ---BEGIN test27
  apply test27_thm
  ---END test27



def test28_before := [llvm|
{
^0(%arg177 : i32):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.add %arg177, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test28_after := [llvm|
{
^0(%arg177 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.add %arg177, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test28_proof : test28_before ⊑ test28_after := by
  unfold test28_before test28_after
  simp_alive_peephole
  intros
  ---BEGIN test28
  apply test28_thm
  ---END test28



def test28_sub_before := [llvm|
{
^0(%arg175 : i32):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.sub %0, %arg175 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test28_sub_after := [llvm|
{
^0(%arg175 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.sub %0, %arg175 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test28_sub_proof : test28_sub_before ⊑ test28_sub_after := by
  unfold test28_sub_before test28_sub_after
  simp_alive_peephole
  intros
  ---BEGIN test28_sub
  apply test28_sub_thm
  ---END test28_sub



def test29_before := [llvm|
{
^0(%arg173 : i1):
  %0 = llvm.mlir.constant(1000 : i32) : i32
  %1 = llvm.mlir.constant(10 : i32) : i32
  %2 = llvm.mlir.constant(123 : i32) : i32
  %3 = "llvm.select"(%arg173, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.xor %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test29_after := [llvm|
{
^0(%arg173 : i1):
  %0 = llvm.mlir.constant(915 : i32) : i32
  %1 = llvm.mlir.constant(113 : i32) : i32
  %2 = "llvm.select"(%arg173, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
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



def or_xor_commute1_before := [llvm|
{
^0(%arg166 : i32, %arg167 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.udiv %0, %arg166 : i32
  %2 = llvm.udiv %0, %arg167 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_xor_commute1_after := [llvm|
{
^0(%arg166 : i32, %arg167 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg166 : i32
  %3 = llvm.udiv %0, %arg167 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_commute1_proof : or_xor_commute1_before ⊑ or_xor_commute1_after := by
  unfold or_xor_commute1_before or_xor_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_commute1
  apply or_xor_commute1_thm
  ---END or_xor_commute1



def or_xor_commute2_before := [llvm|
{
^0(%arg164 : i32, %arg165 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.udiv %0, %arg164 : i32
  %2 = llvm.udiv %0, %arg165 : i32
  %3 = llvm.or %1, %2 : i32
  %4 = llvm.xor %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_xor_commute2_after := [llvm|
{
^0(%arg164 : i32, %arg165 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg164 : i32
  %3 = llvm.udiv %0, %arg165 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_commute2_proof : or_xor_commute2_before ⊑ or_xor_commute2_after := by
  unfold or_xor_commute2_before or_xor_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_commute2
  apply or_xor_commute2_thm
  ---END or_xor_commute2



def or_xor_commute3_before := [llvm|
{
^0(%arg162 : i32, %arg163 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.udiv %0, %arg162 : i32
  %2 = llvm.udiv %0, %arg163 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = llvm.xor %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_xor_commute3_after := [llvm|
{
^0(%arg162 : i32, %arg163 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg162 : i32
  %3 = llvm.udiv %0, %arg163 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_commute3_proof : or_xor_commute3_before ⊑ or_xor_commute3_after := by
  unfold or_xor_commute3_before or_xor_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_commute3
  apply or_xor_commute3_thm
  ---END or_xor_commute3



def or_xor_commute4_before := [llvm|
{
^0(%arg160 : i32, %arg161 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.udiv %0, %arg160 : i32
  %2 = llvm.udiv %0, %arg161 : i32
  %3 = llvm.or %1, %2 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_xor_commute4_after := [llvm|
{
^0(%arg160 : i32, %arg161 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg160 : i32
  %3 = llvm.udiv %0, %arg161 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_commute4_proof : or_xor_commute4_before ⊑ or_xor_commute4_after := by
  unfold or_xor_commute4_before or_xor_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_commute4
  apply or_xor_commute4_thm
  ---END or_xor_commute4



def and_xor_commute1_before := [llvm|
{
^0(%arg155 : i32, %arg156 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.udiv %0, %arg155 : i32
  %2 = llvm.udiv %0, %arg156 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_xor_commute1_after := [llvm|
{
^0(%arg155 : i32, %arg156 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg155 : i32
  %3 = llvm.udiv %0, %arg156 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_commute1_proof : and_xor_commute1_before ⊑ and_xor_commute1_after := by
  unfold and_xor_commute1_before and_xor_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_commute1
  apply and_xor_commute1_thm
  ---END and_xor_commute1



def and_xor_commute2_before := [llvm|
{
^0(%arg153 : i32, %arg154 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.udiv %0, %arg153 : i32
  %2 = llvm.udiv %0, %arg154 : i32
  %3 = llvm.and %1, %2 : i32
  %4 = llvm.xor %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_xor_commute2_after := [llvm|
{
^0(%arg153 : i32, %arg154 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg153 : i32
  %3 = llvm.udiv %0, %arg154 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_commute2_proof : and_xor_commute2_before ⊑ and_xor_commute2_after := by
  unfold and_xor_commute2_before and_xor_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_commute2
  apply and_xor_commute2_thm
  ---END and_xor_commute2



def and_xor_commute3_before := [llvm|
{
^0(%arg151 : i32, %arg152 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.udiv %0, %arg151 : i32
  %2 = llvm.udiv %0, %arg152 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_xor_commute3_after := [llvm|
{
^0(%arg151 : i32, %arg152 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg151 : i32
  %3 = llvm.udiv %0, %arg152 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_commute3_proof : and_xor_commute3_before ⊑ and_xor_commute3_after := by
  unfold and_xor_commute3_before and_xor_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_commute3
  apply and_xor_commute3_thm
  ---END and_xor_commute3



def and_xor_commute4_before := [llvm|
{
^0(%arg149 : i32, %arg150 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.udiv %0, %arg149 : i32
  %2 = llvm.udiv %0, %arg150 : i32
  %3 = llvm.and %1, %2 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_xor_commute4_after := [llvm|
{
^0(%arg149 : i32, %arg150 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg149 : i32
  %3 = llvm.udiv %0, %arg150 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_commute4_proof : and_xor_commute4_before ⊑ and_xor_commute4_after := by
  unfold and_xor_commute4_before and_xor_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_commute4
  apply and_xor_commute4_thm
  ---END and_xor_commute4



def or_or_xor_before := [llvm|
{
^0(%arg106 : i4, %arg107 : i4, %arg108 : i4):
  %0 = llvm.or %arg108, %arg106 : i4
  %1 = llvm.or %arg108, %arg107 : i4
  %2 = llvm.xor %0, %1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def or_or_xor_after := [llvm|
{
^0(%arg106 : i4, %arg107 : i4, %arg108 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg108, %0 : i4
  %2 = llvm.xor %arg106, %arg107 : i4
  %3 = llvm.and %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_xor_proof : or_or_xor_before ⊑ or_or_xor_after := by
  unfold or_or_xor_before or_or_xor_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_xor
  apply or_or_xor_thm
  ---END or_or_xor



def or_or_xor_commute1_before := [llvm|
{
^0(%arg103 : i4, %arg104 : i4, %arg105 : i4):
  %0 = llvm.or %arg103, %arg105 : i4
  %1 = llvm.or %arg105, %arg104 : i4
  %2 = llvm.xor %0, %1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def or_or_xor_commute1_after := [llvm|
{
^0(%arg103 : i4, %arg104 : i4, %arg105 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg105, %0 : i4
  %2 = llvm.xor %arg103, %arg104 : i4
  %3 = llvm.and %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_xor_commute1_proof : or_or_xor_commute1_before ⊑ or_or_xor_commute1_after := by
  unfold or_or_xor_commute1_before or_or_xor_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_xor_commute1
  apply or_or_xor_commute1_thm
  ---END or_or_xor_commute1



def or_or_xor_commute2_before := [llvm|
{
^0(%arg100 : i4, %arg101 : i4, %arg102 : i4):
  %0 = llvm.or %arg102, %arg100 : i4
  %1 = llvm.or %arg101, %arg102 : i4
  %2 = llvm.xor %0, %1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def or_or_xor_commute2_after := [llvm|
{
^0(%arg100 : i4, %arg101 : i4, %arg102 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg102, %0 : i4
  %2 = llvm.xor %arg100, %arg101 : i4
  %3 = llvm.and %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_xor_commute2_proof : or_or_xor_commute2_before ⊑ or_or_xor_commute2_after := by
  unfold or_or_xor_commute2_before or_or_xor_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_xor_commute2
  apply or_or_xor_commute2_thm
  ---END or_or_xor_commute2



def not_is_canonical_before := [llvm|
{
^0(%arg87 : i32, %arg88 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.xor %arg87, %0 : i32
  %3 = llvm.add %2, %arg88 : i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def not_is_canonical_after := [llvm|
{
^0(%arg87 : i32, %arg88 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.xor %arg87, %0 : i32
  %3 = llvm.add %arg88, %2 : i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_is_canonical_proof : not_is_canonical_before ⊑ not_is_canonical_after := by
  unfold not_is_canonical_before not_is_canonical_after
  simp_alive_peephole
  intros
  ---BEGIN not_is_canonical
  apply not_is_canonical_thm
  ---END not_is_canonical



def not_shl_before := [llvm|
{
^0(%arg86 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.shl %arg86, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_shl_after := [llvm|
{
^0(%arg86 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.xor %arg86, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_shl_proof : not_shl_before ⊑ not_shl_after := by
  unfold not_shl_before not_shl_after
  simp_alive_peephole
  intros
  ---BEGIN not_shl
  apply not_shl_thm
  ---END not_shl



def not_lshr_before := [llvm|
{
^0(%arg82 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.lshr %arg82, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_lshr_after := [llvm|
{
^0(%arg82 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.xor %arg82, %0 : i8
  %3 = llvm.lshr %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_lshr_proof : not_lshr_before ⊑ not_lshr_after := by
  unfold not_lshr_before not_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN not_lshr
  apply not_lshr_thm
  ---END not_lshr



def ashr_not_before := [llvm|
{
^0(%arg78 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.xor %arg78, %0 : i8
  %3 = llvm.ashr %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def ashr_not_after := [llvm|
{
^0(%arg78 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %arg78, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_not_proof : ashr_not_before ⊑ ashr_not_after := by
  unfold ashr_not_before ashr_not_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_not
  apply ashr_not_thm
  ---END ashr_not



def xor_andn_commute2_before := [llvm|
{
^0(%arg70 : i33, %arg71 : i33):
  %0 = llvm.mlir.constant(42 : i33) : i33
  %1 = llvm.mlir.constant(-1 : i33) : i33
  %2 = llvm.udiv %0, %arg71 : i33
  %3 = llvm.xor %arg70, %1 : i33
  %4 = llvm.and %2, %3 : i33
  %5 = llvm.xor %4, %arg70 : i33
  "llvm.return"(%5) : (i33) -> ()
}
]
def xor_andn_commute2_after := [llvm|
{
^0(%arg70 : i33, %arg71 : i33):
  %0 = llvm.mlir.constant(42 : i33) : i33
  %1 = llvm.udiv %0, %arg71 : i33
  %2 = llvm.or %arg70, %1 : i33
  "llvm.return"(%2) : (i33) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_andn_commute2_proof : xor_andn_commute2_before ⊑ xor_andn_commute2_after := by
  unfold xor_andn_commute2_before xor_andn_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN xor_andn_commute2
  apply xor_andn_commute2_thm
  ---END xor_andn_commute2



def xor_andn_commute3_before := [llvm|
{
^0(%arg68 : i32, %arg69 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg68 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = llvm.and %3, %arg69 : i32
  %5 = llvm.xor %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def xor_andn_commute3_after := [llvm|
{
^0(%arg68 : i32, %arg69 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.udiv %0, %arg68 : i32
  %2 = llvm.or %1, %arg69 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_andn_commute3_proof : xor_andn_commute3_before ⊑ xor_andn_commute3_after := by
  unfold xor_andn_commute3_before xor_andn_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN xor_andn_commute3
  apply xor_andn_commute3_thm
  ---END xor_andn_commute3



def xor_andn_commute4_before := [llvm|
{
^0(%arg66 : i32, %arg67 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg66 : i32
  %3 = llvm.udiv %0, %arg67 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.and %3, %4 : i32
  %6 = llvm.xor %2, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def xor_andn_commute4_after := [llvm|
{
^0(%arg66 : i32, %arg67 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.udiv %0, %arg66 : i32
  %2 = llvm.udiv %0, %arg67 : i32
  %3 = llvm.or %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_andn_commute4_proof : xor_andn_commute4_before ⊑ xor_andn_commute4_after := by
  unfold xor_andn_commute4_before xor_andn_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN xor_andn_commute4
  apply xor_andn_commute4_thm
  ---END xor_andn_commute4



def xor_orn_commute1_before := [llvm|
{
^0(%arg62 : i8, %arg63 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.udiv %0, %arg62 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.or %3, %arg63 : i8
  %5 = llvm.xor %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def xor_orn_commute1_after := [llvm|
{
^0(%arg62 : i8, %arg63 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.udiv %0, %arg62 : i8
  %3 = llvm.and %2, %arg63 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_orn_commute1_proof : xor_orn_commute1_before ⊑ xor_orn_commute1_after := by
  unfold xor_orn_commute1_before xor_orn_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN xor_orn_commute1
  apply xor_orn_commute1_thm
  ---END xor_orn_commute1



def tryFactorization_xor_ashr_lshr_before := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.ashr %0, %arg40 : i32
  %3 = llvm.lshr %1, %arg40 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def tryFactorization_xor_ashr_lshr_after := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(-8 : i32) : i32
  %1 = llvm.ashr %0, %arg40 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_xor_ashr_lshr_proof : tryFactorization_xor_ashr_lshr_before ⊑ tryFactorization_xor_ashr_lshr_after := by
  unfold tryFactorization_xor_ashr_lshr_before tryFactorization_xor_ashr_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_xor_ashr_lshr
  apply tryFactorization_xor_ashr_lshr_thm
  ---END tryFactorization_xor_ashr_lshr



def tryFactorization_xor_lshr_ashr_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.ashr %0, %arg39 : i32
  %3 = llvm.lshr %1, %arg39 : i32
  %4 = llvm.xor %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def tryFactorization_xor_lshr_ashr_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(-8 : i32) : i32
  %1 = llvm.ashr %0, %arg39 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_xor_lshr_ashr_proof : tryFactorization_xor_lshr_ashr_before ⊑ tryFactorization_xor_lshr_ashr_after := by
  unfold tryFactorization_xor_lshr_ashr_before tryFactorization_xor_lshr_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_xor_lshr_ashr
  apply tryFactorization_xor_lshr_ashr_thm
  ---END tryFactorization_xor_lshr_ashr



def tryFactorization_xor_lshr_lshr_before := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.lshr %0, %arg37 : i32
  %3 = llvm.lshr %1, %arg37 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def tryFactorization_xor_lshr_lshr_after := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(-8 : i32) : i32
  %1 = llvm.lshr %0, %arg37 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_xor_lshr_lshr_proof : tryFactorization_xor_lshr_lshr_before ⊑ tryFactorization_xor_lshr_lshr_after := by
  unfold tryFactorization_xor_lshr_lshr_before tryFactorization_xor_lshr_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_xor_lshr_lshr
  apply tryFactorization_xor_lshr_lshr_thm
  ---END tryFactorization_xor_lshr_lshr



def tryFactorization_xor_ashr_ashr_before := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.mlir.constant(-5 : i32) : i32
  %2 = llvm.ashr %0, %arg36 : i32
  %3 = llvm.ashr %1, %arg36 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def tryFactorization_xor_ashr_ashr_after := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.lshr %0, %arg36 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem tryFactorization_xor_ashr_ashr_proof : tryFactorization_xor_ashr_ashr_before ⊑ tryFactorization_xor_ashr_ashr_after := by
  unfold tryFactorization_xor_ashr_ashr_before tryFactorization_xor_ashr_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN tryFactorization_xor_ashr_ashr
  apply tryFactorization_xor_ashr_ashr_thm
  ---END tryFactorization_xor_ashr_ashr



def PR96857_xor_with_noundef_before := [llvm|
{
^0(%arg33 : i4, %arg34 : i4, %arg35 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.and %arg35, %arg33 : i4
  %2 = llvm.xor %arg35, %0 : i4
  %3 = llvm.and %2, %arg34 : i4
  %4 = llvm.xor %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def PR96857_xor_with_noundef_after := [llvm|
{
^0(%arg33 : i4, %arg34 : i4, %arg35 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.and %arg35, %arg33 : i4
  %2 = llvm.xor %arg35, %0 : i4
  %3 = llvm.and %arg34, %2 : i4
  %4 = llvm.or disjoint %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR96857_xor_with_noundef_proof : PR96857_xor_with_noundef_before ⊑ PR96857_xor_with_noundef_after := by
  unfold PR96857_xor_with_noundef_before PR96857_xor_with_noundef_after
  simp_alive_peephole
  intros
  ---BEGIN PR96857_xor_with_noundef
  apply PR96857_xor_with_noundef_thm
  ---END PR96857_xor_with_noundef



def PR96857_xor_without_noundef_before := [llvm|
{
^0(%arg30 : i4, %arg31 : i4, %arg32 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.and %arg32, %arg30 : i4
  %2 = llvm.xor %arg32, %0 : i4
  %3 = llvm.and %2, %arg31 : i4
  %4 = llvm.xor %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def PR96857_xor_without_noundef_after := [llvm|
{
^0(%arg30 : i4, %arg31 : i4, %arg32 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.and %arg32, %arg30 : i4
  %2 = llvm.xor %arg32, %0 : i4
  %3 = llvm.and %arg31, %2 : i4
  %4 = llvm.or %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR96857_xor_without_noundef_proof : PR96857_xor_without_noundef_before ⊑ PR96857_xor_without_noundef_after := by
  unfold PR96857_xor_without_noundef_before PR96857_xor_without_noundef_after
  simp_alive_peephole
  intros
  ---BEGIN PR96857_xor_without_noundef
  apply PR96857_xor_without_noundef_thm
  ---END PR96857_xor_without_noundef



def or_disjoint_with_xor_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.or disjoint %arg28, %arg29 : i32
  %1 = llvm.xor %0, %arg28 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def or_disjoint_with_xor_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  "llvm.return"(%arg29) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_disjoint_with_xor_proof : or_disjoint_with_xor_before ⊑ or_disjoint_with_xor_after := by
  unfold or_disjoint_with_xor_before or_disjoint_with_xor_after
  simp_alive_peephole
  intros
  ---BEGIN or_disjoint_with_xor
  apply or_disjoint_with_xor_thm
  ---END or_disjoint_with_xor



def xor_with_or_disjoint_ab_before := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.or disjoint %arg26, %arg27 : i32
  %1 = llvm.xor %arg26, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def xor_with_or_disjoint_ab_after := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  "llvm.return"(%arg27) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_with_or_disjoint_ab_proof : xor_with_or_disjoint_ab_before ⊑ xor_with_or_disjoint_ab_after := by
  unfold xor_with_or_disjoint_ab_before xor_with_or_disjoint_ab_after
  simp_alive_peephole
  intros
  ---BEGIN xor_with_or_disjoint_ab
  apply xor_with_or_disjoint_ab_thm
  ---END xor_with_or_disjoint_ab



def xor_with_or_disjoint_ba_before := [llvm|
{
^0(%arg24 : i32, %arg25 : i32):
  %0 = llvm.or disjoint %arg25, %arg24 : i32
  %1 = llvm.xor %arg25, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def xor_with_or_disjoint_ba_after := [llvm|
{
^0(%arg24 : i32, %arg25 : i32):
  "llvm.return"(%arg24) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_with_or_disjoint_ba_proof : xor_with_or_disjoint_ba_before ⊑ xor_with_or_disjoint_ba_after := by
  unfold xor_with_or_disjoint_ba_before xor_with_or_disjoint_ba_after
  simp_alive_peephole
  intros
  ---BEGIN xor_with_or_disjoint_ba
  apply xor_with_or_disjoint_ba_thm
  ---END xor_with_or_disjoint_ba



def select_or_disjoint_or_before := [llvm|
{
^0(%arg14 : i32, %arg15 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = "llvm.select"(%arg15, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.shl %arg14, %1 : i32
  %4 = llvm.or disjoint %2, %3 : i32
  %5 = llvm.add %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select_or_disjoint_or_after := [llvm|
{
^0(%arg14 : i32, %arg15 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = "llvm.select"(%arg15, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.shl %arg14, %1 : i32
  %4 = llvm.or disjoint %2, %3 : i32
  %5 = llvm.add %4, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_or_disjoint_or_proof : select_or_disjoint_or_before ⊑ select_or_disjoint_or_after := by
  unfold select_or_disjoint_or_before select_or_disjoint_or_after
  simp_alive_peephole
  intros
  ---BEGIN select_or_disjoint_or
  apply select_or_disjoint_or_thm
  ---END select_or_disjoint_or


