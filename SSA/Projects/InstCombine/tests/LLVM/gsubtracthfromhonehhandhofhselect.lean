
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
section gsubtracthfromhonehhandhofhselect_statements

def t0_sub_from_trueval_before := [llvm|
{
^0(%arg13 : i1, %arg14 : i8, %arg15 : i8):
  %0 = "llvm.select"(%arg13, %arg14, %arg15) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %1 = llvm.sub %arg14, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_sub_from_trueval_after := [llvm|
{
^0(%arg13 : i1, %arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %arg14, %arg15 : i8
  %2 = "llvm.select"(%arg13, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_sub_from_trueval_proof : t0_sub_from_trueval_before ⊑ t0_sub_from_trueval_after := by
  unfold t0_sub_from_trueval_before t0_sub_from_trueval_after
  simp_alive_peephole
  intros
  ---BEGIN t0_sub_from_trueval
  all_goals (try extract_goal ; sorry)
  ---END t0_sub_from_trueval



def t1_sub_from_falseval_before := [llvm|
{
^0(%arg10 : i1, %arg11 : i8, %arg12 : i8):
  %0 = "llvm.select"(%arg10, %arg11, %arg12) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %1 = llvm.sub %arg12, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_sub_from_falseval_after := [llvm|
{
^0(%arg10 : i1, %arg11 : i8, %arg12 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %arg12, %arg11 : i8
  %2 = "llvm.select"(%arg10, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_sub_from_falseval_proof : t1_sub_from_falseval_before ⊑ t1_sub_from_falseval_after := by
  unfold t1_sub_from_falseval_before t1_sub_from_falseval_after
  simp_alive_peephole
  intros
  ---BEGIN t1_sub_from_falseval
  all_goals (try extract_goal ; sorry)
  ---END t1_sub_from_falseval


