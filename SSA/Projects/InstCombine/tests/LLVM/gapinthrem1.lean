import SSA.Projects.InstCombine.tests.LLVM.gapinthrem1_proof
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
^0(%arg0 : i33):
  %0 = "llvm.mlir.constant"() <{value = 4096 : i33}> : () -> i33
  %1 = llvm.urem %arg0, %0 : i33
  "llvm.return"(%1) : (i33) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i33):
  %0 = "llvm.mlir.constant"() <{value = 4095 : i33}> : () -> i33
  %1 = llvm.and %arg0, %0 : i33
  "llvm.return"(%1) : (i33) -> ()
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



def test2_before := [llvm|
{
^0(%arg0 : i49):
  %0 = "llvm.mlir.constant"() <{value = 4096 : i49}> : () -> i49
  %1 = "llvm.mlir.constant"() <{value = 11 : i49}> : () -> i49
  %2 = llvm.shl %0, %1 : i49
  %3 = llvm.urem %arg0, %2 : i49
  "llvm.return"(%3) : (i49) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i49):
  %0 = "llvm.mlir.constant"() <{value = 8388607 : i49}> : () -> i49
  %1 = llvm.and %arg0, %0 : i49
  "llvm.return"(%1) : (i49) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test2
  apply test2_thm
  ---END test2


