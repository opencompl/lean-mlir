import SSA.Projects.InstCombine.lean.gapinthnot_proof
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
  %0 = "llvm.mlir.constant"() <{value = -1 : i33}> : () -> i33
  %1 = llvm.xor %arg0, %0 : i33
  %2 = llvm.xor %1, %0 : i33
  "llvm.return"(%2) : (i33) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i33):
  "llvm.return"(%arg0) : (i33) -> ()
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
  all_goals (try extract_goal ; sorry)
  ---END test1


