
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
section gaddhmaskhneg_statements

def dec_mask_neg_i32_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sub %0, %arg7 : i32
  %3 = llvm.and %2, %arg7 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def dec_mask_neg_i32_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.add %arg7, %0 : i32
  %2 = llvm.xor %arg7, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem dec_mask_neg_i32_proof : dec_mask_neg_i32_before ⊑ dec_mask_neg_i32_after := by
  unfold dec_mask_neg_i32_before dec_mask_neg_i32_after
  simp_alive_peephole
  intros
  ---BEGIN dec_mask_neg_i32
  all_goals (try extract_goal ; sorry)
  ---END dec_mask_neg_i32



def dec_mask_commute_neg_i32_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.sdiv %0, %arg6 : i32
  %4 = llvm.sub %1, %3 : i32
  %5 = llvm.and %3, %4 : i32
  %6 = llvm.add %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def dec_mask_commute_neg_i32_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg6 : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem dec_mask_commute_neg_i32_proof : dec_mask_commute_neg_i32_before ⊑ dec_mask_commute_neg_i32_after := by
  unfold dec_mask_commute_neg_i32_before dec_mask_commute_neg_i32_after
  simp_alive_peephole
  intros
  ---BEGIN dec_mask_commute_neg_i32
  all_goals (try extract_goal ; sorry)
  ---END dec_mask_commute_neg_i32



def dec_commute_mask_neg_i32_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sub %0, %arg5 : i32
  %3 = llvm.and %2, %arg5 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def dec_commute_mask_neg_i32_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.add %arg5, %0 : i32
  %2 = llvm.xor %arg5, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem dec_commute_mask_neg_i32_proof : dec_commute_mask_neg_i32_before ⊑ dec_commute_mask_neg_i32_after := by
  unfold dec_commute_mask_neg_i32_before dec_commute_mask_neg_i32_after
  simp_alive_peephole
  intros
  ---BEGIN dec_commute_mask_neg_i32
  all_goals (try extract_goal ; sorry)
  ---END dec_commute_mask_neg_i32


