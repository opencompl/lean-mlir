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

def match_unsigned_before := [llvm|
{
^0(%arg18 : i64):
  %0 = llvm.mlir.constant(299) : i64
  %1 = llvm.mlir.constant(64) : i64
  %2 = llvm.urem %arg18, %0 : i64
  %3 = llvm.udiv %arg18, %0 : i64
  %4 = llvm.urem %3, %1 : i64
  %5 = llvm.mul %4, %0 : i64
  %6 = llvm.add %2, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def match_unsigned_after := [llvm|
{
^0(%arg18 : i64):
  %0 = llvm.mlir.constant(19136) : i64
  %1 = llvm.urem %arg18, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem match_unsigned_proof : match_unsigned_before ⊑ match_unsigned_after := by
  unfold match_unsigned_before match_unsigned_after
  simp_alive_peephole
  intros
  ---BEGIN match_unsigned
  apply match_unsigned_thm
  ---END match_unsigned



def match_andAsRem_lshrAsDiv_shlAsMul_before := [llvm|
{
^0(%arg16 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(6) : i64
  %2 = llvm.mlir.constant(9) : i64
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
  %0 = llvm.mlir.constant(576) : i64
  %1 = llvm.urem %arg16, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem match_andAsRem_lshrAsDiv_shlAsMul_proof : match_andAsRem_lshrAsDiv_shlAsMul_before ⊑ match_andAsRem_lshrAsDiv_shlAsMul_after := by
  unfold match_andAsRem_lshrAsDiv_shlAsMul_before match_andAsRem_lshrAsDiv_shlAsMul_after
  simp_alive_peephole
  intros
  ---BEGIN match_andAsRem_lshrAsDiv_shlAsMul
  apply match_andAsRem_lshrAsDiv_shlAsMul_thm
  ---END match_andAsRem_lshrAsDiv_shlAsMul



def match_signed_before := [llvm|
{
^0(%arg15 : i64):
  %0 = llvm.mlir.constant(299) : i64
  %1 = llvm.mlir.constant(64) : i64
  %2 = llvm.mlir.constant(19136) : i64
  %3 = llvm.mlir.constant(9) : i64
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
  %0 = llvm.mlir.constant(172224) : i64
  %1 = llvm.srem %arg15, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem match_signed_proof : match_signed_before ⊑ match_signed_after := by
  unfold match_signed_before match_signed_after
  simp_alive_peephole
  intros
  ---BEGIN match_signed
  apply match_signed_thm
  ---END match_signed



def not_match_inconsistent_signs_before := [llvm|
{
^0(%arg13 : i64):
  %0 = llvm.mlir.constant(299) : i64
  %1 = llvm.mlir.constant(64) : i64
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
  %0 = llvm.mlir.constant(299) : i64
  %1 = llvm.mlir.constant(63) : i64
  %2 = llvm.urem %arg13, %0 : i64
  %3 = llvm.sdiv %arg13, %0 : i64
  %4 = llvm.and %3, %1 : i64
  %5 = llvm.mul %4, %0 overflow<nsw,nuw> : i64
  %6 = llvm.add %2, %5 overflow<nsw,nuw> : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_match_inconsistent_signs_proof : not_match_inconsistent_signs_before ⊑ not_match_inconsistent_signs_after := by
  unfold not_match_inconsistent_signs_before not_match_inconsistent_signs_after
  simp_alive_peephole
  intros
  ---BEGIN not_match_inconsistent_signs
  apply not_match_inconsistent_signs_thm
  ---END not_match_inconsistent_signs



def not_match_inconsistent_values_before := [llvm|
{
^0(%arg12 : i64):
  %0 = llvm.mlir.constant(299) : i64
  %1 = llvm.mlir.constant(29) : i64
  %2 = llvm.mlir.constant(64) : i64
  %3 = llvm.urem %arg12, %0 : i64
  %4 = llvm.udiv %arg12, %1 : i64
  %5 = llvm.urem %4, %2 : i64
  %6 = llvm.mul %5, %0 : i64
  %7 = llvm.add %3, %6 : i64
  "llvm.return"(%7) : (i64) -> ()
}
]
def not_match_inconsistent_values_after := [llvm|
{
^0(%arg12 : i64):
  %0 = llvm.mlir.constant(299) : i64
  %1 = llvm.mlir.constant(29) : i64
  %2 = llvm.mlir.constant(63) : i64
  %3 = llvm.urem %arg12, %0 : i64
  %4 = llvm.udiv %arg12, %1 : i64
  %5 = llvm.and %4, %2 : i64
  %6 = llvm.mul %5, %0 overflow<nsw,nuw> : i64
  %7 = llvm.add %3, %6 overflow<nsw,nuw> : i64
  "llvm.return"(%7) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_match_inconsistent_values_proof : not_match_inconsistent_values_before ⊑ not_match_inconsistent_values_after := by
  unfold not_match_inconsistent_values_before not_match_inconsistent_values_after
  simp_alive_peephole
  intros
  ---BEGIN not_match_inconsistent_values
  apply not_match_inconsistent_values_thm
  ---END not_match_inconsistent_values



def fold_add_udiv_urem_before := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.udiv %arg10, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.urem %arg10, %0 : i32
  %5 = llvm.add %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def fold_add_udiv_urem_after := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.udiv %arg10, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nuw> : i32
  %4 = llvm.add %3, %arg10 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_add_udiv_urem_proof : fold_add_udiv_urem_before ⊑ fold_add_udiv_urem_after := by
  unfold fold_add_udiv_urem_before fold_add_udiv_urem_after
  simp_alive_peephole
  intros
  ---BEGIN fold_add_udiv_urem
  apply fold_add_udiv_urem_thm
  ---END fold_add_udiv_urem



def fold_add_sdiv_srem_before := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
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
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.sdiv %arg9, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw> : i32
  %4 = llvm.add %3, %arg9 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_add_sdiv_srem_proof : fold_add_sdiv_srem_before ⊑ fold_add_sdiv_srem_after := by
  unfold fold_add_sdiv_srem_before fold_add_sdiv_srem_after
  simp_alive_peephole
  intros
  ---BEGIN fold_add_sdiv_srem
  apply fold_add_sdiv_srem_thm
  ---END fold_add_sdiv_srem



def fold_add_udiv_urem_to_mul_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(21 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.udiv %arg8, %0 : i32
  %4 = llvm.mul %3, %1 : i32
  %5 = llvm.urem %arg8, %0 : i32
  %6 = llvm.mul %5, %2 : i32
  %7 = llvm.add %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def fold_add_udiv_urem_to_mul_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mul %arg8, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_add_udiv_urem_to_mul_proof : fold_add_udiv_urem_to_mul_before ⊑ fold_add_udiv_urem_to_mul_after := by
  unfold fold_add_udiv_urem_to_mul_before fold_add_udiv_urem_to_mul_after
  simp_alive_peephole
  intros
  ---BEGIN fold_add_udiv_urem_to_mul
  apply fold_add_udiv_urem_to_mul_thm
  ---END fold_add_udiv_urem_to_mul



def fold_add_udiv_urem_commuted_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.udiv %arg6, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.urem %arg6, %0 : i32
  %5 = llvm.add %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def fold_add_udiv_urem_commuted_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.udiv %arg6, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nuw> : i32
  %4 = llvm.add %3, %arg6 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_add_udiv_urem_commuted_proof : fold_add_udiv_urem_commuted_before ⊑ fold_add_udiv_urem_commuted_after := by
  unfold fold_add_udiv_urem_commuted_before fold_add_udiv_urem_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN fold_add_udiv_urem_commuted
  apply fold_add_udiv_urem_commuted_thm
  ---END fold_add_udiv_urem_commuted



def fold_add_udiv_urem_or_disjoint_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.udiv %arg5, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.urem %arg5, %0 : i32
  %5 = llvm.or disjoint %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def fold_add_udiv_urem_or_disjoint_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.udiv %arg5, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nuw> : i32
  %4 = llvm.add %3, %arg5 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_add_udiv_urem_or_disjoint_proof : fold_add_udiv_urem_or_disjoint_before ⊑ fold_add_udiv_urem_or_disjoint_after := by
  unfold fold_add_udiv_urem_or_disjoint_before fold_add_udiv_urem_or_disjoint_after
  simp_alive_peephole
  intros
  ---BEGIN fold_add_udiv_urem_or_disjoint
  apply fold_add_udiv_urem_or_disjoint_thm
  ---END fold_add_udiv_urem_or_disjoint



def fold_add_udiv_urem_without_noundef_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.udiv %arg4, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.urem %arg4, %0 : i32
  %5 = llvm.add %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def fold_add_udiv_urem_without_noundef_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.udiv %arg4, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.urem %arg4, %0 : i32
  %5 = llvm.or disjoint %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_add_udiv_urem_without_noundef_proof : fold_add_udiv_urem_without_noundef_before ⊑ fold_add_udiv_urem_without_noundef_after := by
  unfold fold_add_udiv_urem_without_noundef_before fold_add_udiv_urem_without_noundef_after
  simp_alive_peephole
  intros
  ---BEGIN fold_add_udiv_urem_without_noundef
  apply fold_add_udiv_urem_without_noundef_thm
  ---END fold_add_udiv_urem_without_noundef


