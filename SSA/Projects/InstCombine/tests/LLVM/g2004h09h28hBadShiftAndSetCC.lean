
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
section g2004h09h28hBadShiftAndSetCC_statements

def test_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-16777216 : i32) : i32
  %2 = llvm.mlir.constant(167772160 : i32) : i32
  %3 = llvm.shl %arg0, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(16711680 : i32) : i32
  %1 = llvm.mlir.constant(655360 : i32) : i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
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


