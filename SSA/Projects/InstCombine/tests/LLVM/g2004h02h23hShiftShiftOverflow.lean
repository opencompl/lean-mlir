
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
section g2004h02h23hShiftShiftOverflow_statements

def test_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(17 : i32) : i32
  %1 = llvm.ashr %arg1, %0 : i32
  %2 = llvm.ashr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.ashr %arg1, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_proof : test_before ⊑ test_after := by
  unfold test_before test_after
  simp_alive_peephole
  intros
  ---BEGIN test
  all_goals (try extract_goal ; sorry)
  ---END test



def test2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(17 : i32) : i32
  %1 = llvm.shl %arg0, %0 : i32
  %2 = llvm.shl %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
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


