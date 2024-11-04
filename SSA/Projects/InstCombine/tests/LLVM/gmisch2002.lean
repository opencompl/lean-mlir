
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
section gmisch2002_statements

def cast_test_2002h08h02_before := [llvm|
{
^0(%arg1 : i64):
  %0 = llvm.trunc %arg1 : i64 to i8
  %1 = llvm.zext %0 : i8 to i64
  "llvm.return"(%1) : (i64) -> ()
}
]
def cast_test_2002h08h02_after := [llvm|
{
^0(%arg1 : i64):
  %0 = llvm.mlir.constant(255) : i64
  %1 = llvm.and %arg1, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem cast_test_2002h08h02_proof : cast_test_2002h08h02_before ⊑ cast_test_2002h08h02_after := by
  unfold cast_test_2002h08h02_before cast_test_2002h08h02_after
  simp_alive_peephole
  intros
  ---BEGIN cast_test_2002h08h02
  all_goals (try extract_goal ; sorry)
  ---END cast_test_2002h08h02



def missed_const_prop_2002h12h05_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.sub %0, %1 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.add %arg0, %4 : i32
  %6 = llvm.add %2, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def missed_const_prop_2002h12h05_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem missed_const_prop_2002h12h05_proof : missed_const_prop_2002h12h05_before ⊑ missed_const_prop_2002h12h05_after := by
  unfold missed_const_prop_2002h12h05_before missed_const_prop_2002h12h05_after
  simp_alive_peephole
  intros
  ---BEGIN missed_const_prop_2002h12h05
  all_goals (try extract_goal ; sorry)
  ---END missed_const_prop_2002h12h05


