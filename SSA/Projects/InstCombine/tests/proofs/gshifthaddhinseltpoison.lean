import SSA.Projects.InstCombine.tests.proofs.gshifthaddhinseltpoison_proof
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
section gshifthaddhinseltpoison_statements
<<<<<<< HEAD
<<<<<<< HEAD

<<<<<<< HEAD
=======
                                                    
>>>>>>> 43a49182 (re-ran scripts)
=======

>>>>>>> 4bf2f937 (Re-ran the sccripts)
=======
def shl_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg8 : i16):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %2 = llvm.zext %arg8 : i16 to i32
  %3 = llvm.add %2, %0 : i32
  %4 = llvm.shl %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shl_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg8 : i16):
  %0 = "llvm.mlir.constant"() <{value = 192 : i32}> : () -> i32
  %1 = llvm.zext %arg8 : i16 to i32
  %2 = llvm.shl %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem shl_C1_add_A_C2_i32_proof : shl_C1_add_A_C2_i32_before ⊑ shl_C1_add_A_C2_i32_after := by
  unfold shl_C1_add_A_C2_i32_before shl_C1_add_A_C2_i32_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN shl_C1_add_A_C2_i32
  apply shl_C1_add_A_C2_i32_thm
  ---END shl_C1_add_A_C2_i32



>>>>>>> bd0a83c7 (Updated the generated tests)
def ashr_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg7 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %3 = llvm.and %arg7, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.ashr %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def ashr_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg7 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem ashr_C1_add_A_C2_i32_proof : ashr_C1_add_A_C2_i32_before ⊑ ashr_C1_add_A_C2_i32_after := by
  unfold ashr_C1_add_A_C2_i32_before ashr_C1_add_A_C2_i32_after
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
  ---BEGIN ashr_C1_add_A_C2_i32
  apply ashr_C1_add_A_C2_i32_thm
  ---END ashr_C1_add_A_C2_i32



def lshr_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %3 = llvm.and %arg6, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.shl %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lshr_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 192 : i32}> : () -> i32
  %2 = llvm.and %arg6, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem lshr_C1_add_A_C2_i32_proof : lshr_C1_add_A_C2_i32_before ⊑ lshr_C1_add_A_C2_i32_after := by
  unfold lshr_C1_add_A_C2_i32_before lshr_C1_add_A_C2_i32_after
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
  ---BEGIN lshr_C1_add_A_C2_i32
  apply lshr_C1_add_A_C2_i32_thm
  ---END lshr_C1_add_A_C2_i32


