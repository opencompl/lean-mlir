
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
section gapinthandhxorhmerge_statements

def test1_before := [llvm|
{
^0(%arg3 : i57, %arg4 : i57, %arg5 : i57):
  %0 = llvm.and %arg5, %arg3 : i57
  %1 = llvm.and %arg5, %arg4 : i57
  %2 = llvm.xor %0, %1 : i57
  "llvm.return"(%2) : (i57) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg3 : i57, %arg4 : i57, %arg5 : i57):
  %0 = llvm.xor %arg3, %arg4 : i57
  %1 = llvm.and %arg5, %0 : i57
  "llvm.return"(%1) : (i57) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg0 : i23, %arg1 : i23, %arg2 : i23):
  %0 = llvm.and %arg1, %arg0 : i23
  %1 = llvm.or %arg1, %arg0 : i23
  %2 = llvm.xor %0, %1 : i23
  "llvm.return"(%2) : (i23) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i23, %arg1 : i23, %arg2 : i23):
  %0 = llvm.xor %arg1, %arg0 : i23
  "llvm.return"(%0) : (i23) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2


