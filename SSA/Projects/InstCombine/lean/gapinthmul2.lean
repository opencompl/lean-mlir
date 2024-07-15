import SSA.Projects.InstCombine.lean.gapinthmul2_proof
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
^0(%arg0 : i177):
  %0 = "llvm.mlir.constant"() <{value = 1 : i177}> : () -> i177
  %1 = "llvm.mlir.constant"() <{value = 155 : i177}> : () -> i177
  %2 = llvm.shl %0, %1 : i177
  %3 = llvm.mul %arg0, %2 : i177
  "llvm.return"(%3) : (i177) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i177):
  %0 = "llvm.mlir.constant"() <{value = 155 : i177}> : () -> i177
  %1 = llvm.shl %arg0, %0 : i177
  "llvm.return"(%1) : (i177) -> ()
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


