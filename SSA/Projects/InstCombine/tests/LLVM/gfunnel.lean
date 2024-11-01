
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
section gfunnel_statements

def unmasked_shlop_insufficient_mask_shift_amount_before := [llvm|
{
^0(%arg14 : i16, %arg15 : i16, %arg16 : i16):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.mlir.constant(255 : i16) : i16
  %2 = llvm.mlir.constant(8 : i16) : i16
  %3 = llvm.and %arg16, %0 : i16
  %4 = llvm.and %arg14, %1 : i16
  %5 = llvm.sub %2, %3 : i16
  %6 = llvm.shl %arg15, %5 : i16
  %7 = llvm.lshr %4, %3 : i16
  %8 = llvm.or %6, %7 : i16
  %9 = llvm.trunc %8 : i16 to i8
  "llvm.return"(%9) : (i8) -> ()
}
]
def unmasked_shlop_insufficient_mask_shift_amount_after := [llvm|
{
^0(%arg14 : i16, %arg15 : i16, %arg16 : i16):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.mlir.constant(255 : i16) : i16
  %2 = llvm.mlir.constant(8 : i16) : i16
  %3 = llvm.and %arg16, %0 : i16
  %4 = llvm.and %arg14, %1 : i16
  %5 = llvm.sub %2, %3 overflow<nsw> : i16
  %6 = llvm.shl %arg15, %5 : i16
  %7 = llvm.lshr %4, %3 : i16
  %8 = llvm.or %6, %7 : i16
  %9 = llvm.trunc %8 : i16 to i8
  "llvm.return"(%9) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem unmasked_shlop_insufficient_mask_shift_amount_proof : unmasked_shlop_insufficient_mask_shift_amount_before ⊑ unmasked_shlop_insufficient_mask_shift_amount_after := by
  unfold unmasked_shlop_insufficient_mask_shift_amount_before unmasked_shlop_insufficient_mask_shift_amount_after
  simp_alive_peephole
  intros
  ---BEGIN unmasked_shlop_insufficient_mask_shift_amount
  all_goals (try extract_goal ; sorry)
  ---END unmasked_shlop_insufficient_mask_shift_amount


