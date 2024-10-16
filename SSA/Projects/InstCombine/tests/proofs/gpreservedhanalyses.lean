import SSA.Projects.InstCombine.tests.proofs.gpreservedhanalyses_proof
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
section gpreservedhanalyses_statements
<<<<<<< HEAD

=======
                                                    
>>>>>>> 1011dc2e (re-ran the tests)
def test_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -5 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem test_proof : test_before ⊑ test_after := by
  unfold test_before test_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
<<<<<<< HEAD
  try intros
=======
  intros
>>>>>>> 1011dc2e (re-ran the tests)
  try simp
  ---BEGIN test
  apply test_thm
  ---END test


