
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
section g2007h08h02hInfiniteLoop_statements

def test_before := [llvm|
{
^0(%arg0 : i16, %arg1 : i16):
  %0 = llvm.sext %arg0 : i16 to i32
  %1 = llvm.sext %arg1 : i16 to i32
  %2 = llvm.add %0, %1 : i32
  %3 = llvm.sext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i16, %arg1 : i16):
  %0 = llvm.sext %arg0 : i16 to i32
  %1 = llvm.sext %arg1 : i16 to i32
  %2 = llvm.add %0, %1 overflow<nsw> : i32
  %3 = llvm.sext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
theorem test_proof : test_before ⊑ test_after := by
  unfold test_before test_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test
  all_goals (try extract_goal ; sorry)
  ---END test

