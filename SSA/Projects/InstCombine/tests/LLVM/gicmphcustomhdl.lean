
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
section gicmphcustomhdl_statements

def icmp_and_ashr_multiuse_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(31 : i32) : i32
  %3 = llvm.mlir.constant(14 : i32) : i32
  %4 = llvm.mlir.constant(27 : i32) : i32
  %5 = llvm.ashr %arg5, %0 : i32
  %6 = llvm.and %5, %1 : i32
  %7 = llvm.and %5, %2 : i32
  %8 = llvm.icmp "ne" %6, %3 : i32
  %9 = llvm.icmp "ne" %7, %4 : i32
  %10 = llvm.and %8, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def icmp_and_ashr_multiuse_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(240 : i32) : i32
  %1 = llvm.mlir.constant(224 : i32) : i32
  %2 = llvm.mlir.constant(496 : i32) : i32
  %3 = llvm.mlir.constant(432 : i32) : i32
  %4 = llvm.and %arg5, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg5, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_and_ashr_multiuse_proof : icmp_and_ashr_multiuse_before ⊑ icmp_and_ashr_multiuse_after := by
  unfold icmp_and_ashr_multiuse_before icmp_and_ashr_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_and_ashr_multiuse
  all_goals (try extract_goal ; sorry)
  ---END icmp_and_ashr_multiuse



def icmp_and_ashr_multiuse_logical_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(31 : i32) : i32
  %3 = llvm.mlir.constant(14 : i32) : i32
  %4 = llvm.mlir.constant(27 : i32) : i32
  %5 = llvm.mlir.constant(false) : i1
  %6 = llvm.ashr %arg4, %0 : i32
  %7 = llvm.and %6, %1 : i32
  %8 = llvm.and %6, %2 : i32
  %9 = llvm.icmp "ne" %7, %3 : i32
  %10 = llvm.icmp "ne" %8, %4 : i32
  %11 = "llvm.select"(%9, %10, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def icmp_and_ashr_multiuse_logical_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(240 : i32) : i32
  %1 = llvm.mlir.constant(224 : i32) : i32
  %2 = llvm.mlir.constant(496 : i32) : i32
  %3 = llvm.mlir.constant(432 : i32) : i32
  %4 = llvm.and %arg4, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg4, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_and_ashr_multiuse_logical_proof : icmp_and_ashr_multiuse_logical_before ⊑ icmp_and_ashr_multiuse_logical_after := by
  unfold icmp_and_ashr_multiuse_logical_before icmp_and_ashr_multiuse_logical_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_and_ashr_multiuse_logical
  all_goals (try extract_goal ; sorry)
  ---END icmp_and_ashr_multiuse_logical



def icmp_lshr_and_overshift_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.lshr %arg3, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "ne" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_lshr_and_overshift_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.icmp "ugt" %arg3, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_lshr_and_overshift_proof : icmp_lshr_and_overshift_before ⊑ icmp_lshr_and_overshift_after := by
  unfold icmp_lshr_and_overshift_before icmp_lshr_and_overshift_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_lshr_and_overshift
  all_goals (try extract_goal ; sorry)
  ---END icmp_lshr_and_overshift


