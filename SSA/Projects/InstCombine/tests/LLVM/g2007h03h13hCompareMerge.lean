
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
section g2007h03h13hCompareMerge_statements

def test_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.icmp "slt" %arg2, %arg3 : i32
  %1 = llvm.icmp "eq" %arg2, %arg3 : i32
  %2 = llvm.or %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.icmp "sle" %arg2, %arg3 : i32
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



def test_logical_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "slt" %arg0, %arg1 : i32
  %2 = llvm.icmp "eq" %arg0, %arg1 : i32
  %3 = "llvm.select"(%1, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_logical_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.icmp "sle" %arg0, %arg1 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_logical_proof : test_logical_before ⊑ test_logical_after := by
  unfold test_logical_before test_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test_logical
  all_goals (try extract_goal ; sorry)
  ---END test_logical


