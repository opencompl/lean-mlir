import SSA.Projects.InstCombine.tests.proofs.gxorhofhor_proof
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
section gxorhofhor_statements

def t1_before := [llvm|
{
^0(%arg12 : i4):
  %0 = "llvm.mlir.constant"() <{value = -4 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = -6 : i4}> : () -> i4
  %2 = llvm.or %arg12, %0 : i4
  %3 = llvm.xor %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg12 : i4):
  %0 = "llvm.mlir.constant"() <{value = 3 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 6 : i4}> : () -> i4
  %2 = llvm.and %arg12, %0 : i4
  %3 = llvm.xor %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem t1_proof : t1_before ⊑ t1_after := by
  unfold t1_before t1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN t1
  apply t1_thm
  ---END t1

