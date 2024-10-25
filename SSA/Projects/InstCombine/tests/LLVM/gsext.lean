
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
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = llvm.udiv %arg33, %0 : i32
  %2 = llvm.sext %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg33 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = llvm.udiv %arg33, %0 : i32
  %2 = llvm.zext %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4



def test5_before := [llvm|
{
^0(%arg32 : i32):
  %0 = "llvm.mlir.constant"() <{value = 30000 : i32}> : () -> i32
  %1 = llvm.urem %arg32, %0 : i32
  %2 = llvm.sext %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg32 : i32):
  %0 = "llvm.mlir.constant"() <{value = 30000 : i32}> : () -> i32
  %1 = llvm.urem %arg32, %0 : i32
  %2 = llvm.zext %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test5
  all_goals (try extract_goal ; sorry)
  ---END test5



def test6_before := [llvm|
{
^0(%arg31 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = llvm.lshr %arg31, %0 : i32
  %2 = llvm.mul %1, %0 : i32
  %3 = llvm.sext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg31 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = llvm.lshr %arg31, %0 : i32
  %2 = llvm.mul %1, %0 overflow<nsw,nuw> : i32
  %3 = llvm.zext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test6
  all_goals (try extract_goal ; sorry)
  ---END test6



def test7_before := [llvm|
{
^0(%arg30 : i32):
  %0 = "llvm.mlir.constant"() <{value = 511 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 20000 : i32}> : () -> i32
  %2 = llvm.and %arg30, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  %4 = llvm.sext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg30 : i32):
  %0 = "llvm.mlir.constant"() <{value = 511 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 20000 : i32}> : () -> i32
  %2 = llvm.and %arg30, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nsw,nuw> : i32
  %4 = llvm.zext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
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
^0(%arg26 : i8, %arg27 : i32, %arg28 : i1, %arg29 : !llvm.ptr):
  %0 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %2 = llvm.lshr %arg27, %0 : i32
  %3 = "llvm.select"(%arg28, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.sext %4 : i16 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg26 : i8, %arg27 : i32, %arg28 : i1, %arg29 : !llvm.ptr):
  %0 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %2 = llvm.lshr %arg27, %0 : i32
  %3 = "llvm.select"(%arg28, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
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



def test10_before := [llvm|
{
^0(%arg23 : i32):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
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
  %0 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %1 = llvm.shl %arg23, %0 : i32
  %2 = llvm.ashr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
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



def test17_before := [llvm|
{
^0(%arg9 : i1):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
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
theorem test17_proof : test17_before ⊑ test17_after := by
  unfold test17_before test17_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test17
  all_goals (try extract_goal ; sorry)
  ---END test17



def test19_before := [llvm|
{
^0(%arg7 : i10):
  %0 = "llvm.mlir.constant"() <{value = 2 : i3}> : () -> i3
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
  %0 = "llvm.mlir.constant"() <{value = 1 : i3}> : () -> i3
  %1 = "llvm.mlir.constant"() <{value = 0 : i3}> : () -> i3
  %2 = llvm.trunc %arg7 : i10 to i3
  %3 = llvm.and %2, %0 : i3
  %4 = llvm.sub %1, %3 overflow<nsw> : i3
  %5 = llvm.sext %4 : i3 to i10
  "llvm.return"(%5) : (i10) -> ()
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



def smear_set_bit_before := [llvm|
{
^0(%arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.trunc %arg6 : i32 to i8
  %2 = llvm.ashr %1, %0 : i8
  %3 = llvm.sext %2 : i8 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def smear_set_bit_after := [llvm|
{
^0(%arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.shl %arg6, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem smear_set_bit_proof : smear_set_bit_before ⊑ smear_set_bit_after := by
  unfold smear_set_bit_before smear_set_bit_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN smear_set_bit
  all_goals (try extract_goal ; sorry)
  ---END smear_set_bit



def smear_set_bit_different_dest_type_before := [llvm|
{
^0(%arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.trunc %arg2 : i32 to i8
  %2 = llvm.ashr %1, %0 : i8
  %3 = llvm.sext %2 : i8 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def smear_set_bit_different_dest_type_after := [llvm|
{
^0(%arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.shl %arg2, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  %4 = llvm.trunc %3 : i32 to i16
  "llvm.return"(%4) : (i16) -> ()
}
]
theorem smear_set_bit_different_dest_type_proof : smear_set_bit_different_dest_type_before ⊑ smear_set_bit_different_dest_type_after := by
  unfold smear_set_bit_different_dest_type_before smear_set_bit_different_dest_type_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN smear_set_bit_different_dest_type
  all_goals (try extract_goal ; sorry)
  ---END smear_set_bit_different_dest_type



def smear_set_bit_different_dest_type_wider_dst_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.trunc %arg0 : i32 to i8
  %2 = llvm.ashr %1, %0 : i8
  %3 = llvm.sext %2 : i8 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def smear_set_bit_different_dest_type_wider_dst_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  %4 = llvm.sext %3 : i32 to i64
  "llvm.return"(%4) : (i64) -> ()
}
]
theorem smear_set_bit_different_dest_type_wider_dst_proof : smear_set_bit_different_dest_type_wider_dst_before ⊑ smear_set_bit_different_dest_type_wider_dst_after := by
  unfold smear_set_bit_different_dest_type_wider_dst_before smear_set_bit_different_dest_type_wider_dst_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN smear_set_bit_different_dest_type_wider_dst
  all_goals (try extract_goal ; sorry)
  ---END smear_set_bit_different_dest_type_wider_dst


