import SSA.Projects.InstCombine.tests.proofs.gand_proof
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
section gand_statements

def test_with_1_before := [llvm|
{
^0(%arg317 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg317 : i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_with_1_after := [llvm|
{
^0(%arg317 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg317, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_with_1_proof : test_with_1_before ⊑ test_with_1_after := by
  unfold test_with_1_before test_with_1_after
  simp_alive_peephole
  intros
  ---BEGIN test_with_1
  apply test_with_1_thm
  ---END test_with_1



def test_with_3_before := [llvm|
{
^0(%arg316 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.shl %0, %arg316 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_with_3_after := [llvm|
{
^0(%arg316 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg316, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_with_3_proof : test_with_3_before ⊑ test_with_3_after := by
  unfold test_with_3_before test_with_3_after
  simp_alive_peephole
  intros
  ---BEGIN test_with_3
  apply test_with_3_thm
  ---END test_with_3



def test_with_5_before := [llvm|
{
^0(%arg315 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.shl %0, %arg315 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_with_5_after := [llvm|
{
^0(%arg315 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg315, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_with_5_proof : test_with_5_before ⊑ test_with_5_after := by
  unfold test_with_5_before test_with_5_after
  simp_alive_peephole
  intros
  ---BEGIN test_with_5
  apply test_with_5_thm
  ---END test_with_5



def test_with_neg_5_before := [llvm|
{
^0(%arg314 : i32):
  %0 = llvm.mlir.constant(-5 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.shl %0, %arg314 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_with_neg_5_after := [llvm|
{
^0(%arg314 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg314, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_with_neg_5_proof : test_with_neg_5_before ⊑ test_with_neg_5_after := by
  unfold test_with_neg_5_before test_with_neg_5_after
  simp_alive_peephole
  intros
  ---BEGIN test_with_neg_5
  apply test_with_neg_5_thm
  ---END test_with_neg_5



def test_with_even_before := [llvm|
{
^0(%arg313 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.shl %0, %arg313 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_with_even_after := [llvm|
{
^0(%arg313 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_with_even_proof : test_with_even_before ⊑ test_with_even_after := by
  unfold test_with_even_before test_with_even_after
  simp_alive_peephole
  intros
  ---BEGIN test_with_even
  apply test_with_even_thm
  ---END test_with_even



def test_with_neg_even_before := [llvm|
{
^0(%arg311 : i32):
  %0 = llvm.mlir.constant(-4 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.shl %0, %arg311 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_with_neg_even_after := [llvm|
{
^0(%arg311 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_with_neg_even_proof : test_with_neg_even_before ⊑ test_with_neg_even_after := by
  unfold test_with_neg_even_before test_with_neg_even_after
  simp_alive_peephole
  intros
  ---BEGIN test_with_neg_even
  apply test_with_neg_even_thm
  ---END test_with_neg_even



def test1_before := [llvm|
{
^0(%arg309 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.and %arg309, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg309 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
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
^0(%arg308 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg308, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg308 : i32):
  "llvm.return"(%arg308) : (i32) -> ()
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
^0(%arg307 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.and %arg307, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg307 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
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



def test3_logical_before := [llvm|
{
^0(%arg306 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg306, %0, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test3_logical_after := [llvm|
{
^0(%arg306 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_logical_proof : test3_logical_before ⊑ test3_logical_after := by
  unfold test3_logical_before test3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test3_logical
  apply test3_logical_thm
  ---END test3_logical



def test4_before := [llvm|
{
^0(%arg305 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg305, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg305 : i1):
  "llvm.return"(%arg305) : (i1) -> ()
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



def test4_logical_before := [llvm|
{
^0(%arg304 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg304, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test4_logical_after := [llvm|
{
^0(%arg304 : i1):
  "llvm.return"(%arg304) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4_logical_proof : test4_logical_before ⊑ test4_logical_after := by
  unfold test4_logical_before test4_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test4_logical
  apply test4_logical_thm
  ---END test4_logical



def test5_before := [llvm|
{
^0(%arg303 : i32):
  %0 = llvm.and %arg303, %arg303 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg303 : i32):
  "llvm.return"(%arg303) : (i32) -> ()
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
^0(%arg302 : i1):
  %0 = llvm.and %arg302, %arg302 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg302 : i1):
  "llvm.return"(%arg302) : (i1) -> ()
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



def test6_logical_before := [llvm|
{
^0(%arg301 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg301, %arg301, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test6_logical_after := [llvm|
{
^0(%arg301 : i1):
  "llvm.return"(%arg301) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test6_logical_proof : test6_logical_before ⊑ test6_logical_after := by
  unfold test6_logical_before test6_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test6_logical
  apply test6_logical_thm
  ---END test6_logical



def test7_before := [llvm|
{
^0(%arg300 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg300, %0 : i32
  %2 = llvm.and %arg300, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg300 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
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
^0(%arg299 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.and %arg299, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg299 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  "llvm.return"(%0) : (i8) -> ()
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
^0(%arg298 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg298, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg298 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg298, %0 : i32
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



def test9a_before := [llvm|
{
^0(%arg297 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg297, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test9a_after := [llvm|
{
^0(%arg297 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg297, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test9a_proof : test9a_before ⊑ test9a_after := by
  unfold test9a_before test9a_after
  simp_alive_peephole
  intros
  ---BEGIN test9a
  apply test9a_thm
  ---END test9a



def test10_before := [llvm|
{
^0(%arg296 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg296, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg296 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
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



def test12_before := [llvm|
{
^0(%arg292 : i32, %arg293 : i32):
  %0 = llvm.icmp "ult" %arg292, %arg293 : i32
  %1 = llvm.icmp "ule" %arg292, %arg293 : i32
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg292 : i32, %arg293 : i32):
  %0 = llvm.icmp "ult" %arg292, %arg293 : i32
  "llvm.return"(%0) : (i1) -> ()
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



def test12_logical_before := [llvm|
{
^0(%arg290 : i32, %arg291 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "ult" %arg290, %arg291 : i32
  %2 = llvm.icmp "ule" %arg290, %arg291 : i32
  %3 = "llvm.select"(%1, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test12_logical_after := [llvm|
{
^0(%arg290 : i32, %arg291 : i32):
  %0 = llvm.icmp "ult" %arg290, %arg291 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test12_logical_proof : test12_logical_before ⊑ test12_logical_after := by
  unfold test12_logical_before test12_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test12_logical
  apply test12_logical_thm
  ---END test12_logical



def test13_before := [llvm|
{
^0(%arg288 : i32, %arg289 : i32):
  %0 = llvm.icmp "ult" %arg288, %arg289 : i32
  %1 = llvm.icmp "ugt" %arg288, %arg289 : i32
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg288 : i32, %arg289 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
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



def test13_logical_before := [llvm|
{
^0(%arg286 : i32, %arg287 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "ult" %arg286, %arg287 : i32
  %2 = llvm.icmp "ugt" %arg286, %arg287 : i32
  %3 = "llvm.select"(%1, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test13_logical_after := [llvm|
{
^0(%arg286 : i32, %arg287 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test13_logical_proof : test13_logical_before ⊑ test13_logical_after := by
  unfold test13_logical_before test13_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test13_logical
  apply test13_logical_thm
  ---END test13_logical



def test14_before := [llvm|
{
^0(%arg285 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg285, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg285 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg285, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
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
^0(%arg284 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.lshr %arg284, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg284 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  "llvm.return"(%0) : (i8) -> ()
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
^0(%arg283 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.shl %arg283, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg283 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  "llvm.return"(%0) : (i8) -> ()
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



def test18_before := [llvm|
{
^0(%arg282 : i32):
  %0 = llvm.mlir.constant(-128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg282, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg282 : i32):
  %0 = llvm.mlir.constant(127 : i32) : i32
  %1 = llvm.icmp "ugt" %arg282, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
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



def test18a_before := [llvm|
{
^0(%arg280 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg280, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def test18a_after := [llvm|
{
^0(%arg280 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.icmp "ult" %arg280, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test18a_proof : test18a_before ⊑ test18a_after := by
  unfold test18a_before test18a_after
  simp_alive_peephole
  intros
  ---BEGIN test18a
  apply test18a_thm
  ---END test18a



def test19_before := [llvm|
{
^0(%arg278 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.shl %arg278, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg278 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.shl %arg278, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
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
^0(%arg277 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr %arg277, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test20_after := [llvm|
{
^0(%arg277 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.lshr %arg277, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
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



def test23_before := [llvm|
{
^0(%arg276 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.icmp "sgt" %arg276, %0 : i32
  %3 = llvm.icmp "sle" %arg276, %1 : i32
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test23_after := [llvm|
{
^0(%arg276 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "eq" %arg276, %0 : i32
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



def test23_logical_before := [llvm|
{
^0(%arg275 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "sgt" %arg275, %0 : i32
  %4 = llvm.icmp "sle" %arg275, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test23_logical_after := [llvm|
{
^0(%arg275 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "eq" %arg275, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test23_logical_proof : test23_logical_before ⊑ test23_logical_after := by
  unfold test23_logical_before test23_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test23_logical
  apply test23_logical_thm
  ---END test23_logical



def test24_before := [llvm|
{
^0(%arg273 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.icmp "sgt" %arg273, %0 : i32
  %3 = llvm.icmp "ne" %arg273, %1 : i32
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test24_after := [llvm|
{
^0(%arg273 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "sgt" %arg273, %0 : i32
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



def test24_logical_before := [llvm|
{
^0(%arg272 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "sgt" %arg272, %0 : i32
  %4 = llvm.icmp "ne" %arg272, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test24_logical_after := [llvm|
{
^0(%arg272 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "sgt" %arg272, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test24_logical_proof : test24_logical_before ⊑ test24_logical_after := by
  unfold test24_logical_before test24_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test24_logical
  apply test24_logical_thm
  ---END test24_logical



def test25_before := [llvm|
{
^0(%arg271 : i32):
  %0 = llvm.mlir.constant(50 : i32) : i32
  %1 = llvm.mlir.constant(100 : i32) : i32
  %2 = llvm.icmp "sge" %arg271, %0 : i32
  %3 = llvm.icmp "slt" %arg271, %1 : i32
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test25_after := [llvm|
{
^0(%arg271 : i32):
  %0 = llvm.mlir.constant(-50 : i32) : i32
  %1 = llvm.mlir.constant(50 : i32) : i32
  %2 = llvm.add %arg271, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
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



def test25_logical_before := [llvm|
{
^0(%arg270 : i32):
  %0 = llvm.mlir.constant(50 : i32) : i32
  %1 = llvm.mlir.constant(100 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "sge" %arg270, %0 : i32
  %4 = llvm.icmp "slt" %arg270, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test25_logical_after := [llvm|
{
^0(%arg270 : i32):
  %0 = llvm.mlir.constant(-50 : i32) : i32
  %1 = llvm.mlir.constant(50 : i32) : i32
  %2 = llvm.add %arg270, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test25_logical_proof : test25_logical_before ⊑ test25_logical_after := by
  unfold test25_logical_before test25_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test25_logical
  apply test25_logical_thm
  ---END test25_logical



def test27_before := [llvm|
{
^0(%arg268 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(16 : i8) : i8
  %2 = llvm.mlir.constant(-16 : i8) : i8
  %3 = llvm.and %arg268, %0 : i8
  %4 = llvm.sub %3, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.add %5, %1 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def test27_after := [llvm|
{
^0(%arg268 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  "llvm.return"(%0) : (i8) -> ()
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



def ashr_lowmask_before := [llvm|
{
^0(%arg267 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.ashr %arg267, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_lowmask_after := [llvm|
{
^0(%arg267 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.lshr %arg267, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lowmask_proof : ashr_lowmask_before ⊑ ashr_lowmask_after := by
  unfold ashr_lowmask_before ashr_lowmask_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lowmask
  apply ashr_lowmask_thm
  ---END ashr_lowmask



def test29_before := [llvm|
{
^0(%arg260 : i8):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.zext %arg260 : i8 to i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test29_after := [llvm|
{
^0(%arg260 : i8):
  %0 = llvm.zext %arg260 : i8 to i32
  "llvm.return"(%0) : (i32) -> ()
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



def test30_before := [llvm|
{
^0(%arg259 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext %arg259 : i1 to i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test30_after := [llvm|
{
^0(%arg259 : i1):
  %0 = llvm.zext %arg259 : i1 to i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test30_proof : test30_before ⊑ test30_after := by
  unfold test30_before test30_after
  simp_alive_peephole
  intros
  ---BEGIN test30
  apply test30_thm
  ---END test30



def test31_before := [llvm|
{
^0(%arg258 : i1):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.zext %arg258 : i1 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test31_after := [llvm|
{
^0(%arg258 : i1):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = "llvm.select"(%arg258, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
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



def and_zext_demanded_before := [llvm|
{
^0(%arg255 : i16, %arg256 : i32):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.lshr %arg255, %0 : i16
  %3 = llvm.zext %2 : i16 to i32
  %4 = llvm.or %arg256, %1 : i32
  %5 = llvm.and %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def and_zext_demanded_after := [llvm|
{
^0(%arg255 : i16, %arg256 : i32):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.lshr %arg255, %0 : i16
  %2 = llvm.zext nneg %1 : i16 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_zext_demanded_proof : and_zext_demanded_before ⊑ and_zext_demanded_after := by
  unfold and_zext_demanded_before and_zext_demanded_after
  simp_alive_peephole
  intros
  ---BEGIN and_zext_demanded
  apply and_zext_demanded_thm
  ---END and_zext_demanded



def test32_before := [llvm|
{
^0(%arg254 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg254, %0 : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test32_after := [llvm|
{
^0(%arg254 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test32_proof : test32_before ⊑ test32_after := by
  unfold test32_before test32_after
  simp_alive_peephole
  intros
  ---BEGIN test32
  apply test32_thm
  ---END test32



def test33_before := [llvm|
{
^0(%arg253 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.and %arg253, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %arg253, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test33_after := [llvm|
{
^0(%arg253 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.xor %arg253, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test33_proof : test33_before ⊑ test33_after := by
  unfold test33_before test33_after
  simp_alive_peephole
  intros
  ---BEGIN test33
  apply test33_thm
  ---END test33



def test33b_before := [llvm|
{
^0(%arg252 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.and %arg252, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %arg252, %1 : i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test33b_after := [llvm|
{
^0(%arg252 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.xor %arg252, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test33b_proof : test33b_before ⊑ test33b_after := by
  unfold test33b_before test33b_after
  simp_alive_peephole
  intros
  ---BEGIN test33b
  apply test33b_thm
  ---END test33b



def test34_before := [llvm|
{
^0(%arg248 : i32, %arg249 : i32):
  %0 = llvm.or %arg249, %arg248 : i32
  %1 = llvm.and %0, %arg249 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test34_after := [llvm|
{
^0(%arg248 : i32, %arg249 : i32):
  "llvm.return"(%arg249) : (i32) -> ()
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



def test35_before := [llvm|
{
^0(%arg246 : i32):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(240) : i64
  %2 = llvm.zext %arg246 : i32 to i64
  %3 = llvm.sub %0, %2 : i64
  %4 = llvm.and %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test35_after := [llvm|
{
^0(%arg246 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(240 : i32) : i32
  %2 = llvm.sub %0, %arg246 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test35_proof : test35_before ⊑ test35_after := by
  unfold test35_before test35_after
  simp_alive_peephole
  intros
  ---BEGIN test35
  apply test35_thm
  ---END test35



def test36_before := [llvm|
{
^0(%arg244 : i32):
  %0 = llvm.mlir.constant(7) : i64
  %1 = llvm.mlir.constant(240) : i64
  %2 = llvm.zext %arg244 : i32 to i64
  %3 = llvm.add %2, %0 : i64
  %4 = llvm.and %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test36_after := [llvm|
{
^0(%arg244 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(240 : i32) : i32
  %2 = llvm.add %arg244, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
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
^0(%arg241 : i32):
  %0 = llvm.mlir.constant(7) : i64
  %1 = llvm.mlir.constant(240) : i64
  %2 = llvm.zext %arg241 : i32 to i64
  %3 = llvm.mul %2, %0 : i64
  %4 = llvm.and %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test37_after := [llvm|
{
^0(%arg241 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(240 : i32) : i32
  %2 = llvm.mul %arg241, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
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
^0(%arg238 : i32):
  %0 = llvm.mlir.constant(7) : i64
  %1 = llvm.mlir.constant(240) : i64
  %2 = llvm.zext %arg238 : i32 to i64
  %3 = llvm.xor %2, %0 : i64
  %4 = llvm.and %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test38_after := [llvm|
{
^0(%arg238 : i32):
  %0 = llvm.mlir.constant(240 : i32) : i32
  %1 = llvm.and %arg238, %0 : i32
  %2 = llvm.zext nneg %1 : i32 to i64
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



def test39_before := [llvm|
{
^0(%arg237 : i32):
  %0 = llvm.mlir.constant(7) : i64
  %1 = llvm.mlir.constant(240) : i64
  %2 = llvm.zext %arg237 : i32 to i64
  %3 = llvm.or %2, %0 : i64
  %4 = llvm.and %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test39_after := [llvm|
{
^0(%arg237 : i32):
  %0 = llvm.mlir.constant(240 : i32) : i32
  %1 = llvm.and %arg237, %0 : i32
  %2 = llvm.zext nneg %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test39_proof : test39_before ⊑ test39_after := by
  unfold test39_before test39_after
  simp_alive_peephole
  intros
  ---BEGIN test39
  apply test39_thm
  ---END test39



def lowmask_add_zext_before := [llvm|
{
^0(%arg235 : i8, %arg236 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.zext %arg235 : i8 to i32
  %2 = llvm.add %1, %arg236 : i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lowmask_add_zext_after := [llvm|
{
^0(%arg235 : i8, %arg236 : i32):
  %0 = llvm.trunc %arg236 : i32 to i8
  %1 = llvm.add %arg235, %0 : i8
  %2 = llvm.zext %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lowmask_add_zext_proof : lowmask_add_zext_before ⊑ lowmask_add_zext_after := by
  unfold lowmask_add_zext_before lowmask_add_zext_after
  simp_alive_peephole
  intros
  ---BEGIN lowmask_add_zext
  apply lowmask_add_zext_thm
  ---END lowmask_add_zext



def lowmask_add_zext_commute_before := [llvm|
{
^0(%arg233 : i16, %arg234 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mul %arg234, %arg234 : i32
  %2 = llvm.zext %arg233 : i16 to i32
  %3 = llvm.add %1, %2 : i32
  %4 = llvm.and %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def lowmask_add_zext_commute_after := [llvm|
{
^0(%arg233 : i16, %arg234 : i32):
  %0 = llvm.mul %arg234, %arg234 : i32
  %1 = llvm.trunc %0 : i32 to i16
  %2 = llvm.add %arg233, %1 : i16
  %3 = llvm.zext %2 : i16 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lowmask_add_zext_commute_proof : lowmask_add_zext_commute_before ⊑ lowmask_add_zext_commute_after := by
  unfold lowmask_add_zext_commute_before lowmask_add_zext_commute_after
  simp_alive_peephole
  intros
  ---BEGIN lowmask_add_zext_commute
  apply lowmask_add_zext_commute_thm
  ---END lowmask_add_zext_commute



def lowmask_add_zext_wrong_mask_before := [llvm|
{
^0(%arg231 : i8, %arg232 : i32):
  %0 = llvm.mlir.constant(511 : i32) : i32
  %1 = llvm.zext %arg231 : i8 to i32
  %2 = llvm.add %1, %arg232 : i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lowmask_add_zext_wrong_mask_after := [llvm|
{
^0(%arg231 : i8, %arg232 : i32):
  %0 = llvm.mlir.constant(511 : i32) : i32
  %1 = llvm.zext %arg231 : i8 to i32
  %2 = llvm.add %arg232, %1 : i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lowmask_add_zext_wrong_mask_proof : lowmask_add_zext_wrong_mask_before ⊑ lowmask_add_zext_wrong_mask_after := by
  unfold lowmask_add_zext_wrong_mask_before lowmask_add_zext_wrong_mask_after
  simp_alive_peephole
  intros
  ---BEGIN lowmask_add_zext_wrong_mask
  apply lowmask_add_zext_wrong_mask_thm
  ---END lowmask_add_zext_wrong_mask



def lowmask_sub_zext_commute_before := [llvm|
{
^0(%arg223 : i5, %arg224 : i17):
  %0 = llvm.mlir.constant(31 : i17) : i17
  %1 = llvm.zext %arg223 : i5 to i17
  %2 = llvm.sub %arg224, %1 : i17
  %3 = llvm.and %2, %0 : i17
  "llvm.return"(%3) : (i17) -> ()
}
]
def lowmask_sub_zext_commute_after := [llvm|
{
^0(%arg223 : i5, %arg224 : i17):
  %0 = llvm.trunc %arg224 : i17 to i5
  %1 = llvm.sub %0, %arg223 : i5
  %2 = llvm.zext %1 : i5 to i17
  "llvm.return"(%2) : (i17) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lowmask_sub_zext_commute_proof : lowmask_sub_zext_commute_before ⊑ lowmask_sub_zext_commute_after := by
  unfold lowmask_sub_zext_commute_before lowmask_sub_zext_commute_after
  simp_alive_peephole
  intros
  ---BEGIN lowmask_sub_zext_commute
  apply lowmask_sub_zext_commute_thm
  ---END lowmask_sub_zext_commute



def lowmask_mul_zext_before := [llvm|
{
^0(%arg221 : i8, %arg222 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.zext %arg221 : i8 to i32
  %2 = llvm.mul %1, %arg222 : i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lowmask_mul_zext_after := [llvm|
{
^0(%arg221 : i8, %arg222 : i32):
  %0 = llvm.trunc %arg222 : i32 to i8
  %1 = llvm.mul %arg221, %0 : i8
  %2 = llvm.zext %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lowmask_mul_zext_proof : lowmask_mul_zext_before ⊑ lowmask_mul_zext_after := by
  unfold lowmask_mul_zext_before lowmask_mul_zext_after
  simp_alive_peephole
  intros
  ---BEGIN lowmask_mul_zext
  apply lowmask_mul_zext_thm
  ---END lowmask_mul_zext



def lowmask_xor_zext_commute_before := [llvm|
{
^0(%arg219 : i8, %arg220 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mul %arg220, %arg220 : i32
  %2 = llvm.zext %arg219 : i8 to i32
  %3 = llvm.xor %1, %2 : i32
  %4 = llvm.and %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def lowmask_xor_zext_commute_after := [llvm|
{
^0(%arg219 : i8, %arg220 : i32):
  %0 = llvm.mul %arg220, %arg220 : i32
  %1 = llvm.trunc %0 : i32 to i8
  %2 = llvm.xor %arg219, %1 : i8
  %3 = llvm.zext %2 : i8 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lowmask_xor_zext_commute_proof : lowmask_xor_zext_commute_before ⊑ lowmask_xor_zext_commute_after := by
  unfold lowmask_xor_zext_commute_before lowmask_xor_zext_commute_after
  simp_alive_peephole
  intros
  ---BEGIN lowmask_xor_zext_commute
  apply lowmask_xor_zext_commute_thm
  ---END lowmask_xor_zext_commute



def lowmask_or_zext_commute_before := [llvm|
{
^0(%arg217 : i16, %arg218 : i24):
  %0 = llvm.mlir.constant(65535 : i24) : i24
  %1 = llvm.zext %arg217 : i16 to i24
  %2 = llvm.or %arg218, %1 : i24
  %3 = llvm.and %2, %0 : i24
  "llvm.return"(%3) : (i24) -> ()
}
]
def lowmask_or_zext_commute_after := [llvm|
{
^0(%arg217 : i16, %arg218 : i24):
  %0 = llvm.trunc %arg218 : i24 to i16
  %1 = llvm.or %arg217, %0 : i16
  %2 = llvm.zext %1 : i16 to i24
  "llvm.return"(%2) : (i24) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lowmask_or_zext_commute_proof : lowmask_or_zext_commute_before ⊑ lowmask_or_zext_commute_after := by
  unfold lowmask_or_zext_commute_before lowmask_or_zext_commute_after
  simp_alive_peephole
  intros
  ---BEGIN lowmask_or_zext_commute
  apply lowmask_or_zext_commute_thm
  ---END lowmask_or_zext_commute



def test40_before := [llvm|
{
^0(%arg216 : i1):
  %0 = llvm.mlir.constant(1000 : i32) : i32
  %1 = llvm.mlir.constant(10 : i32) : i32
  %2 = llvm.mlir.constant(123 : i32) : i32
  %3 = "llvm.select"(%arg216, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.and %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test40_after := [llvm|
{
^0(%arg216 : i1):
  %0 = llvm.mlir.constant(104 : i32) : i32
  %1 = llvm.mlir.constant(10 : i32) : i32
  %2 = "llvm.select"(%arg216, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
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
^0(%arg208 : i32, %arg209 : i32, %arg210 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg209, %arg210 : i32
  %2 = llvm.or %arg208, %1 : i32
  %3 = llvm.xor %arg208, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test42_after := [llvm|
{
^0(%arg208 : i32, %arg209 : i32, %arg210 : i32):
  %0 = llvm.mul %arg209, %arg210 : i32
  %1 = llvm.and %0, %arg208 : i32
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
^0(%arg205 : i32, %arg206 : i32, %arg207 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg206, %arg207 : i32
  %2 = llvm.or %arg205, %1 : i32
  %3 = llvm.xor %arg205, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test43_after := [llvm|
{
^0(%arg205 : i32, %arg206 : i32, %arg207 : i32):
  %0 = llvm.mul %arg206, %arg207 : i32
  %1 = llvm.and %0, %arg205 : i32
  "llvm.return"(%1) : (i32) -> ()
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
^0(%arg203 : i32, %arg204 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg204, %0 : i32
  %2 = llvm.or %1, %arg203 : i32
  %3 = llvm.and %2, %arg204 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test44_after := [llvm|
{
^0(%arg203 : i32, %arg204 : i32):
  %0 = llvm.and %arg203, %arg204 : i32
  "llvm.return"(%0) : (i32) -> ()
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



def test45_before := [llvm|
{
^0(%arg201 : i32, %arg202 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg202, %0 : i32
  %2 = llvm.or %arg201, %1 : i32
  %3 = llvm.and %2, %arg202 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test45_after := [llvm|
{
^0(%arg201 : i32, %arg202 : i32):
  %0 = llvm.and %arg201, %arg202 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test45_proof : test45_before ⊑ test45_after := by
  unfold test45_before test45_after
  simp_alive_peephole
  intros
  ---BEGIN test45
  apply test45_thm
  ---END test45



def test46_before := [llvm|
{
^0(%arg199 : i32, %arg200 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg200, %0 : i32
  %2 = llvm.or %1, %arg199 : i32
  %3 = llvm.and %arg200, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test46_after := [llvm|
{
^0(%arg199 : i32, %arg200 : i32):
  %0 = llvm.and %arg200, %arg199 : i32
  "llvm.return"(%0) : (i32) -> ()
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
^0(%arg197 : i32, %arg198 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg198, %0 : i32
  %2 = llvm.or %arg197, %1 : i32
  %3 = llvm.and %arg198, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test47_after := [llvm|
{
^0(%arg197 : i32, %arg198 : i32):
  %0 = llvm.and %arg198, %arg197 : i32
  "llvm.return"(%0) : (i32) -> ()
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



def and_orn_cmp_1_before := [llvm|
{
^0(%arg194 : i32, %arg195 : i32, %arg196 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.icmp "sgt" %arg194, %arg195 : i32
  %2 = llvm.icmp "sle" %arg194, %arg195 : i32
  %3 = llvm.icmp "ugt" %arg196, %0 : i32
  %4 = llvm.or %3, %2 : i1
  %5 = llvm.and %1, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def and_orn_cmp_1_after := [llvm|
{
^0(%arg194 : i32, %arg195 : i32, %arg196 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.icmp "sgt" %arg194, %arg195 : i32
  %2 = llvm.icmp "ugt" %arg196, %0 : i32
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_orn_cmp_1_proof : and_orn_cmp_1_before ⊑ and_orn_cmp_1_after := by
  unfold and_orn_cmp_1_before and_orn_cmp_1_after
  simp_alive_peephole
  intros
  ---BEGIN and_orn_cmp_1
  apply and_orn_cmp_1_thm
  ---END and_orn_cmp_1



def and_orn_cmp_1_logical_before := [llvm|
{
^0(%arg191 : i32, %arg192 : i32, %arg193 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "sgt" %arg191, %arg192 : i32
  %4 = llvm.icmp "sle" %arg191, %arg192 : i32
  %5 = llvm.icmp "ugt" %arg193, %0 : i32
  %6 = "llvm.select"(%5, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = "llvm.select"(%3, %6, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def and_orn_cmp_1_logical_after := [llvm|
{
^0(%arg191 : i32, %arg192 : i32, %arg193 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sgt" %arg191, %arg192 : i32
  %3 = llvm.icmp "ugt" %arg193, %0 : i32
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_orn_cmp_1_logical_proof : and_orn_cmp_1_logical_before ⊑ and_orn_cmp_1_logical_after := by
  unfold and_orn_cmp_1_logical_before and_orn_cmp_1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN and_orn_cmp_1_logical
  apply and_orn_cmp_1_logical_thm
  ---END and_orn_cmp_1_logical



def and_orn_cmp_3_before := [llvm|
{
^0(%arg185 : i72, %arg186 : i72, %arg187 : i72):
  %0 = llvm.mlir.constant(42 : i72) : i72
  %1 = llvm.icmp "ugt" %arg185, %arg186 : i72
  %2 = llvm.icmp "ule" %arg185, %arg186 : i72
  %3 = llvm.icmp "ugt" %arg187, %0 : i72
  %4 = llvm.or %2, %3 : i1
  %5 = llvm.and %1, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def and_orn_cmp_3_after := [llvm|
{
^0(%arg185 : i72, %arg186 : i72, %arg187 : i72):
  %0 = llvm.mlir.constant(42 : i72) : i72
  %1 = llvm.icmp "ugt" %arg185, %arg186 : i72
  %2 = llvm.icmp "ugt" %arg187, %0 : i72
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_orn_cmp_3_proof : and_orn_cmp_3_before ⊑ and_orn_cmp_3_after := by
  unfold and_orn_cmp_3_before and_orn_cmp_3_after
  simp_alive_peephole
  intros
  ---BEGIN and_orn_cmp_3
  apply and_orn_cmp_3_thm
  ---END and_orn_cmp_3



def and_orn_cmp_3_logical_before := [llvm|
{
^0(%arg182 : i72, %arg183 : i72, %arg184 : i72):
  %0 = llvm.mlir.constant(42 : i72) : i72
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ugt" %arg182, %arg183 : i72
  %4 = llvm.icmp "ule" %arg182, %arg183 : i72
  %5 = llvm.icmp "ugt" %arg184, %0 : i72
  %6 = "llvm.select"(%4, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = "llvm.select"(%3, %6, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def and_orn_cmp_3_logical_after := [llvm|
{
^0(%arg182 : i72, %arg183 : i72, %arg184 : i72):
  %0 = llvm.mlir.constant(42 : i72) : i72
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg182, %arg183 : i72
  %3 = llvm.icmp "ugt" %arg184, %0 : i72
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_orn_cmp_3_logical_proof : and_orn_cmp_3_logical_before ⊑ and_orn_cmp_3_logical_after := by
  unfold and_orn_cmp_3_logical_before and_orn_cmp_3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN and_orn_cmp_3_logical
  apply and_orn_cmp_3_logical_thm
  ---END and_orn_cmp_3_logical



def andn_or_cmp_1_before := [llvm|
{
^0(%arg176 : i37, %arg177 : i37, %arg178 : i37):
  %0 = llvm.mlir.constant(42 : i37) : i37
  %1 = llvm.icmp "sgt" %arg176, %arg177 : i37
  %2 = llvm.icmp "sle" %arg176, %arg177 : i37
  %3 = llvm.icmp "ugt" %arg178, %0 : i37
  %4 = llvm.or %3, %1 : i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def andn_or_cmp_1_after := [llvm|
{
^0(%arg176 : i37, %arg177 : i37, %arg178 : i37):
  %0 = llvm.mlir.constant(42 : i37) : i37
  %1 = llvm.icmp "sle" %arg176, %arg177 : i37
  %2 = llvm.icmp "ugt" %arg178, %0 : i37
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andn_or_cmp_1_proof : andn_or_cmp_1_before ⊑ andn_or_cmp_1_after := by
  unfold andn_or_cmp_1_before andn_or_cmp_1_after
  simp_alive_peephole
  intros
  ---BEGIN andn_or_cmp_1
  apply andn_or_cmp_1_thm
  ---END andn_or_cmp_1



def andn_or_cmp_1_logical_before := [llvm|
{
^0(%arg173 : i37, %arg174 : i37, %arg175 : i37):
  %0 = llvm.mlir.constant(42 : i37) : i37
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "sgt" %arg173, %arg174 : i37
  %4 = llvm.icmp "sle" %arg173, %arg174 : i37
  %5 = llvm.icmp "ugt" %arg175, %0 : i37
  %6 = "llvm.select"(%5, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = "llvm.select"(%4, %6, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def andn_or_cmp_1_logical_after := [llvm|
{
^0(%arg173 : i37, %arg174 : i37, %arg175 : i37):
  %0 = llvm.mlir.constant(42 : i37) : i37
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sle" %arg173, %arg174 : i37
  %3 = llvm.icmp "ugt" %arg175, %0 : i37
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andn_or_cmp_1_logical_proof : andn_or_cmp_1_logical_before ⊑ andn_or_cmp_1_logical_after := by
  unfold andn_or_cmp_1_logical_before andn_or_cmp_1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN andn_or_cmp_1_logical
  apply andn_or_cmp_1_logical_thm
  ---END andn_or_cmp_1_logical



def andn_or_cmp_2_before := [llvm|
{
^0(%arg170 : i16, %arg171 : i16, %arg172 : i16):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.icmp "sge" %arg170, %arg171 : i16
  %2 = llvm.icmp "slt" %arg170, %arg171 : i16
  %3 = llvm.icmp "ugt" %arg172, %0 : i16
  %4 = llvm.or %3, %1 : i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def andn_or_cmp_2_after := [llvm|
{
^0(%arg170 : i16, %arg171 : i16, %arg172 : i16):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.icmp "slt" %arg170, %arg171 : i16
  %2 = llvm.icmp "ugt" %arg172, %0 : i16
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andn_or_cmp_2_proof : andn_or_cmp_2_before ⊑ andn_or_cmp_2_after := by
  unfold andn_or_cmp_2_before andn_or_cmp_2_after
  simp_alive_peephole
  intros
  ---BEGIN andn_or_cmp_2
  apply andn_or_cmp_2_thm
  ---END andn_or_cmp_2



def andn_or_cmp_2_logical_before := [llvm|
{
^0(%arg167 : i16, %arg168 : i16, %arg169 : i16):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "sge" %arg167, %arg168 : i16
  %4 = llvm.icmp "slt" %arg167, %arg168 : i16
  %5 = llvm.icmp "ugt" %arg169, %0 : i16
  %6 = "llvm.select"(%5, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = "llvm.select"(%6, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def andn_or_cmp_2_logical_after := [llvm|
{
^0(%arg167 : i16, %arg168 : i16, %arg169 : i16):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "slt" %arg167, %arg168 : i16
  %3 = llvm.icmp "ugt" %arg169, %0 : i16
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andn_or_cmp_2_logical_proof : andn_or_cmp_2_logical_before ⊑ andn_or_cmp_2_logical_after := by
  unfold andn_or_cmp_2_logical_before andn_or_cmp_2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN andn_or_cmp_2_logical
  apply andn_or_cmp_2_logical_thm
  ---END andn_or_cmp_2_logical



def andn_or_cmp_4_before := [llvm|
{
^0(%arg161 : i32, %arg162 : i32, %arg163 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.icmp "eq" %arg161, %arg162 : i32
  %2 = llvm.icmp "ne" %arg161, %arg162 : i32
  %3 = llvm.icmp "ugt" %arg163, %0 : i32
  %4 = llvm.or %1, %3 : i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def andn_or_cmp_4_after := [llvm|
{
^0(%arg161 : i32, %arg162 : i32, %arg163 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.icmp "ne" %arg161, %arg162 : i32
  %2 = llvm.icmp "ugt" %arg163, %0 : i32
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andn_or_cmp_4_proof : andn_or_cmp_4_before ⊑ andn_or_cmp_4_after := by
  unfold andn_or_cmp_4_before andn_or_cmp_4_after
  simp_alive_peephole
  intros
  ---BEGIN andn_or_cmp_4
  apply andn_or_cmp_4_thm
  ---END andn_or_cmp_4



def andn_or_cmp_4_logical_before := [llvm|
{
^0(%arg158 : i32, %arg159 : i32, %arg160 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "eq" %arg158, %arg159 : i32
  %4 = llvm.icmp "ne" %arg158, %arg159 : i32
  %5 = llvm.icmp "ugt" %arg160, %0 : i32
  %6 = "llvm.select"(%3, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = "llvm.select"(%6, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def andn_or_cmp_4_logical_after := [llvm|
{
^0(%arg158 : i32, %arg159 : i32, %arg160 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ne" %arg158, %arg159 : i32
  %3 = llvm.icmp "ugt" %arg160, %0 : i32
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andn_or_cmp_4_logical_proof : andn_or_cmp_4_logical_before ⊑ andn_or_cmp_4_logical_after := by
  unfold andn_or_cmp_4_logical_before andn_or_cmp_4_logical_after
  simp_alive_peephole
  intros
  ---BEGIN andn_or_cmp_4_logical
  apply andn_or_cmp_4_logical_thm
  ---END andn_or_cmp_4_logical



def lowbitmask_casted_shift_before := [llvm|
{
^0(%arg157 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(2147483647 : i32) : i32
  %2 = llvm.ashr %arg157, %0 : i8
  %3 = llvm.sext %2 : i8 to i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def lowbitmask_casted_shift_after := [llvm|
{
^0(%arg157 : i8):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.sext %arg157 : i8 to i32
  %2 = llvm.lshr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lowbitmask_casted_shift_proof : lowbitmask_casted_shift_before ⊑ lowbitmask_casted_shift_after := by
  unfold lowbitmask_casted_shift_before lowbitmask_casted_shift_after
  simp_alive_peephole
  intros
  ---BEGIN lowbitmask_casted_shift
  apply lowbitmask_casted_shift_thm
  ---END lowbitmask_casted_shift



def lowmask_add_2_before := [llvm|
{
^0(%arg144 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.mlir.constant(63 : i8) : i8
  %2 = llvm.add %arg144, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def lowmask_add_2_after := [llvm|
{
^0(%arg144 : i8):
  %0 = llvm.mlir.constant(63 : i8) : i8
  %1 = llvm.and %arg144, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lowmask_add_2_proof : lowmask_add_2_before ⊑ lowmask_add_2_after := by
  unfold lowmask_add_2_before lowmask_add_2_after
  simp_alive_peephole
  intros
  ---BEGIN lowmask_add_2
  apply lowmask_add_2_thm
  ---END lowmask_add_2



def flip_masked_bit_before := [llvm|
{
^0(%arg132 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.add %arg132, %0 : i8
  %2 = llvm.and %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def flip_masked_bit_after := [llvm|
{
^0(%arg132 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.and %arg132, %0 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem flip_masked_bit_proof : flip_masked_bit_before ⊑ flip_masked_bit_after := by
  unfold flip_masked_bit_before flip_masked_bit_after
  simp_alive_peephole
  intros
  ---BEGIN flip_masked_bit
  apply flip_masked_bit_thm
  ---END flip_masked_bit



def ashr_bitwidth_mask_before := [llvm|
{
^0(%arg127 : i8, %arg128 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.ashr %arg127, %0 : i8
  %2 = llvm.and %1, %arg128 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def ashr_bitwidth_mask_after := [llvm|
{
^0(%arg127 : i8, %arg128 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg127, %0 : i8
  %2 = "llvm.select"(%1, %arg128, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_bitwidth_mask_proof : ashr_bitwidth_mask_before ⊑ ashr_bitwidth_mask_after := by
  unfold ashr_bitwidth_mask_before ashr_bitwidth_mask_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_bitwidth_mask
  apply ashr_bitwidth_mask_thm
  ---END ashr_bitwidth_mask



def signbit_splat_mask_before := [llvm|
{
^0(%arg117 : i8, %arg118 : i16):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.ashr %arg117, %0 : i8
  %2 = llvm.sext %1 : i8 to i16
  %3 = llvm.and %2, %arg118 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def signbit_splat_mask_after := [llvm|
{
^0(%arg117 : i8, %arg118 : i16):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = llvm.icmp "slt" %arg117, %0 : i8
  %3 = "llvm.select"(%2, %arg118, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signbit_splat_mask_proof : signbit_splat_mask_before ⊑ signbit_splat_mask_after := by
  unfold signbit_splat_mask_before signbit_splat_mask_after
  simp_alive_peephole
  intros
  ---BEGIN signbit_splat_mask
  apply signbit_splat_mask_thm
  ---END signbit_splat_mask



def not_signbit_splat_mask1_before := [llvm|
{
^0(%arg109 : i8, %arg110 : i16):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.ashr %arg109, %0 : i8
  %2 = llvm.zext %1 : i8 to i16
  %3 = llvm.and %2, %arg110 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def not_signbit_splat_mask1_after := [llvm|
{
^0(%arg109 : i8, %arg110 : i16):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.ashr %arg109, %0 : i8
  %2 = llvm.zext %1 : i8 to i16
  %3 = llvm.and %arg110, %2 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_signbit_splat_mask1_proof : not_signbit_splat_mask1_before ⊑ not_signbit_splat_mask1_after := by
  unfold not_signbit_splat_mask1_before not_signbit_splat_mask1_after
  simp_alive_peephole
  intros
  ---BEGIN not_signbit_splat_mask1
  apply not_signbit_splat_mask1_thm
  ---END not_signbit_splat_mask1



def not_signbit_splat_mask2_before := [llvm|
{
^0(%arg107 : i8, %arg108 : i16):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.ashr %arg107, %0 : i8
  %2 = llvm.sext %1 : i8 to i16
  %3 = llvm.and %2, %arg108 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def not_signbit_splat_mask2_after := [llvm|
{
^0(%arg107 : i8, %arg108 : i16):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.ashr %arg107, %0 : i8
  %2 = llvm.sext %1 : i8 to i16
  %3 = llvm.and %arg108, %2 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_signbit_splat_mask2_proof : not_signbit_splat_mask2_before ⊑ not_signbit_splat_mask2_after := by
  unfold not_signbit_splat_mask2_before not_signbit_splat_mask2_after
  simp_alive_peephole
  intros
  ---BEGIN not_signbit_splat_mask2
  apply not_signbit_splat_mask2_thm
  ---END not_signbit_splat_mask2



def not_ashr_bitwidth_mask_before := [llvm|
{
^0(%arg105 : i8, %arg106 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %arg105, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.and %3, %arg106 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def not_ashr_bitwidth_mask_after := [llvm|
{
^0(%arg105 : i8, %arg106 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg105, %0 : i8
  %2 = "llvm.select"(%1, %0, %arg106) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_ashr_bitwidth_mask_proof : not_ashr_bitwidth_mask_before ⊑ not_ashr_bitwidth_mask_after := by
  unfold not_ashr_bitwidth_mask_before not_ashr_bitwidth_mask_after
  simp_alive_peephole
  intros
  ---BEGIN not_ashr_bitwidth_mask
  apply not_ashr_bitwidth_mask_thm
  ---END not_ashr_bitwidth_mask



def not_ashr_not_bitwidth_mask_before := [llvm|
{
^0(%arg97 : i8, %arg98 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %arg97, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.and %3, %arg98 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def not_ashr_not_bitwidth_mask_after := [llvm|
{
^0(%arg97 : i8, %arg98 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %arg97, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.and %arg98, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_ashr_not_bitwidth_mask_proof : not_ashr_not_bitwidth_mask_before ⊑ not_ashr_not_bitwidth_mask_after := by
  unfold not_ashr_not_bitwidth_mask_before not_ashr_not_bitwidth_mask_after
  simp_alive_peephole
  intros
  ---BEGIN not_ashr_not_bitwidth_mask
  apply not_ashr_not_bitwidth_mask_thm
  ---END not_ashr_not_bitwidth_mask



def not_lshr_bitwidth_mask_before := [llvm|
{
^0(%arg95 : i8, %arg96 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.lshr %arg95, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.and %3, %arg96 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def not_lshr_bitwidth_mask_after := [llvm|
{
^0(%arg95 : i8, %arg96 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.lshr %arg95, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.and %arg96, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_lshr_bitwidth_mask_proof : not_lshr_bitwidth_mask_before ⊑ not_lshr_bitwidth_mask_after := by
  unfold not_lshr_bitwidth_mask_before not_lshr_bitwidth_mask_after
  simp_alive_peephole
  intros
  ---BEGIN not_lshr_bitwidth_mask
  apply not_lshr_bitwidth_mask_thm
  ---END not_lshr_bitwidth_mask



def invert_signbit_splat_mask_before := [llvm|
{
^0(%arg93 : i8, %arg94 : i16):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %arg93, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.sext %3 : i8 to i16
  %5 = llvm.and %4, %arg94 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def invert_signbit_splat_mask_after := [llvm|
{
^0(%arg93 : i8, %arg94 : i16):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = llvm.icmp "sgt" %arg93, %0 : i8
  %3 = "llvm.select"(%2, %arg94, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem invert_signbit_splat_mask_proof : invert_signbit_splat_mask_before ⊑ invert_signbit_splat_mask_after := by
  unfold invert_signbit_splat_mask_before invert_signbit_splat_mask_after
  simp_alive_peephole
  intros
  ---BEGIN invert_signbit_splat_mask
  apply invert_signbit_splat_mask_thm
  ---END invert_signbit_splat_mask



def not_invert_signbit_splat_mask1_before := [llvm|
{
^0(%arg83 : i8, %arg84 : i16):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %arg83, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.zext %3 : i8 to i16
  %5 = llvm.and %4, %arg84 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def not_invert_signbit_splat_mask1_after := [llvm|
{
^0(%arg83 : i8, %arg84 : i16):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg83, %0 : i8
  %2 = llvm.sext %1 : i1 to i8
  %3 = llvm.zext %2 : i8 to i16
  %4 = llvm.and %arg84, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_invert_signbit_splat_mask1_proof : not_invert_signbit_splat_mask1_before ⊑ not_invert_signbit_splat_mask1_after := by
  unfold not_invert_signbit_splat_mask1_before not_invert_signbit_splat_mask1_after
  simp_alive_peephole
  intros
  ---BEGIN not_invert_signbit_splat_mask1
  apply not_invert_signbit_splat_mask1_thm
  ---END not_invert_signbit_splat_mask1



def not_invert_signbit_splat_mask2_before := [llvm|
{
^0(%arg81 : i8, %arg82 : i16):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %arg81, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.sext %3 : i8 to i16
  %5 = llvm.and %4, %arg82 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def not_invert_signbit_splat_mask2_after := [llvm|
{
^0(%arg81 : i8, %arg82 : i16):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %arg81, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.sext %3 : i8 to i16
  %5 = llvm.and %arg82, %4 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_invert_signbit_splat_mask2_proof : not_invert_signbit_splat_mask2_before ⊑ not_invert_signbit_splat_mask2_after := by
  unfold not_invert_signbit_splat_mask2_before not_invert_signbit_splat_mask2_after
  simp_alive_peephole
  intros
  ---BEGIN not_invert_signbit_splat_mask2
  apply not_invert_signbit_splat_mask2_thm
  ---END not_invert_signbit_splat_mask2



def shl_lshr_pow2_const_case1_before := [llvm|
{
^0(%arg80 : i16):
  %0 = llvm.mlir.constant(4 : i16) : i16
  %1 = llvm.mlir.constant(6 : i16) : i16
  %2 = llvm.mlir.constant(8 : i16) : i16
  %3 = llvm.shl %0, %arg80 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def shl_lshr_pow2_const_case1_after := [llvm|
{
^0(%arg80 : i16):
  %0 = llvm.mlir.constant(7 : i16) : i16
  %1 = llvm.mlir.constant(8 : i16) : i16
  %2 = llvm.mlir.constant(0 : i16) : i16
  %3 = llvm.icmp "eq" %arg80, %0 : i16
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_lshr_pow2_const_case1_proof : shl_lshr_pow2_const_case1_before ⊑ shl_lshr_pow2_const_case1_after := by
  unfold shl_lshr_pow2_const_case1_before shl_lshr_pow2_const_case1_after
  simp_alive_peephole
  intros
  ---BEGIN shl_lshr_pow2_const_case1
  apply shl_lshr_pow2_const_case1_thm
  ---END shl_lshr_pow2_const_case1



def shl_ashr_pow2_const_case1_before := [llvm|
{
^0(%arg79 : i16):
  %0 = llvm.mlir.constant(4 : i16) : i16
  %1 = llvm.mlir.constant(6 : i16) : i16
  %2 = llvm.mlir.constant(8 : i16) : i16
  %3 = llvm.shl %0, %arg79 : i16
  %4 = llvm.ashr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def shl_ashr_pow2_const_case1_after := [llvm|
{
^0(%arg79 : i16):
  %0 = llvm.mlir.constant(7 : i16) : i16
  %1 = llvm.mlir.constant(8 : i16) : i16
  %2 = llvm.mlir.constant(0 : i16) : i16
  %3 = llvm.icmp "eq" %arg79, %0 : i16
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_ashr_pow2_const_case1_proof : shl_ashr_pow2_const_case1_before ⊑ shl_ashr_pow2_const_case1_after := by
  unfold shl_ashr_pow2_const_case1_before shl_ashr_pow2_const_case1_after
  simp_alive_peephole
  intros
  ---BEGIN shl_ashr_pow2_const_case1
  apply shl_ashr_pow2_const_case1_thm
  ---END shl_ashr_pow2_const_case1



def shl_lshr_pow2_const_case2_before := [llvm|
{
^0(%arg72 : i16):
  %0 = llvm.mlir.constant(16 : i16) : i16
  %1 = llvm.mlir.constant(3 : i16) : i16
  %2 = llvm.mlir.constant(8 : i16) : i16
  %3 = llvm.shl %0, %arg72 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def shl_lshr_pow2_const_case2_after := [llvm|
{
^0(%arg72 : i16):
  %0 = llvm.mlir.constant(2 : i16) : i16
  %1 = llvm.mlir.constant(8 : i16) : i16
  %2 = llvm.mlir.constant(0 : i16) : i16
  %3 = llvm.icmp "eq" %arg72, %0 : i16
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_lshr_pow2_const_case2_proof : shl_lshr_pow2_const_case2_before ⊑ shl_lshr_pow2_const_case2_after := by
  unfold shl_lshr_pow2_const_case2_before shl_lshr_pow2_const_case2_after
  simp_alive_peephole
  intros
  ---BEGIN shl_lshr_pow2_const_case2
  apply shl_lshr_pow2_const_case2_thm
  ---END shl_lshr_pow2_const_case2



def shl_lshr_pow2_not_const_case2_before := [llvm|
{
^0(%arg71 : i16):
  %0 = llvm.mlir.constant(16 : i16) : i16
  %1 = llvm.mlir.constant(3 : i16) : i16
  %2 = llvm.mlir.constant(8 : i16) : i16
  %3 = llvm.shl %0, %arg71 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  %6 = llvm.xor %5, %2 : i16
  "llvm.return"(%6) : (i16) -> ()
}
]
def shl_lshr_pow2_not_const_case2_after := [llvm|
{
^0(%arg71 : i16):
  %0 = llvm.mlir.constant(2 : i16) : i16
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = llvm.mlir.constant(8 : i16) : i16
  %3 = llvm.icmp "eq" %arg71, %0 : i16
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_lshr_pow2_not_const_case2_proof : shl_lshr_pow2_not_const_case2_before ⊑ shl_lshr_pow2_not_const_case2_after := by
  unfold shl_lshr_pow2_not_const_case2_before shl_lshr_pow2_not_const_case2_after
  simp_alive_peephole
  intros
  ---BEGIN shl_lshr_pow2_not_const_case2
  apply shl_lshr_pow2_not_const_case2_thm
  ---END shl_lshr_pow2_not_const_case2



def shl_lshr_pow2_const_negative_overflow1_before := [llvm|
{
^0(%arg70 : i16):
  %0 = llvm.mlir.constant(4096 : i16) : i16
  %1 = llvm.mlir.constant(6 : i16) : i16
  %2 = llvm.mlir.constant(8 : i16) : i16
  %3 = llvm.shl %0, %arg70 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def shl_lshr_pow2_const_negative_overflow1_after := [llvm|
{
^0(%arg70 : i16):
  %0 = llvm.mlir.constant(0 : i16) : i16
  "llvm.return"(%0) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_lshr_pow2_const_negative_overflow1_proof : shl_lshr_pow2_const_negative_overflow1_before ⊑ shl_lshr_pow2_const_negative_overflow1_after := by
  unfold shl_lshr_pow2_const_negative_overflow1_before shl_lshr_pow2_const_negative_overflow1_after
  simp_alive_peephole
  intros
  ---BEGIN shl_lshr_pow2_const_negative_overflow1
  apply shl_lshr_pow2_const_negative_overflow1_thm
  ---END shl_lshr_pow2_const_negative_overflow1



def shl_lshr_pow2_const_negative_overflow2_before := [llvm|
{
^0(%arg69 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(6 : i16) : i16
  %2 = llvm.mlir.constant(-32768 : i16) : i16
  %3 = llvm.shl %0, %arg69 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def shl_lshr_pow2_const_negative_overflow2_after := [llvm|
{
^0(%arg69 : i16):
  %0 = llvm.mlir.constant(0 : i16) : i16
  "llvm.return"(%0) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_lshr_pow2_const_negative_overflow2_proof : shl_lshr_pow2_const_negative_overflow2_before ⊑ shl_lshr_pow2_const_negative_overflow2_after := by
  unfold shl_lshr_pow2_const_negative_overflow2_before shl_lshr_pow2_const_negative_overflow2_after
  simp_alive_peephole
  intros
  ---BEGIN shl_lshr_pow2_const_negative_overflow2
  apply shl_lshr_pow2_const_negative_overflow2_thm
  ---END shl_lshr_pow2_const_negative_overflow2



def lshr_lshr_pow2_const_before := [llvm|
{
^0(%arg65 : i16):
  %0 = llvm.mlir.constant(2048 : i16) : i16
  %1 = llvm.mlir.constant(6 : i16) : i16
  %2 = llvm.mlir.constant(4 : i16) : i16
  %3 = llvm.lshr %0, %arg65 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def lshr_lshr_pow2_const_after := [llvm|
{
^0(%arg65 : i16):
  %0 = llvm.mlir.constant(3 : i16) : i16
  %1 = llvm.mlir.constant(4 : i16) : i16
  %2 = llvm.mlir.constant(0 : i16) : i16
  %3 = llvm.icmp "eq" %arg65, %0 : i16
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_lshr_pow2_const_proof : lshr_lshr_pow2_const_before ⊑ lshr_lshr_pow2_const_after := by
  unfold lshr_lshr_pow2_const_before lshr_lshr_pow2_const_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_lshr_pow2_const
  apply lshr_lshr_pow2_const_thm
  ---END lshr_lshr_pow2_const



def lshr_lshr_pow2_const_negative_nopow2_1_before := [llvm|
{
^0(%arg63 : i16):
  %0 = llvm.mlir.constant(2047 : i16) : i16
  %1 = llvm.mlir.constant(6 : i16) : i16
  %2 = llvm.mlir.constant(4 : i16) : i16
  %3 = llvm.lshr %0, %arg63 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def lshr_lshr_pow2_const_negative_nopow2_1_after := [llvm|
{
^0(%arg63 : i16):
  %0 = llvm.mlir.constant(31 : i16) : i16
  %1 = llvm.mlir.constant(4 : i16) : i16
  %2 = llvm.lshr %0, %arg63 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_lshr_pow2_const_negative_nopow2_1_proof : lshr_lshr_pow2_const_negative_nopow2_1_before ⊑ lshr_lshr_pow2_const_negative_nopow2_1_after := by
  unfold lshr_lshr_pow2_const_negative_nopow2_1_before lshr_lshr_pow2_const_negative_nopow2_1_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_lshr_pow2_const_negative_nopow2_1
  apply lshr_lshr_pow2_const_negative_nopow2_1_thm
  ---END lshr_lshr_pow2_const_negative_nopow2_1



def lshr_lshr_pow2_const_negative_nopow2_2_before := [llvm|
{
^0(%arg62 : i16):
  %0 = llvm.mlir.constant(8192 : i16) : i16
  %1 = llvm.mlir.constant(6 : i16) : i16
  %2 = llvm.mlir.constant(3 : i16) : i16
  %3 = llvm.lshr %0, %arg62 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def lshr_lshr_pow2_const_negative_nopow2_2_after := [llvm|
{
^0(%arg62 : i16):
  %0 = llvm.mlir.constant(128 : i16) : i16
  %1 = llvm.mlir.constant(3 : i16) : i16
  %2 = llvm.lshr %0, %arg62 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_lshr_pow2_const_negative_nopow2_2_proof : lshr_lshr_pow2_const_negative_nopow2_2_before ⊑ lshr_lshr_pow2_const_negative_nopow2_2_after := by
  unfold lshr_lshr_pow2_const_negative_nopow2_2_before lshr_lshr_pow2_const_negative_nopow2_2_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_lshr_pow2_const_negative_nopow2_2
  apply lshr_lshr_pow2_const_negative_nopow2_2_thm
  ---END lshr_lshr_pow2_const_negative_nopow2_2



def lshr_lshr_pow2_const_negative_overflow_before := [llvm|
{
^0(%arg61 : i16):
  %0 = llvm.mlir.constant(-32768 : i16) : i16
  %1 = llvm.mlir.constant(15 : i16) : i16
  %2 = llvm.mlir.constant(4 : i16) : i16
  %3 = llvm.lshr %0, %arg61 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def lshr_lshr_pow2_const_negative_overflow_after := [llvm|
{
^0(%arg61 : i16):
  %0 = llvm.mlir.constant(0 : i16) : i16
  "llvm.return"(%0) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_lshr_pow2_const_negative_overflow_proof : lshr_lshr_pow2_const_negative_overflow_before ⊑ lshr_lshr_pow2_const_negative_overflow_after := by
  unfold lshr_lshr_pow2_const_negative_overflow_before lshr_lshr_pow2_const_negative_overflow_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_lshr_pow2_const_negative_overflow
  apply lshr_lshr_pow2_const_negative_overflow_thm
  ---END lshr_lshr_pow2_const_negative_overflow



def lshr_shl_pow2_const_case1_before := [llvm|
{
^0(%arg60 : i16):
  %0 = llvm.mlir.constant(256 : i16) : i16
  %1 = llvm.mlir.constant(2 : i16) : i16
  %2 = llvm.mlir.constant(8 : i16) : i16
  %3 = llvm.lshr %0, %arg60 : i16
  %4 = llvm.shl %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def lshr_shl_pow2_const_case1_after := [llvm|
{
^0(%arg60 : i16):
  %0 = llvm.mlir.constant(7 : i16) : i16
  %1 = llvm.mlir.constant(8 : i16) : i16
  %2 = llvm.mlir.constant(0 : i16) : i16
  %3 = llvm.icmp "eq" %arg60, %0 : i16
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_shl_pow2_const_case1_proof : lshr_shl_pow2_const_case1_before ⊑ lshr_shl_pow2_const_case1_after := by
  unfold lshr_shl_pow2_const_case1_before lshr_shl_pow2_const_case1_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_shl_pow2_const_case1
  apply lshr_shl_pow2_const_case1_thm
  ---END lshr_shl_pow2_const_case1



def lshr_shl_pow2_const_xor_before := [llvm|
{
^0(%arg59 : i16):
  %0 = llvm.mlir.constant(256 : i16) : i16
  %1 = llvm.mlir.constant(2 : i16) : i16
  %2 = llvm.mlir.constant(8 : i16) : i16
  %3 = llvm.lshr %0, %arg59 : i16
  %4 = llvm.shl %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  %6 = llvm.xor %5, %2 : i16
  "llvm.return"(%6) : (i16) -> ()
}
]
def lshr_shl_pow2_const_xor_after := [llvm|
{
^0(%arg59 : i16):
  %0 = llvm.mlir.constant(7 : i16) : i16
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = llvm.mlir.constant(8 : i16) : i16
  %3 = llvm.icmp "eq" %arg59, %0 : i16
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_shl_pow2_const_xor_proof : lshr_shl_pow2_const_xor_before ⊑ lshr_shl_pow2_const_xor_after := by
  unfold lshr_shl_pow2_const_xor_before lshr_shl_pow2_const_xor_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_shl_pow2_const_xor
  apply lshr_shl_pow2_const_xor_thm
  ---END lshr_shl_pow2_const_xor



def lshr_shl_pow2_const_case2_before := [llvm|
{
^0(%arg58 : i16):
  %0 = llvm.mlir.constant(8192 : i16) : i16
  %1 = llvm.mlir.constant(4 : i16) : i16
  %2 = llvm.mlir.constant(32 : i16) : i16
  %3 = llvm.lshr %0, %arg58 : i16
  %4 = llvm.shl %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def lshr_shl_pow2_const_case2_after := [llvm|
{
^0(%arg58 : i16):
  %0 = llvm.mlir.constant(12 : i16) : i16
  %1 = llvm.mlir.constant(32 : i16) : i16
  %2 = llvm.mlir.constant(0 : i16) : i16
  %3 = llvm.icmp "eq" %arg58, %0 : i16
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_shl_pow2_const_case2_proof : lshr_shl_pow2_const_case2_before ⊑ lshr_shl_pow2_const_case2_after := by
  unfold lshr_shl_pow2_const_case2_before lshr_shl_pow2_const_case2_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_shl_pow2_const_case2
  apply lshr_shl_pow2_const_case2_thm
  ---END lshr_shl_pow2_const_case2



def lshr_shl_pow2_const_overflow_before := [llvm|
{
^0(%arg57 : i16):
  %0 = llvm.mlir.constant(8192 : i16) : i16
  %1 = llvm.mlir.constant(6 : i16) : i16
  %2 = llvm.mlir.constant(32 : i16) : i16
  %3 = llvm.lshr %0, %arg57 : i16
  %4 = llvm.shl %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def lshr_shl_pow2_const_overflow_after := [llvm|
{
^0(%arg57 : i16):
  %0 = llvm.mlir.constant(0 : i16) : i16
  "llvm.return"(%0) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_shl_pow2_const_overflow_proof : lshr_shl_pow2_const_overflow_before ⊑ lshr_shl_pow2_const_overflow_after := by
  unfold lshr_shl_pow2_const_overflow_before lshr_shl_pow2_const_overflow_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_shl_pow2_const_overflow
  apply lshr_shl_pow2_const_overflow_thm
  ---END lshr_shl_pow2_const_overflow



def negate_lowbitmask_before := [llvm|
{
^0(%arg48 : i8, %arg49 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg48, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  %4 = llvm.and %3, %arg49 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def negate_lowbitmask_after := [llvm|
{
^0(%arg48 : i8, %arg49 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg48, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  %4 = "llvm.select"(%3, %1, %arg49) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_lowbitmask_proof : negate_lowbitmask_before ⊑ negate_lowbitmask_after := by
  unfold negate_lowbitmask_before negate_lowbitmask_after
  simp_alive_peephole
  intros
  ---BEGIN negate_lowbitmask
  apply negate_lowbitmask_thm
  ---END negate_lowbitmask



def and_zext_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i1):
  %0 = llvm.zext %arg41 : i1 to i32
  %1 = llvm.and %arg40, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def and_zext_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg40, %0 : i32
  %3 = "llvm.select"(%arg41, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_zext_proof : and_zext_before ⊑ and_zext_after := by
  unfold and_zext_before and_zext_after
  simp_alive_peephole
  intros
  ---BEGIN and_zext
  apply and_zext_thm
  ---END and_zext



def and_zext_commuted_before := [llvm|
{
^0(%arg38 : i32, %arg39 : i1):
  %0 = llvm.zext %arg39 : i1 to i32
  %1 = llvm.and %0, %arg38 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def and_zext_commuted_after := [llvm|
{
^0(%arg38 : i32, %arg39 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg38, %0 : i32
  %3 = "llvm.select"(%arg39, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_zext_commuted_proof : and_zext_commuted_before ⊑ and_zext_commuted_after := by
  unfold and_zext_commuted_before and_zext_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN and_zext_commuted
  apply and_zext_commuted_thm
  ---END and_zext_commuted



def and_zext_eq_even_before := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "eq" %arg33, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.and %arg33, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_zext_eq_even_after := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_zext_eq_even_proof : and_zext_eq_even_before ⊑ and_zext_eq_even_after := by
  unfold and_zext_eq_even_before and_zext_eq_even_after
  simp_alive_peephole
  intros
  ---BEGIN and_zext_eq_even
  apply and_zext_eq_even_thm
  ---END and_zext_eq_even



def and_zext_eq_even_commuted_before := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "eq" %arg32, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.and %2, %arg32 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_zext_eq_even_commuted_after := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_zext_eq_even_commuted_proof : and_zext_eq_even_commuted_before ⊑ and_zext_eq_even_commuted_after := by
  unfold and_zext_eq_even_commuted_before and_zext_eq_even_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN and_zext_eq_even_commuted
  apply and_zext_eq_even_commuted_thm
  ---END and_zext_eq_even_commuted



def and_zext_eq_odd_before := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "eq" %arg31, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.and %arg31, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_zext_eq_odd_after := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "eq" %arg31, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_zext_eq_odd_proof : and_zext_eq_odd_before ⊑ and_zext_eq_odd_after := by
  unfold and_zext_eq_odd_before and_zext_eq_odd_after
  simp_alive_peephole
  intros
  ---BEGIN and_zext_eq_odd
  apply and_zext_eq_odd_thm
  ---END and_zext_eq_odd



def and_zext_eq_odd_commuted_before := [llvm|
{
^0(%arg30 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "eq" %arg30, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.and %2, %arg30 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_zext_eq_odd_commuted_after := [llvm|
{
^0(%arg30 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "eq" %arg30, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_zext_eq_odd_commuted_proof : and_zext_eq_odd_commuted_before ⊑ and_zext_eq_odd_commuted_after := by
  unfold and_zext_eq_odd_commuted_before and_zext_eq_odd_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN and_zext_eq_odd_commuted
  apply and_zext_eq_odd_commuted_thm
  ---END and_zext_eq_odd_commuted



def and_zext_eq_zero_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "eq" %arg28, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg28, %arg29 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.and %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_zext_eq_zero_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg28, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_zext_eq_zero_proof : and_zext_eq_zero_before ⊑ and_zext_eq_zero_after := by
  unfold and_zext_eq_zero_before and_zext_eq_zero_after
  simp_alive_peephole
  intros
  ---BEGIN and_zext_eq_zero
  apply and_zext_eq_zero_thm
  ---END and_zext_eq_zero



def add_constant_equal_with_the_top_bit_of_demandedbits_pass_before := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(24 : i32) : i32
  %2 = llvm.add %arg9, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_constant_equal_with_the_top_bit_of_demandedbits_pass_after := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.and %arg9, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_constant_equal_with_the_top_bit_of_demandedbits_pass_proof : add_constant_equal_with_the_top_bit_of_demandedbits_pass_before ⊑ add_constant_equal_with_the_top_bit_of_demandedbits_pass_after := by
  unfold add_constant_equal_with_the_top_bit_of_demandedbits_pass_before add_constant_equal_with_the_top_bit_of_demandedbits_pass_after
  simp_alive_peephole
  intros
  ---BEGIN add_constant_equal_with_the_top_bit_of_demandedbits_pass
  apply add_constant_equal_with_the_top_bit_of_demandedbits_pass_thm
  ---END add_constant_equal_with_the_top_bit_of_demandedbits_pass



def add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(24 : i32) : i32
  %2 = llvm.add %arg4, %0 : i32
  %3 = llvm.or %2, %arg5 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(24 : i32) : i32
  %2 = llvm.xor %arg4, %0 : i32
  %3 = llvm.or %2, %arg5 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_proof : add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_before ⊑ add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_after := by
  unfold add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_before add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_after
  simp_alive_peephole
  intros
  ---BEGIN add_constant_equal_with_the_top_bit_of_demandedbits_insertpt
  apply add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_thm
  ---END add_constant_equal_with_the_top_bit_of_demandedbits_insertpt



def and_sext_multiuse_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32, %arg3 : i32):
  %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
  %1 = llvm.sext %0 : i1 to i32
  %2 = llvm.and %1, %arg2 : i32
  %3 = llvm.and %1, %arg3 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_sext_multiuse_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
  %2 = llvm.add %arg2, %arg3 : i32
  %3 = "llvm.select"(%1, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_sext_multiuse_proof : and_sext_multiuse_before ⊑ and_sext_multiuse_after := by
  unfold and_sext_multiuse_before and_sext_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN and_sext_multiuse
  apply and_sext_multiuse_thm
  ---END and_sext_multiuse


