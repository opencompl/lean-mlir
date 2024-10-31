
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
section gicmphmulhand_statements

def pr40493_neg3_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.mul %arg15, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def pr40493_neg3_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.shl %arg15, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr40493_neg3_proof : pr40493_neg3_before ⊑ pr40493_neg3_after := by
  unfold pr40493_neg3_before pr40493_neg3_after
  simp_alive_peephole
  ---BEGIN pr40493_neg3
  all_goals (try extract_goal ; sorry)
  ---END pr40493_neg3



def pr51551_demand3bits_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(-7 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg1, %0 : i32
  %4 = llvm.or %3, %1 : i32
  %5 = llvm.mul %4, %arg0 overflow<nsw> : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def pr51551_demand3bits_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr51551_demand3bits_proof : pr51551_demand3bits_before ⊑ pr51551_demand3bits_after := by
  unfold pr51551_demand3bits_before pr51551_demand3bits_after
  simp_alive_peephole
  ---BEGIN pr51551_demand3bits
  all_goals (try extract_goal ; sorry)
  ---END pr51551_demand3bits


