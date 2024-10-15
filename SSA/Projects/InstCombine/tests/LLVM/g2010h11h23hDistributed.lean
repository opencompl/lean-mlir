import SSA.Projects.InstCombine.tests.LLVM.g2010h11h23hDistributed_proof
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
section g2010h11h23hDistributed_statements

def foo_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.add %arg3, %arg2 overflow<nsw> : i32
  %1 = llvm.mul %0, %arg3 overflow<nsw> : i32
  %2 = llvm.mul %arg3, %arg3 overflow<nsw> : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mul %arg2, %arg3 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem foo_proof : foo_before ⊑ foo_after := by
  unfold foo_before foo_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN foo
  apply foo_thm
  ---END foo
