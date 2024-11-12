
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
section gtrunchdemand_statements

def trunc_lshr_before := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(14 : i6) : i6
  %2 = llvm.lshr %arg10, %0 : i8
  %3 = llvm.trunc %2 : i8 to i6
  %4 = llvm.and %3, %1 : i6
  "llvm.return"(%4) : (i6) -> ()
}
]
def trunc_lshr_after := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(2 : i6) : i6
  %1 = llvm.mlir.constant(14 : i6) : i6
  %2 = llvm.trunc %arg10 : i8 to i6
  %3 = llvm.lshr %2, %0 : i6
  %4 = llvm.and %3, %1 : i6
  "llvm.return"(%4) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_proof : trunc_lshr_before ⊑ trunc_lshr_after := by
  unfold trunc_lshr_before trunc_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr
  all_goals (try extract_goal ; sorry)
  ---END trunc_lshr



def trunc_lshr_exact_mask_before := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(15 : i6) : i6
  %2 = llvm.lshr %arg9, %0 : i8
  %3 = llvm.trunc %2 : i8 to i6
  %4 = llvm.and %3, %1 : i6
  "llvm.return"(%4) : (i6) -> ()
}
]
def trunc_lshr_exact_mask_after := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(2 : i6) : i6
  %1 = llvm.trunc %arg9 : i8 to i6
  %2 = llvm.lshr %1, %0 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_exact_mask_proof : trunc_lshr_exact_mask_before ⊑ trunc_lshr_exact_mask_after := by
  unfold trunc_lshr_exact_mask_before trunc_lshr_exact_mask_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr_exact_mask
  all_goals (try extract_goal ; sorry)
  ---END trunc_lshr_exact_mask



def trunc_lshr_big_mask_before := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(31 : i6) : i6
  %2 = llvm.lshr %arg8, %0 : i8
  %3 = llvm.trunc %2 : i8 to i6
  %4 = llvm.and %3, %1 : i6
  "llvm.return"(%4) : (i6) -> ()
}
]
def trunc_lshr_big_mask_after := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(31 : i6) : i6
  %2 = llvm.lshr %arg8, %0 : i8
  %3 = llvm.trunc %2 overflow<nuw> : i8 to i6
  %4 = llvm.and %3, %1 : i6
  "llvm.return"(%4) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_lshr_big_mask_proof : trunc_lshr_big_mask_before ⊑ trunc_lshr_big_mask_after := by
  unfold trunc_lshr_big_mask_before trunc_lshr_big_mask_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_lshr_big_mask
  all_goals (try extract_goal ; sorry)
  ---END trunc_lshr_big_mask



def or_trunc_lshr_before := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-32 : i6) : i6
  %2 = llvm.lshr %arg2, %0 : i8
  %3 = llvm.trunc %2 : i8 to i6
  %4 = llvm.or %3, %1 : i6
  "llvm.return"(%4) : (i6) -> ()
}
]
def or_trunc_lshr_after := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(1 : i6) : i6
  %1 = llvm.mlir.constant(-32 : i6) : i6
  %2 = llvm.trunc %arg2 : i8 to i6
  %3 = llvm.lshr %2, %0 : i6
  %4 = llvm.or disjoint %3, %1 : i6
  "llvm.return"(%4) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_trunc_lshr_proof : or_trunc_lshr_before ⊑ or_trunc_lshr_after := by
  unfold or_trunc_lshr_before or_trunc_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN or_trunc_lshr
  all_goals (try extract_goal ; sorry)
  ---END or_trunc_lshr



def or_trunc_lshr_more_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(-4 : i6) : i6
  %2 = llvm.lshr %arg1, %0 : i8
  %3 = llvm.trunc %2 : i8 to i6
  %4 = llvm.or %3, %1 : i6
  "llvm.return"(%4) : (i6) -> ()
}
]
def or_trunc_lshr_more_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(4 : i6) : i6
  %1 = llvm.mlir.constant(-4 : i6) : i6
  %2 = llvm.trunc %arg1 : i8 to i6
  %3 = llvm.lshr %2, %0 : i6
  %4 = llvm.or disjoint %3, %1 : i6
  "llvm.return"(%4) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_trunc_lshr_more_proof : or_trunc_lshr_more_before ⊑ or_trunc_lshr_more_after := by
  unfold or_trunc_lshr_more_before or_trunc_lshr_more_after
  simp_alive_peephole
  intros
  ---BEGIN or_trunc_lshr_more
  all_goals (try extract_goal ; sorry)
  ---END or_trunc_lshr_more



def or_trunc_lshr_small_mask_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(-8 : i6) : i6
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.trunc %2 : i8 to i6
  %4 = llvm.or %3, %1 : i6
  "llvm.return"(%4) : (i6) -> ()
}
]
def or_trunc_lshr_small_mask_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(-8 : i6) : i6
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.trunc %2 overflow<nsw,nuw> : i8 to i6
  %4 = llvm.or %3, %1 : i6
  "llvm.return"(%4) : (i6) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_trunc_lshr_small_mask_proof : or_trunc_lshr_small_mask_before ⊑ or_trunc_lshr_small_mask_after := by
  unfold or_trunc_lshr_small_mask_before or_trunc_lshr_small_mask_after
  simp_alive_peephole
  intros
  ---BEGIN or_trunc_lshr_small_mask
  all_goals (try extract_goal ; sorry)
  ---END or_trunc_lshr_small_mask


