
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
section gdivhi1_statements

def sdiv_i1_is_op0_before := [llvm|
{
^0(%arg6 : i1, %arg7 : i1):
  %0 = llvm.sdiv %arg6, %arg7 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def sdiv_i1_is_op0_after := [llvm|
{
^0(%arg6 : i1, %arg7 : i1):
  "llvm.return"(%arg6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_i1_is_op0_proof : sdiv_i1_is_op0_before ⊑ sdiv_i1_is_op0_after := by
  unfold sdiv_i1_is_op0_before sdiv_i1_is_op0_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_i1_is_op0
  all_goals (try extract_goal ; sorry)
  ---END sdiv_i1_is_op0



def udiv_i1_is_op0_before := [llvm|
{
^0(%arg4 : i1, %arg5 : i1):
  %0 = llvm.udiv %arg4, %arg5 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def udiv_i1_is_op0_after := [llvm|
{
^0(%arg4 : i1, %arg5 : i1):
  "llvm.return"(%arg4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_i1_is_op0_proof : udiv_i1_is_op0_before ⊑ udiv_i1_is_op0_after := by
  unfold udiv_i1_is_op0_before udiv_i1_is_op0_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_i1_is_op0
  all_goals (try extract_goal ; sorry)
  ---END udiv_i1_is_op0



def srem_i1_is_zero_before := [llvm|
{
^0(%arg2 : i1, %arg3 : i1):
  %0 = llvm.srem %arg2, %arg3 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def srem_i1_is_zero_after := [llvm|
{
^0(%arg2 : i1, %arg3 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem srem_i1_is_zero_proof : srem_i1_is_zero_before ⊑ srem_i1_is_zero_after := by
  unfold srem_i1_is_zero_before srem_i1_is_zero_after
  simp_alive_peephole
  intros
  ---BEGIN srem_i1_is_zero
  all_goals (try extract_goal ; sorry)
  ---END srem_i1_is_zero



def urem_i1_is_zero_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.urem %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def urem_i1_is_zero_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_i1_is_zero_proof : urem_i1_is_zero_before ⊑ urem_i1_is_zero_after := by
  unfold urem_i1_is_zero_before urem_i1_is_zero_after
  simp_alive_peephole
  intros
  ---BEGIN urem_i1_is_zero
  all_goals (try extract_goal ; sorry)
  ---END urem_i1_is_zero


