import SSA.Projects.InstCombine.tests.proofs.gsubhxor_proof
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
section gsubhxor_statements

def low_mask_nsw_nuw_before := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(63 : i32) : i32
  %2 = llvm.and %arg13, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def low_mask_nsw_nuw_after := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(63 : i32) : i32
  %2 = llvm.and %arg13, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem low_mask_nsw_nuw_proof : low_mask_nsw_nuw_before ⊑ low_mask_nsw_nuw_after := by
  unfold low_mask_nsw_nuw_before low_mask_nsw_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN low_mask_nsw_nuw
  apply low_mask_nsw_nuw_thm
  ---END low_mask_nsw_nuw



def arbitrary_mask_sub_i8_before := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(11 : i8) : i8
  %2 = llvm.and %arg11, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def arbitrary_mask_sub_i8_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(11 : i8) : i8
  %2 = llvm.and %arg11, %0 : i8
  %3 = llvm.sub %1, %2 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem arbitrary_mask_sub_i8_proof : arbitrary_mask_sub_i8_before ⊑ arbitrary_mask_sub_i8_after := by
  unfold arbitrary_mask_sub_i8_before arbitrary_mask_sub_i8_after
  simp_alive_peephole
  intros
  ---BEGIN arbitrary_mask_sub_i8
  apply arbitrary_mask_sub_i8_thm
  ---END arbitrary_mask_sub_i8



def not_masked_sub_i8_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(11 : i8) : i8
  %2 = llvm.and %arg6, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_masked_sub_i8_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(11 : i8) : i8
  %2 = llvm.and %arg6, %0 : i8
  %3 = llvm.sub %1, %2 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_masked_sub_i8_proof : not_masked_sub_i8_before ⊑ not_masked_sub_i8_after := by
  unfold not_masked_sub_i8_before not_masked_sub_i8_after
  simp_alive_peephole
  intros
  ---BEGIN not_masked_sub_i8
  apply not_masked_sub_i8_thm
  ---END not_masked_sub_i8



def xor_add_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.and %arg4, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def xor_add_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(73 : i32) : i32
  %2 = llvm.and %arg4, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_add_proof : xor_add_before ⊑ xor_add_after := by
  unfold xor_add_before xor_add_after
  simp_alive_peephole
  intros
  ---BEGIN xor_add
  apply xor_add_thm
  ---END xor_add


