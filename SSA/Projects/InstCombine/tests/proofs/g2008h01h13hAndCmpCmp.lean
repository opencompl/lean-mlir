import SSA.Projects.InstCombine.tests.proofs.g2008h01h13hAndCmpCmp_proof
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
section g2008h01h13hAndCmpCmp_statements

def test_logical_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(34 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ne" %arg0, %0 : i32
  %4 = llvm.icmp "sgt" %arg0, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_logical_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(34 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "ne" %arg0, %0 : i32
  %3 = llvm.icmp "sgt" %arg0, %1 : i32
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_logical_proof : test_logical_before ⊑ test_logical_after := by
  unfold test_logical_before test_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test_logical
  apply test_logical_thm
  ---END test_logical

