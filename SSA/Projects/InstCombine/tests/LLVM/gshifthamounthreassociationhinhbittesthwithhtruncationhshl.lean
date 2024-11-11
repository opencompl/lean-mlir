
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
section gshifthamounthreassociationhinhbittesthwithhtruncationhshl_statements

def t0_const_after_fold_lshr_shl_ne_before := [llvm|
{
^0(%arg43 : i32, %arg44 : i64, %arg45 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg45 : i32
  %4 = llvm.lshr %arg43, %3 : i32
  %5 = llvm.add %arg45, %1 : i32
  %6 = llvm.zext %5 : i32 to i64
  %7 = llvm.shl %arg44, %6 : i64
  %8 = llvm.trunc %7 : i64 to i32
  %9 = llvm.and %4, %8 : i32
  %10 = llvm.icmp "ne" %9, %2 : i32
  "llvm.return"(%10) : (i1) -> ()
}
]
def t0_const_after_fold_lshr_shl_ne_after := [llvm|
{
^0(%arg43 : i32, %arg44 : i64, %arg45 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.lshr %arg43, %0 : i32
  %3 = llvm.zext nneg %2 : i32 to i64
  %4 = llvm.and %arg44, %3 : i64
  %5 = llvm.icmp "ne" %4, %1 : i64
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_const_after_fold_lshr_shl_ne_proof : t0_const_after_fold_lshr_shl_ne_before ⊑ t0_const_after_fold_lshr_shl_ne_after := by
  unfold t0_const_after_fold_lshr_shl_ne_before t0_const_after_fold_lshr_shl_ne_after
  simp_alive_peephole
  intros
  ---BEGIN t0_const_after_fold_lshr_shl_ne
  all_goals (try extract_goal ; sorry)
  ---END t0_const_after_fold_lshr_shl_ne



def t10_constants_before := [llvm|
{
^0(%arg14 : i32, %arg15 : i64):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(14) : i64
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %arg14, %0 : i32
  %4 = llvm.shl %arg15, %1 : i64
  %5 = llvm.trunc %4 : i64 to i32
  %6 = llvm.and %3, %5 : i32
  %7 = llvm.icmp "ne" %6, %2 : i32
  "llvm.return"(%7) : (i1) -> ()
}
]
def t10_constants_after := [llvm|
{
^0(%arg14 : i32, %arg15 : i64):
  %0 = llvm.mlir.constant(26 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.trunc %arg15 : i64 to i32
  %3 = llvm.lshr %arg14, %0 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t10_constants_proof : t10_constants_before ⊑ t10_constants_after := by
  unfold t10_constants_before t10_constants_after
  simp_alive_peephole
  intros
  ---BEGIN t10_constants
  all_goals (try extract_goal ; sorry)
  ---END t10_constants



def n13_overshift_before := [llvm|
{
^0(%arg7 : i32, %arg8 : i64, %arg9 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.sub %0, %arg9 : i32
  %3 = llvm.lshr %arg7, %2 : i32
  %4 = llvm.add %arg9, %0 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.shl %arg8, %5 : i64
  %7 = llvm.trunc %6 : i64 to i32
  %8 = llvm.and %3, %7 : i32
  %9 = llvm.icmp "ne" %8, %1 : i32
  "llvm.return"(%9) : (i1) -> ()
}
]
def n13_overshift_after := [llvm|
{
^0(%arg7 : i32, %arg8 : i64, %arg9 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.sub %0, %arg9 : i32
  %3 = llvm.lshr %arg7, %2 : i32
  %4 = llvm.add %arg9, %0 : i32
  %5 = llvm.zext nneg %4 : i32 to i64
  %6 = llvm.shl %arg8, %5 : i64
  %7 = llvm.trunc %6 : i64 to i32
  %8 = llvm.and %3, %7 : i32
  %9 = llvm.icmp "ne" %8, %1 : i32
  "llvm.return"(%9) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n13_overshift_proof : n13_overshift_before ⊑ n13_overshift_after := by
  unfold n13_overshift_before n13_overshift_after
  simp_alive_peephole
  intros
  ---BEGIN n13_overshift
  all_goals (try extract_goal ; sorry)
  ---END n13_overshift



def n14_trunc_of_lshr_before := [llvm|
{
^0(%arg4 : i64, %arg5 : i32, %arg6 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg6 : i32
  %4 = llvm.zext %3 : i32 to i64
  %5 = llvm.lshr %arg4, %4 : i64
  %6 = llvm.trunc %5 : i64 to i32
  %7 = llvm.add %arg6, %1 : i32
  %8 = llvm.shl %arg5, %7 : i32
  %9 = llvm.and %6, %8 : i32
  %10 = llvm.icmp "ne" %9, %2 : i32
  "llvm.return"(%10) : (i1) -> ()
}
]
def n14_trunc_of_lshr_after := [llvm|
{
^0(%arg4 : i64, %arg5 : i32, %arg6 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg6 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.lshr %arg4, %4 : i64
  %6 = llvm.trunc %5 : i64 to i32
  %7 = llvm.add %arg6, %1 : i32
  %8 = llvm.shl %arg5, %7 : i32
  %9 = llvm.and %8, %6 : i32
  %10 = llvm.icmp "ne" %9, %2 : i32
  "llvm.return"(%10) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n14_trunc_of_lshr_proof : n14_trunc_of_lshr_before ⊑ n14_trunc_of_lshr_after := by
  unfold n14_trunc_of_lshr_before n14_trunc_of_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN n14_trunc_of_lshr
  all_goals (try extract_goal ; sorry)
  ---END n14_trunc_of_lshr



def n15_variable_shamts_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i64, %arg2 : i32, %arg3 : i64):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.lshr %arg0, %arg2 : i32
  %2 = llvm.shl %arg1, %arg3 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "ne" %4, %0 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def n15_variable_shamts_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i64, %arg2 : i32, %arg3 : i64):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.lshr %arg0, %arg2 : i32
  %2 = llvm.shl %arg1, %arg3 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.icmp "ne" %4, %0 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n15_variable_shamts_proof : n15_variable_shamts_before ⊑ n15_variable_shamts_after := by
  unfold n15_variable_shamts_before n15_variable_shamts_after
  simp_alive_peephole
  intros
  ---BEGIN n15_variable_shamts
  all_goals (try extract_goal ; sorry)
  ---END n15_variable_shamts


