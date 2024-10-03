
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
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_shl
  all_goals (try extract_goal ; sorry)
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
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_lshr
  all_goals (try extract_goal ; sorry)
  ---END lshr_lshr



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
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_lshr_demand1
  all_goals (try extract_goal ; sorry)
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
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_lshr_demand6
  all_goals (try extract_goal ; sorry)
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
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_shl_demand1
  all_goals (try extract_goal ; sorry)
  ---END lshr_shl_demand1


