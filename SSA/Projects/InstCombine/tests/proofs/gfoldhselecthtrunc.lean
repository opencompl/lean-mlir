import SSA.Projects.InstCombine.tests.proofs.gfoldhselecthtrunc_proof
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
section gfoldhselecthtrunc_statements

def fold_select_trunc_nuw_true_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.trunc %arg10 overflow<nuw> : i8 to i1
  %1 = "llvm.select"(%0, %arg10, %arg11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def fold_select_trunc_nuw_true_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.trunc %arg10 overflow<nuw> : i8 to i1
  %2 = "llvm.select"(%1, %0, %arg11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_select_trunc_nuw_true_proof : fold_select_trunc_nuw_true_before ⊑ fold_select_trunc_nuw_true_after := by
  unfold fold_select_trunc_nuw_true_before fold_select_trunc_nuw_true_after
  simp_alive_peephole
  intros
  ---BEGIN fold_select_trunc_nuw_true
  apply fold_select_trunc_nuw_true_thm
  ---END fold_select_trunc_nuw_true



def fold_select_trunc_nuw_false_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.trunc %arg8 overflow<nuw> : i8 to i1
  %1 = "llvm.select"(%0, %arg9, %arg8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def fold_select_trunc_nuw_false_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.trunc %arg8 overflow<nuw> : i8 to i1
  %2 = "llvm.select"(%1, %arg9, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_select_trunc_nuw_false_proof : fold_select_trunc_nuw_false_before ⊑ fold_select_trunc_nuw_false_after := by
  unfold fold_select_trunc_nuw_false_before fold_select_trunc_nuw_false_after
  simp_alive_peephole
  intros
  ---BEGIN fold_select_trunc_nuw_false
  apply fold_select_trunc_nuw_false_thm
  ---END fold_select_trunc_nuw_false



def fold_select_trunc_nsw_true_before := [llvm|
{
^0(%arg6 : i128, %arg7 : i128):
  %0 = llvm.trunc %arg6 overflow<nsw> : i128 to i1
  %1 = "llvm.select"(%0, %arg6, %arg7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  "llvm.return"(%1) : (i128) -> ()
}
]
def fold_select_trunc_nsw_true_after := [llvm|
{
^0(%arg6 : i128, %arg7 : i128):
  %0 = llvm.mlir.constant(-1 : i128) : i128
  %1 = llvm.trunc %arg6 overflow<nsw> : i128 to i1
  %2 = "llvm.select"(%1, %0, %arg7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  "llvm.return"(%2) : (i128) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_select_trunc_nsw_true_proof : fold_select_trunc_nsw_true_before ⊑ fold_select_trunc_nsw_true_after := by
  unfold fold_select_trunc_nsw_true_before fold_select_trunc_nsw_true_after
  simp_alive_peephole
  intros
  ---BEGIN fold_select_trunc_nsw_true
  apply fold_select_trunc_nsw_true_thm
  ---END fold_select_trunc_nsw_true



def fold_select_trunc_nsw_false_before := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.trunc %arg4 overflow<nsw> : i8 to i1
  %1 = "llvm.select"(%0, %arg5, %arg4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def fold_select_trunc_nsw_false_after := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.trunc %arg4 overflow<nsw> : i8 to i1
  %2 = "llvm.select"(%1, %arg5, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_select_trunc_nsw_false_proof : fold_select_trunc_nsw_false_before ⊑ fold_select_trunc_nsw_false_after := by
  unfold fold_select_trunc_nsw_false_before fold_select_trunc_nsw_false_after
  simp_alive_peephole
  intros
  ---BEGIN fold_select_trunc_nsw_false
  apply fold_select_trunc_nsw_false_thm
  ---END fold_select_trunc_nsw_false


