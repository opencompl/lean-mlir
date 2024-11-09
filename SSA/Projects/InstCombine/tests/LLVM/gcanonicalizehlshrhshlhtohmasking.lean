
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
section gcanonicalizehlshrhshlhtohmasking_statements

def positive_samevar_before := [llvm|
{
^0(%arg62 : i8, %arg63 : i8):
  %0 = llvm.lshr %arg62, %arg63 : i8
  %1 = llvm.shl %0, %arg63 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_after := [llvm|
{
^0(%arg62 : i8, %arg63 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg63 overflow<nsw> : i8
  %2 = llvm.and %1, %arg62 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_proof : positive_samevar_before ⊑ positive_samevar_after := by
  unfold positive_samevar_before positive_samevar_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar
  all_goals (try extract_goal ; sorry)
  ---END positive_samevar



def positive_sameconst_before := [llvm|
{
^0(%arg61 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr %arg61, %0 : i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_after := [llvm|
{
^0(%arg61 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.and %arg61, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_proof : positive_sameconst_before ⊑ positive_sameconst_after := by
  unfold positive_sameconst_before positive_sameconst_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst
  all_goals (try extract_goal ; sorry)
  ---END positive_sameconst



def positive_biggerlshr_before := [llvm|
{
^0(%arg60 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr %arg60, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_after := [llvm|
{
^0(%arg60 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(24 : i8) : i8
  %2 = llvm.lshr %arg60, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerlshr_proof : positive_biggerlshr_before ⊑ positive_biggerlshr_after := by
  unfold positive_biggerlshr_before positive_biggerlshr_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerlshr
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerlshr



def positive_biggershl_before := [llvm|
{
^0(%arg59 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.lshr %arg59, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_after := [llvm|
{
^0(%arg59 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(-64 : i8) : i8
  %2 = llvm.shl %arg59, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_proof : positive_biggershl_before ⊑ positive_biggershl_after := by
  unfold positive_biggershl_before positive_biggershl_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl
  all_goals (try extract_goal ; sorry)
  ---END positive_biggershl



def positive_samevar_shlnuw_before := [llvm|
{
^0(%arg57 : i8, %arg58 : i8):
  %0 = llvm.lshr %arg57, %arg58 : i8
  %1 = llvm.shl %0, %arg58 overflow<nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnuw_after := [llvm|
{
^0(%arg57 : i8, %arg58 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg58 overflow<nsw> : i8
  %2 = llvm.and %1, %arg57 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_shlnuw_proof : positive_samevar_shlnuw_before ⊑ positive_samevar_shlnuw_after := by
  unfold positive_samevar_shlnuw_before positive_samevar_shlnuw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar_shlnuw
  all_goals (try extract_goal ; sorry)
  ---END positive_samevar_shlnuw



def positive_sameconst_shlnuw_before := [llvm|
{
^0(%arg56 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr %arg56, %0 : i8
  %2 = llvm.shl %1, %0 overflow<nuw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnuw_after := [llvm|
{
^0(%arg56 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.and %arg56, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_shlnuw_proof : positive_sameconst_shlnuw_before ⊑ positive_sameconst_shlnuw_after := by
  unfold positive_sameconst_shlnuw_before positive_sameconst_shlnuw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst_shlnuw
  all_goals (try extract_goal ; sorry)
  ---END positive_sameconst_shlnuw



def positive_biggerlshr_shlnuw_before := [llvm|
{
^0(%arg55 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr %arg55, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnuw_after := [llvm|
{
^0(%arg55 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(24 : i8) : i8
  %2 = llvm.lshr %arg55, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerlshr_shlnuw_proof : positive_biggerlshr_shlnuw_before ⊑ positive_biggerlshr_shlnuw_after := by
  unfold positive_biggerlshr_shlnuw_before positive_biggerlshr_shlnuw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerlshr_shlnuw
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerlshr_shlnuw



def positive_biggershl_shlnuw_before := [llvm|
{
^0(%arg54 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.lshr %arg54, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnuw_after := [llvm|
{
^0(%arg54 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(-64 : i8) : i8
  %2 = llvm.shl %arg54, %0 overflow<nuw> : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_shlnuw_proof : positive_biggershl_shlnuw_before ⊑ positive_biggershl_shlnuw_after := by
  unfold positive_biggershl_shlnuw_before positive_biggershl_shlnuw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl_shlnuw
  all_goals (try extract_goal ; sorry)
  ---END positive_biggershl_shlnuw



def positive_samevar_shlnsw_before := [llvm|
{
^0(%arg52 : i8, %arg53 : i8):
  %0 = llvm.lshr %arg52, %arg53 : i8
  %1 = llvm.shl %0, %arg53 overflow<nsw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnsw_after := [llvm|
{
^0(%arg52 : i8, %arg53 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg53 overflow<nsw> : i8
  %2 = llvm.and %1, %arg52 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_shlnsw_proof : positive_samevar_shlnsw_before ⊑ positive_samevar_shlnsw_after := by
  unfold positive_samevar_shlnsw_before positive_samevar_shlnsw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar_shlnsw
  all_goals (try extract_goal ; sorry)
  ---END positive_samevar_shlnsw



def positive_sameconst_shlnsw_before := [llvm|
{
^0(%arg51 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr %arg51, %0 : i8
  %2 = llvm.shl %1, %0 overflow<nsw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnsw_after := [llvm|
{
^0(%arg51 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.and %arg51, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_shlnsw_proof : positive_sameconst_shlnsw_before ⊑ positive_sameconst_shlnsw_after := by
  unfold positive_sameconst_shlnsw_before positive_sameconst_shlnsw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst_shlnsw
  all_goals (try extract_goal ; sorry)
  ---END positive_sameconst_shlnsw



def positive_biggerlshr_shlnsw_before := [llvm|
{
^0(%arg50 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr %arg50, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnsw_after := [llvm|
{
^0(%arg50 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(24 : i8) : i8
  %2 = llvm.lshr %arg50, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerlshr_shlnsw_proof : positive_biggerlshr_shlnsw_before ⊑ positive_biggerlshr_shlnsw_after := by
  unfold positive_biggerlshr_shlnsw_before positive_biggerlshr_shlnsw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerlshr_shlnsw
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerlshr_shlnsw



def positive_biggershl_shlnsw_before := [llvm|
{
^0(%arg49 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.lshr %arg49, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnsw_after := [llvm|
{
^0(%arg49 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(64 : i8) : i8
  %2 = llvm.shl %arg49, %0 overflow<nsw,nuw> : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_shlnsw_proof : positive_biggershl_shlnsw_before ⊑ positive_biggershl_shlnsw_after := by
  unfold positive_biggershl_shlnsw_before positive_biggershl_shlnsw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl_shlnsw
  all_goals (try extract_goal ; sorry)
  ---END positive_biggershl_shlnsw



def positive_samevar_shlnuwnsw_before := [llvm|
{
^0(%arg47 : i8, %arg48 : i8):
  %0 = llvm.lshr %arg47, %arg48 : i8
  %1 = llvm.shl %0, %arg48 overflow<nsw,nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnuwnsw_after := [llvm|
{
^0(%arg47 : i8, %arg48 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg48 overflow<nsw> : i8
  %2 = llvm.and %1, %arg47 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_shlnuwnsw_proof : positive_samevar_shlnuwnsw_before ⊑ positive_samevar_shlnuwnsw_after := by
  unfold positive_samevar_shlnuwnsw_before positive_samevar_shlnuwnsw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar_shlnuwnsw
  all_goals (try extract_goal ; sorry)
  ---END positive_samevar_shlnuwnsw



def positive_sameconst_shlnuwnsw_before := [llvm|
{
^0(%arg46 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr %arg46, %0 : i8
  %2 = llvm.shl %1, %0 overflow<nsw,nuw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnuwnsw_after := [llvm|
{
^0(%arg46 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.and %arg46, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_shlnuwnsw_proof : positive_sameconst_shlnuwnsw_before ⊑ positive_sameconst_shlnuwnsw_after := by
  unfold positive_sameconst_shlnuwnsw_before positive_sameconst_shlnuwnsw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst_shlnuwnsw
  all_goals (try extract_goal ; sorry)
  ---END positive_sameconst_shlnuwnsw



def positive_biggerlshr_shlnuwnsw_before := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr %arg45, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnuwnsw_after := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(24 : i8) : i8
  %2 = llvm.lshr %arg45, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerlshr_shlnuwnsw_proof : positive_biggerlshr_shlnuwnsw_before ⊑ positive_biggerlshr_shlnuwnsw_after := by
  unfold positive_biggerlshr_shlnuwnsw_before positive_biggerlshr_shlnuwnsw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerlshr_shlnuwnsw
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerlshr_shlnuwnsw



def positive_biggershl_shlnuwnsw_before := [llvm|
{
^0(%arg44 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.lshr %arg44, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnuwnsw_after := [llvm|
{
^0(%arg44 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(64 : i8) : i8
  %2 = llvm.shl %arg44, %0 overflow<nsw,nuw> : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_shlnuwnsw_proof : positive_biggershl_shlnuwnsw_before ⊑ positive_biggershl_shlnuwnsw_after := by
  unfold positive_biggershl_shlnuwnsw_before positive_biggershl_shlnuwnsw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl_shlnuwnsw
  all_goals (try extract_goal ; sorry)
  ---END positive_biggershl_shlnuwnsw



def positive_samevar_lshrexact_before := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.lshr exact %arg42, %arg43 : i8
  %1 = llvm.shl %0, %arg43 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_lshrexact_after := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  "llvm.return"(%arg42) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_lshrexact_proof : positive_samevar_lshrexact_before ⊑ positive_samevar_lshrexact_after := by
  unfold positive_samevar_lshrexact_before positive_samevar_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_samevar_lshrexact



def positive_sameconst_lshrexact_before := [llvm|
{
^0(%arg41 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr exact %arg41, %0 : i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_lshrexact_after := [llvm|
{
^0(%arg41 : i8):
  "llvm.return"(%arg41) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_lshrexact_proof : positive_sameconst_lshrexact_before ⊑ positive_sameconst_lshrexact_after := by
  unfold positive_sameconst_lshrexact_before positive_sameconst_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_sameconst_lshrexact



def positive_biggerlshr_lshrexact_before := [llvm|
{
^0(%arg40 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr exact %arg40, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_lshrexact_after := [llvm|
{
^0(%arg40 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr exact %arg40, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerlshr_lshrexact_proof : positive_biggerlshr_lshrexact_before ⊑ positive_biggerlshr_lshrexact_after := by
  unfold positive_biggerlshr_lshrexact_before positive_biggerlshr_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerlshr_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerlshr_lshrexact



def positive_biggershl_lshrexact_before := [llvm|
{
^0(%arg39 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.lshr exact %arg39, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_lshrexact_after := [llvm|
{
^0(%arg39 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.shl %arg39, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_lshrexact_proof : positive_biggershl_lshrexact_before ⊑ positive_biggershl_lshrexact_after := by
  unfold positive_biggershl_lshrexact_before positive_biggershl_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_biggershl_lshrexact



def positive_samevar_shlnsw_lshrexact_before := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  %0 = llvm.lshr exact %arg37, %arg38 : i8
  %1 = llvm.shl %0, %arg38 overflow<nsw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnsw_lshrexact_after := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  "llvm.return"(%arg37) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_shlnsw_lshrexact_proof : positive_samevar_shlnsw_lshrexact_before ⊑ positive_samevar_shlnsw_lshrexact_after := by
  unfold positive_samevar_shlnsw_lshrexact_before positive_samevar_shlnsw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar_shlnsw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_samevar_shlnsw_lshrexact



def positive_sameconst_shlnsw_lshrexact_before := [llvm|
{
^0(%arg36 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr exact %arg36, %0 : i8
  %2 = llvm.shl %1, %0 overflow<nsw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnsw_lshrexact_after := [llvm|
{
^0(%arg36 : i8):
  "llvm.return"(%arg36) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_shlnsw_lshrexact_proof : positive_sameconst_shlnsw_lshrexact_before ⊑ positive_sameconst_shlnsw_lshrexact_after := by
  unfold positive_sameconst_shlnsw_lshrexact_before positive_sameconst_shlnsw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst_shlnsw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_sameconst_shlnsw_lshrexact



def positive_biggerlshr_shlnsw_lshrexact_before := [llvm|
{
^0(%arg35 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr exact %arg35, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnsw_lshrexact_after := [llvm|
{
^0(%arg35 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr exact %arg35, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerlshr_shlnsw_lshrexact_proof : positive_biggerlshr_shlnsw_lshrexact_before ⊑ positive_biggerlshr_shlnsw_lshrexact_after := by
  unfold positive_biggerlshr_shlnsw_lshrexact_before positive_biggerlshr_shlnsw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerlshr_shlnsw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerlshr_shlnsw_lshrexact



def positive_biggershl_shlnsw_lshrexact_before := [llvm|
{
^0(%arg34 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.lshr exact %arg34, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnsw_lshrexact_after := [llvm|
{
^0(%arg34 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.shl %arg34, %0 overflow<nsw,nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_shlnsw_lshrexact_proof : positive_biggershl_shlnsw_lshrexact_before ⊑ positive_biggershl_shlnsw_lshrexact_after := by
  unfold positive_biggershl_shlnsw_lshrexact_before positive_biggershl_shlnsw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl_shlnsw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_biggershl_shlnsw_lshrexact



def positive_samevar_shlnuw_lshrexact_before := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.lshr exact %arg32, %arg33 : i8
  %1 = llvm.shl %0, %arg33 overflow<nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnuw_lshrexact_after := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  "llvm.return"(%arg32) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_shlnuw_lshrexact_proof : positive_samevar_shlnuw_lshrexact_before ⊑ positive_samevar_shlnuw_lshrexact_after := by
  unfold positive_samevar_shlnuw_lshrexact_before positive_samevar_shlnuw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar_shlnuw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_samevar_shlnuw_lshrexact



def positive_sameconst_shlnuw_lshrexact_before := [llvm|
{
^0(%arg31 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr exact %arg31, %0 : i8
  %2 = llvm.shl %1, %0 overflow<nuw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnuw_lshrexact_after := [llvm|
{
^0(%arg31 : i8):
  "llvm.return"(%arg31) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_shlnuw_lshrexact_proof : positive_sameconst_shlnuw_lshrexact_before ⊑ positive_sameconst_shlnuw_lshrexact_after := by
  unfold positive_sameconst_shlnuw_lshrexact_before positive_sameconst_shlnuw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst_shlnuw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_sameconst_shlnuw_lshrexact



def positive_biggerlshr_shlnuw_lshrexact_before := [llvm|
{
^0(%arg30 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr exact %arg30, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnuw_lshrexact_after := [llvm|
{
^0(%arg30 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr exact %arg30, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerlshr_shlnuw_lshrexact_proof : positive_biggerlshr_shlnuw_lshrexact_before ⊑ positive_biggerlshr_shlnuw_lshrexact_after := by
  unfold positive_biggerlshr_shlnuw_lshrexact_before positive_biggerlshr_shlnuw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerlshr_shlnuw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerlshr_shlnuw_lshrexact



def positive_biggershl_shlnuw_lshrexact_before := [llvm|
{
^0(%arg29 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.lshr exact %arg29, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnuw_lshrexact_after := [llvm|
{
^0(%arg29 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.shl %arg29, %0 overflow<nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_shlnuw_lshrexact_proof : positive_biggershl_shlnuw_lshrexact_before ⊑ positive_biggershl_shlnuw_lshrexact_after := by
  unfold positive_biggershl_shlnuw_lshrexact_before positive_biggershl_shlnuw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl_shlnuw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_biggershl_shlnuw_lshrexact



def positive_samevar_shlnuwnsw_lshrexact_before := [llvm|
{
^0(%arg27 : i8, %arg28 : i8):
  %0 = llvm.lshr exact %arg27, %arg28 : i8
  %1 = llvm.shl %0, %arg28 overflow<nsw,nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnuwnsw_lshrexact_after := [llvm|
{
^0(%arg27 : i8, %arg28 : i8):
  "llvm.return"(%arg27) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_shlnuwnsw_lshrexact_proof : positive_samevar_shlnuwnsw_lshrexact_before ⊑ positive_samevar_shlnuwnsw_lshrexact_after := by
  unfold positive_samevar_shlnuwnsw_lshrexact_before positive_samevar_shlnuwnsw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar_shlnuwnsw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_samevar_shlnuwnsw_lshrexact



def positive_sameconst_shlnuwnsw_lshrexact_before := [llvm|
{
^0(%arg26 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr exact %arg26, %0 : i8
  %2 = llvm.shl %1, %0 overflow<nsw,nuw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnuwnsw_lshrexact_after := [llvm|
{
^0(%arg26 : i8):
  "llvm.return"(%arg26) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_shlnuwnsw_lshrexact_proof : positive_sameconst_shlnuwnsw_lshrexact_before ⊑ positive_sameconst_shlnuwnsw_lshrexact_after := by
  unfold positive_sameconst_shlnuwnsw_lshrexact_before positive_sameconst_shlnuwnsw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst_shlnuwnsw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_sameconst_shlnuwnsw_lshrexact



def positive_biggerlshr_shlnuwnsw_lshrexact_before := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr exact %arg25, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnuwnsw_lshrexact_after := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.lshr exact %arg25, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerlshr_shlnuwnsw_lshrexact_proof : positive_biggerlshr_shlnuwnsw_lshrexact_before ⊑ positive_biggerlshr_shlnuwnsw_lshrexact_after := by
  unfold positive_biggerlshr_shlnuwnsw_lshrexact_before positive_biggerlshr_shlnuwnsw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerlshr_shlnuwnsw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerlshr_shlnuwnsw_lshrexact



def positive_biggershl_shlnuwnsw_lshrexact_before := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.lshr exact %arg24, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnuwnsw_lshrexact_after := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.shl %arg24, %0 overflow<nsw,nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_shlnuwnsw_lshrexact_proof : positive_biggershl_shlnuwnsw_lshrexact_before ⊑ positive_biggershl_shlnuwnsw_lshrexact_after := by
  unfold positive_biggershl_shlnuwnsw_lshrexact_before positive_biggershl_shlnuwnsw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl_shlnuwnsw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_biggershl_shlnuwnsw_lshrexact


