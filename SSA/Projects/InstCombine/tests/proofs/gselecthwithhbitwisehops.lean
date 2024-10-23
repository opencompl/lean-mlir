import SSA.Projects.InstCombine.tests.proofs.gselecthwithhbitwisehops_proof
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
section gselecthwithhbitwisehops_statements

def set_bits_before := [llvm|
{
^0(%arg26 : i8, %arg27 : i1):
  %0 = "llvm.mlir.constant"() <{value = -6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %2 = llvm.and %arg26, %0 : i8
  %3 = llvm.or %arg26, %1 : i8
  %4 = "llvm.select"(%arg27, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def set_bits_after := [llvm|
{
^0(%arg26 : i8, %arg27 : i1):
  %0 = "llvm.mlir.constant"() <{value = -6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %3 = llvm.and %arg26, %0 : i8
  %4 = "llvm.select"(%arg27, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.or %3, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem set_bits_proof : set_bits_before ⊑ set_bits_after := by
  unfold set_bits_before set_bits_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN set_bits
  apply set_bits_thm
  ---END set_bits


