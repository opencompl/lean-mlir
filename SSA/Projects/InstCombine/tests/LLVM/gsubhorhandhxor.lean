
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
section gsubhorhandhxor_statements

def sub_to_xor_before := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.or %arg15, %arg16 : i32
  %1 = llvm.and %arg15, %arg16 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_xor_after := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.xor %arg15, %arg16 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_to_xor_proof : sub_to_xor_before ⊑ sub_to_xor_after := by
  unfold sub_to_xor_before sub_to_xor_after
  simp_alive_peephole
  intros
  ---BEGIN sub_to_xor
  all_goals (try extract_goal ; sorry)
  ---END sub_to_xor



def sub_to_xor_or_commuted_before := [llvm|
{
^0(%arg7 : i32, %arg8 : i32):
  %0 = llvm.or %arg8, %arg7 : i32
  %1 = llvm.and %arg7, %arg8 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_xor_or_commuted_after := [llvm|
{
^0(%arg7 : i32, %arg8 : i32):
  %0 = llvm.xor %arg7, %arg8 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_to_xor_or_commuted_proof : sub_to_xor_or_commuted_before ⊑ sub_to_xor_or_commuted_after := by
  unfold sub_to_xor_or_commuted_before sub_to_xor_or_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN sub_to_xor_or_commuted
  all_goals (try extract_goal ; sorry)
  ---END sub_to_xor_or_commuted



def sub_to_xor_and_commuted_before := [llvm|
{
^0(%arg5 : i32, %arg6 : i32):
  %0 = llvm.or %arg5, %arg6 : i32
  %1 = llvm.and %arg6, %arg5 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_xor_and_commuted_after := [llvm|
{
^0(%arg5 : i32, %arg6 : i32):
  %0 = llvm.xor %arg6, %arg5 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_to_xor_and_commuted_proof : sub_to_xor_and_commuted_before ⊑ sub_to_xor_and_commuted_after := by
  unfold sub_to_xor_and_commuted_before sub_to_xor_and_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN sub_to_xor_and_commuted
  all_goals (try extract_goal ; sorry)
  ---END sub_to_xor_and_commuted


