import SSA.Projects.InstCombine.tests.proofs.gadd4_proof
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
section gadd4_statements

def match_andAsRem_lshrAsDiv_shlAsMul_before := [llvm|
{
^0(%arg16 : i64):
  %0 = "llvm.mlir.constant"() <{value = 63 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 6 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{value = 9 : i64}> : () -> i64
  %3 = llvm.and %arg16, %0 : i64
  %4 = llvm.lshr %arg16, %1 : i64
  %5 = llvm.urem %4, %2 : i64
  %6 = llvm.shl %5, %1 : i64
  %7 = llvm.add %3, %6 : i64
  "llvm.return"(%7) : (i64) -> ()
}
]
def match_andAsRem_lshrAsDiv_shlAsMul_after := [llvm|
{
^0(%arg16 : i64):
  %0 = "llvm.mlir.constant"() <{value = 576 : i64}> : () -> i64
  %1 = llvm.urem %arg16, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem match_andAsRem_lshrAsDiv_shlAsMul_proof : match_andAsRem_lshrAsDiv_shlAsMul_before ⊑ match_andAsRem_lshrAsDiv_shlAsMul_after := by
  unfold match_andAsRem_lshrAsDiv_shlAsMul_before match_andAsRem_lshrAsDiv_shlAsMul_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN match_andAsRem_lshrAsDiv_shlAsMul
  apply match_andAsRem_lshrAsDiv_shlAsMul_thm
  ---END match_andAsRem_lshrAsDiv_shlAsMul



def match_signed_before := [llvm|
{
^0(%arg15 : i64):
  %0 = "llvm.mlir.constant"() <{value = 299 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{value = 19136 : i64}> : () -> i64
  %3 = "llvm.mlir.constant"() <{value = 9 : i64}> : () -> i64
  %4 = llvm.srem %arg15, %0 : i64
  %5 = llvm.sdiv %arg15, %0 : i64
  %6 = llvm.srem %5, %1 : i64
  %7 = llvm.sdiv %arg15, %2 : i64
  %8 = llvm.srem %7, %3 : i64
  %9 = llvm.mul %6, %0 : i64
  %10 = llvm.add %4, %9 : i64
  %11 = llvm.mul %8, %2 : i64
  %12 = llvm.add %10, %11 : i64
  "llvm.return"(%12) : (i64) -> ()
}
]
def match_signed_after := [llvm|
{
^0(%arg15 : i64):
  %0 = "llvm.mlir.constant"() <{value = 172224 : i64}> : () -> i64
  %1 = llvm.srem %arg15, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem match_signed_proof : match_signed_before ⊑ match_signed_after := by
  unfold match_signed_before match_signed_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN match_signed
  apply match_signed_thm
  ---END match_signed



def not_match_inconsistent_signs_before := [llvm|
{
^0(%arg13 : i64):
  %0 = "llvm.mlir.constant"() <{value = 299 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
  %2 = llvm.urem %arg13, %0 : i64
  %3 = llvm.sdiv %arg13, %0 : i64
  %4 = llvm.urem %3, %1 : i64
  %5 = llvm.mul %4, %0 : i64
  %6 = llvm.add %2, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def not_match_inconsistent_signs_after := [llvm|
{
^0(%arg13 : i64):
  %0 = "llvm.mlir.constant"() <{value = 299 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 63 : i64}> : () -> i64
  %2 = llvm.urem %arg13, %0 : i64
  %3 = llvm.sdiv %arg13, %0 : i64
  %4 = llvm.and %3, %1 : i64
  %5 = llvm.mul %4, %0 overflow<nsw,nuw> : i64
  %6 = llvm.add %2, %5 overflow<nsw,nuw> : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
theorem not_match_inconsistent_signs_proof : not_match_inconsistent_signs_before ⊑ not_match_inconsistent_signs_after := by
  unfold not_match_inconsistent_signs_before not_match_inconsistent_signs_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN not_match_inconsistent_signs
  apply not_match_inconsistent_signs_thm
  ---END not_match_inconsistent_signs



def fold_add_sdiv_srem_before := [llvm|
{
^0(%arg9 : i32):
  %0 = "llvm.mlir.constant"() <{value = 10 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %2 = llvm.sdiv %arg9, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.srem %arg9, %0 : i32
  %5 = llvm.add %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def fold_add_sdiv_srem_after := [llvm|
{
^0(%arg9 : i32):
  %0 = "llvm.mlir.constant"() <{value = 10 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %2 = llvm.sdiv %arg9, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw> : i32
  %4 = llvm.add %3, %arg9 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem fold_add_sdiv_srem_proof : fold_add_sdiv_srem_before ⊑ fold_add_sdiv_srem_after := by
  unfold fold_add_sdiv_srem_before fold_add_sdiv_srem_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN fold_add_sdiv_srem
  apply fold_add_sdiv_srem_thm
  ---END fold_add_sdiv_srem


