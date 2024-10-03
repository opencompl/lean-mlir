
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
section gapinthrem1_statements
                                                    
def test1_before := [llvm|
{
^0(%arg3 : i33):
  %0 = "llvm.mlir.constant"() <{value = 4096 : i33}> : () -> i33
  %1 = llvm.urem %arg3, %0 : i33
  "llvm.return"(%1) : (i33) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg3 : i33):
  %0 = "llvm.mlir.constant"() <{value = 4095 : i33}> : () -> i33
  %1 = llvm.and %arg3, %0 : i33
  "llvm.return"(%1) : (i33) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg2 : i49):
  %0 = "llvm.mlir.constant"() <{value = 4096 : i49}> : () -> i49
  %1 = "llvm.mlir.constant"() <{value = 11 : i49}> : () -> i49
  %2 = llvm.shl %0, %1 : i49
  %3 = llvm.urem %arg2, %2 : i49
  "llvm.return"(%3) : (i49) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg2 : i49):
  %0 = "llvm.mlir.constant"() <{value = 8388607 : i49}> : () -> i49
  %1 = llvm.and %arg2, %0 : i49
  "llvm.return"(%1) : (i49) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2


