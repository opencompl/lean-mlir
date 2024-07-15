import SSA.Projects.InstCombine.lean.gsremhcanonicalize_proof
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

def test_srem_canonicalize_op0_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  %2 = llvm.srem %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_srem_canonicalize_op0_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = llvm.srem %arg0, %arg1 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]

theorem test_srem_canonicalize_op0_proof : test_srem_canonicalize_op0_before ⊑ test_srem_canonicalize_op0_after := by
  unfold test_srem_canonicalize_op0_before test_srem_canonicalize_op0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test_srem_canonicalize_op0
  apply test_srem_canonicalize_op0_thm
  ---END test_srem_canonicalize_op0
