
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
section gsignedhtruncationhcheck_statements

def positive_with_signbit_before := [llvm|
{
^0(%arg62 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.icmp "sgt" %arg62, %0 : i32
  %4 = llvm.add %arg62, %1 : i32
  %5 = llvm.icmp "ult" %4, %2 : i32
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def positive_with_signbit_after := [llvm|
{
^0(%arg62 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ult" %arg62, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_with_signbit_proof : positive_with_signbit_before ⊑ positive_with_signbit_after := by
  unfold positive_with_signbit_before positive_with_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN positive_with_signbit
  all_goals (try extract_goal ; sorry)
  ---END positive_with_signbit



def positive_with_signbit_logical_before := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "sgt" %arg61, %0 : i32
  %5 = llvm.add %arg61, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = "llvm.select"(%4, %6, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def positive_with_signbit_logical_after := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ult" %arg61, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_with_signbit_logical_proof : positive_with_signbit_logical_before ⊑ positive_with_signbit_logical_after := by
  unfold positive_with_signbit_logical_before positive_with_signbit_logical_after
  simp_alive_peephole
  intros
  ---BEGIN positive_with_signbit_logical
  all_goals (try extract_goal ; sorry)
  ---END positive_with_signbit_logical



def positive_with_mask_before := [llvm|
{
^0(%arg60 : i32):
  %0 = llvm.mlir.constant(1107296256 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.mlir.constant(256 : i32) : i32
  %4 = llvm.and %arg60, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %arg60, %2 : i32
  %7 = llvm.icmp "ult" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def positive_with_mask_after := [llvm|
{
^0(%arg60 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ult" %arg60, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_with_mask_proof : positive_with_mask_before ⊑ positive_with_mask_after := by
  unfold positive_with_mask_before positive_with_mask_after
  simp_alive_peephole
  intros
  ---BEGIN positive_with_mask
  all_goals (try extract_goal ; sorry)
  ---END positive_with_mask



def positive_with_mask_logical_before := [llvm|
{
^0(%arg59 : i32):
  %0 = llvm.mlir.constant(1107296256 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.mlir.constant(256 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg59, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.add %arg59, %2 : i32
  %8 = llvm.icmp "ult" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def positive_with_mask_logical_after := [llvm|
{
^0(%arg59 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ult" %arg59, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_with_mask_logical_proof : positive_with_mask_logical_before ⊑ positive_with_mask_logical_after := by
  unfold positive_with_mask_logical_before positive_with_mask_logical_after
  simp_alive_peephole
  intros
  ---BEGIN positive_with_mask_logical
  all_goals (try extract_goal ; sorry)
  ---END positive_with_mask_logical



def positive_with_icmp_before := [llvm|
{
^0(%arg58 : i32):
  %0 = llvm.mlir.constant(512 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.icmp "ult" %arg58, %0 : i32
  %4 = llvm.add %arg58, %1 : i32
  %5 = llvm.icmp "ult" %4, %2 : i32
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def positive_with_icmp_after := [llvm|
{
^0(%arg58 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ult" %arg58, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_with_icmp_proof : positive_with_icmp_before ⊑ positive_with_icmp_after := by
  unfold positive_with_icmp_before positive_with_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN positive_with_icmp
  all_goals (try extract_goal ; sorry)
  ---END positive_with_icmp



def positive_with_icmp_logical_before := [llvm|
{
^0(%arg57 : i32):
  %0 = llvm.mlir.constant(512 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "ult" %arg57, %0 : i32
  %5 = llvm.add %arg57, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = "llvm.select"(%4, %6, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def positive_with_icmp_logical_after := [llvm|
{
^0(%arg57 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ult" %arg57, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_with_icmp_logical_proof : positive_with_icmp_logical_before ⊑ positive_with_icmp_logical_after := by
  unfold positive_with_icmp_logical_before positive_with_icmp_logical_after
  simp_alive_peephole
  intros
  ---BEGIN positive_with_icmp_logical
  all_goals (try extract_goal ; sorry)
  ---END positive_with_icmp_logical



def positive_with_aggressive_icmp_before := [llvm|
{
^0(%arg56 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(256 : i32) : i32
  %2 = llvm.mlir.constant(512 : i32) : i32
  %3 = llvm.icmp "ult" %arg56, %0 : i32
  %4 = llvm.add %arg56, %1 : i32
  %5 = llvm.icmp "ult" %4, %2 : i32
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def positive_with_aggressive_icmp_after := [llvm|
{
^0(%arg56 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ult" %arg56, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_with_aggressive_icmp_proof : positive_with_aggressive_icmp_before ⊑ positive_with_aggressive_icmp_after := by
  unfold positive_with_aggressive_icmp_before positive_with_aggressive_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN positive_with_aggressive_icmp
  all_goals (try extract_goal ; sorry)
  ---END positive_with_aggressive_icmp



def positive_with_aggressive_icmp_logical_before := [llvm|
{
^0(%arg55 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(256 : i32) : i32
  %2 = llvm.mlir.constant(512 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "ult" %arg55, %0 : i32
  %5 = llvm.add %arg55, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = "llvm.select"(%4, %6, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def positive_with_aggressive_icmp_logical_after := [llvm|
{
^0(%arg55 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ult" %arg55, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_with_aggressive_icmp_logical_proof : positive_with_aggressive_icmp_logical_before ⊑ positive_with_aggressive_icmp_logical_after := by
  unfold positive_with_aggressive_icmp_logical_before positive_with_aggressive_icmp_logical_after
  simp_alive_peephole
  intros
  ---BEGIN positive_with_aggressive_icmp_logical
  all_goals (try extract_goal ; sorry)
  ---END positive_with_aggressive_icmp_logical



def positive_with_extra_and_before := [llvm|
{
^0(%arg53 : i32, %arg54 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.icmp "sgt" %arg53, %0 : i32
  %4 = llvm.add %arg53, %1 : i32
  %5 = llvm.icmp "ult" %4, %2 : i32
  %6 = llvm.and %3, %arg54 : i1
  %7 = llvm.and %5, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def positive_with_extra_and_after := [llvm|
{
^0(%arg53 : i32, %arg54 : i1):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ult" %arg53, %0 : i32
  %2 = llvm.and %1, %arg54 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_with_extra_and_proof : positive_with_extra_and_before ⊑ positive_with_extra_and_after := by
  unfold positive_with_extra_and_before positive_with_extra_and_after
  simp_alive_peephole
  intros
  ---BEGIN positive_with_extra_and
  all_goals (try extract_goal ; sorry)
  ---END positive_with_extra_and



def positive_with_extra_and_logical_before := [llvm|
{
^0(%arg51 : i32, %arg52 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "sgt" %arg51, %0 : i32
  %5 = llvm.add %arg51, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = "llvm.select"(%4, %arg52, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%6, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def positive_with_extra_and_logical_after := [llvm|
{
^0(%arg51 : i32, %arg52 : i1):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ult" %arg51, %0 : i32
  %3 = "llvm.select"(%2, %arg52, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_with_extra_and_logical_proof : positive_with_extra_and_logical_before ⊑ positive_with_extra_and_logical_after := by
  unfold positive_with_extra_and_logical_before positive_with_extra_and_logical_after
  simp_alive_peephole
  intros
  ---BEGIN positive_with_extra_and_logical
  all_goals (try extract_goal ; sorry)
  ---END positive_with_extra_and_logical



def positive_trunc_signbit_before := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.trunc %arg41 : i32 to i8
  %4 = llvm.icmp "sgt" %3, %0 : i8
  %5 = llvm.add %arg41, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def positive_trunc_signbit_after := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ult" %arg41, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_trunc_signbit_proof : positive_trunc_signbit_before ⊑ positive_trunc_signbit_after := by
  unfold positive_trunc_signbit_before positive_trunc_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN positive_trunc_signbit
  all_goals (try extract_goal ; sorry)
  ---END positive_trunc_signbit



def positive_trunc_signbit_logical_before := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.trunc %arg40 : i32 to i8
  %5 = llvm.icmp "sgt" %4, %0 : i8
  %6 = llvm.add %arg40, %1 : i32
  %7 = llvm.icmp "ult" %6, %2 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def positive_trunc_signbit_logical_after := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.icmp "ult" %arg40, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_trunc_signbit_logical_proof : positive_trunc_signbit_logical_before ⊑ positive_trunc_signbit_logical_after := by
  unfold positive_trunc_signbit_logical_before positive_trunc_signbit_logical_after
  simp_alive_peephole
  intros
  ---BEGIN positive_trunc_signbit_logical
  all_goals (try extract_goal ; sorry)
  ---END positive_trunc_signbit_logical



def positive_trunc_base_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.mlir.constant(128 : i16) : i16
  %2 = llvm.mlir.constant(256 : i16) : i16
  %3 = llvm.trunc %arg39 : i32 to i16
  %4 = llvm.icmp "sgt" %3, %0 : i16
  %5 = llvm.add %3, %1 : i16
  %6 = llvm.icmp "ult" %5, %2 : i16
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def positive_trunc_base_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(65408 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg39, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_trunc_base_proof : positive_trunc_base_before ⊑ positive_trunc_base_after := by
  unfold positive_trunc_base_before positive_trunc_base_after
  simp_alive_peephole
  intros
  ---BEGIN positive_trunc_base
  all_goals (try extract_goal ; sorry)
  ---END positive_trunc_base



def positive_trunc_base_logical_before := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.mlir.constant(128 : i16) : i16
  %2 = llvm.mlir.constant(256 : i16) : i16
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.trunc %arg38 : i32 to i16
  %5 = llvm.icmp "sgt" %4, %0 : i16
  %6 = llvm.add %4, %1 : i16
  %7 = llvm.icmp "ult" %6, %2 : i16
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def positive_trunc_base_logical_after := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(65408 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg38, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_trunc_base_logical_proof : positive_trunc_base_logical_before ⊑ positive_trunc_base_logical_after := by
  unfold positive_trunc_base_logical_before positive_trunc_base_logical_after
  simp_alive_peephole
  intros
  ---BEGIN positive_trunc_base_logical
  all_goals (try extract_goal ; sorry)
  ---END positive_trunc_base_logical



def positive_different_trunc_both_before := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(-1 : i15) : i15
  %1 = llvm.mlir.constant(128 : i16) : i16
  %2 = llvm.mlir.constant(256 : i16) : i16
  %3 = llvm.trunc %arg37 : i32 to i15
  %4 = llvm.icmp "sgt" %3, %0 : i15
  %5 = llvm.trunc %arg37 : i32 to i16
  %6 = llvm.add %5, %1 : i16
  %7 = llvm.icmp "ult" %6, %2 : i16
  %8 = llvm.and %4, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def positive_different_trunc_both_after := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(16384 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(128 : i16) : i16
  %3 = llvm.mlir.constant(256 : i16) : i16
  %4 = llvm.and %arg37, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.trunc %arg37 : i32 to i16
  %7 = llvm.add %6, %2 : i16
  %8 = llvm.icmp "ult" %7, %3 : i16
  %9 = llvm.and %5, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_different_trunc_both_proof : positive_different_trunc_both_before ⊑ positive_different_trunc_both_after := by
  unfold positive_different_trunc_both_before positive_different_trunc_both_after
  simp_alive_peephole
  intros
  ---BEGIN positive_different_trunc_both
  all_goals (try extract_goal ; sorry)
  ---END positive_different_trunc_both



def positive_different_trunc_both_logical_before := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(-1 : i15) : i15
  %1 = llvm.mlir.constant(128 : i16) : i16
  %2 = llvm.mlir.constant(256 : i16) : i16
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.trunc %arg36 : i32 to i15
  %5 = llvm.icmp "sgt" %4, %0 : i15
  %6 = llvm.trunc %arg36 : i32 to i16
  %7 = llvm.add %6, %1 : i16
  %8 = llvm.icmp "ult" %7, %2 : i16
  %9 = "llvm.select"(%5, %8, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def positive_different_trunc_both_logical_after := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(16384 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(128 : i16) : i16
  %3 = llvm.mlir.constant(256 : i16) : i16
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg36, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.trunc %arg36 : i32 to i16
  %8 = llvm.add %7, %2 : i16
  %9 = llvm.icmp "ult" %8, %3 : i16
  %10 = "llvm.select"(%6, %9, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%10) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem positive_different_trunc_both_logical_proof : positive_different_trunc_both_logical_before ⊑ positive_different_trunc_both_logical_after := by
  unfold positive_different_trunc_both_logical_before positive_different_trunc_both_logical_after
  simp_alive_peephole
  intros
  ---BEGIN positive_different_trunc_both_logical
  all_goals (try extract_goal ; sorry)
  ---END positive_different_trunc_both_logical



def negative_trunc_not_arg_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i32):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.trunc %arg22 : i32 to i8
  %4 = llvm.icmp "sgt" %3, %0 : i8
  %5 = llvm.add %arg23, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def negative_trunc_not_arg_after := [llvm|
{
^0(%arg22 : i32, %arg23 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.and %arg22, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.add %arg23, %0 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_trunc_not_arg_proof : negative_trunc_not_arg_before ⊑ negative_trunc_not_arg_after := by
  unfold negative_trunc_not_arg_before negative_trunc_not_arg_after
  simp_alive_peephole
  intros
  ---BEGIN negative_trunc_not_arg
  all_goals (try extract_goal ; sorry)
  ---END negative_trunc_not_arg



def negative_trunc_not_arg_logical_before := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.trunc %arg20 : i32 to i8
  %5 = llvm.icmp "sgt" %4, %0 : i8
  %6 = llvm.add %arg21, %1 : i32
  %7 = llvm.icmp "ult" %6, %2 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def negative_trunc_not_arg_logical_after := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg20, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %arg21, %0 : i32
  %7 = llvm.icmp "ult" %6, %2 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_trunc_not_arg_logical_proof : negative_trunc_not_arg_logical_before ⊑ negative_trunc_not_arg_logical_after := by
  unfold negative_trunc_not_arg_logical_before negative_trunc_not_arg_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative_trunc_not_arg_logical
  all_goals (try extract_goal ; sorry)
  ---END negative_trunc_not_arg_logical



def negative_with_nonuniform_bad_mask_logical_before := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(1711276033 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.mlir.constant(256 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg14, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.add %arg14, %2 : i32
  %8 = llvm.icmp "ult" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def negative_with_nonuniform_bad_mask_logical_after := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(1711276033 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.mlir.constant(256 : i32) : i32
  %4 = llvm.and %arg14, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %arg14, %2 : i32
  %7 = llvm.icmp "ult" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_with_nonuniform_bad_mask_logical_proof : negative_with_nonuniform_bad_mask_logical_before ⊑ negative_with_nonuniform_bad_mask_logical_after := by
  unfold negative_with_nonuniform_bad_mask_logical_before negative_with_nonuniform_bad_mask_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative_with_nonuniform_bad_mask_logical
  all_goals (try extract_goal ; sorry)
  ---END negative_with_nonuniform_bad_mask_logical



def negative_with_uniform_bad_mask_logical_before := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(-16777152 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.mlir.constant(256 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg12, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.add %arg12, %2 : i32
  %8 = llvm.icmp "ult" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def negative_with_uniform_bad_mask_logical_after := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(-16777152 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.mlir.constant(256 : i32) : i32
  %4 = llvm.and %arg12, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %arg12, %2 : i32
  %7 = llvm.icmp "ult" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_with_uniform_bad_mask_logical_proof : negative_with_uniform_bad_mask_logical_before ⊑ negative_with_uniform_bad_mask_logical_after := by
  unfold negative_with_uniform_bad_mask_logical_before negative_with_uniform_bad_mask_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative_with_uniform_bad_mask_logical
  all_goals (try extract_goal ; sorry)
  ---END negative_with_uniform_bad_mask_logical



def negative_with_wrong_mask_logical_before := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.mlir.constant(256 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg10, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.add %arg10, %2 : i32
  %8 = llvm.icmp "ult" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def negative_with_wrong_mask_logical_after := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.mlir.constant(256 : i32) : i32
  %4 = llvm.and %arg10, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %arg10, %2 : i32
  %7 = llvm.icmp "ult" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_with_wrong_mask_logical_proof : negative_with_wrong_mask_logical_before ⊑ negative_with_wrong_mask_logical_after := by
  unfold negative_with_wrong_mask_logical_before negative_with_wrong_mask_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative_with_wrong_mask_logical
  all_goals (try extract_goal ; sorry)
  ---END negative_with_wrong_mask_logical



def negative_not_less_than_before := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(256 : i32) : i32
  %2 = llvm.icmp "sgt" %arg9, %0 : i32
  %3 = llvm.add %arg9, %1 : i32
  %4 = llvm.icmp "ult" %3, %1 : i32
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def negative_not_less_than_after := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_not_less_than_proof : negative_not_less_than_before ⊑ negative_not_less_than_after := by
  unfold negative_not_less_than_before negative_not_less_than_after
  simp_alive_peephole
  intros
  ---BEGIN negative_not_less_than
  all_goals (try extract_goal ; sorry)
  ---END negative_not_less_than



def negative_not_less_than_logical_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(256 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "sgt" %arg8, %0 : i32
  %4 = llvm.add %arg8, %1 : i32
  %5 = llvm.icmp "ult" %4, %1 : i32
  %6 = "llvm.select"(%3, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def negative_not_less_than_logical_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_not_less_than_logical_proof : negative_not_less_than_logical_before ⊑ negative_not_less_than_logical_after := by
  unfold negative_not_less_than_logical_before negative_not_less_than_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative_not_less_than_logical
  all_goals (try extract_goal ; sorry)
  ---END negative_not_less_than_logical



def negative_not_power_of_two_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.icmp "sgt" %arg7, %0 : i32
  %4 = llvm.add %arg7, %1 : i32
  %5 = llvm.icmp "ult" %4, %2 : i32
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def negative_not_power_of_two_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg7, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_not_power_of_two_proof : negative_not_power_of_two_before ⊑ negative_not_power_of_two_after := by
  unfold negative_not_power_of_two_before negative_not_power_of_two_after
  simp_alive_peephole
  intros
  ---BEGIN negative_not_power_of_two
  all_goals (try extract_goal ; sorry)
  ---END negative_not_power_of_two



def negative_not_power_of_two_logical_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "sgt" %arg6, %0 : i32
  %5 = llvm.add %arg6, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = "llvm.select"(%4, %6, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def negative_not_power_of_two_logical_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg6, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_not_power_of_two_logical_proof : negative_not_power_of_two_logical_before ⊑ negative_not_power_of_two_logical_after := by
  unfold negative_not_power_of_two_logical_before negative_not_power_of_two_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative_not_power_of_two_logical
  all_goals (try extract_goal ; sorry)
  ---END negative_not_power_of_two_logical



def negative_not_next_power_of_two_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(64 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.icmp "sgt" %arg5, %0 : i32
  %4 = llvm.add %arg5, %1 : i32
  %5 = llvm.icmp "ult" %4, %2 : i32
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def negative_not_next_power_of_two_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.icmp "ult" %arg5, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_not_next_power_of_two_proof : negative_not_next_power_of_two_before ⊑ negative_not_next_power_of_two_after := by
  unfold negative_not_next_power_of_two_before negative_not_next_power_of_two_after
  simp_alive_peephole
  intros
  ---BEGIN negative_not_next_power_of_two
  all_goals (try extract_goal ; sorry)
  ---END negative_not_next_power_of_two



def negative_not_next_power_of_two_logical_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(64 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "sgt" %arg4, %0 : i32
  %5 = llvm.add %arg4, %1 : i32
  %6 = llvm.icmp "ult" %5, %2 : i32
  %7 = "llvm.select"(%4, %6, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def negative_not_next_power_of_two_logical_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.icmp "ult" %arg4, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_not_next_power_of_two_logical_proof : negative_not_next_power_of_two_logical_before ⊑ negative_not_next_power_of_two_logical_after := by
  unfold negative_not_next_power_of_two_logical_before negative_not_next_power_of_two_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative_not_next_power_of_two_logical
  all_goals (try extract_goal ; sorry)
  ---END negative_not_next_power_of_two_logical



def two_signed_truncation_checks_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(512 : i32) : i32
  %1 = llvm.mlir.constant(1024 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.mlir.constant(256 : i32) : i32
  %4 = llvm.add %arg3, %0 : i32
  %5 = llvm.icmp "ult" %4, %1 : i32
  %6 = llvm.add %arg3, %2 : i32
  %7 = llvm.icmp "ult" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def two_signed_truncation_checks_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(256 : i32) : i32
  %2 = llvm.add %arg3, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem two_signed_truncation_checks_proof : two_signed_truncation_checks_before ⊑ two_signed_truncation_checks_after := by
  unfold two_signed_truncation_checks_before two_signed_truncation_checks_after
  simp_alive_peephole
  intros
  ---BEGIN two_signed_truncation_checks
  all_goals (try extract_goal ; sorry)
  ---END two_signed_truncation_checks



def two_signed_truncation_checks_logical_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(512 : i32) : i32
  %1 = llvm.mlir.constant(1024 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.mlir.constant(256 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.add %arg2, %0 : i32
  %6 = llvm.icmp "ult" %5, %1 : i32
  %7 = llvm.add %arg2, %2 : i32
  %8 = llvm.icmp "ult" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def two_signed_truncation_checks_logical_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(256 : i32) : i32
  %2 = llvm.add %arg2, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem two_signed_truncation_checks_logical_proof : two_signed_truncation_checks_logical_before ⊑ two_signed_truncation_checks_logical_after := by
  unfold two_signed_truncation_checks_logical_before two_signed_truncation_checks_logical_after
  simp_alive_peephole
  intros
  ---BEGIN two_signed_truncation_checks_logical
  all_goals (try extract_goal ; sorry)
  ---END two_signed_truncation_checks_logical


