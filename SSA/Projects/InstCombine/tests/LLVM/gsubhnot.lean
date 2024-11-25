
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
section gsubhnot_statements

def sub_not_before := [llvm|
{
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.sub %arg22, %arg23 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_not_after := [llvm|
{
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg22, %0 : i8
  %2 = llvm.add %arg23, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_not_proof : sub_not_before ⊑ sub_not_after := by
  unfold sub_not_before sub_not_after
  simp_alive_peephole
  intros
  ---BEGIN sub_not
  all_goals (try extract_goal ; sorry)
  ---END sub_not



def dec_sub_before := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.sub %arg16, %arg17 : i8
  %2 = llvm.add %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def dec_sub_after := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg17, %0 : i8
  %2 = llvm.add %arg16, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem dec_sub_proof : dec_sub_before ⊑ dec_sub_after := by
  unfold dec_sub_before dec_sub_after
  simp_alive_peephole
  intros
  ---BEGIN dec_sub
  all_goals (try extract_goal ; sorry)
  ---END dec_sub



def sub_inc_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.add %arg10, %0 : i8
  %2 = llvm.sub %arg11, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_inc_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg10, %0 : i8
  %2 = llvm.add %arg11, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_inc_proof : sub_inc_before ⊑ sub_inc_after := by
  unfold sub_inc_before sub_inc_after
  simp_alive_peephole
  intros
  ---BEGIN sub_inc
  all_goals (try extract_goal ; sorry)
  ---END sub_inc



def sub_dec_before := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.add %arg4, %0 : i8
  %2 = llvm.sub %1, %arg5 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_dec_after := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg5, %0 : i8
  %2 = llvm.add %arg4, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_dec_proof : sub_dec_before ⊑ sub_dec_after := by
  unfold sub_dec_before sub_dec_after
  simp_alive_peephole
  intros
  ---BEGIN sub_dec
  all_goals (try extract_goal ; sorry)
  ---END sub_dec


