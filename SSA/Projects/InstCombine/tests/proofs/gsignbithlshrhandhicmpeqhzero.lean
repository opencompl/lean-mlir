import SSA.Projects.InstCombine.tests.proofs.gsignbithlshrhandhicmpeqhzero_proof
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
section gsignbithlshrhandhicmpeqhzero_statements

def scalar_i32_signbit_lshr_and_eq_X_is_constant2_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg4 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def scalar_i32_signbit_lshr_and_eq_X_is_constant2_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.icmp "ne" %arg4, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_signbit_lshr_and_eq_X_is_constant2_proof : scalar_i32_signbit_lshr_and_eq_X_is_constant2_before ⊑ scalar_i32_signbit_lshr_and_eq_X_is_constant2_after := by
  unfold scalar_i32_signbit_lshr_and_eq_X_is_constant2_before scalar_i32_signbit_lshr_and_eq_X_is_constant2_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_signbit_lshr_and_eq_X_is_constant2
  apply scalar_i32_signbit_lshr_and_eq_X_is_constant2_thm
  ---END scalar_i32_signbit_lshr_and_eq_X_is_constant2


