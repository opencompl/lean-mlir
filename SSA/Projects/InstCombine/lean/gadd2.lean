import SSA.Projects.InstCombine.lean.gadd2_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def test2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg0, %1 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 39 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test2
  apply test2_thm
  ---END test2



def test3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.lshr %arg0, %1 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.lshr %arg0, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test3
  apply test3_thm
  ---END test3



def test4_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.add %arg0, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test4
  apply test4_thm
  ---END test4



def test9_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 2 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 32767 : i16}> : () -> i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.mul %arg0, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = -32767 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test9
  apply test9_thm
  ---END test9



def test10_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1431655766 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1431655765 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %4 = llvm.ashr %arg0, %0 : i32
  %5 = llvm.or %4, %1 : i32
  %6 = llvm.xor %5, %2 : i32
  %7 = llvm.add %arg1, %3 : i32
  %8 = llvm.add %7, %6 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1431655765 : i32}> : () -> i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.sub %arg1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test10
  apply test10_thm
  ---END test10



def test11_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1431655766 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1431655765 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %3 = llvm.or %arg0, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %arg1, %2 : i32
  %6 = llvm.add %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1431655765 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test11
  apply test11_thm
  ---END test11



def test12_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1431655766 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1431655765 : i32}> : () -> i32
  %3 = llvm.add %arg1, %0 : i32
  %4 = llvm.or %arg0, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1431655765 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test12
  apply test12_thm
  ---END test12



def test13_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1431655767 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1431655766 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %3 = llvm.or %arg0, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %arg1, %2 : i32
  %6 = llvm.add %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1431655766 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test13
  apply test13_thm
  ---END test13



def test14_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1431655767 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1431655766 : i32}> : () -> i32
  %3 = llvm.add %arg1, %0 : i32
  %4 = llvm.or %arg0, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1431655766 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test14_proof : test14_before ⊑ test14_after := by
  unfold test14_before test14_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test14
  apply test14_thm
  ---END test14



def test15_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1431655767 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.add %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1431655766 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test15_proof : test15_before ⊑ test15_after := by
  unfold test15_before test15_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test15
  apply test15_thm
  ---END test15



def test16_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1431655767 : i32}> : () -> i32
  %2 = llvm.add %arg1, %0 : i32
  %3 = llvm.and %arg0, %1 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1431655766 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test16_proof : test16_before ⊑ test16_after := by
  unfold test16_before test16_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test16
  apply test16_thm
  ---END test16



def test17_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1431655766 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1431655765 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = llvm.add %3, %arg1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test17_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1431655765 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test17_proof : test17_before ⊑ test17_after := by
  unfold test17_before test17_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test17
  apply test17_thm
  ---END test17



def test18_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1431655766 : i32}> : () -> i32
  %2 = llvm.add %arg1, %0 : i32
  %3 = llvm.and %arg0, %1 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1431655765 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test18_proof : test18_before ⊑ test18_after := by
  unfold test18_before test18_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test18
  apply test18_thm
  ---END test18



def add_nsw_mul_nsw_before := [llvm|
{
^0(%arg0 : i16):
  %0 = llvm.add %arg0, %arg0 : i16
  %1 = llvm.add %0, %arg0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
def add_nsw_mul_nsw_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 3 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem add_nsw_mul_nsw_proof : add_nsw_mul_nsw_before ⊑ add_nsw_mul_nsw_after := by
  unfold add_nsw_mul_nsw_before add_nsw_mul_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_nsw_mul_nsw
  all_goals (try extract_goal ; sorry)
  ---END add_nsw_mul_nsw



def mul_add_to_mul_1_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 8 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  %2 = llvm.add %arg0, %1 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def mul_add_to_mul_1_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 9 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_1_proof : mul_add_to_mul_1_before ⊑ mul_add_to_mul_1_after := by
  unfold mul_add_to_mul_1_before mul_add_to_mul_1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN mul_add_to_mul_1
  apply mul_add_to_mul_1_thm
  ---END mul_add_to_mul_1



def mul_add_to_mul_2_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 8 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  %2 = llvm.add %1, %arg0 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def mul_add_to_mul_2_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 9 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_2_proof : mul_add_to_mul_2_before ⊑ mul_add_to_mul_2_after := by
  unfold mul_add_to_mul_2_before mul_add_to_mul_2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN mul_add_to_mul_2
  apply mul_add_to_mul_2_thm
  ---END mul_add_to_mul_2



def mul_add_to_mul_3_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 2 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 3 : i16}> : () -> i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.mul %arg0, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_3_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 5 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_3_proof : mul_add_to_mul_3_before ⊑ mul_add_to_mul_3_after := by
  unfold mul_add_to_mul_3_before mul_add_to_mul_3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN mul_add_to_mul_3
  apply mul_add_to_mul_3_thm
  ---END mul_add_to_mul_3



def mul_add_to_mul_4_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 2 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 7 : i16}> : () -> i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.mul %arg0, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_4_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 9 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_4_proof : mul_add_to_mul_4_before ⊑ mul_add_to_mul_4_after := by
  unfold mul_add_to_mul_4_before mul_add_to_mul_4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN mul_add_to_mul_4
  apply mul_add_to_mul_4_thm
  ---END mul_add_to_mul_4



def mul_add_to_mul_5_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 3 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 7 : i16}> : () -> i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.mul %arg0, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_5_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 10 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_5_proof : mul_add_to_mul_5_before ⊑ mul_add_to_mul_5_after := by
  unfold mul_add_to_mul_5_before mul_add_to_mul_5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN mul_add_to_mul_5
  apply mul_add_to_mul_5_thm
  ---END mul_add_to_mul_5



def mul_add_to_mul_6_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %arg1 : i32
  %2 = llvm.mul %1, %0 : i32
  %3 = llvm.add %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def mul_add_to_mul_6_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %arg1 : i32
  %2 = llvm.mul %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem mul_add_to_mul_6_proof : mul_add_to_mul_6_before ⊑ mul_add_to_mul_6_after := by
  unfold mul_add_to_mul_6_before mul_add_to_mul_6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN mul_add_to_mul_6
  apply mul_add_to_mul_6_thm
  ---END mul_add_to_mul_6



def mul_add_to_mul_7_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 32767 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  %2 = llvm.add %arg0, %1 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def mul_add_to_mul_7_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 15 : i16}> : () -> i16
  %1 = llvm.shl %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_7_proof : mul_add_to_mul_7_before ⊑ mul_add_to_mul_7_after := by
  unfold mul_add_to_mul_7_before mul_add_to_mul_7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN mul_add_to_mul_7
  apply mul_add_to_mul_7_thm
  ---END mul_add_to_mul_7



def mul_add_to_mul_8_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 16383 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 16384 : i16}> : () -> i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.mul %arg0, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_8_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 32767 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_8_proof : mul_add_to_mul_8_before ⊑ mul_add_to_mul_8_after := by
  unfold mul_add_to_mul_8_before mul_add_to_mul_8_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN mul_add_to_mul_8
  apply mul_add_to_mul_8_thm
  ---END mul_add_to_mul_8



def mul_add_to_mul_9_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 16384 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.add %1, %2 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def mul_add_to_mul_9_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{value = 15 : i16}> : () -> i16
  %1 = llvm.shl %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_9_proof : mul_add_to_mul_9_before ⊑ mul_add_to_mul_9_after := by
  unfold mul_add_to_mul_9_before mul_add_to_mul_9_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN mul_add_to_mul_9
  apply mul_add_to_mul_9_thm
  ---END mul_add_to_mul_9



def add_or_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_or_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_or_and_proof : add_or_and_before ⊑ add_or_and_after := by
  unfold add_or_and_before add_or_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_or_and
  apply add_or_and_thm
  ---END add_or_and



def add_or_and_commutative_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_or_and_commutative_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_or_and_commutative_proof : add_or_and_commutative_before ⊑ add_or_and_commutative_after := by
  unfold add_or_and_commutative_before add_or_and_commutative_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_or_and_commutative
  apply add_or_and_commutative_thm
  ---END add_or_and_commutative



def add_and_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.add %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_and_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_and_or_proof : add_and_or_before ⊑ add_and_or_after := by
  unfold add_and_or_before add_and_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_and_or
  all_goals (try extract_goal ; sorry)
  ---END add_and_or



def add_and_or_commutative_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.add %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_and_or_commutative_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_and_or_commutative_proof : add_and_or_commutative_before ⊑ add_and_or_commutative_after := by
  unfold add_and_or_commutative_before add_and_or_commutative_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_and_or_commutative
  apply add_and_or_commutative_thm
  ---END add_and_or_commutative



def add_nsw_or_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_nsw_or_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_nsw_or_and_proof : add_nsw_or_and_before ⊑ add_nsw_or_and_after := by
  unfold add_nsw_or_and_before add_nsw_or_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_nsw_or_and
  apply add_nsw_or_and_thm
  ---END add_nsw_or_and



def add_nuw_or_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_nuw_or_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_nuw_or_and_proof : add_nuw_or_and_before ⊑ add_nuw_or_and_after := by
  unfold add_nuw_or_and_before add_nuw_or_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_nuw_or_and
  apply add_nuw_or_and_thm
  ---END add_nuw_or_and



def add_nuw_nsw_or_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_nuw_nsw_or_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_nuw_nsw_or_and_proof : add_nuw_nsw_or_and_before ⊑ add_nuw_nsw_or_and_after := by
  unfold add_nuw_nsw_or_and_before add_nuw_nsw_or_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_nuw_nsw_or_and
  apply add_nuw_nsw_or_and_thm
  ---END add_nuw_nsw_or_and



def add_of_mul_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.mul %arg0, %arg1 : i8
  %1 = llvm.mul %arg0, %arg2 : i8
  %2 = llvm.add %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def add_of_mul_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.mul %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem add_of_mul_proof : add_of_mul_before ⊑ add_of_mul_after := by
  unfold add_of_mul_before add_of_mul_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_of_mul
  all_goals (try extract_goal ; sorry)
  ---END add_of_mul



def add_undemanded_low_bits_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1616 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %3 = llvm.or %arg0, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.lshr %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def add_undemanded_low_bits_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1616 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem add_undemanded_low_bits_proof : add_undemanded_low_bits_before ⊑ add_undemanded_low_bits_after := by
  unfold add_undemanded_low_bits_before add_undemanded_low_bits_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_undemanded_low_bits
  apply add_undemanded_low_bits_thm
  ---END add_undemanded_low_bits



def sub_undemanded_low_bits_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1616 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %3 = llvm.or %arg0, %0 : i32
  %4 = llvm.sub %3, %1 : i32
  %5 = llvm.lshr %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def sub_undemanded_low_bits_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1616 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem sub_undemanded_low_bits_proof : sub_undemanded_low_bits_before ⊑ sub_undemanded_low_bits_after := by
  unfold sub_undemanded_low_bits_before sub_undemanded_low_bits_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_undemanded_low_bits
  apply sub_undemanded_low_bits_thm
  ---END sub_undemanded_low_bits


