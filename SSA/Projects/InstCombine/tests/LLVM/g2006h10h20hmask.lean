
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
section g2006h10h20hmask_statements

def foo_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.trunc %arg0 : i64 to i32
  %1 = llvm.trunc %arg1 : i64 to i32
  %2 = llvm.and %0, %1 : i32
  %3 = llvm.zext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{value = 4294967295 : i64}> : () -> i64
  %1 = llvm.and %arg0, %arg1 : i64
  %2 = llvm.and %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
theorem foo_proof : foo_before ⊑ foo_after := by
  unfold foo_before foo_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN foo
  all_goals (try extract_goal ; sorry)
  ---END foo


