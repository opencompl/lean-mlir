
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
section gand2_statements

def test2_before := [llvm|
{
^0(%arg30 : i1, %arg31 : i1):
  %0 = llvm.and %arg30, %arg31 : i1
  %1 = llvm.and %0, %arg30 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg30 : i1, %arg31 : i1):
  %0 = llvm.and %arg30, %arg31 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2



def test2_logical_before := [llvm|
{
^0(%arg28 : i1, %arg29 : i1):
  %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
  %1 = "llvm.select"(%arg28, %arg29, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%1, %arg28, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test2_logical_after := [llvm|
{
^0(%arg28 : i1, %arg29 : i1):
  %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
  %1 = "llvm.select"(%arg28, %arg29, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test2_logical_proof : test2_logical_before ⊑ test2_logical_after := by
  unfold test2_logical_before test2_logical_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test2_logical
  all_goals (try extract_goal ; sorry)
  ---END test2_logical



def test3_before := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.and %arg26, %arg27 : i32
  %1 = llvm.and %arg27, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.and %arg26, %arg27 : i32
  "llvm.return"(%0) : (i32) -> ()
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



def test9_before := [llvm|
{
^0(%arg18 : i64):
  %0 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg18 overflow<nsw> : i64
  %3 = llvm.and %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg18 : i64):
  %0 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
  %1 = llvm.and %arg18, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
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



def test10_before := [llvm|
{
^0(%arg16 : i64):
  %0 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg16 overflow<nsw> : i64
  %3 = llvm.and %2, %1 : i64
  %4 = llvm.add %2, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg16 : i64):
  %0 = "llvm.mlir.constant"() <{value = -2 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
  %2 = llvm.and %arg16, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test10
  all_goals (try extract_goal ; sorry)
  ---END test10



def and1_shl1_is_cmp_eq_0_multiuse_before := [llvm|
{
^0(%arg14 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg14 : i8
  %2 = llvm.and %1, %0 : i8
  %3 = llvm.add %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def and1_shl1_is_cmp_eq_0_multiuse_after := [llvm|
{
^0(%arg14 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg14 overflow<nuw> : i8
  %2 = llvm.and %1, %0 : i8
  %3 = llvm.add %1, %2 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem and1_shl1_is_cmp_eq_0_multiuse_proof : and1_shl1_is_cmp_eq_0_multiuse_before ⊑ and1_shl1_is_cmp_eq_0_multiuse_after := by
  unfold and1_shl1_is_cmp_eq_0_multiuse_before and1_shl1_is_cmp_eq_0_multiuse_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN and1_shl1_is_cmp_eq_0_multiuse
  all_goals (try extract_goal ; sorry)
  ---END and1_shl1_is_cmp_eq_0_multiuse



def and1_lshr1_is_cmp_eq_0_before := [llvm|
{
^0(%arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.lshr %0, %arg11 : i8
  %2 = llvm.and %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def and1_lshr1_is_cmp_eq_0_after := [llvm|
{
^0(%arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.lshr %0, %arg11 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem and1_lshr1_is_cmp_eq_0_proof : and1_lshr1_is_cmp_eq_0_before ⊑ and1_lshr1_is_cmp_eq_0_after := by
  unfold and1_lshr1_is_cmp_eq_0_before and1_lshr1_is_cmp_eq_0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN and1_lshr1_is_cmp_eq_0
  all_goals (try extract_goal ; sorry)
  ---END and1_lshr1_is_cmp_eq_0



def and1_lshr1_is_cmp_eq_0_multiuse_before := [llvm|
{
^0(%arg10 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.lshr %0, %arg10 : i8
  %2 = llvm.and %1, %0 : i8
  %3 = llvm.add %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def and1_lshr1_is_cmp_eq_0_multiuse_after := [llvm|
{
^0(%arg10 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.lshr %0, %arg10 : i8
  %2 = llvm.shl %1, %0 overflow<nsw,nuw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem and1_lshr1_is_cmp_eq_0_multiuse_proof : and1_lshr1_is_cmp_eq_0_multiuse_before ⊑ and1_lshr1_is_cmp_eq_0_multiuse_after := by
  unfold and1_lshr1_is_cmp_eq_0_multiuse_before and1_lshr1_is_cmp_eq_0_multiuse_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN and1_lshr1_is_cmp_eq_0_multiuse
  all_goals (try extract_goal ; sorry)
  ---END and1_lshr1_is_cmp_eq_0_multiuse



def test11_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg6, %0 : i32
  %3 = llvm.add %2, %arg7 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg6, %0 : i32
  %3 = llvm.and %arg7, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
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
^0(%arg4 : i32, %arg5 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg4, %0 : i32
  %3 = llvm.add %arg5, %2 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg4, %0 : i32
  %3 = llvm.and %arg5, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
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
^0(%arg2 : i32, %arg3 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg2, %0 : i32
  %3 = llvm.sub %arg3, %2 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg2, %0 : i32
  %3 = llvm.and %arg3, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
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



def test14_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.sub %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %3 = llvm.shl %arg0, %0 : i32
  %4 = llvm.sub %1, %arg1 : i32
  %5 = llvm.and %4, %2 : i32
  %6 = llvm.mul %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem test14_proof : test14_before ⊑ test14_after := by
  unfold test14_before test14_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test14
  all_goals (try extract_goal ; sorry)
  ---END test14


