
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
section grem_statements

def test1_before := [llvm|
{
^0(%arg104 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.srem %arg104, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg104 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test3_before := [llvm|
{
^0(%arg103 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.urem %arg103, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg103 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg103, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test4_before := [llvm|
{
^0(%arg97 : i32, %arg98 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = "llvm.select"(%arg98, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.urem %arg97, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg97 : i32, %arg98 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = "llvm.select"(%arg98, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.and %arg97, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4



def test5_before := [llvm|
{
^0(%arg95 : i32, %arg96 : i8):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.zext %arg96 : i8 to i32
  %2 = llvm.shl %0, %1 : i32
  %3 = llvm.urem %arg95, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg95 : i32, %arg96 : i8):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.zext %arg96 : i8 to i32
  %3 = llvm.shl %0, %2 overflow<nuw> : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.and %arg95, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  ---BEGIN test5
  all_goals (try extract_goal ; sorry)
  ---END test5



def test7_before := [llvm|
{
^0(%arg93 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.mul %arg93, %0 : i32
  %3 = llvm.srem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg93 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  ---BEGIN test7
  all_goals (try extract_goal ; sorry)
  ---END test7



def test8_before := [llvm|
{
^0(%arg92 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.shl %arg92, %0 : i32
  %3 = llvm.srem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg92 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  ---BEGIN test8
  all_goals (try extract_goal ; sorry)
  ---END test8



def test9_before := [llvm|
{
^0(%arg91 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(32 : i32) : i32
  %2 = llvm.mul %arg91, %0 : i32
  %3 = llvm.urem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg91 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  ---BEGIN test9
  all_goals (try extract_goal ; sorry)
  ---END test9



def test10_before := [llvm|
{
^0(%arg90 : i8):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(4) : i64
  %2 = llvm.zext %arg90 : i8 to i32
  %3 = llvm.mul %2, %0 : i32
  %4 = llvm.sext %3 : i32 to i64
  %5 = llvm.urem %4, %1 : i64
  %6 = llvm.trunc %5 : i64 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg90 : i8):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  ---BEGIN test10
  all_goals (try extract_goal ; sorry)
  ---END test10



def test11_before := [llvm|
{
^0(%arg89 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.and %arg89, %0 : i32
  %4 = llvm.mul %3, %1 : i32
  %5 = llvm.urem %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg89 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  ---BEGIN test11
  all_goals (try extract_goal ; sorry)
  ---END test11



def test12_before := [llvm|
{
^0(%arg88 : i32):
  %0 = llvm.mlir.constant(-4 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.and %arg88, %0 : i32
  %3 = llvm.srem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg88 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  ---BEGIN test12
  all_goals (try extract_goal ; sorry)
  ---END test12



def test13_before := [llvm|
{
^0(%arg87 : i32):
  %0 = llvm.srem %arg87, %arg87 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg87 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  ---BEGIN test13
  all_goals (try extract_goal ; sorry)
  ---END test13



def test14_before := [llvm|
{
^0(%arg85 : i64, %arg86 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg86 : i32
  %2 = llvm.zext %1 : i32 to i64
  %3 = llvm.urem %arg85, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg85 : i64, %arg86 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1) : i64
  %2 = llvm.shl %0, %arg86 overflow<nuw> : i32
  %3 = llvm.zext %2 : i32 to i64
  %4 = llvm.add %3, %1 overflow<nsw> : i64
  %5 = llvm.and %arg85, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
theorem test14_proof : test14_before ⊑ test14_after := by
  unfold test14_before test14_after
  simp_alive_peephole
  ---BEGIN test14
  all_goals (try extract_goal ; sorry)
  ---END test14



def test15_before := [llvm|
{
^0(%arg83 : i32, %arg84 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg84 : i32
  %2 = llvm.zext %1 : i32 to i64
  %3 = llvm.zext %arg83 : i32 to i64
  %4 = llvm.urem %3, %2 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg83 : i32, %arg84 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg84 overflow<nsw> : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg83, %2 : i32
  %4 = llvm.zext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
}
]
theorem test15_proof : test15_before ⊑ test15_after := by
  unfold test15_before test15_after
  simp_alive_peephole
  ---BEGIN test15
  all_goals (try extract_goal ; sorry)
  ---END test15



def test16_before := [llvm|
{
^0(%arg81 : i32, %arg82 : i32):
  %0 = llvm.mlir.constant(11 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.lshr %arg82, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.urem %arg81, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg81 : i32, %arg82 : i32):
  %0 = llvm.mlir.constant(11 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.lshr %arg82, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.or %4, %2 : i32
  %6 = llvm.and %arg81, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem test16_proof : test16_before ⊑ test16_after := by
  unfold test16_before test16_after
  simp_alive_peephole
  ---BEGIN test16
  all_goals (try extract_goal ; sorry)
  ---END test16



def test19_before := [llvm|
{
^0(%arg76 : i32, %arg77 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg76 : i32
  %2 = llvm.shl %0, %arg77 : i32
  %3 = llvm.and %1, %2 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.urem %arg77, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg76 : i32, %arg77 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg76 overflow<nuw> : i32
  %3 = llvm.shl %0, %arg77 overflow<nuw> : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.add %4, %2 : i32
  %6 = llvm.add %5, %1 : i32
  %7 = llvm.and %arg77, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
theorem test19_proof : test19_before ⊑ test19_after := by
  unfold test19_before test19_after
  simp_alive_peephole
  ---BEGIN test19
  all_goals (try extract_goal ; sorry)
  ---END test19



def test19_commutative0_before := [llvm|
{
^0(%arg74 : i32, %arg75 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg74 : i32
  %2 = llvm.shl %0, %arg75 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.urem %arg75, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test19_commutative0_after := [llvm|
{
^0(%arg74 : i32, %arg75 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg74 overflow<nuw> : i32
  %3 = llvm.shl %0, %arg75 overflow<nuw> : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.add %4, %2 : i32
  %6 = llvm.add %5, %1 : i32
  %7 = llvm.and %arg75, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
theorem test19_commutative0_proof : test19_commutative0_before ⊑ test19_commutative0_after := by
  unfold test19_commutative0_before test19_commutative0_after
  simp_alive_peephole
  ---BEGIN test19_commutative0
  all_goals (try extract_goal ; sorry)
  ---END test19_commutative0



def test19_commutative1_before := [llvm|
{
^0(%arg72 : i32, %arg73 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg72 : i32
  %2 = llvm.shl %0, %arg73 : i32
  %3 = llvm.and %1, %2 : i32
  %4 = llvm.add %1, %3 : i32
  %5 = llvm.urem %arg73, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test19_commutative1_after := [llvm|
{
^0(%arg72 : i32, %arg73 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg72 overflow<nuw> : i32
  %3 = llvm.shl %0, %arg73 overflow<nuw> : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.add %2, %4 : i32
  %6 = llvm.add %5, %1 : i32
  %7 = llvm.and %arg73, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
theorem test19_commutative1_proof : test19_commutative1_before ⊑ test19_commutative1_after := by
  unfold test19_commutative1_before test19_commutative1_after
  simp_alive_peephole
  ---BEGIN test19_commutative1
  all_goals (try extract_goal ; sorry)
  ---END test19_commutative1



def test19_commutative2_before := [llvm|
{
^0(%arg70 : i32, %arg71 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg70 : i32
  %2 = llvm.shl %0, %arg71 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %1, %3 : i32
  %5 = llvm.urem %arg71, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test19_commutative2_after := [llvm|
{
^0(%arg70 : i32, %arg71 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg70 overflow<nuw> : i32
  %3 = llvm.shl %0, %arg71 overflow<nuw> : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.add %2, %4 : i32
  %6 = llvm.add %5, %1 : i32
  %7 = llvm.and %arg71, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
theorem test19_commutative2_proof : test19_commutative2_before ⊑ test19_commutative2_after := by
  unfold test19_commutative2_before test19_commutative2_after
  simp_alive_peephole
  ---BEGIN test19_commutative2
  all_goals (try extract_goal ; sorry)
  ---END test19_commutative2



def test22_before := [llvm|
{
^0(%arg55 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg55, %0 : i32
  %2 = llvm.srem %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test22_after := [llvm|
{
^0(%arg55 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg55, %0 : i32
  %2 = llvm.urem %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test22_proof : test22_before ⊑ test22_after := by
  unfold test22_before test22_after
  simp_alive_peephole
  ---BEGIN test22
  all_goals (try extract_goal ; sorry)
  ---END test22



def srem_constant_dividend_select_of_constants_divisor_before := [llvm|
{
^0(%arg37 : i1):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(-3 : i32) : i32
  %2 = llvm.mlir.constant(42 : i32) : i32
  %3 = "llvm.select"(%arg37, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.srem %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def srem_constant_dividend_select_of_constants_divisor_after := [llvm|
{
^0(%arg37 : i1):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = "llvm.select"(%arg37, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem srem_constant_dividend_select_of_constants_divisor_proof : srem_constant_dividend_select_of_constants_divisor_before ⊑ srem_constant_dividend_select_of_constants_divisor_after := by
  unfold srem_constant_dividend_select_of_constants_divisor_before srem_constant_dividend_select_of_constants_divisor_after
  simp_alive_peephole
  ---BEGIN srem_constant_dividend_select_of_constants_divisor
  all_goals (try extract_goal ; sorry)
  ---END srem_constant_dividend_select_of_constants_divisor



def srem_constant_dividend_select_of_constants_divisor_0_arm_before := [llvm|
{
^0(%arg35 : i1):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(42 : i32) : i32
  %3 = "llvm.select"(%arg35, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.srem %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def srem_constant_dividend_select_of_constants_divisor_0_arm_after := [llvm|
{
^0(%arg35 : i1):
  %0 = llvm.mlir.constant(6 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem srem_constant_dividend_select_of_constants_divisor_0_arm_proof : srem_constant_dividend_select_of_constants_divisor_0_arm_before ⊑ srem_constant_dividend_select_of_constants_divisor_0_arm_after := by
  unfold srem_constant_dividend_select_of_constants_divisor_0_arm_before srem_constant_dividend_select_of_constants_divisor_0_arm_after
  simp_alive_peephole
  ---BEGIN srem_constant_dividend_select_of_constants_divisor_0_arm
  all_goals (try extract_goal ; sorry)
  ---END srem_constant_dividend_select_of_constants_divisor_0_arm



def urem_constant_dividend_select_of_constants_divisor_before := [llvm|
{
^0(%arg25 : i1):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(-3 : i32) : i32
  %2 = llvm.mlir.constant(42 : i32) : i32
  %3 = "llvm.select"(%arg25, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.urem %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def urem_constant_dividend_select_of_constants_divisor_after := [llvm|
{
^0(%arg25 : i1):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = "llvm.select"(%arg25, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem urem_constant_dividend_select_of_constants_divisor_proof : urem_constant_dividend_select_of_constants_divisor_before ⊑ urem_constant_dividend_select_of_constants_divisor_after := by
  unfold urem_constant_dividend_select_of_constants_divisor_before urem_constant_dividend_select_of_constants_divisor_after
  simp_alive_peephole
  ---BEGIN urem_constant_dividend_select_of_constants_divisor
  all_goals (try extract_goal ; sorry)
  ---END urem_constant_dividend_select_of_constants_divisor



def urem_constant_dividend_select_of_constants_divisor_0_arm_before := [llvm|
{
^0(%arg23 : i1):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(42 : i32) : i32
  %3 = "llvm.select"(%arg23, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.urem %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def urem_constant_dividend_select_of_constants_divisor_0_arm_after := [llvm|
{
^0(%arg23 : i1):
  %0 = llvm.mlir.constant(6 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem urem_constant_dividend_select_of_constants_divisor_0_arm_proof : urem_constant_dividend_select_of_constants_divisor_0_arm_before ⊑ urem_constant_dividend_select_of_constants_divisor_0_arm_after := by
  unfold urem_constant_dividend_select_of_constants_divisor_0_arm_before urem_constant_dividend_select_of_constants_divisor_0_arm_after
  simp_alive_peephole
  ---BEGIN urem_constant_dividend_select_of_constants_divisor_0_arm
  all_goals (try extract_goal ; sorry)
  ---END urem_constant_dividend_select_of_constants_divisor_0_arm


