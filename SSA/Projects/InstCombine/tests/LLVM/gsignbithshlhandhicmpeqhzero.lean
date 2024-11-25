
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
section gsignbithshlhandhicmpeqhzero_statements

def scalar_i32_signbit_shl_and_eq_X_is_constant1_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(12345 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg5 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def scalar_i32_signbit_shl_and_eq_X_is_constant1_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_signbit_shl_and_eq_X_is_constant1_proof : scalar_i32_signbit_shl_and_eq_X_is_constant1_before ⊑ scalar_i32_signbit_shl_and_eq_X_is_constant1_after := by
  unfold scalar_i32_signbit_shl_and_eq_X_is_constant1_before scalar_i32_signbit_shl_and_eq_X_is_constant1_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_signbit_shl_and_eq_X_is_constant1
  all_goals (try extract_goal ; sorry)
  ---END scalar_i32_signbit_shl_and_eq_X_is_constant1



def scalar_i32_signbit_shl_and_eq_X_is_constant2_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg4 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def scalar_i32_signbit_shl_and_eq_X_is_constant2_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_signbit_shl_and_eq_X_is_constant2_proof : scalar_i32_signbit_shl_and_eq_X_is_constant2_before ⊑ scalar_i32_signbit_shl_and_eq_X_is_constant2_after := by
  unfold scalar_i32_signbit_shl_and_eq_X_is_constant2_before scalar_i32_signbit_shl_and_eq_X_is_constant2_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_signbit_shl_and_eq_X_is_constant2
  all_goals (try extract_goal ; sorry)
  ---END scalar_i32_signbit_shl_and_eq_X_is_constant2



def scalar_i32_signbit_shl_and_slt_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg3 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.icmp "slt" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_signbit_shl_and_slt_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg3 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_signbit_shl_and_slt_proof : scalar_i32_signbit_shl_and_slt_before ⊑ scalar_i32_signbit_shl_and_slt_after := by
  unfold scalar_i32_signbit_shl_and_slt_before scalar_i32_signbit_shl_and_slt_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_signbit_shl_and_slt
  all_goals (try extract_goal ; sorry)
  ---END scalar_i32_signbit_shl_and_slt



def scalar_i32_signbit_shl_and_eq_nonzero_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.shl %0, %arg1 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_signbit_shl_and_eq_nonzero_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_signbit_shl_and_eq_nonzero_proof : scalar_i32_signbit_shl_and_eq_nonzero_before ⊑ scalar_i32_signbit_shl_and_eq_nonzero_after := by
  unfold scalar_i32_signbit_shl_and_eq_nonzero_before scalar_i32_signbit_shl_and_eq_nonzero_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_signbit_shl_and_eq_nonzero
  all_goals (try extract_goal ; sorry)
  ---END scalar_i32_signbit_shl_and_eq_nonzero


