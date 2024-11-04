import SSA.Projects.InstCombine.tests.proofs.gsubtracthofhonehhandhofhselect_proof
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
section gsubtracthofhonehhandhofhselect_statements

def t0_sub_of_trueval_before := [llvm|
{
^0(%arg13 : i1, %arg14 : i8, %arg15 : i8):
  %0 = "llvm.select"(%arg13, %arg14, %arg15) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %1 = llvm.sub %0, %arg14 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_sub_of_trueval_after := [llvm|
{
^0(%arg13 : i1, %arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %arg15, %arg14 : i8
  %2 = "llvm.select"(%arg13, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_sub_of_trueval_proof : t0_sub_of_trueval_before ⊑ t0_sub_of_trueval_after := by
  unfold t0_sub_of_trueval_before t0_sub_of_trueval_after
  simp_alive_peephole
  intros
  ---BEGIN t0_sub_of_trueval
  apply t0_sub_of_trueval_thm
  ---END t0_sub_of_trueval



def t1_sub_of_falseval_before := [llvm|
{
^0(%arg10 : i1, %arg11 : i8, %arg12 : i8):
  %0 = "llvm.select"(%arg10, %arg11, %arg12) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %1 = llvm.sub %0, %arg12 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_sub_of_falseval_after := [llvm|
{
^0(%arg10 : i1, %arg11 : i8, %arg12 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %arg11, %arg12 : i8
  %2 = "llvm.select"(%arg10, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_sub_of_falseval_proof : t1_sub_of_falseval_before ⊑ t1_sub_of_falseval_after := by
  unfold t1_sub_of_falseval_before t1_sub_of_falseval_after
  simp_alive_peephole
  intros
  ---BEGIN t1_sub_of_falseval
  apply t1_sub_of_falseval_thm
  ---END t1_sub_of_falseval


