import SSA.Projects.InstCombine.tests.proofs.ghoisthnothfromhashrhoperand_proof
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
section ghoisthnothfromhashrhoperand_statements
<<<<<<< HEAD
<<<<<<< HEAD

=======
                                                    
>>>>>>> 43a49182 (re-ran scripts)
=======

>>>>>>> 4bf2f937 (Re-ran the sccripts)
def t0_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg8, %0 : i8
  %2 = llvm.ashr %1, %arg9 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.ashr %arg8, %arg9 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
<<<<<<< HEAD
<<<<<<< HEAD
  try simp
  simp_alive_case_bash
  try intros
<<<<<<< HEAD
=======
=======
  try simp
>>>>>>> 1011dc2e (re-ran the tests)
  simp_alive_case_bash
  intros
>>>>>>> 43a49182 (re-ran scripts)
=======
>>>>>>> 4bf2f937 (Re-ran the sccripts)
  try simp
  ---BEGIN t0
  apply t0_thm
  ---END t0



def t1_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg6, %0 : i8
  %2 = llvm.ashr %1, %arg7 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.ashr %arg6, %arg7 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t1_proof : t1_before ⊑ t1_after := by
  unfold t1_before t1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
<<<<<<< HEAD
<<<<<<< HEAD
  try simp
  simp_alive_case_bash
  try intros
<<<<<<< HEAD
=======
=======
  try simp
>>>>>>> 1011dc2e (re-ran the tests)
  simp_alive_case_bash
  intros
>>>>>>> 43a49182 (re-ran scripts)
=======
>>>>>>> 4bf2f937 (Re-ran the sccripts)
  try simp
  ---BEGIN t1
  apply t1_thm
  ---END t1


