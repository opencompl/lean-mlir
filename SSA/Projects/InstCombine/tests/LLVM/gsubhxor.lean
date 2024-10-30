
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
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 63 : i32}> : () -> i32
  %2 = llvm.and %arg13, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def low_mask_nsw_nuw_after := [llvm|
{
^0(%arg13 : i32):
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 63 : i32}> : () -> i32
  %2 = llvm.and %arg13, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem low_mask_nsw_nuw_proof : low_mask_nsw_nuw_before ⊑ low_mask_nsw_nuw_after := by
  unfold low_mask_nsw_nuw_before low_mask_nsw_nuw_after
  simp_alive_peephole
  ---BEGIN low_mask_nsw_nuw
  all_goals (try extract_goal ; sorry)
  ---END low_mask_nsw_nuw



def xor_add_before := [llvm|
{
^0(%arg4 : i32):
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %2 = llvm.and %arg4, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def xor_add_after := [llvm|
{
^0(%arg4 : i32):
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 73 : i32}> : () -> i32
  %2 = llvm.and %arg4, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_add_proof : xor_add_before ⊑ xor_add_after := by
  unfold xor_add_before xor_add_after
  simp_alive_peephole
  ---BEGIN xor_add
  all_goals (try extract_goal ; sorry)
  ---END xor_add


