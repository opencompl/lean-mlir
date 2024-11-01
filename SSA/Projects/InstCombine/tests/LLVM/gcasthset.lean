
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
section gcasthset_statements

def test5_before := [llvm|
{
^0(%arg3 : i16):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.sext %arg3 : i16 to i32
  %2 = llvm.and %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg3 : i16):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.and %arg3, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  intros
  ---BEGIN test5
  all_goals (try extract_goal ; sorry)
  ---END test5



def test6_before := [llvm|
{
^0(%arg2 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.zext %arg2 : i1 to i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg2 : i1):
  "llvm.return"(%arg2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  intros
  ---BEGIN test6
  all_goals (try extract_goal ; sorry)
  ---END test6



def test6a_before := [llvm|
{
^0(%arg1 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.zext %arg1 : i1 to i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def test6a_after := [llvm|
{
^0(%arg1 : i1):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test6a_proof : test6a_before ⊑ test6a_after := by
  unfold test6a_before test6a_after
  simp_alive_peephole
  intros
  ---BEGIN test6a
  all_goals (try extract_goal ; sorry)
  ---END test6a


