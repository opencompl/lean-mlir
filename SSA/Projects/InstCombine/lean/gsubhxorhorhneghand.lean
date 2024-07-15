import SSA.Projects.InstCombine.lean.gsubhxorhorhneghand_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def sub_to_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.sub %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sub_to_and_proof : sub_to_and_before ⊑ sub_to_and_after := by
  unfold sub_to_and_before sub_to_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_to_and
  apply sub_to_and_thm
  ---END sub_to_and



def sub_to_and_or_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg1, %arg0 : i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.sub %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_and_or_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sub_to_and_or_commuted_proof : sub_to_and_or_commuted_before ⊑ sub_to_and_or_commuted_after := by
  unfold sub_to_and_or_commuted_before sub_to_and_or_commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_to_and_or_commuted
  apply sub_to_and_or_commuted_thm
  ---END sub_to_and_or_commuted



def sub_to_and_and_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.sub %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_and_and_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sub_to_and_and_commuted_proof : sub_to_and_and_commuted_before ⊑ sub_to_and_and_commuted_after := by
  unfold sub_to_and_and_commuted_before sub_to_and_and_commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_to_and_and_commuted
  apply sub_to_and_and_commuted_thm
  ---END sub_to_and_and_commuted


