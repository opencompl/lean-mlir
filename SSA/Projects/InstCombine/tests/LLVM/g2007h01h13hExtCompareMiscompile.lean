
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
section g2007h01h13hExtCompareMiscompile_statements

def test_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.zext %arg0 : i8 to i32
  %1 = llvm.zext %arg1 : i8 to i32
  %2 = llvm.icmp "sgt" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.icmp "ugt" %arg0, %arg1 : i8
  "llvm.return"(%0) : (i1) -> ()
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


