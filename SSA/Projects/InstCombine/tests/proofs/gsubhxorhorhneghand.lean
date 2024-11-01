import SSA.Projects.InstCombine.tests.proofs.gsubhxorhorhneghand_proof
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
section gsubhxorhorhneghand_statements

def sub_to_and_before := [llvm|
{
^0(%arg14 : i32, %arg15 : i32):
  %0 = llvm.or %arg14, %arg15 : i32
  %1 = llvm.xor %arg14, %arg15 : i32
  %2 = llvm.sub %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_and_after := [llvm|
{
^0(%arg14 : i32, %arg15 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.and %arg14, %arg15 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_to_and_proof : sub_to_and_before ⊑ sub_to_and_after := by
  unfold sub_to_and_before sub_to_and_after
  simp_alive_peephole
  intros
  ---BEGIN sub_to_and
  apply sub_to_and_thm
  ---END sub_to_and



def sub_to_and_or_commuted_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.or %arg7, %arg6 : i32
  %1 = llvm.xor %arg6, %arg7 : i32
  %2 = llvm.sub %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_and_or_commuted_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.and %arg6, %arg7 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_to_and_or_commuted_proof : sub_to_and_or_commuted_before ⊑ sub_to_and_or_commuted_after := by
  unfold sub_to_and_or_commuted_before sub_to_and_or_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN sub_to_and_or_commuted
  apply sub_to_and_or_commuted_thm
  ---END sub_to_and_or_commuted



def sub_to_and_and_commuted_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.or %arg4, %arg5 : i32
  %1 = llvm.xor %arg5, %arg4 : i32
  %2 = llvm.sub %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_and_and_commuted_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.and %arg5, %arg4 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_to_and_and_commuted_proof : sub_to_and_and_commuted_before ⊑ sub_to_and_and_commuted_after := by
  unfold sub_to_and_and_commuted_before sub_to_and_and_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN sub_to_and_and_commuted
  apply sub_to_and_and_commuted_thm
  ---END sub_to_and_and_commuted


