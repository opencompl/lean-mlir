
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
section gselecthbitexthbitwisehops_statements

def sel_false_val_is_a_masked_shl_of_true_val1_before := [llvm|
{
^0(%arg10 : i32, %arg11 : i64):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg10, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw,nuw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg11, %5 : i64
  %8 = "llvm.select"(%6, %arg11, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def sel_false_val_is_a_masked_shl_of_true_val1_after := [llvm|
{
^0(%arg10 : i32, %arg11 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(60 : i32) : i32
  %2 = llvm.shl %arg10, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg11, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sel_false_val_is_a_masked_shl_of_true_val1_proof : sel_false_val_is_a_masked_shl_of_true_val1_before ⊑ sel_false_val_is_a_masked_shl_of_true_val1_after := by
  unfold sel_false_val_is_a_masked_shl_of_true_val1_before sel_false_val_is_a_masked_shl_of_true_val1_after
  simp_alive_peephole
  intros
  ---BEGIN sel_false_val_is_a_masked_shl_of_true_val1
  all_goals (try extract_goal ; sorry)
  ---END sel_false_val_is_a_masked_shl_of_true_val1



def sel_false_val_is_a_masked_shl_of_true_val2_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i64):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg8, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw,nuw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %4, %2 : i32
  %7 = llvm.ashr %arg9, %5 : i64
  %8 = "llvm.select"(%6, %arg9, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def sel_false_val_is_a_masked_shl_of_true_val2_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(60 : i32) : i32
  %2 = llvm.shl %arg8, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg9, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sel_false_val_is_a_masked_shl_of_true_val2_proof : sel_false_val_is_a_masked_shl_of_true_val2_before ⊑ sel_false_val_is_a_masked_shl_of_true_val2_after := by
  unfold sel_false_val_is_a_masked_shl_of_true_val2_before sel_false_val_is_a_masked_shl_of_true_val2_after
  simp_alive_peephole
  intros
  ---BEGIN sel_false_val_is_a_masked_shl_of_true_val2
  all_goals (try extract_goal ; sorry)
  ---END sel_false_val_is_a_masked_shl_of_true_val2



def sel_false_val_is_a_masked_lshr_of_true_val1_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i64):
  %0 = llvm.mlir.constant(60 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg6, %0 : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg7, %5 : i64
  %8 = "llvm.select"(%6, %arg7, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def sel_false_val_is_a_masked_lshr_of_true_val1_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.lshr %arg6, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg7, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sel_false_val_is_a_masked_lshr_of_true_val1_proof : sel_false_val_is_a_masked_lshr_of_true_val1_before ⊑ sel_false_val_is_a_masked_lshr_of_true_val1_after := by
  unfold sel_false_val_is_a_masked_lshr_of_true_val1_before sel_false_val_is_a_masked_lshr_of_true_val1_after
  simp_alive_peephole
  intros
  ---BEGIN sel_false_val_is_a_masked_lshr_of_true_val1
  all_goals (try extract_goal ; sorry)
  ---END sel_false_val_is_a_masked_lshr_of_true_val1



def sel_false_val_is_a_masked_lshr_of_true_val2_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i64):
  %0 = llvm.mlir.constant(60 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg4, %0 : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %4, %2 : i32
  %7 = llvm.ashr %arg5, %5 : i64
  %8 = "llvm.select"(%6, %arg5, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def sel_false_val_is_a_masked_lshr_of_true_val2_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.lshr %arg4, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg5, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sel_false_val_is_a_masked_lshr_of_true_val2_proof : sel_false_val_is_a_masked_lshr_of_true_val2_before ⊑ sel_false_val_is_a_masked_lshr_of_true_val2_after := by
  unfold sel_false_val_is_a_masked_lshr_of_true_val2_before sel_false_val_is_a_masked_lshr_of_true_val2_after
  simp_alive_peephole
  intros
  ---BEGIN sel_false_val_is_a_masked_lshr_of_true_val2
  all_goals (try extract_goal ; sorry)
  ---END sel_false_val_is_a_masked_lshr_of_true_val2



def sel_false_val_is_a_masked_ashr_of_true_val1_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i64):
  %0 = llvm.mlir.constant(-2147483588 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg2, %0 : i32
  %4 = llvm.ashr %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg3, %5 : i64
  %8 = "llvm.select"(%6, %arg3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def sel_false_val_is_a_masked_ashr_of_true_val1_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-536870897 : i32) : i32
  %2 = llvm.ashr %arg2, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg3, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sel_false_val_is_a_masked_ashr_of_true_val1_proof : sel_false_val_is_a_masked_ashr_of_true_val1_before ⊑ sel_false_val_is_a_masked_ashr_of_true_val1_after := by
  unfold sel_false_val_is_a_masked_ashr_of_true_val1_before sel_false_val_is_a_masked_ashr_of_true_val1_after
  simp_alive_peephole
  intros
  ---BEGIN sel_false_val_is_a_masked_ashr_of_true_val1
  all_goals (try extract_goal ; sorry)
  ---END sel_false_val_is_a_masked_ashr_of_true_val1



def sel_false_val_is_a_masked_ashr_of_true_val2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i64):
  %0 = llvm.mlir.constant(-2147483588 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.ashr %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %4, %2 : i32
  %7 = llvm.ashr %arg1, %5 : i64
  %8 = "llvm.select"(%6, %arg1, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def sel_false_val_is_a_masked_ashr_of_true_val2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-536870897 : i32) : i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg1, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sel_false_val_is_a_masked_ashr_of_true_val2_proof : sel_false_val_is_a_masked_ashr_of_true_val2_before ⊑ sel_false_val_is_a_masked_ashr_of_true_val2_after := by
  unfold sel_false_val_is_a_masked_ashr_of_true_val2_before sel_false_val_is_a_masked_ashr_of_true_val2_after
  simp_alive_peephole
  intros
  ---BEGIN sel_false_val_is_a_masked_ashr_of_true_val2
  all_goals (try extract_goal ; sorry)
  ---END sel_false_val_is_a_masked_ashr_of_true_val2


