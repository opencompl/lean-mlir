import SSA.Projects.InstCombine.tests.LLVM.ghoisthnegationhouthofhbiashcalculation_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def t0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = llvm.sub %2, %arg0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.add %arg1, %0 : i8
  %3 = llvm.and %2, %arg0 : i8
  %4 = llvm.sub %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t0
  apply t0_thm
  ---END t0



def n7_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = llvm.sub %arg0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def n7_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.add %arg1, %0 : i8
  %2 = llvm.and %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem n7_proof : n7_before ⊑ n7_after := by
  unfold n7_before n7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN n7
  apply n7_thm
  ---END n7



def n9_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg2 : i8
  %2 = llvm.and %arg1, %1 : i8
  %3 = llvm.sub %2, %arg0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def n9_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg2 : i8
  %2 = llvm.and %1, %arg1 : i8
  %3 = llvm.sub %2, %arg0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem n9_proof : n9_before ⊑ n9_after := by
  unfold n9_before n9_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN n9
  all_goals (try extract_goal ; sorry)
  ---END n9


