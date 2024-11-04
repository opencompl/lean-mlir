
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
section gshlhfactor_statements

def add_shl_same_amount_before := [llvm|
{
^0(%arg59 : i6, %arg60 : i6, %arg61 : i6):
  %0 = llvm.shl %arg59, %arg61 : i6
  %1 = llvm.shl %arg60, %arg61 : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_after := [llvm|
{
^0(%arg59 : i6, %arg60 : i6, %arg61 : i6):
  %0 = llvm.add %arg59, %arg60 : i6
  %1 = llvm.shl %0, %arg61 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_shl_same_amount_proof : add_shl_same_amount_before ⊑ add_shl_same_amount_after := by
  unfold add_shl_same_amount_before add_shl_same_amount_after
  simp_alive_peephole
  intros
  ---BEGIN add_shl_same_amount
  all_goals (try extract_goal ; sorry)
  ---END add_shl_same_amount



def add_shl_same_amount_nuw_before := [llvm|
{
^0(%arg53 : i64, %arg54 : i64, %arg55 : i64):
  %0 = llvm.shl %arg53, %arg55 overflow<nuw> : i64
  %1 = llvm.shl %arg54, %arg55 overflow<nuw> : i64
  %2 = llvm.add %0, %1 overflow<nuw> : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def add_shl_same_amount_nuw_after := [llvm|
{
^0(%arg53 : i64, %arg54 : i64, %arg55 : i64):
  %0 = llvm.add %arg53, %arg54 overflow<nuw> : i64
  %1 = llvm.shl %0, %arg55 overflow<nuw> : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_shl_same_amount_nuw_proof : add_shl_same_amount_nuw_before ⊑ add_shl_same_amount_nuw_after := by
  unfold add_shl_same_amount_nuw_before add_shl_same_amount_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN add_shl_same_amount_nuw
  all_goals (try extract_goal ; sorry)
  ---END add_shl_same_amount_nuw



def add_shl_same_amount_partial_nsw1_before := [llvm|
{
^0(%arg41 : i6, %arg42 : i6, %arg43 : i6):
  %0 = llvm.shl %arg41, %arg43 overflow<nsw> : i6
  %1 = llvm.shl %arg42, %arg43 overflow<nsw> : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nsw1_after := [llvm|
{
^0(%arg41 : i6, %arg42 : i6, %arg43 : i6):
  %0 = llvm.add %arg41, %arg42 : i6
  %1 = llvm.shl %0, %arg43 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_shl_same_amount_partial_nsw1_proof : add_shl_same_amount_partial_nsw1_before ⊑ add_shl_same_amount_partial_nsw1_after := by
  unfold add_shl_same_amount_partial_nsw1_before add_shl_same_amount_partial_nsw1_after
  simp_alive_peephole
  intros
  ---BEGIN add_shl_same_amount_partial_nsw1
  all_goals (try extract_goal ; sorry)
  ---END add_shl_same_amount_partial_nsw1



def add_shl_same_amount_partial_nsw2_before := [llvm|
{
^0(%arg38 : i6, %arg39 : i6, %arg40 : i6):
  %0 = llvm.shl %arg38, %arg40 : i6
  %1 = llvm.shl %arg39, %arg40 overflow<nsw> : i6
  %2 = llvm.add %0, %1 overflow<nsw> : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nsw2_after := [llvm|
{
^0(%arg38 : i6, %arg39 : i6, %arg40 : i6):
  %0 = llvm.add %arg38, %arg39 : i6
  %1 = llvm.shl %0, %arg40 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_shl_same_amount_partial_nsw2_proof : add_shl_same_amount_partial_nsw2_before ⊑ add_shl_same_amount_partial_nsw2_after := by
  unfold add_shl_same_amount_partial_nsw2_before add_shl_same_amount_partial_nsw2_after
  simp_alive_peephole
  intros
  ---BEGIN add_shl_same_amount_partial_nsw2
  all_goals (try extract_goal ; sorry)
  ---END add_shl_same_amount_partial_nsw2



def add_shl_same_amount_partial_nuw1_before := [llvm|
{
^0(%arg35 : i6, %arg36 : i6, %arg37 : i6):
  %0 = llvm.shl %arg35, %arg37 overflow<nuw> : i6
  %1 = llvm.shl %arg36, %arg37 overflow<nuw> : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nuw1_after := [llvm|
{
^0(%arg35 : i6, %arg36 : i6, %arg37 : i6):
  %0 = llvm.add %arg35, %arg36 : i6
  %1 = llvm.shl %0, %arg37 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_shl_same_amount_partial_nuw1_proof : add_shl_same_amount_partial_nuw1_before ⊑ add_shl_same_amount_partial_nuw1_after := by
  unfold add_shl_same_amount_partial_nuw1_before add_shl_same_amount_partial_nuw1_after
  simp_alive_peephole
  intros
  ---BEGIN add_shl_same_amount_partial_nuw1
  all_goals (try extract_goal ; sorry)
  ---END add_shl_same_amount_partial_nuw1



def add_shl_same_amount_partial_nuw2_before := [llvm|
{
^0(%arg32 : i6, %arg33 : i6, %arg34 : i6):
  %0 = llvm.shl %arg32, %arg34 overflow<nuw> : i6
  %1 = llvm.shl %arg33, %arg34 : i6
  %2 = llvm.add %0, %1 overflow<nuw> : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nuw2_after := [llvm|
{
^0(%arg32 : i6, %arg33 : i6, %arg34 : i6):
  %0 = llvm.add %arg32, %arg33 : i6
  %1 = llvm.shl %0, %arg34 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_shl_same_amount_partial_nuw2_proof : add_shl_same_amount_partial_nuw2_before ⊑ add_shl_same_amount_partial_nuw2_after := by
  unfold add_shl_same_amount_partial_nuw2_before add_shl_same_amount_partial_nuw2_after
  simp_alive_peephole
  intros
  ---BEGIN add_shl_same_amount_partial_nuw2
  all_goals (try extract_goal ; sorry)
  ---END add_shl_same_amount_partial_nuw2



def sub_shl_same_amount_before := [llvm|
{
^0(%arg29 : i6, %arg30 : i6, %arg31 : i6):
  %0 = llvm.shl %arg29, %arg31 : i6
  %1 = llvm.shl %arg30, %arg31 : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_after := [llvm|
{
^0(%arg29 : i6, %arg30 : i6, %arg31 : i6):
  %0 = llvm.sub %arg29, %arg30 : i6
  %1 = llvm.shl %0, %arg31 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_shl_same_amount_proof : sub_shl_same_amount_before ⊑ sub_shl_same_amount_after := by
  unfold sub_shl_same_amount_before sub_shl_same_amount_after
  simp_alive_peephole
  intros
  ---BEGIN sub_shl_same_amount
  all_goals (try extract_goal ; sorry)
  ---END sub_shl_same_amount



def sub_shl_same_amount_nuw_before := [llvm|
{
^0(%arg23 : i64, %arg24 : i64, %arg25 : i64):
  %0 = llvm.shl %arg23, %arg25 overflow<nuw> : i64
  %1 = llvm.shl %arg24, %arg25 overflow<nuw> : i64
  %2 = llvm.sub %0, %1 overflow<nuw> : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sub_shl_same_amount_nuw_after := [llvm|
{
^0(%arg23 : i64, %arg24 : i64, %arg25 : i64):
  %0 = llvm.sub %arg23, %arg24 overflow<nuw> : i64
  %1 = llvm.shl %0, %arg25 overflow<nuw> : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_shl_same_amount_nuw_proof : sub_shl_same_amount_nuw_before ⊑ sub_shl_same_amount_nuw_after := by
  unfold sub_shl_same_amount_nuw_before sub_shl_same_amount_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN sub_shl_same_amount_nuw
  all_goals (try extract_goal ; sorry)
  ---END sub_shl_same_amount_nuw



def sub_shl_same_amount_partial_nsw1_before := [llvm|
{
^0(%arg11 : i6, %arg12 : i6, %arg13 : i6):
  %0 = llvm.shl %arg11, %arg13 overflow<nsw> : i6
  %1 = llvm.shl %arg12, %arg13 overflow<nsw> : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nsw1_after := [llvm|
{
^0(%arg11 : i6, %arg12 : i6, %arg13 : i6):
  %0 = llvm.sub %arg11, %arg12 : i6
  %1 = llvm.shl %0, %arg13 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_shl_same_amount_partial_nsw1_proof : sub_shl_same_amount_partial_nsw1_before ⊑ sub_shl_same_amount_partial_nsw1_after := by
  unfold sub_shl_same_amount_partial_nsw1_before sub_shl_same_amount_partial_nsw1_after
  simp_alive_peephole
  intros
  ---BEGIN sub_shl_same_amount_partial_nsw1
  all_goals (try extract_goal ; sorry)
  ---END sub_shl_same_amount_partial_nsw1



def sub_shl_same_amount_partial_nsw2_before := [llvm|
{
^0(%arg8 : i6, %arg9 : i6, %arg10 : i6):
  %0 = llvm.shl %arg8, %arg10 : i6
  %1 = llvm.shl %arg9, %arg10 overflow<nsw> : i6
  %2 = llvm.sub %0, %1 overflow<nsw> : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nsw2_after := [llvm|
{
^0(%arg8 : i6, %arg9 : i6, %arg10 : i6):
  %0 = llvm.sub %arg8, %arg9 : i6
  %1 = llvm.shl %0, %arg10 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_shl_same_amount_partial_nsw2_proof : sub_shl_same_amount_partial_nsw2_before ⊑ sub_shl_same_amount_partial_nsw2_after := by
  unfold sub_shl_same_amount_partial_nsw2_before sub_shl_same_amount_partial_nsw2_after
  simp_alive_peephole
  intros
  ---BEGIN sub_shl_same_amount_partial_nsw2
  all_goals (try extract_goal ; sorry)
  ---END sub_shl_same_amount_partial_nsw2



def sub_shl_same_amount_partial_nuw1_before := [llvm|
{
^0(%arg5 : i6, %arg6 : i6, %arg7 : i6):
  %0 = llvm.shl %arg5, %arg7 overflow<nuw> : i6
  %1 = llvm.shl %arg6, %arg7 overflow<nuw> : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nuw1_after := [llvm|
{
^0(%arg5 : i6, %arg6 : i6, %arg7 : i6):
  %0 = llvm.sub %arg5, %arg6 : i6
  %1 = llvm.shl %0, %arg7 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_shl_same_amount_partial_nuw1_proof : sub_shl_same_amount_partial_nuw1_before ⊑ sub_shl_same_amount_partial_nuw1_after := by
  unfold sub_shl_same_amount_partial_nuw1_before sub_shl_same_amount_partial_nuw1_after
  simp_alive_peephole
  intros
  ---BEGIN sub_shl_same_amount_partial_nuw1
  all_goals (try extract_goal ; sorry)
  ---END sub_shl_same_amount_partial_nuw1



def sub_shl_same_amount_partial_nuw2_before := [llvm|
{
^0(%arg2 : i6, %arg3 : i6, %arg4 : i6):
  %0 = llvm.shl %arg2, %arg4 overflow<nuw> : i6
  %1 = llvm.shl %arg3, %arg4 : i6
  %2 = llvm.sub %0, %1 overflow<nuw> : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nuw2_after := [llvm|
{
^0(%arg2 : i6, %arg3 : i6, %arg4 : i6):
  %0 = llvm.sub %arg2, %arg3 : i6
  %1 = llvm.shl %0, %arg4 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_shl_same_amount_partial_nuw2_proof : sub_shl_same_amount_partial_nuw2_before ⊑ sub_shl_same_amount_partial_nuw2_after := by
  unfold sub_shl_same_amount_partial_nuw2_before sub_shl_same_amount_partial_nuw2_after
  simp_alive_peephole
  intros
  ---BEGIN sub_shl_same_amount_partial_nuw2
  all_goals (try extract_goal ; sorry)
  ---END sub_shl_same_amount_partial_nuw2



def add_shl_same_amount_constants_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.shl %0, %arg1 : i8
  %3 = llvm.shl %1, %arg1 : i8
  %4 = llvm.add %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def add_shl_same_amount_constants_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.shl %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_shl_same_amount_constants_proof : add_shl_same_amount_constants_before ⊑ add_shl_same_amount_constants_after := by
  unfold add_shl_same_amount_constants_before add_shl_same_amount_constants_after
  simp_alive_peephole
  intros
  ---BEGIN add_shl_same_amount_constants
  all_goals (try extract_goal ; sorry)
  ---END add_shl_same_amount_constants


