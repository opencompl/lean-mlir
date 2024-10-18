
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

def missed_const_prop_2002h12h05_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
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
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem missed_const_prop_2002h12h05_proof : missed_const_prop_2002h12h05_before ⊑ missed_const_prop_2002h12h05_after := by
  unfold missed_const_prop_2002h12h05_before missed_const_prop_2002h12h05_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN missed_const_prop_2002h12h05
  all_goals (try extract_goal ; sorry)
  ---END missed_const_prop_2002h12h05


