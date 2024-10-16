import SSA.Projects.InstCombine.tests.proofs.gsdivhexacthbyhpowerhofhtwo_proof
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
section gsdivhexacthbyhpowerhofhtwo_statements
                                                    
def t0_before := [llvm|
{
^0(%arg22 : i8):
  %0 = "llvm.mlir.constant"() <{value = 32 : i8}> : () -> i8
  %1 = llvm.sdiv %arg22, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg22 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = llvm.ashr %arg22, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t0
  apply t0_thm
  ---END t0



def shl1_nsw_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg15 overflow<nsw> : i8
  %2 = llvm.sdiv %arg14, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl1_nsw_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.ashr %arg14, %arg15 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem shl1_nsw_proof : shl1_nsw_before ⊑ shl1_nsw_after := by
  unfold shl1_nsw_before shl1_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl1_nsw
  apply shl1_nsw_thm
  ---END shl1_nsw



def shl1_nsw_not_exact_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg11 overflow<nsw> : i8
  %2 = llvm.sdiv %arg10, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl1_nsw_not_exact_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg11 overflow<nsw,nuw> : i8
  %2 = llvm.sdiv %arg10, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem shl1_nsw_not_exact_proof : shl1_nsw_not_exact_before ⊑ shl1_nsw_not_exact_after := by
  unfold shl1_nsw_not_exact_before shl1_nsw_not_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl1_nsw_not_exact
  apply shl1_nsw_not_exact_thm
  ---END shl1_nsw_not_exact



def prove_exact_with_high_mask_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %2 = llvm.and %arg8, %0 : i8
  %3 = llvm.sdiv %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def prove_exact_with_high_mask_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -2 : i8}> : () -> i8
  %2 = llvm.ashr %arg8, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem prove_exact_with_high_mask_proof : prove_exact_with_high_mask_before ⊑ prove_exact_with_high_mask_after := by
  unfold prove_exact_with_high_mask_before prove_exact_with_high_mask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN prove_exact_with_high_mask
  apply prove_exact_with_high_mask_thm
  ---END prove_exact_with_high_mask



def prove_exact_with_high_mask_limit_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 8 : i8}> : () -> i8
  %2 = llvm.and %arg6, %0 : i8
  %3 = llvm.sdiv %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def prove_exact_with_high_mask_limit_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.ashr %arg6, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem prove_exact_with_high_mask_limit_proof : prove_exact_with_high_mask_limit_before ⊑ prove_exact_with_high_mask_limit_after := by
  unfold prove_exact_with_high_mask_limit_before prove_exact_with_high_mask_limit_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN prove_exact_with_high_mask_limit
  apply prove_exact_with_high_mask_limit_thm
  ---END prove_exact_with_high_mask_limit


