
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
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.srem %arg104, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg104 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test3_before := [llvm|
{
^0(%arg103 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = llvm.urem %arg103, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg103 : i32):
  %0 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %1 = llvm.and %arg103, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test7_before := [llvm|
{
^0(%arg93 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %2 = llvm.mul %arg93, %0 : i32
  %3 = llvm.srem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg93 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test7
  all_goals (try extract_goal ; sorry)
  ---END test7



def test8_before := [llvm|
{
^0(%arg92 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.shl %arg92, %0 : i32
  %3 = llvm.srem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg92 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test8
  all_goals (try extract_goal ; sorry)
  ---END test8



def test9_before := [llvm|
{
^0(%arg91 : i32):
  %0 = "llvm.mlir.constant"() <{value = 64 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %2 = llvm.mul %arg91, %0 : i32
  %3 = llvm.urem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg91 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test9
  all_goals (try extract_goal ; sorry)
  ---END test9



def test11_before := [llvm|
{
^0(%arg89 : i32):
  %0 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %3 = llvm.and %arg89, %0 : i32
  %4 = llvm.mul %3, %1 : i32
  %5 = llvm.urem %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg89 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test11
  all_goals (try extract_goal ; sorry)
  ---END test11



def test12_before := [llvm|
{
^0(%arg88 : i32):
  %0 = "llvm.mlir.constant"() <{value = -4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.and %arg88, %0 : i32
  %3 = llvm.srem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg88 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
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
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test13
  all_goals (try extract_goal ; sorry)
  ---END test13



def test16_before := [llvm|
{
^0(%arg81 : i32, %arg82 : i32):
  %0 = "llvm.mlir.constant"() <{value = 11 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
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
  %0 = "llvm.mlir.constant"() <{value = 11 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
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
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test16
  all_goals (try extract_goal ; sorry)
  ---END test16



def test19_before := [llvm|
{
^0(%arg76 : i32, %arg77 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
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
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
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
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test19
  all_goals (try extract_goal ; sorry)
  ---END test19



def test19_commutative0_before := [llvm|
{
^0(%arg74 : i32, %arg75 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
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
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
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
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test19_commutative0
  all_goals (try extract_goal ; sorry)
  ---END test19_commutative0



def test19_commutative1_before := [llvm|
{
^0(%arg72 : i32, %arg73 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
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
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
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
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test19_commutative1
  all_goals (try extract_goal ; sorry)
  ---END test19_commutative1



def test19_commutative2_before := [llvm|
{
^0(%arg70 : i32, %arg71 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
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
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
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
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test19_commutative2
  all_goals (try extract_goal ; sorry)
  ---END test19_commutative2



def test22_before := [llvm|
{
^0(%arg55 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg55, %0 : i32
  %2 = llvm.srem %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test22_after := [llvm|
{
^0(%arg55 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg55, %0 : i32
  %2 = llvm.urem %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test22_proof : test22_before ⊑ test22_after := by
  unfold test22_before test22_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test22
  all_goals (try extract_goal ; sorry)
  ---END test22


