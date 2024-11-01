
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
section geqhofhparts_statements

def eq_10_before := [llvm|
{
^0(%arg130 : i32, %arg131 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.trunc %arg130 : i32 to i8
  %2 = llvm.lshr %arg130, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.trunc %arg131 : i32 to i8
  %5 = llvm.lshr %arg131, %0 : i32
  %6 = llvm.trunc %5 : i32 to i8
  %7 = llvm.icmp "eq" %1, %4 : i8
  %8 = llvm.icmp "eq" %3, %6 : i8
  %9 = llvm.and %7, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def eq_10_after := [llvm|
{
^0(%arg130 : i32, %arg131 : i32):
  %0 = llvm.trunc %arg130 : i32 to i16
  %1 = llvm.trunc %arg131 : i32 to i16
  %2 = llvm.icmp "eq" %0, %1 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_10_proof : eq_10_before ⊑ eq_10_after := by
  unfold eq_10_before eq_10_after
  simp_alive_peephole
  intros
  ---BEGIN eq_10
  all_goals (try extract_goal ; sorry)
  ---END eq_10



def eq_210_before := [llvm|
{
^0(%arg128 : i32, %arg129 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.trunc %arg128 : i32 to i8
  %3 = llvm.lshr %arg128, %0 : i32
  %4 = llvm.trunc %3 : i32 to i8
  %5 = llvm.lshr %arg128, %1 : i32
  %6 = llvm.trunc %5 : i32 to i8
  %7 = llvm.trunc %arg129 : i32 to i8
  %8 = llvm.lshr %arg129, %0 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.lshr %arg129, %1 : i32
  %11 = llvm.trunc %10 : i32 to i8
  %12 = llvm.icmp "eq" %2, %7 : i8
  %13 = llvm.icmp "eq" %4, %9 : i8
  %14 = llvm.icmp "eq" %6, %11 : i8
  %15 = llvm.and %12, %13 : i1
  %16 = llvm.and %14, %15 : i1
  "llvm.return"(%16) : (i1) -> ()
}
]
def eq_210_after := [llvm|
{
^0(%arg128 : i32, %arg129 : i32):
  %0 = llvm.trunc %arg128 : i32 to i24
  %1 = llvm.trunc %arg129 : i32 to i24
  %2 = llvm.icmp "eq" %0, %1 : i24
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_210_proof : eq_210_before ⊑ eq_210_after := by
  unfold eq_210_before eq_210_after
  simp_alive_peephole
  intros
  ---BEGIN eq_210
  all_goals (try extract_goal ; sorry)
  ---END eq_210



def eq_3210_before := [llvm|
{
^0(%arg126 : i32, %arg127 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(24 : i32) : i32
  %3 = llvm.trunc %arg126 : i32 to i8
  %4 = llvm.lshr %arg126, %0 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.lshr %arg126, %1 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg126, %2 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.trunc %arg127 : i32 to i8
  %11 = llvm.lshr %arg127, %0 : i32
  %12 = llvm.trunc %11 : i32 to i8
  %13 = llvm.lshr %arg127, %1 : i32
  %14 = llvm.trunc %13 : i32 to i8
  %15 = llvm.lshr %arg127, %2 : i32
  %16 = llvm.trunc %15 : i32 to i8
  %17 = llvm.icmp "eq" %3, %10 : i8
  %18 = llvm.icmp "eq" %5, %12 : i8
  %19 = llvm.icmp "eq" %7, %14 : i8
  %20 = llvm.icmp "eq" %9, %16 : i8
  %21 = llvm.and %17, %18 : i1
  %22 = llvm.and %19, %21 : i1
  %23 = llvm.and %20, %22 : i1
  "llvm.return"(%23) : (i1) -> ()
}
]
def eq_3210_after := [llvm|
{
^0(%arg126 : i32, %arg127 : i32):
  %0 = llvm.icmp "eq" %arg126, %arg127 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_3210_proof : eq_3210_before ⊑ eq_3210_after := by
  unfold eq_3210_before eq_3210_after
  simp_alive_peephole
  intros
  ---BEGIN eq_3210
  all_goals (try extract_goal ; sorry)
  ---END eq_3210



def eq_21_before := [llvm|
{
^0(%arg124 : i32, %arg125 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.lshr %arg124, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.lshr %arg124, %1 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.lshr %arg125, %0 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg125, %1 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.icmp "eq" %3, %7 : i8
  %11 = llvm.icmp "eq" %5, %9 : i8
  %12 = llvm.and %11, %10 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def eq_21_after := [llvm|
{
^0(%arg124 : i32, %arg125 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.lshr %arg124, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  %3 = llvm.lshr %arg125, %0 : i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.icmp "eq" %2, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_21_proof : eq_21_before ⊑ eq_21_after := by
  unfold eq_21_before eq_21_after
  simp_alive_peephole
  intros
  ---BEGIN eq_21
  all_goals (try extract_goal ; sorry)
  ---END eq_21



def eq_21_comm_and_before := [llvm|
{
^0(%arg122 : i32, %arg123 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.lshr %arg122, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.lshr %arg122, %1 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.lshr %arg123, %0 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg123, %1 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.icmp "eq" %3, %7 : i8
  %11 = llvm.icmp "eq" %5, %9 : i8
  %12 = llvm.and %10, %11 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def eq_21_comm_and_after := [llvm|
{
^0(%arg122 : i32, %arg123 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.lshr %arg122, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  %3 = llvm.lshr %arg123, %0 : i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.icmp "eq" %2, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_21_comm_and_proof : eq_21_comm_and_before ⊑ eq_21_comm_and_after := by
  unfold eq_21_comm_and_before eq_21_comm_and_after
  simp_alive_peephole
  intros
  ---BEGIN eq_21_comm_and
  all_goals (try extract_goal ; sorry)
  ---END eq_21_comm_and



def eq_21_comm_eq_before := [llvm|
{
^0(%arg120 : i32, %arg121 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.lshr %arg120, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.lshr %arg120, %1 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.lshr %arg121, %0 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg121, %1 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.icmp "eq" %3, %7 : i8
  %11 = llvm.icmp "eq" %9, %5 : i8
  %12 = llvm.and %11, %10 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def eq_21_comm_eq_after := [llvm|
{
^0(%arg120 : i32, %arg121 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.lshr %arg121, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  %3 = llvm.lshr %arg120, %0 : i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.icmp "eq" %2, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_21_comm_eq_proof : eq_21_comm_eq_before ⊑ eq_21_comm_eq_after := by
  unfold eq_21_comm_eq_before eq_21_comm_eq_after
  simp_alive_peephole
  intros
  ---BEGIN eq_21_comm_eq
  all_goals (try extract_goal ; sorry)
  ---END eq_21_comm_eq



def eq_21_comm_eq2_before := [llvm|
{
^0(%arg118 : i32, %arg119 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.lshr %arg118, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.lshr %arg118, %1 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.lshr %arg119, %0 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg119, %1 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.icmp "eq" %7, %3 : i8
  %11 = llvm.icmp "eq" %5, %9 : i8
  %12 = llvm.and %11, %10 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def eq_21_comm_eq2_after := [llvm|
{
^0(%arg118 : i32, %arg119 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.lshr %arg118, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  %3 = llvm.lshr %arg119, %0 : i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.icmp "eq" %2, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_21_comm_eq2_proof : eq_21_comm_eq2_before ⊑ eq_21_comm_eq2_after := by
  unfold eq_21_comm_eq2_before eq_21_comm_eq2_after
  simp_alive_peephole
  intros
  ---BEGIN eq_21_comm_eq2
  all_goals (try extract_goal ; sorry)
  ---END eq_21_comm_eq2



def eq_irregular_bit_widths_before := [llvm|
{
^0(%arg114 : i31, %arg115 : i31):
  %0 = llvm.mlir.constant(7 : i31) : i31
  %1 = llvm.mlir.constant(13 : i31) : i31
  %2 = llvm.lshr %arg114, %0 : i31
  %3 = llvm.trunc %2 : i31 to i6
  %4 = llvm.lshr %arg114, %1 : i31
  %5 = llvm.trunc %4 : i31 to i5
  %6 = llvm.lshr %arg115, %0 : i31
  %7 = llvm.trunc %6 : i31 to i6
  %8 = llvm.lshr %arg115, %1 : i31
  %9 = llvm.trunc %8 : i31 to i5
  %10 = llvm.icmp "eq" %3, %7 : i6
  %11 = llvm.icmp "eq" %5, %9 : i5
  %12 = llvm.and %11, %10 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def eq_irregular_bit_widths_after := [llvm|
{
^0(%arg114 : i31, %arg115 : i31):
  %0 = llvm.mlir.constant(7 : i31) : i31
  %1 = llvm.lshr %arg114, %0 : i31
  %2 = llvm.trunc %1 : i31 to i11
  %3 = llvm.lshr %arg115, %0 : i31
  %4 = llvm.trunc %3 : i31 to i11
  %5 = llvm.icmp "eq" %2, %4 : i11
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_irregular_bit_widths_proof : eq_irregular_bit_widths_before ⊑ eq_irregular_bit_widths_after := by
  unfold eq_irregular_bit_widths_before eq_irregular_bit_widths_after
  simp_alive_peephole
  intros
  ---BEGIN eq_irregular_bit_widths
  all_goals (try extract_goal ; sorry)
  ---END eq_irregular_bit_widths



def eq_21_logical_before := [llvm|
{
^0(%arg104 : i32, %arg105 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.lshr %arg104, %0 : i32
  %4 = llvm.trunc %3 : i32 to i8
  %5 = llvm.lshr %arg104, %1 : i32
  %6 = llvm.trunc %5 : i32 to i8
  %7 = llvm.lshr %arg105, %0 : i32
  %8 = llvm.trunc %7 : i32 to i8
  %9 = llvm.lshr %arg105, %1 : i32
  %10 = llvm.trunc %9 : i32 to i8
  %11 = llvm.icmp "eq" %4, %8 : i8
  %12 = llvm.icmp "eq" %6, %10 : i8
  %13 = "llvm.select"(%12, %11, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%13) : (i1) -> ()
}
]
def eq_21_logical_after := [llvm|
{
^0(%arg104 : i32, %arg105 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.lshr %arg104, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  %3 = llvm.lshr %arg105, %0 : i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.icmp "eq" %2, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_21_logical_proof : eq_21_logical_before ⊑ eq_21_logical_after := by
  unfold eq_21_logical_before eq_21_logical_after
  simp_alive_peephole
  intros
  ---BEGIN eq_21_logical
  all_goals (try extract_goal ; sorry)
  ---END eq_21_logical



def eq_shift_in_zeros_before := [llvm|
{
^0(%arg84 : i32, %arg85 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.lshr %arg84, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.lshr %arg84, %1 : i32
  %5 = llvm.trunc %4 : i32 to i24
  %6 = llvm.lshr %arg85, %0 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg85, %1 : i32
  %9 = llvm.trunc %8 : i32 to i24
  %10 = llvm.icmp "eq" %3, %7 : i8
  %11 = llvm.icmp "eq" %5, %9 : i24
  %12 = llvm.and %11, %10 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def eq_shift_in_zeros_after := [llvm|
{
^0(%arg84 : i32, %arg85 : i32):
  %0 = llvm.mlir.constant(256 : i32) : i32
  %1 = llvm.xor %arg84, %arg85 : i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_shift_in_zeros_proof : eq_shift_in_zeros_before ⊑ eq_shift_in_zeros_after := by
  unfold eq_shift_in_zeros_before eq_shift_in_zeros_after
  simp_alive_peephole
  intros
  ---BEGIN eq_shift_in_zeros
  all_goals (try extract_goal ; sorry)
  ---END eq_shift_in_zeros



def ne_10_before := [llvm|
{
^0(%arg78 : i32, %arg79 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.trunc %arg78 : i32 to i8
  %2 = llvm.lshr %arg78, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.trunc %arg79 : i32 to i8
  %5 = llvm.lshr %arg79, %0 : i32
  %6 = llvm.trunc %5 : i32 to i8
  %7 = llvm.icmp "ne" %1, %4 : i8
  %8 = llvm.icmp "ne" %3, %6 : i8
  %9 = llvm.or %7, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def ne_10_after := [llvm|
{
^0(%arg78 : i32, %arg79 : i32):
  %0 = llvm.trunc %arg78 : i32 to i16
  %1 = llvm.trunc %arg79 : i32 to i16
  %2 = llvm.icmp "ne" %0, %1 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_10_proof : ne_10_before ⊑ ne_10_after := by
  unfold ne_10_before ne_10_after
  simp_alive_peephole
  intros
  ---BEGIN ne_10
  all_goals (try extract_goal ; sorry)
  ---END ne_10



def ne_210_before := [llvm|
{
^0(%arg76 : i32, %arg77 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.trunc %arg76 : i32 to i8
  %3 = llvm.lshr %arg76, %0 : i32
  %4 = llvm.trunc %3 : i32 to i8
  %5 = llvm.lshr %arg76, %1 : i32
  %6 = llvm.trunc %5 : i32 to i8
  %7 = llvm.trunc %arg77 : i32 to i8
  %8 = llvm.lshr %arg77, %0 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.lshr %arg77, %1 : i32
  %11 = llvm.trunc %10 : i32 to i8
  %12 = llvm.icmp "ne" %2, %7 : i8
  %13 = llvm.icmp "ne" %4, %9 : i8
  %14 = llvm.icmp "ne" %6, %11 : i8
  %15 = llvm.or %12, %13 : i1
  %16 = llvm.or %14, %15 : i1
  "llvm.return"(%16) : (i1) -> ()
}
]
def ne_210_after := [llvm|
{
^0(%arg76 : i32, %arg77 : i32):
  %0 = llvm.trunc %arg76 : i32 to i24
  %1 = llvm.trunc %arg77 : i32 to i24
  %2 = llvm.icmp "ne" %0, %1 : i24
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_210_proof : ne_210_before ⊑ ne_210_after := by
  unfold ne_210_before ne_210_after
  simp_alive_peephole
  intros
  ---BEGIN ne_210
  all_goals (try extract_goal ; sorry)
  ---END ne_210



def ne_3210_before := [llvm|
{
^0(%arg74 : i32, %arg75 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(24 : i32) : i32
  %3 = llvm.trunc %arg74 : i32 to i8
  %4 = llvm.lshr %arg74, %0 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.lshr %arg74, %1 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg74, %2 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.trunc %arg75 : i32 to i8
  %11 = llvm.lshr %arg75, %0 : i32
  %12 = llvm.trunc %11 : i32 to i8
  %13 = llvm.lshr %arg75, %1 : i32
  %14 = llvm.trunc %13 : i32 to i8
  %15 = llvm.lshr %arg75, %2 : i32
  %16 = llvm.trunc %15 : i32 to i8
  %17 = llvm.icmp "ne" %3, %10 : i8
  %18 = llvm.icmp "ne" %5, %12 : i8
  %19 = llvm.icmp "ne" %7, %14 : i8
  %20 = llvm.icmp "ne" %9, %16 : i8
  %21 = llvm.or %17, %18 : i1
  %22 = llvm.or %19, %21 : i1
  %23 = llvm.or %20, %22 : i1
  "llvm.return"(%23) : (i1) -> ()
}
]
def ne_3210_after := [llvm|
{
^0(%arg74 : i32, %arg75 : i32):
  %0 = llvm.icmp "ne" %arg74, %arg75 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_3210_proof : ne_3210_before ⊑ ne_3210_after := by
  unfold ne_3210_before ne_3210_after
  simp_alive_peephole
  intros
  ---BEGIN ne_3210
  all_goals (try extract_goal ; sorry)
  ---END ne_3210



def ne_21_before := [llvm|
{
^0(%arg72 : i32, %arg73 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.lshr %arg72, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.lshr %arg72, %1 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.lshr %arg73, %0 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg73, %1 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.icmp "ne" %3, %7 : i8
  %11 = llvm.icmp "ne" %5, %9 : i8
  %12 = llvm.or %11, %10 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def ne_21_after := [llvm|
{
^0(%arg72 : i32, %arg73 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.lshr %arg72, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  %3 = llvm.lshr %arg73, %0 : i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.icmp "ne" %2, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_21_proof : ne_21_before ⊑ ne_21_after := by
  unfold ne_21_before ne_21_after
  simp_alive_peephole
  intros
  ---BEGIN ne_21
  all_goals (try extract_goal ; sorry)
  ---END ne_21



def ne_21_comm_or_before := [llvm|
{
^0(%arg70 : i32, %arg71 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.lshr %arg70, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.lshr %arg70, %1 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.lshr %arg71, %0 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg71, %1 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.icmp "ne" %3, %7 : i8
  %11 = llvm.icmp "ne" %5, %9 : i8
  %12 = llvm.or %10, %11 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def ne_21_comm_or_after := [llvm|
{
^0(%arg70 : i32, %arg71 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.lshr %arg70, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  %3 = llvm.lshr %arg71, %0 : i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.icmp "ne" %2, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_21_comm_or_proof : ne_21_comm_or_before ⊑ ne_21_comm_or_after := by
  unfold ne_21_comm_or_before ne_21_comm_or_after
  simp_alive_peephole
  intros
  ---BEGIN ne_21_comm_or
  all_goals (try extract_goal ; sorry)
  ---END ne_21_comm_or



def ne_21_comm_ne_before := [llvm|
{
^0(%arg68 : i32, %arg69 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.lshr %arg68, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.lshr %arg68, %1 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.lshr %arg69, %0 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg69, %1 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.icmp "ne" %3, %7 : i8
  %11 = llvm.icmp "ne" %9, %5 : i8
  %12 = llvm.or %11, %10 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def ne_21_comm_ne_after := [llvm|
{
^0(%arg68 : i32, %arg69 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.lshr %arg69, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  %3 = llvm.lshr %arg68, %0 : i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.icmp "ne" %2, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_21_comm_ne_proof : ne_21_comm_ne_before ⊑ ne_21_comm_ne_after := by
  unfold ne_21_comm_ne_before ne_21_comm_ne_after
  simp_alive_peephole
  intros
  ---BEGIN ne_21_comm_ne
  all_goals (try extract_goal ; sorry)
  ---END ne_21_comm_ne



def ne_21_comm_ne2_before := [llvm|
{
^0(%arg66 : i32, %arg67 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.lshr %arg66, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.lshr %arg66, %1 : i32
  %5 = llvm.trunc %4 : i32 to i8
  %6 = llvm.lshr %arg67, %0 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg67, %1 : i32
  %9 = llvm.trunc %8 : i32 to i8
  %10 = llvm.icmp "ne" %7, %3 : i8
  %11 = llvm.icmp "ne" %5, %9 : i8
  %12 = llvm.or %11, %10 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def ne_21_comm_ne2_after := [llvm|
{
^0(%arg66 : i32, %arg67 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.lshr %arg66, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  %3 = llvm.lshr %arg67, %0 : i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.icmp "ne" %2, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_21_comm_ne2_proof : ne_21_comm_ne2_before ⊑ ne_21_comm_ne2_after := by
  unfold ne_21_comm_ne2_before ne_21_comm_ne2_after
  simp_alive_peephole
  intros
  ---BEGIN ne_21_comm_ne2
  all_goals (try extract_goal ; sorry)
  ---END ne_21_comm_ne2



def ne_irregular_bit_widths_before := [llvm|
{
^0(%arg62 : i31, %arg63 : i31):
  %0 = llvm.mlir.constant(7 : i31) : i31
  %1 = llvm.mlir.constant(13 : i31) : i31
  %2 = llvm.lshr %arg62, %0 : i31
  %3 = llvm.trunc %2 : i31 to i6
  %4 = llvm.lshr %arg62, %1 : i31
  %5 = llvm.trunc %4 : i31 to i5
  %6 = llvm.lshr %arg63, %0 : i31
  %7 = llvm.trunc %6 : i31 to i6
  %8 = llvm.lshr %arg63, %1 : i31
  %9 = llvm.trunc %8 : i31 to i5
  %10 = llvm.icmp "ne" %3, %7 : i6
  %11 = llvm.icmp "ne" %5, %9 : i5
  %12 = llvm.or %11, %10 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def ne_irregular_bit_widths_after := [llvm|
{
^0(%arg62 : i31, %arg63 : i31):
  %0 = llvm.mlir.constant(7 : i31) : i31
  %1 = llvm.lshr %arg62, %0 : i31
  %2 = llvm.trunc %1 : i31 to i11
  %3 = llvm.lshr %arg63, %0 : i31
  %4 = llvm.trunc %3 : i31 to i11
  %5 = llvm.icmp "ne" %2, %4 : i11
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_irregular_bit_widths_proof : ne_irregular_bit_widths_before ⊑ ne_irregular_bit_widths_after := by
  unfold ne_irregular_bit_widths_before ne_irregular_bit_widths_after
  simp_alive_peephole
  intros
  ---BEGIN ne_irregular_bit_widths
  all_goals (try extract_goal ; sorry)
  ---END ne_irregular_bit_widths



def ne_21_logical_before := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.lshr %arg52, %0 : i32
  %4 = llvm.trunc %3 : i32 to i8
  %5 = llvm.lshr %arg52, %1 : i32
  %6 = llvm.trunc %5 : i32 to i8
  %7 = llvm.lshr %arg53, %0 : i32
  %8 = llvm.trunc %7 : i32 to i8
  %9 = llvm.lshr %arg53, %1 : i32
  %10 = llvm.trunc %9 : i32 to i8
  %11 = llvm.icmp "ne" %4, %8 : i8
  %12 = llvm.icmp "ne" %6, %10 : i8
  %13 = "llvm.select"(%12, %2, %11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%13) : (i1) -> ()
}
]
def ne_21_logical_after := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.lshr %arg52, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  %3 = llvm.lshr %arg53, %0 : i32
  %4 = llvm.trunc %3 : i32 to i16
  %5 = llvm.icmp "ne" %2, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_21_logical_proof : ne_21_logical_before ⊑ ne_21_logical_after := by
  unfold ne_21_logical_before ne_21_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ne_21_logical
  all_goals (try extract_goal ; sorry)
  ---END ne_21_logical



def ne_shift_in_zeros_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.lshr %arg32, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.lshr %arg32, %1 : i32
  %5 = llvm.trunc %4 : i32 to i24
  %6 = llvm.lshr %arg33, %0 : i32
  %7 = llvm.trunc %6 : i32 to i8
  %8 = llvm.lshr %arg33, %1 : i32
  %9 = llvm.trunc %8 : i32 to i24
  %10 = llvm.icmp "ne" %3, %7 : i8
  %11 = llvm.icmp "ne" %5, %9 : i24
  %12 = llvm.or %11, %10 : i1
  "llvm.return"(%12) : (i1) -> ()
}
]
def ne_shift_in_zeros_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.xor %arg32, %arg33 : i32
  %2 = llvm.icmp "ugt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_shift_in_zeros_proof : ne_shift_in_zeros_before ⊑ ne_shift_in_zeros_after := by
  unfold ne_shift_in_zeros_before ne_shift_in_zeros_after
  simp_alive_peephole
  intros
  ---BEGIN ne_shift_in_zeros
  all_goals (try extract_goal ; sorry)
  ---END ne_shift_in_zeros



def eq_optimized_highbits_cmp_before := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(33554432 : i32) : i32
  %1 = llvm.xor %arg27, %arg26 : i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  %3 = llvm.trunc %arg26 : i32 to i25
  %4 = llvm.trunc %arg27 : i32 to i25
  %5 = llvm.icmp "eq" %3, %4 : i25
  %6 = llvm.and %2, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def eq_optimized_highbits_cmp_after := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.icmp "eq" %arg27, %arg26 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_optimized_highbits_cmp_proof : eq_optimized_highbits_cmp_before ⊑ eq_optimized_highbits_cmp_after := by
  unfold eq_optimized_highbits_cmp_before eq_optimized_highbits_cmp_after
  simp_alive_peephole
  intros
  ---BEGIN eq_optimized_highbits_cmp
  all_goals (try extract_goal ; sorry)
  ---END eq_optimized_highbits_cmp



def ne_optimized_highbits_cmp_before := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.mlir.constant(16777215 : i32) : i32
  %1 = llvm.xor %arg21, %arg20 : i32
  %2 = llvm.icmp "ugt" %1, %0 : i32
  %3 = llvm.trunc %arg20 : i32 to i24
  %4 = llvm.trunc %arg21 : i32 to i24
  %5 = llvm.icmp "ne" %3, %4 : i24
  %6 = llvm.or %2, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def ne_optimized_highbits_cmp_after := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.icmp "ne" %arg21, %arg20 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_optimized_highbits_cmp_proof : ne_optimized_highbits_cmp_before ⊑ ne_optimized_highbits_cmp_after := by
  unfold ne_optimized_highbits_cmp_before ne_optimized_highbits_cmp_after
  simp_alive_peephole
  intros
  ---BEGIN ne_optimized_highbits_cmp
  all_goals (try extract_goal ; sorry)
  ---END ne_optimized_highbits_cmp


