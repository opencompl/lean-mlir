
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
section gnarrow_statements

def test1_before := [llvm|
{
^0(%arg14 : i32, %arg15 : i32):
  %0 = llvm.icmp "slt" %arg14, %arg15 : i32
  %1 = llvm.zext %0 : i1 to i32
  %2 = llvm.icmp "sgt" %arg14, %arg15 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.trunc %4 : i32 to i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg14 : i32, %arg15 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
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



def shrink_xor_before := [llvm|
{
^0(%arg13 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.xor %arg13, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shrink_xor_after := [llvm|
{
^0(%arg13 : i64):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.trunc %arg13 : i64 to i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shrink_xor_proof : shrink_xor_before ⊑ shrink_xor_after := by
  unfold shrink_xor_before shrink_xor_after
  simp_alive_peephole
  intros
  ---BEGIN shrink_xor
  all_goals (try extract_goal ; sorry)
  ---END shrink_xor



def shrink_or_before := [llvm|
{
^0(%arg11 : i6):
  %0 = llvm.mlir.constant(-31 : i6) : i6
  %1 = llvm.or %arg11, %0 : i6
  %2 = llvm.trunc %1 : i6 to i3
  "llvm.return"(%2) : (i3) -> ()
}
]
def shrink_or_after := [llvm|
{
^0(%arg11 : i6):
  %0 = llvm.mlir.constant(1 : i3) : i3
  %1 = llvm.trunc %arg11 : i6 to i3
  %2 = llvm.or %1, %0 : i3
  "llvm.return"(%2) : (i3) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shrink_or_proof : shrink_or_before ⊑ shrink_or_after := by
  unfold shrink_or_before shrink_or_after
  simp_alive_peephole
  intros
  ---BEGIN shrink_or
  all_goals (try extract_goal ; sorry)
  ---END shrink_or



def shrink_and_before := [llvm|
{
^0(%arg9 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.and %arg9, %0 : i64
  %2 = llvm.trunc %1 : i64 to i31
  "llvm.return"(%2) : (i31) -> ()
}
]
def shrink_and_after := [llvm|
{
^0(%arg9 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.and %arg9, %0 : i64
  %2 = llvm.trunc %1 overflow<nsw,nuw> : i64 to i31
  "llvm.return"(%2) : (i31) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shrink_and_proof : shrink_and_before ⊑ shrink_and_after := by
  unfold shrink_and_before shrink_and_after
  simp_alive_peephole
  intros
  ---BEGIN shrink_and
  all_goals (try extract_goal ; sorry)
  ---END shrink_and


