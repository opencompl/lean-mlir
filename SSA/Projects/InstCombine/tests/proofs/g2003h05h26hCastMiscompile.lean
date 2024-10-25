import SSA.Projects.InstCombine.tests.proofs.g2003h05h26hCastMiscompile_proof
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
<<<<<<< HEAD:SSA/Projects/InstCombine/tests/proofs/g2008h02h23hMulSub.lean
section g2008h02h23hMulSub_statements
<<<<<<< HEAD
<<<<<<< HEAD
=======
section g2003h05h26hCastMiscompile_statements
>>>>>>> bd0a83c7 (Updated the generated tests):SSA/Projects/InstCombine/tests/proofs/g2003h05h26hCastMiscompile.lean

=======
                                                    
>>>>>>> 1011dc2e (re-ran the tests)
=======

>>>>>>> 4bf2f937 (Re-ran the sccripts)
def test_before := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.trunc %arg0 : i64 to i32
  %1 = llvm.zext %0 : i32 to i64
  "llvm.return"(%1) : (i64) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 4294967295 : i64}> : () -> i64
  %1 = llvm.and %arg0, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
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


