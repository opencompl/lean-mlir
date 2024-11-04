
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
section g2008h05h31hBools_statements

def foo1_before := [llvm|
{
^0(%arg6 : i1, %arg7 : i1):
  %0 = llvm.sub %arg6, %arg7 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def foo1_after := [llvm|
{
^0(%arg6 : i1, %arg7 : i1):
  %0 = llvm.xor %arg7, %arg6 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_proof : foo1_before ⊑ foo1_after := by
  unfold foo1_before foo1_after
  simp_alive_peephole
  intros
  ---BEGIN foo1
  all_goals (try extract_goal ; sorry)
  ---END foo1



def foo2_before := [llvm|
{
^0(%arg4 : i1, %arg5 : i1):
  %0 = llvm.mul %arg4, %arg5 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def foo2_after := [llvm|
{
^0(%arg4 : i1, %arg5 : i1):
  %0 = llvm.and %arg4, %arg5 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo2_proof : foo2_before ⊑ foo2_after := by
  unfold foo2_before foo2_after
  simp_alive_peephole
  intros
  ---BEGIN foo2
  all_goals (try extract_goal ; sorry)
  ---END foo2



def foo3_before := [llvm|
{
^0(%arg2 : i1, %arg3 : i1):
  %0 = llvm.udiv %arg2, %arg3 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def foo3_after := [llvm|
{
^0(%arg2 : i1, %arg3 : i1):
  "llvm.return"(%arg2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo3_proof : foo3_before ⊑ foo3_after := by
  unfold foo3_before foo3_after
  simp_alive_peephole
  intros
  ---BEGIN foo3
  all_goals (try extract_goal ; sorry)
  ---END foo3



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
set_option debug.skipKernelTC true in
theorem foo4_proof : foo4_before ⊑ foo4_after := by
  unfold foo4_before foo4_after
  simp_alive_peephole
  intros
  ---BEGIN foo4
  all_goals (try extract_goal ; sorry)
  ---END foo4


