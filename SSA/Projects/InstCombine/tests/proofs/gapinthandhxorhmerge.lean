import SSA.Projects.InstCombine.tests.proofs.gapinthandhxorhmerge_proof
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
<<<<<<< HEAD
section gapinthandhxorhmerge_statements

=======
<<<<<<<< HEAD:SSA/Projects/InstCombine/tests/proofs/gapinthrem2.lean
section gapinthrem2_statements
<<<<<<< HEAD

=======
========
section gapinthandhxorhmerge_statements
>>>>>>>> 1011dc2e (re-ran the tests):SSA/Projects/InstCombine/tests/proofs/gapinthandhxorhmerge.lean
                                                    
>>>>>>> 43a49182 (re-ran scripts)
>>>>>>> 1011dc2e (re-ran the tests)
def test1_before := [llvm|
{
^0(%arg3 : i57, %arg4 : i57, %arg5 : i57):
  %0 = llvm.and %arg5, %arg3 : i57
  %1 = llvm.and %arg5, %arg4 : i57
  %2 = llvm.xor %0, %1 : i57
  "llvm.return"(%2) : (i57) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg3 : i57, %arg4 : i57, %arg5 : i57):
  %0 = llvm.xor %arg3, %arg4 : i57
  %1 = llvm.and %arg5, %0 : i57
  "llvm.return"(%1) : (i57) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
<<<<<<< HEAD
  try simp
  simp_alive_case_bash
  try intros
=======
<<<<<<<< HEAD:SSA/Projects/InstCombine/tests/proofs/gapinthrem2.lean
<<<<<<< HEAD
  try simp
  simp_alive_case_bash
  try intros
=======
========
  try simp
>>>>>>>> 1011dc2e (re-ran the tests):SSA/Projects/InstCombine/tests/proofs/gapinthandhxorhmerge.lean
  simp_alive_case_bash
  intros
>>>>>>> 43a49182 (re-ran scripts)
>>>>>>> 1011dc2e (re-ran the tests)
  try simp
  ---BEGIN test1
  apply test1_thm
  ---END test1



def test2_before := [llvm|
{
^0(%arg0 : i23, %arg1 : i23, %arg2 : i23):
  %0 = llvm.and %arg1, %arg0 : i23
  %1 = llvm.or %arg1, %arg0 : i23
  %2 = llvm.xor %0, %1 : i23
  "llvm.return"(%2) : (i23) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i23, %arg1 : i23, %arg2 : i23):
  %0 = llvm.xor %arg1, %arg0 : i23
  "llvm.return"(%0) : (i23) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
<<<<<<< HEAD
  try simp
  simp_alive_case_bash
  try intros
=======
<<<<<<<< HEAD:SSA/Projects/InstCombine/tests/proofs/gapinthrem2.lean
<<<<<<< HEAD
  try simp
  simp_alive_case_bash
  try intros
=======
========
  try simp
>>>>>>>> 1011dc2e (re-ran the tests):SSA/Projects/InstCombine/tests/proofs/gapinthandhxorhmerge.lean
  simp_alive_case_bash
  intros
>>>>>>> 43a49182 (re-ran scripts)
>>>>>>> 1011dc2e (re-ran the tests)
  try simp
  ---BEGIN test2
  apply test2_thm
  ---END test2


<<<<<<< HEAD
=======
<<<<<<< HEAD

def test3_before := [llvm|
{
^0(%arg0 : i599, %arg1 : i1):
  %0 = "llvm.mlir.constant"() <{value = 70368744177664 : i599}> : () -> i599
  %1 = "llvm.mlir.constant"() <{value = 4096 : i599}> : () -> i599
  %2 = "llvm.select"(%arg1, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i599, i599) -> i599
  %3 = llvm.urem %arg0, %2 : i599
  "llvm.return"(%3) : (i599) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i599, %arg1 : i1):
  %0 = "llvm.mlir.constant"() <{value = 70368744177663 : i599}> : () -> i599
  %1 = "llvm.mlir.constant"() <{value = 4095 : i599}> : () -> i599
  %2 = "llvm.select"(%arg1, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i599, i599) -> i599
  %3 = llvm.and %arg0, %2 : i599
  "llvm.return"(%3) : (i599) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test3
  apply test3_thm
  ---END test3


=======
>>>>>>> 43a49182 (re-ran scripts)
>>>>>>> 1011dc2e (re-ran the tests)
