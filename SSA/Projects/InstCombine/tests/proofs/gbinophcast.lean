import SSA.Projects.InstCombine.tests.proofs.gbinophcast_proof
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
section gbinophcast_statements

def and_sext_to_sel_before := [llvm|
{
^0(%arg41 : i32, %arg42 : i1):
  %0 = llvm.sext %arg42 : i1 to i32
  %1 = llvm.and %0, %arg41 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def and_sext_to_sel_after := [llvm|
{
^0(%arg41 : i32, %arg42 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = "llvm.select"(%arg42, %arg41, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_sext_to_sel_proof : and_sext_to_sel_before ⊑ and_sext_to_sel_after := by
  unfold and_sext_to_sel_before and_sext_to_sel_after
  simp_alive_peephole
  intros
  ---BEGIN and_sext_to_sel
  apply and_sext_to_sel_thm
  ---END and_sext_to_sel



def or_sext_to_sel_before := [llvm|
{
^0(%arg25 : i32, %arg26 : i1):
  %0 = llvm.sext %arg26 : i1 to i32
  %1 = llvm.or %0, %arg25 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def or_sext_to_sel_after := [llvm|
{
^0(%arg25 : i32, %arg26 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = "llvm.select"(%arg26, %0, %arg25) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_sext_to_sel_proof : or_sext_to_sel_before ⊑ or_sext_to_sel_after := by
  unfold or_sext_to_sel_before or_sext_to_sel_after
  simp_alive_peephole
  intros
  ---BEGIN or_sext_to_sel
  apply or_sext_to_sel_thm
  ---END or_sext_to_sel



def xor_sext_to_sel_before := [llvm|
{
^0(%arg17 : i32, %arg18 : i1):
  %0 = llvm.sext %arg18 : i1 to i32
  %1 = llvm.xor %0, %arg17 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def xor_sext_to_sel_after := [llvm|
{
^0(%arg17 : i32, %arg18 : i1):
  %0 = llvm.sext %arg18 : i1 to i32
  %1 = llvm.xor %arg17, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_sext_to_sel_proof : xor_sext_to_sel_before ⊑ xor_sext_to_sel_after := by
  unfold xor_sext_to_sel_before xor_sext_to_sel_after
  simp_alive_peephole
  intros
  ---BEGIN xor_sext_to_sel
  apply xor_sext_to_sel_thm
  ---END xor_sext_to_sel



def and_add_bool_to_select_before := [llvm|
{
^0(%arg5 : i1, %arg6 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.zext %arg5 : i1 to i32
  %2 = llvm.add %0, %1 : i32
  %3 = llvm.and %2, %arg6 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_add_bool_to_select_after := [llvm|
{
^0(%arg5 : i1, %arg6 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = "llvm.select"(%arg5, %0, %arg6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_add_bool_to_select_proof : and_add_bool_to_select_before ⊑ and_add_bool_to_select_after := by
  unfold and_add_bool_to_select_before and_add_bool_to_select_after
  simp_alive_peephole
  intros
  ---BEGIN and_add_bool_to_select
  apply and_add_bool_to_select_thm
  ---END and_add_bool_to_select



def and_add_bool_no_fold_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg4, %0 : i32
  %3 = llvm.add %1, %2 : i32
  %4 = llvm.and %3, %arg4 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_add_bool_no_fold_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg4, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = "llvm.select"(%3, %arg4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_add_bool_no_fold_proof : and_add_bool_no_fold_before ⊑ and_add_bool_no_fold_after := by
  unfold and_add_bool_no_fold_before and_add_bool_no_fold_after
  simp_alive_peephole
  intros
  ---BEGIN and_add_bool_no_fold
  apply and_add_bool_no_fold_thm
  ---END and_add_bool_no_fold



def and_add_bool_to_select_multi_use_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.zext %arg0 : i1 to i32
  %2 = llvm.add %0, %1 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_add_bool_to_select_multi_use_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.add %arg1, %0 : i32
  %3 = "llvm.select"(%arg0, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_add_bool_to_select_multi_use_proof : and_add_bool_to_select_multi_use_before ⊑ and_add_bool_to_select_multi_use_after := by
  unfold and_add_bool_to_select_multi_use_before and_add_bool_to_select_multi_use_after
  simp_alive_peephole
  intros
  ---BEGIN and_add_bool_to_select_multi_use
  apply and_add_bool_to_select_multi_use_thm
  ---END and_add_bool_to_select_multi_use


