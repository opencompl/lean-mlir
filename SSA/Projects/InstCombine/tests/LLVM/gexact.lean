
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
section gexact_statements
                                                    
def sdiv2_before := [llvm|
{
^0(%arg39 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = llvm.sdiv %arg39, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def sdiv2_after := [llvm|
{
^0(%arg39 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = llvm.ashr %arg39, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem sdiv2_proof : sdiv2_before ⊑ sdiv2_after := by
  unfold sdiv2_before sdiv2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sdiv2
  all_goals (try extract_goal ; sorry)
  ---END sdiv2



def sdiv4_before := [llvm|
{
^0(%arg36 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = llvm.sdiv %arg36, %0 : i32
  %2 = llvm.mul %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sdiv4_after := [llvm|
{
^0(%arg36 : i32):
  "llvm.return"(%arg36) : (i32) -> ()
}
]
theorem sdiv4_proof : sdiv4_before ⊑ sdiv4_after := by
  unfold sdiv4_before sdiv4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sdiv4
  all_goals (try extract_goal ; sorry)
  ---END sdiv4



def sdiv6_before := [llvm|
{
^0(%arg34 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -3 : i32}> : () -> i32
  %2 = llvm.sdiv %arg34, %0 : i32
  %3 = llvm.mul %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sdiv6_after := [llvm|
{
^0(%arg34 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg34 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem sdiv6_proof : sdiv6_before ⊑ sdiv6_after := by
  unfold sdiv6_before sdiv6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sdiv6
  all_goals (try extract_goal ; sorry)
  ---END sdiv6



def mul_of_sdiv_before := [llvm|
{
^0(%arg5 : i8):
  %0 = "llvm.mlir.constant"() <{value = 12 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -6 : i8}> : () -> i8
  %2 = llvm.sdiv %arg5, %0 : i8
  %3 = llvm.mul %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def mul_of_sdiv_after := [llvm|
{
^0(%arg5 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.ashr %arg5, %0 : i8
  %3 = llvm.sub %1, %2 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem mul_of_sdiv_proof : mul_of_sdiv_before ⊑ mul_of_sdiv_after := by
  unfold mul_of_sdiv_before mul_of_sdiv_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul_of_sdiv
  all_goals (try extract_goal ; sorry)
  ---END mul_of_sdiv



def mul_of_sdiv_fail_ub_before := [llvm|
{
^0(%arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -6 : i8}> : () -> i8
  %2 = llvm.sdiv %arg1, %0 : i8
  %3 = llvm.mul %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def mul_of_sdiv_fail_ub_after := [llvm|
{
^0(%arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem mul_of_sdiv_fail_ub_proof : mul_of_sdiv_fail_ub_before ⊑ mul_of_sdiv_fail_ub_after := by
  unfold mul_of_sdiv_fail_ub_before mul_of_sdiv_fail_ub_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul_of_sdiv_fail_ub
  all_goals (try extract_goal ; sorry)
  ---END mul_of_sdiv_fail_ub


