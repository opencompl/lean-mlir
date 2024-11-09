
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
section gcanonicalizehshlhlshrhtohmasking_statements

def positive_samevar_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.shl %arg36, %arg37 : i32
  %1 = llvm.lshr %0, %arg37 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def positive_samevar_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.lshr %0, %arg37 : i32
  %2 = llvm.and %1, %arg36 : i32
  "llvm.return"(%2) : (i32) -> ()
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
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.shl %arg35, %0 : i32
  %2 = llvm.lshr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def positive_sameconst_after := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(134217727 : i32) : i32
  %1 = llvm.and %arg35, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
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



def positive_biggerShl_before := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.shl %arg34, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerShl_after := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(134217696 : i32) : i32
  %2 = llvm.shl %arg34, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerShl_proof : positive_biggerShl_before ⊑ positive_biggerShl_after := by
  unfold positive_biggerShl_before positive_biggerShl_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerShl
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerShl



def positive_biggerLshr_before := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(10 : i32) : i32
  %2 = llvm.shl %arg33, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerLshr_after := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(4194303 : i32) : i32
  %2 = llvm.lshr %arg33, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerLshr_proof : positive_biggerLshr_before ⊑ positive_biggerLshr_after := by
  unfold positive_biggerLshr_before positive_biggerLshr_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerLshr
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerLshr



def positive_biggerLshr_lshrexact_before := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(10 : i32) : i32
  %2 = llvm.shl %arg32, %0 : i32
  %3 = llvm.lshr exact %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerLshr_lshrexact_after := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(4194303 : i32) : i32
  %2 = llvm.lshr exact %arg32, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerLshr_lshrexact_proof : positive_biggerLshr_lshrexact_before ⊑ positive_biggerLshr_lshrexact_after := by
  unfold positive_biggerLshr_lshrexact_before positive_biggerLshr_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerLshr_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerLshr_lshrexact



def positive_samevar_shlnuw_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.shl %arg30, %arg31 overflow<nuw> : i32
  %1 = llvm.lshr %0, %arg31 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def positive_samevar_shlnuw_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  "llvm.return"(%arg30) : (i32) -> ()
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
^0(%arg29 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.shl %arg29, %0 overflow<nuw> : i32
  %2 = llvm.lshr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def positive_sameconst_shlnuw_after := [llvm|
{
^0(%arg29 : i32):
  "llvm.return"(%arg29) : (i32) -> ()
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



def positive_biggerShl_shlnuw_before := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.shl %arg28, %0 overflow<nuw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerShl_shlnuw_after := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.shl %arg28, %0 overflow<nsw,nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerShl_shlnuw_proof : positive_biggerShl_shlnuw_before ⊑ positive_biggerShl_shlnuw_after := by
  unfold positive_biggerShl_shlnuw_before positive_biggerShl_shlnuw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerShl_shlnuw
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerShl_shlnuw



def positive_biggerLshr_shlnuw_before := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(10 : i32) : i32
  %2 = llvm.shl %arg27, %0 overflow<nuw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerLshr_shlnuw_after := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.lshr %arg27, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerLshr_shlnuw_proof : positive_biggerLshr_shlnuw_before ⊑ positive_biggerLshr_shlnuw_after := by
  unfold positive_biggerLshr_shlnuw_before positive_biggerLshr_shlnuw_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerLshr_shlnuw
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerLshr_shlnuw



def positive_biggerLshr_shlnuw_lshrexact_before := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(10 : i32) : i32
  %2 = llvm.shl %arg26, %0 overflow<nuw> : i32
  %3 = llvm.lshr exact %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerLshr_shlnuw_lshrexact_after := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.lshr exact %arg26, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_biggerLshr_shlnuw_lshrexact_proof : positive_biggerLshr_shlnuw_lshrexact_before ⊑ positive_biggerLshr_shlnuw_lshrexact_after := by
  unfold positive_biggerLshr_shlnuw_lshrexact_before positive_biggerLshr_shlnuw_lshrexact_after
  simp_alive_peephole
  intros
  ---BEGIN positive_biggerLshr_shlnuw_lshrexact
  all_goals (try extract_goal ; sorry)
  ---END positive_biggerLshr_shlnuw_lshrexact


