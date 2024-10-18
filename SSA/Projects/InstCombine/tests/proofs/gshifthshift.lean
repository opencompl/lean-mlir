import SSA.Projects.InstCombine.tests.proofs.gshifthshift_proof
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
section gshifthshift_statements
<<<<<<< HEAD
<<<<<<< HEAD

=======
                                                    
>>>>>>> 43a49182 (re-ran scripts)
=======

>>>>>>> 4bf2f937 (Re-ran the sccripts)
def shl_shl_before := [llvm|
{
^0(%arg50 : i32):
  %0 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 28 : i32}> : () -> i32
  %2 = llvm.shl %arg50, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_shl_after := [llvm|
{
^0(%arg50 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem shl_shl_proof : shl_shl_before ⊑ shl_shl_after := by
  unfold shl_shl_before shl_shl_after
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
  ---BEGIN shl_shl
  apply shl_shl_thm
  ---END shl_shl



def lshr_lshr_before := [llvm|
{
^0(%arg47 : i232):
  %0 = "llvm.mlir.constant"() <{value = 231 : i232}> : () -> i232
  %1 = "llvm.mlir.constant"() <{value = 1 : i232}> : () -> i232
  %2 = llvm.lshr %arg47, %0 : i232
  %3 = llvm.lshr %2, %1 : i232
  "llvm.return"(%3) : (i232) -> ()
}
]
def lshr_lshr_after := [llvm|
{
^0(%arg47 : i232):
  %0 = "llvm.mlir.constant"() <{value = 0 : i232}> : () -> i232
  "llvm.return"(%0) : (i232) -> ()
}
]
theorem lshr_lshr_proof : lshr_lshr_before ⊑ lshr_lshr_after := by
  unfold lshr_lshr_before lshr_lshr_after
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
  ---BEGIN lshr_lshr
  apply lshr_lshr_thm
  ---END lshr_lshr



<<<<<<< HEAD
def shl_shl_constants_div_before := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg28 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.udiv %arg27, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shl_shl_constants_div_after := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.add %arg28, %0 : i32
  %2 = llvm.lshr %arg27, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem shl_shl_constants_div_proof : shl_shl_constants_div_before ⊑ shl_shl_constants_div_after := by
  unfold shl_shl_constants_div_before shl_shl_constants_div_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN shl_shl_constants_div
  apply shl_shl_constants_div_thm
  ---END shl_shl_constants_div



=======
>>>>>>> 43a49182 (re-ran scripts)
def ashr_shl_constants_before := [llvm|
{
^0(%arg25 : i32):
  %0 = "llvm.mlir.constant"() <{value = -33 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %2 = llvm.ashr %0, %arg25 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_shl_constants_after := [llvm|
{
^0(%arg25 : i32):
  %0 = "llvm.mlir.constant"() <{value = -33 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %2 = llvm.ashr %0, %arg25 : i32
  %3 = llvm.shl %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem ashr_shl_constants_proof : ashr_shl_constants_before ⊑ ashr_shl_constants_after := by
  unfold ashr_shl_constants_before ashr_shl_constants_after
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
  ---BEGIN ashr_shl_constants
  apply ashr_shl_constants_thm
  ---END ashr_shl_constants



def shl_lshr_demand1_before := [llvm|
{
^0(%arg20 : i8):
  %0 = "llvm.mlir.constant"() <{value = 40 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = -32 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg20 : i8
  %4 = llvm.lshr %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_lshr_demand1_after := [llvm|
{
^0(%arg20 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -32 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg20 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem shl_lshr_demand1_proof : shl_lshr_demand1_before ⊑ shl_lshr_demand1_after := by
  unfold shl_lshr_demand1_before shl_lshr_demand1_after
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
  ---BEGIN shl_lshr_demand1
  apply shl_lshr_demand1_thm
  ---END shl_lshr_demand1



def shl_lshr_demand6_before := [llvm|
{
^0(%arg10 : i16):
  %0 = "llvm.mlir.constant"() <{value = -32624 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 4 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 4094 : i16}> : () -> i16
  %3 = llvm.shl %0, %arg10 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def shl_lshr_demand6_after := [llvm|
{
^0(%arg10 : i16):
  %0 = "llvm.mlir.constant"() <{value = 2057 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 4094 : i16}> : () -> i16
  %2 = llvm.shl %0, %arg10 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
theorem shl_lshr_demand6_proof : shl_lshr_demand6_before ⊑ shl_lshr_demand6_after := by
  unfold shl_lshr_demand6_before shl_lshr_demand6_after
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
  ---BEGIN shl_lshr_demand6
  apply shl_lshr_demand6_thm
  ---END shl_lshr_demand6



def lshr_shl_demand1_before := [llvm|
{
^0(%arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = 28 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %3 = llvm.lshr %0, %arg9 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_shl_demand1_after := [llvm|
{
^0(%arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = -32 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %2 = llvm.lshr %0, %arg9 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem lshr_shl_demand1_proof : lshr_shl_demand1_before ⊑ lshr_shl_demand1_after := by
  unfold lshr_shl_demand1_before lshr_shl_demand1_after
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
  ---BEGIN lshr_shl_demand1
  apply lshr_shl_demand1_thm
  ---END lshr_shl_demand1



def lshr_shl_demand3_before := [llvm|
{
^0(%arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = 28 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.lshr %0, %arg7 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = llvm.or %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def lshr_shl_demand3_after := [llvm|
{
^0(%arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = 28 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.lshr %0, %arg7 : i8
  %3 = llvm.shl %2, %1 overflow<nuw> : i8
  %4 = llvm.or %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem lshr_shl_demand3_proof : lshr_shl_demand3_before ⊑ lshr_shl_demand3_after := by
  unfold lshr_shl_demand3_before lshr_shl_demand3_after
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
  ---BEGIN lshr_shl_demand3
  apply lshr_shl_demand3_thm
  ---END lshr_shl_demand3


