
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
section gapinthshifthsimplify_statements

def test0_before := [llvm|
{
^0(%arg6 : i41, %arg7 : i41, %arg8 : i41):
  %0 = llvm.shl %arg6, %arg8 : i41
  %1 = llvm.shl %arg7, %arg8 : i41
  %2 = llvm.and %0, %1 : i41
  "llvm.return"(%2) : (i41) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg6 : i41, %arg7 : i41, %arg8 : i41):
  %0 = llvm.and %arg6, %arg7 : i41
  %1 = llvm.shl %0, %arg8 : i41
  "llvm.return"(%1) : (i41) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test0_proof : test0_before ⊑ test0_after := by
  unfold test0_before test0_after
  simp_alive_peephole
  intros
  ---BEGIN test0
  all_goals (try extract_goal ; sorry)
  ---END test0



def test1_before := [llvm|
{
^0(%arg3 : i57, %arg4 : i57, %arg5 : i57):
  %0 = llvm.lshr %arg3, %arg5 : i57
  %1 = llvm.lshr %arg4, %arg5 : i57
  %2 = llvm.or %0, %1 : i57
  "llvm.return"(%2) : (i57) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg3 : i57, %arg4 : i57, %arg5 : i57):
  %0 = llvm.or %arg3, %arg4 : i57
  %1 = llvm.lshr %0, %arg5 : i57
  "llvm.return"(%1) : (i57) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg0 : i49, %arg1 : i49, %arg2 : i49):
  %0 = llvm.ashr %arg0, %arg2 : i49
  %1 = llvm.ashr %arg1, %arg2 : i49
  %2 = llvm.xor %0, %1 : i49
  "llvm.return"(%2) : (i49) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i49, %arg1 : i49, %arg2 : i49):
  %0 = llvm.xor %arg0, %arg1 : i49
  %1 = llvm.ashr %0, %arg2 : i49
  "llvm.return"(%1) : (i49) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2


