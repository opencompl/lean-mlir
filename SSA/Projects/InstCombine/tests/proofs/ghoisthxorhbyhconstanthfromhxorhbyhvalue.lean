import SSA.Projects.InstCombine.tests.proofs.ghoisthxorhbyhconstanthfromhxorhbyhvalue_proof
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
section ghoisthxorhbyhconstanthfromhxorhbyhvalue_statements

def t0_scalar_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.xor %arg10, %0 : i8
  %2 = llvm.xor %1, %arg11 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t0_scalar_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.xor %arg10, %arg11 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t0_scalar_proof : t0_scalar_before ⊑ t0_scalar_after := by
  unfold t0_scalar_before t0_scalar_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN t0_scalar
  apply t0_scalar_thm
  ---END t0_scalar


