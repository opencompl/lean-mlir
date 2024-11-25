
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
section gpr17827_statements

def test_shift_and_cmp_changed1_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(8 : i8) : i8
  %2 = llvm.mlir.constant(5 : i8) : i8
  %3 = llvm.mlir.constant(1 : i8) : i8
  %4 = llvm.and %arg6, %0 : i8
  %5 = llvm.and %arg7, %1 : i8
  %6 = llvm.or %5, %4 : i8
  %7 = llvm.shl %6, %2 : i8
  %8 = llvm.ashr %7, %2 : i8
  %9 = llvm.icmp "slt" %8, %3 : i8
  "llvm.return"(%9) : (i1) -> ()
}
]
def test_shift_and_cmp_changed1_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-64 : i8) : i8
  %2 = llvm.mlir.constant(32 : i8) : i8
  %3 = llvm.shl %arg6, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "slt" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shift_and_cmp_changed1_proof : test_shift_and_cmp_changed1_before ⊑ test_shift_and_cmp_changed1_after := by
  unfold test_shift_and_cmp_changed1_before test_shift_and_cmp_changed1_after
  simp_alive_peephole
  intros
  ---BEGIN test_shift_and_cmp_changed1
  all_goals (try extract_goal ; sorry)
  ---END test_shift_and_cmp_changed1



def test_shift_and_cmp_changed2_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-64 : i8) : i8
  %2 = llvm.mlir.constant(32 : i8) : i8
  %3 = llvm.shl %arg3, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "ult" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_shift_and_cmp_changed2_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg3, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shift_and_cmp_changed2_proof : test_shift_and_cmp_changed2_before ⊑ test_shift_and_cmp_changed2_after := by
  unfold test_shift_and_cmp_changed2_before test_shift_and_cmp_changed2_after
  simp_alive_peephole
  intros
  ---BEGIN test_shift_and_cmp_changed2
  all_goals (try extract_goal ; sorry)
  ---END test_shift_and_cmp_changed2



def test_shift_and_cmp_changed4_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-64 : i8) : i8
  %2 = llvm.mlir.constant(32 : i8) : i8
  %3 = llvm.lshr %arg0, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "slt" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_shift_and_cmp_changed4_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shift_and_cmp_changed4_proof : test_shift_and_cmp_changed4_before ⊑ test_shift_and_cmp_changed4_after := by
  unfold test_shift_and_cmp_changed4_before test_shift_and_cmp_changed4_after
  simp_alive_peephole
  intros
  ---BEGIN test_shift_and_cmp_changed4
  all_goals (try extract_goal ; sorry)
  ---END test_shift_and_cmp_changed4


