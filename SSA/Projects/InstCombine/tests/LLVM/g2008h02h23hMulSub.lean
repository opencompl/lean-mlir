import SSA.Projects.InstCombine.tests.LLVM.g2008h02h23hMulSub_proof
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
                                                                       
def test_before := [llvm|
{
^0(%arg0 : i26):
  %0 = "llvm.mlir.constant"() <{value = 2885 : i26}> : () -> i26
  %1 = "llvm.mlir.constant"() <{value = 2884 : i26}> : () -> i26
  %2 = llvm.mul %arg0, %0 : i26
  %3 = llvm.mul %arg0, %1 : i26
  %4 = llvm.sub %2, %3 : i26
  "llvm.return"(%4) : (i26) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i26):
  "llvm.return"(%arg0) : (i26) -> ()
}
]
theorem test_proof : test_before ⊑ test_after := by
  unfold test_before test_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test
  apply test_thm
  ---END test


