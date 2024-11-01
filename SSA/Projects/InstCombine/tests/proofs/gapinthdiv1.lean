import SSA.Projects.InstCombine.tests.proofs.gapinthdiv1_proof
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
section gapinthdiv1_statements

def test1_before := [llvm|
{
^0(%arg3 : i33):
  %0 = llvm.mlir.constant(4096 : i33) : i33
  %1 = llvm.udiv %arg3, %0 : i33
  "llvm.return"(%1) : (i33) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg3 : i33):
  %0 = llvm.mlir.constant(12 : i33) : i33
  %1 = llvm.lshr %arg3, %0 : i33
  "llvm.return"(%1) : (i33) -> ()
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
^0(%arg2 : i49):
  %0 = llvm.mlir.constant(4096 : i49) : i49
  %1 = llvm.mlir.constant(17 : i49) : i49
  %2 = llvm.shl %0, %1 : i49
  %3 = llvm.udiv %arg2, %2 : i49
  "llvm.return"(%3) : (i49) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg2 : i49):
  %0 = llvm.mlir.constant(29 : i49) : i49
  %1 = llvm.lshr %arg2, %0 : i49
  "llvm.return"(%1) : (i49) -> ()
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
^0(%arg0 : i59, %arg1 : i1):
  %0 = llvm.mlir.constant(1024 : i59) : i59
  %1 = llvm.mlir.constant(4096 : i59) : i59
  %2 = "llvm.select"(%arg1, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i59, i59) -> i59
  %3 = llvm.udiv %arg0, %2 : i59
  "llvm.return"(%3) : (i59) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i59, %arg1 : i1):
  %0 = llvm.mlir.constant(10 : i59) : i59
  %1 = llvm.mlir.constant(12 : i59) : i59
  %2 = "llvm.select"(%arg1, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i59, i59) -> i59
  %3 = llvm.lshr %arg0, %2 : i59
  "llvm.return"(%3) : (i59) -> ()
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


