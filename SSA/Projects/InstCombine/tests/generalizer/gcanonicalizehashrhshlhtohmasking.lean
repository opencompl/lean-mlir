import SSA.Projects.InstCombine.tests.proofs.gcanonicalizehashrhshlhtohmasking_proof
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
section gcanonicalizehashrhshlhtohmasking_statements

def positive_samevar_before := [llvm|
{
^0(%arg62 : i8, %arg63 : i8):
  %0 = llvm.ashr %arg62, %arg63 : i8
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
  apply positive_samevar_thm
  ---END positive_samevar



def positive_sameconst_before := [llvm|
{
^0(%arg61 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr %arg61, %0 : i8
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
  apply positive_sameconst_thm
  ---END positive_sameconst



def positive_biggerashr_before := [llvm|
{
^0(%arg60 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.ashr %arg60, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerashr_after := [llvm|
{
^0(%arg60 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(-8 : i8) : i8
  %2 = llvm.ashr %arg60, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerashr_proof : positive_biggerashr_before ⊑ positive_biggerashr_after := by
  unfold positive_biggerashr_before positive_biggerashr_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerashr
  apply positive_biggerashr_thm
  ---END positive_biggerashr



def positive_biggershl_before := [llvm|
{
^0(%arg59 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.ashr %arg59, %0 : i8
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
  apply positive_biggershl_thm
  ---END positive_biggershl



def positive_samevar_shlnuw_before := [llvm|
{
^0(%arg57 : i8, %arg58 : i8):
  %0 = llvm.ashr %arg57, %arg58 : i8
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
  apply positive_samevar_shlnuw_thm
  ---END positive_samevar_shlnuw



def positive_sameconst_shlnuw_before := [llvm|
{
^0(%arg56 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr %arg56, %0 : i8
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
  apply positive_sameconst_shlnuw_thm
  ---END positive_sameconst_shlnuw



def positive_biggerashr_shlnuw_before := [llvm|
{
^0(%arg55 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.ashr %arg55, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerashr_shlnuw_after := [llvm|
{
^0(%arg55 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(-8 : i8) : i8
  %2 = llvm.ashr %arg55, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerashr_shlnuw_proof : positive_biggerashr_shlnuw_before ⊑ positive_biggerashr_shlnuw_after := by
  unfold positive_biggerashr_shlnuw_before positive_biggerashr_shlnuw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerashr_shlnuw
  apply positive_biggerashr_shlnuw_thm
  ---END positive_biggerashr_shlnuw



def positive_biggershl_shlnuw_before := [llvm|
{
^0(%arg54 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.ashr %arg54, %0 : i8
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
  apply positive_biggershl_shlnuw_thm
  ---END positive_biggershl_shlnuw



def positive_samevar_shlnsw_before := [llvm|
{
^0(%arg52 : i8, %arg53 : i8):
  %0 = llvm.ashr %arg52, %arg53 : i8
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
  apply positive_samevar_shlnsw_thm
  ---END positive_samevar_shlnsw



def positive_sameconst_shlnsw_before := [llvm|
{
^0(%arg51 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr %arg51, %0 : i8
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
  apply positive_sameconst_shlnsw_thm
  ---END positive_sameconst_shlnsw



def positive_biggerashr_shlnsw_before := [llvm|
{
^0(%arg50 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.ashr %arg50, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerashr_shlnsw_after := [llvm|
{
^0(%arg50 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(-8 : i8) : i8
  %2 = llvm.ashr %arg50, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerashr_shlnsw_proof : positive_biggerashr_shlnsw_before ⊑ positive_biggerashr_shlnsw_after := by
  unfold positive_biggerashr_shlnsw_before positive_biggerashr_shlnsw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerashr_shlnsw
  apply positive_biggerashr_shlnsw_thm
  ---END positive_biggerashr_shlnsw



def positive_biggershl_shlnsw_before := [llvm|
{
^0(%arg49 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.ashr %arg49, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnsw_after := [llvm|
{
^0(%arg49 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(-64 : i8) : i8
  %2 = llvm.shl %arg49, %0 overflow<nsw> : i8
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
  apply positive_biggershl_shlnsw_thm
  ---END positive_biggershl_shlnsw



def positive_samevar_shlnuwnsw_before := [llvm|
{
^0(%arg47 : i8, %arg48 : i8):
  %0 = llvm.ashr %arg47, %arg48 : i8
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
  apply positive_samevar_shlnuwnsw_thm
  ---END positive_samevar_shlnuwnsw



def positive_sameconst_shlnuwnsw_before := [llvm|
{
^0(%arg46 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr %arg46, %0 : i8
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
  apply positive_sameconst_shlnuwnsw_thm
  ---END positive_sameconst_shlnuwnsw



def positive_biggerashr_shlnuwnsw_before := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.ashr %arg45, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerashr_shlnuwnsw_after := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(-8 : i8) : i8
  %2 = llvm.ashr %arg45, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerashr_shlnuwnsw_proof : positive_biggerashr_shlnuwnsw_before ⊑ positive_biggerashr_shlnuwnsw_after := by
  unfold positive_biggerashr_shlnuwnsw_before positive_biggerashr_shlnuwnsw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerashr_shlnuwnsw
  apply positive_biggerashr_shlnuwnsw_thm
  ---END positive_biggerashr_shlnuwnsw



def positive_biggershl_shlnuwnsw_before := [llvm|
{
^0(%arg44 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.ashr %arg44, %0 : i8
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
  apply positive_biggershl_shlnuwnsw_thm
  ---END positive_biggershl_shlnuwnsw



def positive_samevar_ashrexact_before := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.ashr exact %arg42, %arg43 : i8
  %1 = llvm.shl %0, %arg43 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_ashrexact_after := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  "llvm.return"(%arg42) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_ashrexact_proof : positive_samevar_ashrexact_before ⊑ positive_samevar_ashrexact_after := by
  unfold positive_samevar_ashrexact_before positive_samevar_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar_ashrexact
  apply positive_samevar_ashrexact_thm
  ---END positive_samevar_ashrexact



def positive_sameconst_ashrexact_before := [llvm|
{
^0(%arg41 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr exact %arg41, %0 : i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_ashrexact_after := [llvm|
{
^0(%arg41 : i8):
  "llvm.return"(%arg41) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_ashrexact_proof : positive_sameconst_ashrexact_before ⊑ positive_sameconst_ashrexact_after := by
  unfold positive_sameconst_ashrexact_before positive_sameconst_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst_ashrexact
  apply positive_sameconst_ashrexact_thm
  ---END positive_sameconst_ashrexact



def positive_biggerashr_ashrexact_before := [llvm|
{
^0(%arg40 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.ashr exact %arg40, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerashr_ashrexact_after := [llvm|
{
^0(%arg40 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr exact %arg40, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerashr_ashrexact_proof : positive_biggerashr_ashrexact_before ⊑ positive_biggerashr_ashrexact_after := by
  unfold positive_biggerashr_ashrexact_before positive_biggerashr_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerashr_ashrexact
  apply positive_biggerashr_ashrexact_thm
  ---END positive_biggerashr_ashrexact



def positive_biggershl_ashrexact_before := [llvm|
{
^0(%arg39 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.ashr exact %arg39, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_ashrexact_after := [llvm|
{
^0(%arg39 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.shl %arg39, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_ashrexact_proof : positive_biggershl_ashrexact_before ⊑ positive_biggershl_ashrexact_after := by
  unfold positive_biggershl_ashrexact_before positive_biggershl_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl_ashrexact
  apply positive_biggershl_ashrexact_thm
  ---END positive_biggershl_ashrexact



def positive_samevar_shlnsw_ashrexact_before := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  %0 = llvm.ashr exact %arg37, %arg38 : i8
  %1 = llvm.shl %0, %arg38 overflow<nsw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnsw_ashrexact_after := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  "llvm.return"(%arg37) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_shlnsw_ashrexact_proof : positive_samevar_shlnsw_ashrexact_before ⊑ positive_samevar_shlnsw_ashrexact_after := by
  unfold positive_samevar_shlnsw_ashrexact_before positive_samevar_shlnsw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar_shlnsw_ashrexact
  apply positive_samevar_shlnsw_ashrexact_thm
  ---END positive_samevar_shlnsw_ashrexact



def positive_sameconst_shlnsw_ashrexact_before := [llvm|
{
^0(%arg36 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr exact %arg36, %0 : i8
  %2 = llvm.shl %1, %0 overflow<nsw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnsw_ashrexact_after := [llvm|
{
^0(%arg36 : i8):
  "llvm.return"(%arg36) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_shlnsw_ashrexact_proof : positive_sameconst_shlnsw_ashrexact_before ⊑ positive_sameconst_shlnsw_ashrexact_after := by
  unfold positive_sameconst_shlnsw_ashrexact_before positive_sameconst_shlnsw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst_shlnsw_ashrexact
  apply positive_sameconst_shlnsw_ashrexact_thm
  ---END positive_sameconst_shlnsw_ashrexact



def positive_biggerashr_shlnsw_ashrexact_before := [llvm|
{
^0(%arg35 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.ashr exact %arg35, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerashr_shlnsw_ashrexact_after := [llvm|
{
^0(%arg35 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr exact %arg35, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerashr_shlnsw_ashrexact_proof : positive_biggerashr_shlnsw_ashrexact_before ⊑ positive_biggerashr_shlnsw_ashrexact_after := by
  unfold positive_biggerashr_shlnsw_ashrexact_before positive_biggerashr_shlnsw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerashr_shlnsw_ashrexact
  apply positive_biggerashr_shlnsw_ashrexact_thm
  ---END positive_biggerashr_shlnsw_ashrexact



def positive_biggershl_shlnsw_ashrexact_before := [llvm|
{
^0(%arg34 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.ashr exact %arg34, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnsw_ashrexact_after := [llvm|
{
^0(%arg34 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.shl %arg34, %0 overflow<nsw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_shlnsw_ashrexact_proof : positive_biggershl_shlnsw_ashrexact_before ⊑ positive_biggershl_shlnsw_ashrexact_after := by
  unfold positive_biggershl_shlnsw_ashrexact_before positive_biggershl_shlnsw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl_shlnsw_ashrexact
  apply positive_biggershl_shlnsw_ashrexact_thm
  ---END positive_biggershl_shlnsw_ashrexact



def positive_samevar_shlnuw_ashrexact_before := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.ashr exact %arg32, %arg33 : i8
  %1 = llvm.shl %0, %arg33 overflow<nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnuw_ashrexact_after := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  "llvm.return"(%arg32) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_shlnuw_ashrexact_proof : positive_samevar_shlnuw_ashrexact_before ⊑ positive_samevar_shlnuw_ashrexact_after := by
  unfold positive_samevar_shlnuw_ashrexact_before positive_samevar_shlnuw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar_shlnuw_ashrexact
  apply positive_samevar_shlnuw_ashrexact_thm
  ---END positive_samevar_shlnuw_ashrexact



def positive_sameconst_shlnuw_ashrexact_before := [llvm|
{
^0(%arg31 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr exact %arg31, %0 : i8
  %2 = llvm.shl %1, %0 overflow<nuw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnuw_ashrexact_after := [llvm|
{
^0(%arg31 : i8):
  "llvm.return"(%arg31) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_shlnuw_ashrexact_proof : positive_sameconst_shlnuw_ashrexact_before ⊑ positive_sameconst_shlnuw_ashrexact_after := by
  unfold positive_sameconst_shlnuw_ashrexact_before positive_sameconst_shlnuw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst_shlnuw_ashrexact
  apply positive_sameconst_shlnuw_ashrexact_thm
  ---END positive_sameconst_shlnuw_ashrexact



def positive_biggerashr_shlnuw_ashrexact_before := [llvm|
{
^0(%arg30 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.ashr exact %arg30, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerashr_shlnuw_ashrexact_after := [llvm|
{
^0(%arg30 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr exact %arg30, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerashr_shlnuw_ashrexact_proof : positive_biggerashr_shlnuw_ashrexact_before ⊑ positive_biggerashr_shlnuw_ashrexact_after := by
  unfold positive_biggerashr_shlnuw_ashrexact_before positive_biggerashr_shlnuw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerashr_shlnuw_ashrexact
  apply positive_biggerashr_shlnuw_ashrexact_thm
  ---END positive_biggerashr_shlnuw_ashrexact



def positive_biggershl_shlnuw_ashrexact_before := [llvm|
{
^0(%arg29 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.ashr exact %arg29, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnuw_ashrexact_after := [llvm|
{
^0(%arg29 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.shl %arg29, %0 overflow<nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_shlnuw_ashrexact_proof : positive_biggershl_shlnuw_ashrexact_before ⊑ positive_biggershl_shlnuw_ashrexact_after := by
  unfold positive_biggershl_shlnuw_ashrexact_before positive_biggershl_shlnuw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl_shlnuw_ashrexact
  apply positive_biggershl_shlnuw_ashrexact_thm
  ---END positive_biggershl_shlnuw_ashrexact



def positive_samevar_shlnuwnsw_ashrexact_before := [llvm|
{
^0(%arg27 : i8, %arg28 : i8):
  %0 = llvm.ashr exact %arg27, %arg28 : i8
  %1 = llvm.shl %0, %arg28 overflow<nsw,nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnuwnsw_ashrexact_after := [llvm|
{
^0(%arg27 : i8, %arg28 : i8):
  "llvm.return"(%arg27) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_samevar_shlnuwnsw_ashrexact_proof : positive_samevar_shlnuwnsw_ashrexact_before ⊑ positive_samevar_shlnuwnsw_ashrexact_after := by
  unfold positive_samevar_shlnuwnsw_ashrexact_before positive_samevar_shlnuwnsw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_samevar_shlnuwnsw_ashrexact
  apply positive_samevar_shlnuwnsw_ashrexact_thm
  ---END positive_samevar_shlnuwnsw_ashrexact



def positive_sameconst_shlnuwnsw_ashrexact_before := [llvm|
{
^0(%arg26 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr exact %arg26, %0 : i8
  %2 = llvm.shl %1, %0 overflow<nsw,nuw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnuwnsw_ashrexact_after := [llvm|
{
^0(%arg26 : i8):
  "llvm.return"(%arg26) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_sameconst_shlnuwnsw_ashrexact_proof : positive_sameconst_shlnuwnsw_ashrexact_before ⊑ positive_sameconst_shlnuwnsw_ashrexact_after := by
  unfold positive_sameconst_shlnuwnsw_ashrexact_before positive_sameconst_shlnuwnsw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_sameconst_shlnuwnsw_ashrexact
  apply positive_sameconst_shlnuwnsw_ashrexact_thm
  ---END positive_sameconst_shlnuwnsw_ashrexact



def positive_biggerashr_shlnuwnsw_ashrexact_before := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.ashr exact %arg25, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerashr_shlnuwnsw_ashrexact_after := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr exact %arg25, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerashr_shlnuwnsw_ashrexact_proof : positive_biggerashr_shlnuwnsw_ashrexact_before ⊑ positive_biggerashr_shlnuwnsw_ashrexact_after := by
  unfold positive_biggerashr_shlnuwnsw_ashrexact_before positive_biggerashr_shlnuwnsw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerashr_shlnuwnsw_ashrexact
  apply positive_biggerashr_shlnuwnsw_ashrexact_thm
  ---END positive_biggerashr_shlnuwnsw_ashrexact



def positive_biggershl_shlnuwnsw_ashrexact_before := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.ashr exact %arg24, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnuwnsw_ashrexact_after := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.shl %arg24, %0 overflow<nsw,nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggershl_shlnuwnsw_ashrexact_proof : positive_biggershl_shlnuwnsw_ashrexact_before ⊑ positive_biggershl_shlnuwnsw_ashrexact_after := by
  unfold positive_biggershl_shlnuwnsw_ashrexact_before positive_biggershl_shlnuwnsw_ashrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggershl_shlnuwnsw_ashrexact
  apply positive_biggershl_shlnuwnsw_ashrexact_thm
  ---END positive_biggershl_shlnuwnsw_ashrexact


