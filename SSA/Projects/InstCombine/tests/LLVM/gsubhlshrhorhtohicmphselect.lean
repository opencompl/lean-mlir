
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
section gsubhlshrhorhtohicmphselect_statements

def neg_or_lshr_i32_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.sub %0, %arg7 : i32
  %3 = llvm.or %2, %arg7 : i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def neg_or_lshr_i32_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg7, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_or_lshr_i32_proof : neg_or_lshr_i32_before ⊑ neg_or_lshr_i32_after := by
  unfold neg_or_lshr_i32_before neg_or_lshr_i32_after
  simp_alive_peephole
  intros
  ---BEGIN neg_or_lshr_i32
  all_goals (try extract_goal ; sorry)
  ---END neg_or_lshr_i32



def neg_or_lshr_i32_commute_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(31 : i32) : i32
  %3 = llvm.sdiv %0, %arg6 : i32
  %4 = llvm.sub %1, %3 : i32
  %5 = llvm.or %3, %4 : i32
  %6 = llvm.lshr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def neg_or_lshr_i32_commute_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.sdiv %0, %arg6 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_or_lshr_i32_commute_proof : neg_or_lshr_i32_commute_before ⊑ neg_or_lshr_i32_commute_after := by
  unfold neg_or_lshr_i32_commute_before neg_or_lshr_i32_commute_after
  simp_alive_peephole
  intros
  ---BEGIN neg_or_lshr_i32_commute
  all_goals (try extract_goal ; sorry)
  ---END neg_or_lshr_i32_commute


