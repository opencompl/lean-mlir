import SSA.Projects.InstCombine.tests.LLVM.gapinthmul1_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def test1_before := [llvm|
{
^0(%arg0 : i17):
  %0 = "llvm.mlir.constant"() <{value = 1024 : i17}> : () -> i17
  %1 = llvm.mul %arg0, %0 : i17
  "llvm.return"(%1) : (i17) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i17):
  %0 = "llvm.mlir.constant"() <{value = 10 : i17}> : () -> i17
  %1 = llvm.shl %arg0, %0 : i17
  "llvm.return"(%1) : (i17) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test1
  apply test1_thm
  ---END test1


