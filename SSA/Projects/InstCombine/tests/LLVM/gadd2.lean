
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
section gadd2_statements

def test1_before := [llvm|
{
^0(%arg60 : i64, %arg61 : i32):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.mlir.constant(123) : i64
  %2 = llvm.zext %arg61 : i32 to i64
  %3 = llvm.shl %2, %0 : i64
  %4 = llvm.add %3, %arg60 : i64
  %5 = llvm.and %4, %1 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg60 : i64, %arg61 : i32):
  %0 = llvm.mlir.constant(123) : i64
  %1 = llvm.and %arg60, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg59 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(32 : i32) : i32
  %2 = llvm.and %arg59, %0 : i32
  %3 = llvm.and %arg59, %1 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg59 : i32):
  %0 = llvm.mlir.constant(39 : i32) : i32
  %1 = llvm.and %arg59, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2



def test3_before := [llvm|
{
^0(%arg58 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(30 : i32) : i32
  %2 = llvm.and %arg58, %0 : i32
  %3 = llvm.lshr %arg58, %1 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg58 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(30 : i32) : i32
  %2 = llvm.and %arg58, %0 : i32
  %3 = llvm.lshr %arg58, %1 : i32
  %4 = llvm.or disjoint %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  intros
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test4_before := [llvm|
{
^0(%arg57 : i32):
  %0 = llvm.add %arg57, %arg57 overflow<nuw> : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg57 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %arg57, %0 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  intros
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4



def test9_before := [llvm|
{
^0(%arg52 : i16):
  %0 = llvm.mlir.constant(2 : i16) : i16
  %1 = llvm.mlir.constant(32767 : i16) : i16
  %2 = llvm.mul %arg52, %0 : i16
  %3 = llvm.mul %arg52, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg52 : i16):
  %0 = llvm.mlir.constant(-32767 : i16) : i16
  %1 = llvm.mul %arg52, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  intros
  ---BEGIN test9
  all_goals (try extract_goal ; sorry)
  ---END test9



def test10_before := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(-1431655766 : i32) : i32
  %2 = llvm.mlir.constant(1431655765 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.ashr %arg50, %0 : i32
  %5 = llvm.or %4, %1 : i32
  %6 = llvm.xor %5, %2 : i32
  %7 = llvm.add %arg51, %3 : i32
  %8 = llvm.add %7, %6 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1431655765 : i32) : i32
  %2 = llvm.ashr %arg50, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.sub %arg51, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  intros
  ---BEGIN test10
  all_goals (try extract_goal ; sorry)
  ---END test10



def test11_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(-1431655766 : i32) : i32
  %1 = llvm.mlir.constant(1431655765 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.or %arg48, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %arg49, %2 : i32
  %6 = llvm.add %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(1431655765 : i32) : i32
  %1 = llvm.and %arg48, %0 : i32
  %2 = llvm.sub %arg49, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  intros
  ---BEGIN test11
  all_goals (try extract_goal ; sorry)
  ---END test11



def test12_before := [llvm|
{
^0(%arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1431655766 : i32) : i32
  %2 = llvm.mlir.constant(1431655765 : i32) : i32
  %3 = llvm.add %arg47, %0 overflow<nsw> : i32
  %4 = llvm.or %arg46, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %3, %5 overflow<nsw> : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(1431655765 : i32) : i32
  %1 = llvm.and %arg46, %0 : i32
  %2 = llvm.sub %arg47, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  intros
  ---BEGIN test12
  all_goals (try extract_goal ; sorry)
  ---END test12



def test13_before := [llvm|
{
^0(%arg44 : i32, %arg45 : i32):
  %0 = llvm.mlir.constant(-1431655767 : i32) : i32
  %1 = llvm.mlir.constant(1431655766 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.or %arg44, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %arg45, %2 : i32
  %6 = llvm.add %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg44 : i32, %arg45 : i32):
  %0 = llvm.mlir.constant(1431655766 : i32) : i32
  %1 = llvm.and %arg44, %0 : i32
  %2 = llvm.sub %arg45, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  intros
  ---BEGIN test13
  all_goals (try extract_goal ; sorry)
  ---END test13



def test14_before := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1431655767 : i32) : i32
  %2 = llvm.mlir.constant(1431655766 : i32) : i32
  %3 = llvm.add %arg43, %0 overflow<nsw> : i32
  %4 = llvm.or %arg42, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %3, %5 overflow<nsw> : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(1431655766 : i32) : i32
  %1 = llvm.and %arg42, %0 : i32
  %2 = llvm.sub %arg43, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test14_proof : test14_before ⊑ test14_after := by
  unfold test14_before test14_after
  simp_alive_peephole
  intros
  ---BEGIN test14
  all_goals (try extract_goal ; sorry)
  ---END test14



def test15_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(-1431655767 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg40, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %arg41, %1 : i32
  %5 = llvm.add %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(1431655766 : i32) : i32
  %1 = llvm.or %arg40, %0 : i32
  %2 = llvm.sub %arg41, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15_proof : test15_before ⊑ test15_after := by
  unfold test15_before test15_after
  simp_alive_peephole
  intros
  ---BEGIN test15
  all_goals (try extract_goal ; sorry)
  ---END test15



def test16_before := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1431655767 : i32) : i32
  %2 = llvm.add %arg39, %0 overflow<nsw> : i32
  %3 = llvm.and %arg38, %1 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %2, %4 overflow<nsw> : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(1431655766 : i32) : i32
  %1 = llvm.or %arg38, %0 : i32
  %2 = llvm.sub %arg39, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test16_proof : test16_before ⊑ test16_after := by
  unfold test16_before test16_after
  simp_alive_peephole
  intros
  ---BEGIN test16
  all_goals (try extract_goal ; sorry)
  ---END test16



def test17_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(-1431655766 : i32) : i32
  %1 = llvm.mlir.constant(-1431655765 : i32) : i32
  %2 = llvm.and %arg36, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = llvm.add %3, %arg37 overflow<nsw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test17_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(1431655765 : i32) : i32
  %1 = llvm.or %arg36, %0 : i32
  %2 = llvm.sub %arg37, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test17_proof : test17_before ⊑ test17_after := by
  unfold test17_before test17_after
  simp_alive_peephole
  intros
  ---BEGIN test17
  all_goals (try extract_goal ; sorry)
  ---END test17



def test18_before := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1431655766 : i32) : i32
  %2 = llvm.add %arg35, %0 overflow<nsw> : i32
  %3 = llvm.and %arg34, %1 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %2, %4 overflow<nsw> : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.mlir.constant(1431655765 : i32) : i32
  %1 = llvm.or %arg34, %0 : i32
  %2 = llvm.sub %arg35, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test18_proof : test18_before ⊑ test18_after := by
  unfold test18_before test18_after
  simp_alive_peephole
  intros
  ---BEGIN test18
  all_goals (try extract_goal ; sorry)
  ---END test18



def add_nsw_mul_nsw_before := [llvm|
{
^0(%arg33 : i16):
  %0 = llvm.add %arg33, %arg33 overflow<nsw> : i16
  %1 = llvm.add %0, %arg33 overflow<nsw> : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
def add_nsw_mul_nsw_after := [llvm|
{
^0(%arg33 : i16):
  %0 = llvm.mlir.constant(3 : i16) : i16
  %1 = llvm.mul %arg33, %0 overflow<nsw> : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_nsw_mul_nsw_proof : add_nsw_mul_nsw_before ⊑ add_nsw_mul_nsw_after := by
  unfold add_nsw_mul_nsw_before add_nsw_mul_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN add_nsw_mul_nsw
  all_goals (try extract_goal ; sorry)
  ---END add_nsw_mul_nsw



def mul_add_to_mul_1_before := [llvm|
{
^0(%arg32 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mul %arg32, %0 overflow<nsw> : i16
  %2 = llvm.add %arg32, %1 overflow<nsw> : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def mul_add_to_mul_1_after := [llvm|
{
^0(%arg32 : i16):
  %0 = llvm.mlir.constant(9 : i16) : i16
  %1 = llvm.mul %arg32, %0 overflow<nsw> : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_add_to_mul_1_proof : mul_add_to_mul_1_before ⊑ mul_add_to_mul_1_after := by
  unfold mul_add_to_mul_1_before mul_add_to_mul_1_after
  simp_alive_peephole
  intros
  ---BEGIN mul_add_to_mul_1
  all_goals (try extract_goal ; sorry)
  ---END mul_add_to_mul_1



def mul_add_to_mul_2_before := [llvm|
{
^0(%arg31 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mul %arg31, %0 overflow<nsw> : i16
  %2 = llvm.add %1, %arg31 overflow<nsw> : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def mul_add_to_mul_2_after := [llvm|
{
^0(%arg31 : i16):
  %0 = llvm.mlir.constant(9 : i16) : i16
  %1 = llvm.mul %arg31, %0 overflow<nsw> : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_add_to_mul_2_proof : mul_add_to_mul_2_before ⊑ mul_add_to_mul_2_after := by
  unfold mul_add_to_mul_2_before mul_add_to_mul_2_after
  simp_alive_peephole
  intros
  ---BEGIN mul_add_to_mul_2
  all_goals (try extract_goal ; sorry)
  ---END mul_add_to_mul_2



def mul_add_to_mul_3_before := [llvm|
{
^0(%arg30 : i16):
  %0 = llvm.mlir.constant(2 : i16) : i16
  %1 = llvm.mlir.constant(3 : i16) : i16
  %2 = llvm.mul %arg30, %0 : i16
  %3 = llvm.mul %arg30, %1 : i16
  %4 = llvm.add %2, %3 overflow<nsw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_3_after := [llvm|
{
^0(%arg30 : i16):
  %0 = llvm.mlir.constant(5 : i16) : i16
  %1 = llvm.mul %arg30, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_add_to_mul_3_proof : mul_add_to_mul_3_before ⊑ mul_add_to_mul_3_after := by
  unfold mul_add_to_mul_3_before mul_add_to_mul_3_after
  simp_alive_peephole
  intros
  ---BEGIN mul_add_to_mul_3
  all_goals (try extract_goal ; sorry)
  ---END mul_add_to_mul_3



def mul_add_to_mul_4_before := [llvm|
{
^0(%arg29 : i16):
  %0 = llvm.mlir.constant(2 : i16) : i16
  %1 = llvm.mlir.constant(7 : i16) : i16
  %2 = llvm.mul %arg29, %0 overflow<nsw> : i16
  %3 = llvm.mul %arg29, %1 overflow<nsw> : i16
  %4 = llvm.add %2, %3 overflow<nsw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_4_after := [llvm|
{
^0(%arg29 : i16):
  %0 = llvm.mlir.constant(9 : i16) : i16
  %1 = llvm.mul %arg29, %0 overflow<nsw> : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_add_to_mul_4_proof : mul_add_to_mul_4_before ⊑ mul_add_to_mul_4_after := by
  unfold mul_add_to_mul_4_before mul_add_to_mul_4_after
  simp_alive_peephole
  intros
  ---BEGIN mul_add_to_mul_4
  all_goals (try extract_goal ; sorry)
  ---END mul_add_to_mul_4



def mul_add_to_mul_5_before := [llvm|
{
^0(%arg28 : i16):
  %0 = llvm.mlir.constant(3 : i16) : i16
  %1 = llvm.mlir.constant(7 : i16) : i16
  %2 = llvm.mul %arg28, %0 overflow<nsw> : i16
  %3 = llvm.mul %arg28, %1 overflow<nsw> : i16
  %4 = llvm.add %2, %3 overflow<nsw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_5_after := [llvm|
{
^0(%arg28 : i16):
  %0 = llvm.mlir.constant(10 : i16) : i16
  %1 = llvm.mul %arg28, %0 overflow<nsw> : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_add_to_mul_5_proof : mul_add_to_mul_5_before ⊑ mul_add_to_mul_5_after := by
  unfold mul_add_to_mul_5_before mul_add_to_mul_5_after
  simp_alive_peephole
  intros
  ---BEGIN mul_add_to_mul_5
  all_goals (try extract_goal ; sorry)
  ---END mul_add_to_mul_5



def mul_add_to_mul_6_before := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mul %arg26, %arg27 overflow<nsw> : i32
  %2 = llvm.mul %1, %0 overflow<nsw> : i32
  %3 = llvm.add %1, %2 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def mul_add_to_mul_6_after := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mul %arg26, %arg27 overflow<nsw> : i32
  %2 = llvm.mul %1, %0 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_add_to_mul_6_proof : mul_add_to_mul_6_before ⊑ mul_add_to_mul_6_after := by
  unfold mul_add_to_mul_6_before mul_add_to_mul_6_after
  simp_alive_peephole
  intros
  ---BEGIN mul_add_to_mul_6
  all_goals (try extract_goal ; sorry)
  ---END mul_add_to_mul_6



def mul_add_to_mul_7_before := [llvm|
{
^0(%arg25 : i16):
  %0 = llvm.mlir.constant(32767 : i16) : i16
  %1 = llvm.mul %arg25, %0 overflow<nsw> : i16
  %2 = llvm.add %arg25, %1 overflow<nsw> : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def mul_add_to_mul_7_after := [llvm|
{
^0(%arg25 : i16):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.shl %arg25, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_add_to_mul_7_proof : mul_add_to_mul_7_before ⊑ mul_add_to_mul_7_after := by
  unfold mul_add_to_mul_7_before mul_add_to_mul_7_after
  simp_alive_peephole
  intros
  ---BEGIN mul_add_to_mul_7
  all_goals (try extract_goal ; sorry)
  ---END mul_add_to_mul_7



def mul_add_to_mul_8_before := [llvm|
{
^0(%arg24 : i16):
  %0 = llvm.mlir.constant(16383 : i16) : i16
  %1 = llvm.mlir.constant(16384 : i16) : i16
  %2 = llvm.mul %arg24, %0 overflow<nsw> : i16
  %3 = llvm.mul %arg24, %1 overflow<nsw> : i16
  %4 = llvm.add %2, %3 overflow<nsw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_8_after := [llvm|
{
^0(%arg24 : i16):
  %0 = llvm.mlir.constant(32767 : i16) : i16
  %1 = llvm.mul %arg24, %0 overflow<nsw> : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_add_to_mul_8_proof : mul_add_to_mul_8_before ⊑ mul_add_to_mul_8_after := by
  unfold mul_add_to_mul_8_before mul_add_to_mul_8_after
  simp_alive_peephole
  intros
  ---BEGIN mul_add_to_mul_8
  all_goals (try extract_goal ; sorry)
  ---END mul_add_to_mul_8



def mul_add_to_mul_9_before := [llvm|
{
^0(%arg23 : i16):
  %0 = llvm.mlir.constant(16384 : i16) : i16
  %1 = llvm.mul %arg23, %0 overflow<nsw> : i16
  %2 = llvm.mul %arg23, %0 overflow<nsw> : i16
  %3 = llvm.add %1, %2 overflow<nsw> : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def mul_add_to_mul_9_after := [llvm|
{
^0(%arg23 : i16):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.shl %arg23, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_add_to_mul_9_proof : mul_add_to_mul_9_before ⊑ mul_add_to_mul_9_after := by
  unfold mul_add_to_mul_9_before mul_add_to_mul_9_after
  simp_alive_peephole
  intros
  ---BEGIN mul_add_to_mul_9
  all_goals (try extract_goal ; sorry)
  ---END mul_add_to_mul_9



def add_or_and_before := [llvm|
{
^0(%arg19 : i32, %arg20 : i32):
  %0 = llvm.or %arg19, %arg20 : i32
  %1 = llvm.and %arg19, %arg20 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_or_and_after := [llvm|
{
^0(%arg19 : i32, %arg20 : i32):
  %0 = llvm.add %arg19, %arg20 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_or_and_proof : add_or_and_before ⊑ add_or_and_after := by
  unfold add_or_and_before add_or_and_after
  simp_alive_peephole
  intros
  ---BEGIN add_or_and
  all_goals (try extract_goal ; sorry)
  ---END add_or_and



def add_or_and_commutative_before := [llvm|
{
^0(%arg17 : i32, %arg18 : i32):
  %0 = llvm.or %arg17, %arg18 : i32
  %1 = llvm.and %arg18, %arg17 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_or_and_commutative_after := [llvm|
{
^0(%arg17 : i32, %arg18 : i32):
  %0 = llvm.add %arg17, %arg18 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_or_and_commutative_proof : add_or_and_commutative_before ⊑ add_or_and_commutative_after := by
  unfold add_or_and_commutative_before add_or_and_commutative_after
  simp_alive_peephole
  intros
  ---BEGIN add_or_and_commutative
  all_goals (try extract_goal ; sorry)
  ---END add_or_and_commutative



def add_and_or_before := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.or %arg15, %arg16 : i32
  %1 = llvm.and %arg15, %arg16 : i32
  %2 = llvm.add %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_and_or_after := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.add %arg15, %arg16 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_and_or_proof : add_and_or_before ⊑ add_and_or_after := by
  unfold add_and_or_before add_and_or_after
  simp_alive_peephole
  intros
  ---BEGIN add_and_or
  all_goals (try extract_goal ; sorry)
  ---END add_and_or



def add_and_or_commutative_before := [llvm|
{
^0(%arg13 : i32, %arg14 : i32):
  %0 = llvm.or %arg13, %arg14 : i32
  %1 = llvm.and %arg14, %arg13 : i32
  %2 = llvm.add %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_and_or_commutative_after := [llvm|
{
^0(%arg13 : i32, %arg14 : i32):
  %0 = llvm.add %arg13, %arg14 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_and_or_commutative_proof : add_and_or_commutative_before ⊑ add_and_or_commutative_after := by
  unfold add_and_or_commutative_before add_and_or_commutative_after
  simp_alive_peephole
  intros
  ---BEGIN add_and_or_commutative
  all_goals (try extract_goal ; sorry)
  ---END add_and_or_commutative



def add_nsw_or_and_before := [llvm|
{
^0(%arg11 : i32, %arg12 : i32):
  %0 = llvm.or %arg11, %arg12 : i32
  %1 = llvm.and %arg11, %arg12 : i32
  %2 = llvm.add %0, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_nsw_or_and_after := [llvm|
{
^0(%arg11 : i32, %arg12 : i32):
  %0 = llvm.add %arg11, %arg12 overflow<nsw> : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_nsw_or_and_proof : add_nsw_or_and_before ⊑ add_nsw_or_and_after := by
  unfold add_nsw_or_and_before add_nsw_or_and_after
  simp_alive_peephole
  intros
  ---BEGIN add_nsw_or_and
  all_goals (try extract_goal ; sorry)
  ---END add_nsw_or_and



def add_nuw_or_and_before := [llvm|
{
^0(%arg9 : i32, %arg10 : i32):
  %0 = llvm.or %arg9, %arg10 : i32
  %1 = llvm.and %arg9, %arg10 : i32
  %2 = llvm.add %0, %1 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_nuw_or_and_after := [llvm|
{
^0(%arg9 : i32, %arg10 : i32):
  %0 = llvm.add %arg9, %arg10 overflow<nuw> : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_nuw_or_and_proof : add_nuw_or_and_before ⊑ add_nuw_or_and_after := by
  unfold add_nuw_or_and_before add_nuw_or_and_after
  simp_alive_peephole
  intros
  ---BEGIN add_nuw_or_and
  all_goals (try extract_goal ; sorry)
  ---END add_nuw_or_and



def add_nuw_nsw_or_and_before := [llvm|
{
^0(%arg7 : i32, %arg8 : i32):
  %0 = llvm.or %arg7, %arg8 : i32
  %1 = llvm.and %arg7, %arg8 : i32
  %2 = llvm.add %0, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_nuw_nsw_or_and_after := [llvm|
{
^0(%arg7 : i32, %arg8 : i32):
  %0 = llvm.add %arg7, %arg8 overflow<nsw,nuw> : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_nuw_nsw_or_and_proof : add_nuw_nsw_or_and_before ⊑ add_nuw_nsw_or_and_after := by
  unfold add_nuw_nsw_or_and_before add_nuw_nsw_or_and_after
  simp_alive_peephole
  intros
  ---BEGIN add_nuw_nsw_or_and
  all_goals (try extract_goal ; sorry)
  ---END add_nuw_nsw_or_and



def add_of_mul_before := [llvm|
{
^0(%arg4 : i8, %arg5 : i8, %arg6 : i8):
  %0 = llvm.mul %arg4, %arg5 overflow<nsw> : i8
  %1 = llvm.mul %arg4, %arg6 overflow<nsw> : i8
  %2 = llvm.add %0, %1 overflow<nsw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def add_of_mul_after := [llvm|
{
^0(%arg4 : i8, %arg5 : i8, %arg6 : i8):
  %0 = llvm.add %arg5, %arg6 : i8
  %1 = llvm.mul %arg4, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_of_mul_proof : add_of_mul_before ⊑ add_of_mul_after := by
  unfold add_of_mul_before add_of_mul_after
  simp_alive_peephole
  intros
  ---BEGIN add_of_mul
  all_goals (try extract_goal ; sorry)
  ---END add_of_mul



def add_of_selects_before := [llvm|
{
^0(%arg2 : i1, %arg3 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = "llvm.select"(%arg2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = "llvm.select"(%arg2, %arg3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def add_of_selects_after := [llvm|
{
^0(%arg2 : i1, %arg3 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = "llvm.select"(%arg2, %arg3, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_of_selects_proof : add_of_selects_before ⊑ add_of_selects_after := by
  unfold add_of_selects_before add_of_selects_after
  simp_alive_peephole
  intros
  ---BEGIN add_of_selects
  all_goals (try extract_goal ; sorry)
  ---END add_of_selects



def add_undemanded_low_bits_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(1616 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.or %arg1, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.lshr %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def add_undemanded_low_bits_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(1616 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.add %arg1, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_undemanded_low_bits_proof : add_undemanded_low_bits_before ⊑ add_undemanded_low_bits_after := by
  unfold add_undemanded_low_bits_before add_undemanded_low_bits_after
  simp_alive_peephole
  intros
  ---BEGIN add_undemanded_low_bits
  all_goals (try extract_goal ; sorry)
  ---END add_undemanded_low_bits



def sub_undemanded_low_bits_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(1616 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.or %arg0, %0 : i32
  %4 = llvm.sub %3, %1 : i32
  %5 = llvm.lshr %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def sub_undemanded_low_bits_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(-1616 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_undemanded_low_bits_proof : sub_undemanded_low_bits_before ⊑ sub_undemanded_low_bits_after := by
  unfold sub_undemanded_low_bits_before sub_undemanded_low_bits_after
  simp_alive_peephole
  intros
  ---BEGIN sub_undemanded_low_bits
  all_goals (try extract_goal ; sorry)
  ---END sub_undemanded_low_bits


