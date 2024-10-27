
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
  %0 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %1 = llvm.sext %arg3 : i16 to i32
  %2 = llvm.and %1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg3 : i16):
  %0 = "llvm.mlir.constant"() <{value = 15 : i16}> : () -> i16
  %1 = llvm.and %arg3, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
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

