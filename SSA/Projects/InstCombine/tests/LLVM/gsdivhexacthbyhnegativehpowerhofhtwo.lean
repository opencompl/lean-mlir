
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
section gsdivhexacthbyhnegativehpowerhofhtwo_statements
                                                    
def t0_before := [llvm|
{
^0(%arg15 : i8):
  %0 = "llvm.mlir.constant"() <{value = -32 : i8}> : () -> i8
  %1 = llvm.sdiv %arg15, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg15 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.ashr %arg15, %0 : i8
  %3 = llvm.sub %1, %2 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t0
  all_goals (try extract_goal ; sorry)
  ---END t0



def prove_exact_with_high_mask_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = -32 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -4 : i8}> : () -> i8
  %2 = llvm.and %arg8, %0 : i8
  %3 = llvm.sdiv %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def prove_exact_with_high_mask_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %3 = llvm.ashr %arg8, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.sub %2, %4 overflow<nsw> : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem prove_exact_with_high_mask_proof : prove_exact_with_high_mask_before ⊑ prove_exact_with_high_mask_after := by
  unfold prove_exact_with_high_mask_before prove_exact_with_high_mask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN prove_exact_with_high_mask
  all_goals (try extract_goal ; sorry)
  ---END prove_exact_with_high_mask



def prove_exact_with_high_mask_limit_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = -32 : i8}> : () -> i8
  %1 = llvm.and %arg6, %0 : i8
  %2 = llvm.sdiv %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def prove_exact_with_high_mask_limit_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.ashr %arg6, %0 : i8
  %3 = llvm.sub %1, %2 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem prove_exact_with_high_mask_limit_proof : prove_exact_with_high_mask_limit_before ⊑ prove_exact_with_high_mask_limit_after := by
  unfold prove_exact_with_high_mask_limit_before prove_exact_with_high_mask_limit_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN prove_exact_with_high_mask_limit
  all_goals (try extract_goal ; sorry)
  ---END prove_exact_with_high_mask_limit


