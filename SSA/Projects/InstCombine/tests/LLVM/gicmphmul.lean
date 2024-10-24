
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
section gicmphmul_statements

def mul_of_pow2s_before := [llvm|
{
^0(%arg79 : i32, %arg80 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %3 = llvm.and %arg79, %0 : i32
  %4 = llvm.and %arg80, %1 : i32
  %5 = llvm.mul %3, %4 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def mul_of_pow2s_after := [llvm|
{
^0(%arg79 : i32, %arg80 : i32):
  %0 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem mul_of_pow2s_proof : mul_of_pow2s_before ⊑ mul_of_pow2s_after := by
  unfold mul_of_pow2s_before mul_of_pow2s_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN mul_of_pow2s
  all_goals (try extract_goal ; sorry)
  ---END mul_of_pow2s


