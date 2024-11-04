
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
section gapinthnot_statements

def test1_before := [llvm|
{
^0(%arg2 : i33):
  %0 = llvm.mlir.constant(-1 : i33) : i33
  %1 = llvm.xor %arg2, %0 : i33
  %2 = llvm.xor %1, %0 : i33
  "llvm.return"(%2) : (i33) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg2 : i33):
  "llvm.return"(%arg2) : (i33) -> ()
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
^0(%arg0 : i52, %arg1 : i52):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "ule" %arg0, %arg1 : i52
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i52, %arg1 : i52):
  %0 = llvm.icmp "ugt" %arg0, %arg1 : i52
  "llvm.return"(%0) : (i1) -> ()
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


