import SSA.Projects.InstCombine.tests.proofs.gmulhpow2_proof
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
section gmulhpow2_statements

def mul_selectp2_x_before := [llvm|
{
^0(%arg22 : i8, %arg23 : i1):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = "llvm.select"(%arg23, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.mul %2, %arg22 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def mul_selectp2_x_after := [llvm|
{
^0(%arg22 : i8, %arg23 : i1):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = "llvm.select"(%arg23, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.shl %arg22, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_selectp2_x_proof : mul_selectp2_x_before ⊑ mul_selectp2_x_after := by
  unfold mul_selectp2_x_before mul_selectp2_x_after
  simp_alive_peephole
  intros
  ---BEGIN mul_selectp2_x
  apply mul_selectp2_x_thm
  ---END mul_selectp2_x



def mul_selectp2_x_propegate_nuw_before := [llvm|
{
^0(%arg20 : i8, %arg21 : i1):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = "llvm.select"(%arg21, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.mul %2, %arg20 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def mul_selectp2_x_propegate_nuw_after := [llvm|
{
^0(%arg20 : i8, %arg21 : i1):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = "llvm.select"(%arg21, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.shl %arg20, %2 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_selectp2_x_propegate_nuw_proof : mul_selectp2_x_propegate_nuw_before ⊑ mul_selectp2_x_propegate_nuw_after := by
  unfold mul_selectp2_x_propegate_nuw_before mul_selectp2_x_propegate_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN mul_selectp2_x_propegate_nuw
  apply mul_selectp2_x_propegate_nuw_thm
  ---END mul_selectp2_x_propegate_nuw



def mul_selectp2_x_non_const_before := [llvm|
{
^0(%arg15 : i8, %arg16 : i1, %arg17 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.shl %0, %arg17 : i8
  %3 = "llvm.select"(%arg16, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.mul %3, %arg15 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def mul_selectp2_x_non_const_after := [llvm|
{
^0(%arg15 : i8, %arg16 : i1, %arg17 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = "llvm.select"(%arg16, %0, %arg17) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %2 = llvm.shl %arg15, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_selectp2_x_non_const_proof : mul_selectp2_x_non_const_before ⊑ mul_selectp2_x_non_const_after := by
  unfold mul_selectp2_x_non_const_before mul_selectp2_x_non_const_after
  simp_alive_peephole
  intros
  ---BEGIN mul_selectp2_x_non_const
  apply mul_selectp2_x_non_const_thm
  ---END mul_selectp2_x_non_const



def mul_x_selectp2_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i1):
  %0 = llvm.mlir.constant(8 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mul %arg10, %arg10 : i8
  %3 = "llvm.select"(%arg11, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.mul %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def mul_x_selectp2_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i1):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mul %arg10, %arg10 : i8
  %3 = "llvm.select"(%arg11, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.shl %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_x_selectp2_proof : mul_x_selectp2_before ⊑ mul_x_selectp2_after := by
  unfold mul_x_selectp2_before mul_x_selectp2_after
  simp_alive_peephole
  intros
  ---BEGIN mul_x_selectp2
  apply mul_x_selectp2_thm
  ---END mul_x_selectp2



def shl_add_log_may_cause_poison_pr62175_with_nuw_before := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.shl %0, %arg2 overflow<nuw> : i8
  %2 = llvm.mul %arg3, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl_add_log_may_cause_poison_pr62175_with_nuw_after := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.add %arg2, %0 : i8
  %2 = llvm.shl %arg3, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_log_may_cause_poison_pr62175_with_nuw_proof : shl_add_log_may_cause_poison_pr62175_with_nuw_before ⊑ shl_add_log_may_cause_poison_pr62175_with_nuw_after := by
  unfold shl_add_log_may_cause_poison_pr62175_with_nuw_before shl_add_log_may_cause_poison_pr62175_with_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_log_may_cause_poison_pr62175_with_nuw
  apply shl_add_log_may_cause_poison_pr62175_with_nuw_thm
  ---END shl_add_log_may_cause_poison_pr62175_with_nuw



def shl_add_log_may_cause_poison_pr62175_with_nsw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.shl %0, %arg0 overflow<nsw> : i8
  %2 = llvm.mul %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl_add_log_may_cause_poison_pr62175_with_nsw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.shl %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_log_may_cause_poison_pr62175_with_nsw_proof : shl_add_log_may_cause_poison_pr62175_with_nsw_before ⊑ shl_add_log_may_cause_poison_pr62175_with_nsw_after := by
  unfold shl_add_log_may_cause_poison_pr62175_with_nsw_before shl_add_log_may_cause_poison_pr62175_with_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_log_may_cause_poison_pr62175_with_nsw
  apply shl_add_log_may_cause_poison_pr62175_with_nsw_thm
  ---END shl_add_log_may_cause_poison_pr62175_with_nsw


