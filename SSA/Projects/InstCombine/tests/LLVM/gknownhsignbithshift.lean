
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
section gknownhsignbithshift_statements

def test_shift_nonnegative_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %arg4, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.icmp "sge" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_shift_nonnegative_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shift_nonnegative_proof : test_shift_nonnegative_before ⊑ test_shift_nonnegative_after := by
  unfold test_shift_nonnegative_before test_shift_nonnegative_after
  simp_alive_peephole
  intros
  ---BEGIN test_shift_nonnegative
  all_goals (try extract_goal ; sorry)
  ---END test_shift_nonnegative



def test_shift_negative_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.or %arg2, %0 : i32
  %4 = llvm.and %arg3, %1 : i32
  %5 = llvm.shl %3, %4 overflow<nsw> : i32
  %6 = llvm.icmp "slt" %5, %2 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
def test_shift_negative_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shift_negative_proof : test_shift_negative_before ⊑ test_shift_negative_after := by
  unfold test_shift_negative_before test_shift_negative_after
  simp_alive_peephole
  intros
  ---BEGIN test_shift_negative
  all_goals (try extract_goal ; sorry)
  ---END test_shift_negative


