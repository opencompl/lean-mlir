import SSA.Projects.InstCombine.tests.proofs.g2008h05h31hAddBool_proof
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
section g2008h05h31hAddBool_statements
<<<<<<< HEAD
<<<<<<< HEAD

=======
                                                    
>>>>>>> 1011dc2e (re-ran the tests)
=======

>>>>>>> 4bf2f937 (Re-ran the sccripts)
def test_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.add %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.xor %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
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
<<<<<<< HEAD
  try intros
=======
  intros
>>>>>>> 1011dc2e (re-ran the tests)
=======
  try intros
>>>>>>> 4bf2f937 (Re-ran the sccripts)
  try simp
  ---BEGIN test
  apply test_thm
  ---END test


