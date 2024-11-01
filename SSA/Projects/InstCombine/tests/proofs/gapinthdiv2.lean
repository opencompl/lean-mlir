import SSA.Projects.InstCombine.tests.proofs.gapinthdiv2_proof
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
section gapinthdiv2_statements

def test1_before := [llvm|
{
^0(%arg3 : i333):
  %0 = llvm.mlir.constant(70368744177664 : i333) : i333
  %1 = llvm.udiv %arg3, %0 : i333
  "llvm.return"(%1) : (i333) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg3 : i333):
  %0 = llvm.mlir.constant(46 : i333) : i333
  %1 = llvm.lshr %arg3, %0 : i333
  "llvm.return"(%1) : (i333) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  apply test1_thm
  ---END test1



def test2_before := [llvm|
{
^0(%arg2 : i499):
  %0 = llvm.mlir.constant(4096 : i499) : i499
  %1 = llvm.mlir.constant(197 : i499) : i499
  %2 = llvm.shl %0, %1 : i499
  %3 = llvm.udiv %arg2, %2 : i499
  "llvm.return"(%3) : (i499) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg2 : i499):
  %0 = llvm.mlir.constant(209 : i499) : i499
  %1 = llvm.lshr %arg2, %0 : i499
  "llvm.return"(%1) : (i499) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  apply test2_thm
  ---END test2



def test3_before := [llvm|
{
^0(%arg0 : i599, %arg1 : i1):
  %0 = llvm.mlir.constant(70368744177664 : i599) : i599
  %1 = llvm.mlir.constant(4096 : i599) : i599
  %2 = "llvm.select"(%arg1, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i599, i599) -> i599
  %3 = llvm.udiv %arg0, %2 : i599
  "llvm.return"(%3) : (i599) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i599, %arg1 : i1):
  %0 = llvm.mlir.constant(46 : i599) : i599
  %1 = llvm.mlir.constant(12 : i599) : i599
  %2 = "llvm.select"(%arg1, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i599, i599) -> i599
  %3 = llvm.lshr %arg0, %2 : i599
  "llvm.return"(%3) : (i599) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  intros
  ---BEGIN test3
  apply test3_thm
  ---END test3


