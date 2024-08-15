import SSA.Projects.InstCombine.tests.LLVM.g2008h05h31hBools_proof
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
                                                                       
def foo1_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.sub %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def foo1_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.xor %arg1, %arg0 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem foo1_proof : foo1_before ⊑ foo1_after := by
  unfold foo1_before foo1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN foo1
  all_goals (try extract_goal ; sorry)
  ---END foo1



def foo2_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.mul %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def foo2_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.and %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem foo2_proof : foo2_before ⊑ foo2_after := by
  unfold foo2_before foo2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN foo2
  all_goals (try extract_goal ; sorry)
  ---END foo2



def foo4_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.sdiv %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def foo4_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  "llvm.return"(%arg0) : (i1) -> ()
}
]
theorem foo4_proof : foo4_before ⊑ foo4_after := by
  unfold foo4_before foo4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN foo4
  apply foo4_thm
  ---END foo4


