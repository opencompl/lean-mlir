
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
section gapinthcast_statements

def test1_before := [llvm|
{
^0(%arg1 : i17):
  %0 = llvm.mlir.constant(8 : i37) : i37
  %1 = llvm.zext %arg1 : i17 to i37
  %2 = llvm.lshr %1, %0 : i37
  %3 = llvm.shl %1, %0 : i37
  %4 = llvm.or %2, %3 : i37
  %5 = llvm.trunc %4 : i37 to i17
  "llvm.return"(%5) : (i17) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg1 : i17):
  %0 = llvm.mlir.constant(8 : i17) : i17
  %1 = llvm.lshr %arg1, %0 : i17
  %2 = llvm.shl %arg1, %0 : i17
  %3 = llvm.or %1, %2 : i17
  "llvm.return"(%3) : (i17) -> ()
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
^0(%arg0 : i167):
  %0 = llvm.mlir.constant(9 : i577) : i577
  %1 = llvm.mlir.constant(8 : i577) : i577
  %2 = llvm.zext %arg0 : i167 to i577
  %3 = llvm.lshr %2, %0 : i577
  %4 = llvm.shl %2, %1 : i577
  %5 = llvm.or %3, %4 : i577
  %6 = llvm.trunc %5 : i577 to i167
  "llvm.return"(%6) : (i167) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i167):
  %0 = llvm.mlir.constant(9 : i167) : i167
  %1 = llvm.mlir.constant(8 : i167) : i167
  %2 = llvm.lshr %arg0, %0 : i167
  %3 = llvm.shl %arg0, %1 : i167
  %4 = llvm.or %2, %3 : i167
  "llvm.return"(%4) : (i167) -> ()
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


