import SSA.Projects.InstCombine.tests.proofs.gnarrow_proof
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
section gnarrow_statements

def shrink_xor_before := [llvm|
{
^0(%arg13 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.xor %arg13, %0 : i64
  %2 = llvm.trunc %1 : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shrink_xor_after := [llvm|
{
^0(%arg13 : i64):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.trunc %arg13 : i64 to i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shrink_xor_proof : shrink_xor_before ⊑ shrink_xor_after := by
  unfold shrink_xor_before shrink_xor_after
  simp_alive_peephole
  ---BEGIN shrink_xor
  apply shrink_xor_thm
  ---END shrink_xor



def shrink_or_before := [llvm|
{
^0(%arg11 : i6):
  %0 = llvm.mlir.constant(-31 : i6) : i6
  %1 = llvm.or %arg11, %0 : i6
  %2 = llvm.trunc %1 : i6 to i3
  "llvm.return"(%2) : (i3) -> ()
}
]
def shrink_or_after := [llvm|
{
^0(%arg11 : i6):
  %0 = llvm.mlir.constant(1 : i3) : i3
  %1 = llvm.trunc %arg11 : i6 to i3
  %2 = llvm.or %1, %0 : i3
  "llvm.return"(%2) : (i3) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shrink_or_proof : shrink_or_before ⊑ shrink_or_after := by
  unfold shrink_or_before shrink_or_after
  simp_alive_peephole
  ---BEGIN shrink_or
  apply shrink_or_thm
  ---END shrink_or


