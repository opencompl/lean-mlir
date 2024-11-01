
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
section gandhorhicmps_statements

def PR1817_1_before := [llvm|
{
^0(%arg374 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.icmp "slt" %arg374, %0 : i32
  %2 = llvm.icmp "ult" %arg374, %0 : i32
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def PR1817_1_after := [llvm|
{
^0(%arg374 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.icmp "ult" %arg374, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR1817_1_proof : PR1817_1_before ⊑ PR1817_1_after := by
  unfold PR1817_1_before PR1817_1_after
  simp_alive_peephole
  intros
  ---BEGIN PR1817_1
  all_goals (try extract_goal ; sorry)
  ---END PR1817_1



def PR1817_1_logical_before := [llvm|
{
^0(%arg373 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "slt" %arg373, %0 : i32
  %3 = llvm.icmp "ult" %arg373, %0 : i32
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR1817_1_logical_after := [llvm|
{
^0(%arg373 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.icmp "ult" %arg373, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR1817_1_logical_proof : PR1817_1_logical_before ⊑ PR1817_1_logical_after := by
  unfold PR1817_1_logical_before PR1817_1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR1817_1_logical
  all_goals (try extract_goal ; sorry)
  ---END PR1817_1_logical



def PR1817_2_before := [llvm|
{
^0(%arg372 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.icmp "slt" %arg372, %0 : i32
  %2 = llvm.icmp "ult" %arg372, %0 : i32
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def PR1817_2_after := [llvm|
{
^0(%arg372 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.icmp "slt" %arg372, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR1817_2_proof : PR1817_2_before ⊑ PR1817_2_after := by
  unfold PR1817_2_before PR1817_2_after
  simp_alive_peephole
  intros
  ---BEGIN PR1817_2
  all_goals (try extract_goal ; sorry)
  ---END PR1817_2



def PR1817_2_logical_before := [llvm|
{
^0(%arg371 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "slt" %arg371, %0 : i32
  %3 = llvm.icmp "ult" %arg371, %0 : i32
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR1817_2_logical_after := [llvm|
{
^0(%arg371 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.icmp "slt" %arg371, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR1817_2_logical_proof : PR1817_2_logical_before ⊑ PR1817_2_logical_after := by
  unfold PR1817_2_logical_before PR1817_2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR1817_2_logical
  all_goals (try extract_goal ; sorry)
  ---END PR1817_2_logical



def PR2330_before := [llvm|
{
^0(%arg369 : i32, %arg370 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.icmp "ult" %arg369, %0 : i32
  %2 = llvm.icmp "ult" %arg370, %0 : i32
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def PR2330_after := [llvm|
{
^0(%arg369 : i32, %arg370 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.or %arg370, %arg369 : i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR2330_proof : PR2330_before ⊑ PR2330_after := by
  unfold PR2330_before PR2330_after
  simp_alive_peephole
  intros
  ---BEGIN PR2330
  all_goals (try extract_goal ; sorry)
  ---END PR2330



def or_eq_with_one_bit_diff_constants1_before := [llvm|
{
^0(%arg366 : i32):
  %0 = llvm.mlir.constant(50 : i32) : i32
  %1 = llvm.mlir.constant(51 : i32) : i32
  %2 = llvm.icmp "eq" %arg366, %0 : i32
  %3 = llvm.icmp "eq" %arg366, %1 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_eq_with_one_bit_diff_constants1_after := [llvm|
{
^0(%arg366 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(50 : i32) : i32
  %2 = llvm.and %arg366, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_eq_with_one_bit_diff_constants1_proof : or_eq_with_one_bit_diff_constants1_before ⊑ or_eq_with_one_bit_diff_constants1_after := by
  unfold or_eq_with_one_bit_diff_constants1_before or_eq_with_one_bit_diff_constants1_after
  simp_alive_peephole
  intros
  ---BEGIN or_eq_with_one_bit_diff_constants1
  all_goals (try extract_goal ; sorry)
  ---END or_eq_with_one_bit_diff_constants1



def or_eq_with_one_bit_diff_constants1_logical_before := [llvm|
{
^0(%arg365 : i32):
  %0 = llvm.mlir.constant(50 : i32) : i32
  %1 = llvm.mlir.constant(51 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg365, %0 : i32
  %4 = llvm.icmp "eq" %arg365, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_eq_with_one_bit_diff_constants1_logical_after := [llvm|
{
^0(%arg365 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(50 : i32) : i32
  %2 = llvm.and %arg365, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_eq_with_one_bit_diff_constants1_logical_proof : or_eq_with_one_bit_diff_constants1_logical_before ⊑ or_eq_with_one_bit_diff_constants1_logical_after := by
  unfold or_eq_with_one_bit_diff_constants1_logical_before or_eq_with_one_bit_diff_constants1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN or_eq_with_one_bit_diff_constants1_logical
  all_goals (try extract_goal ; sorry)
  ---END or_eq_with_one_bit_diff_constants1_logical



def and_ne_with_one_bit_diff_constants1_before := [llvm|
{
^0(%arg364 : i32):
  %0 = llvm.mlir.constant(51 : i32) : i32
  %1 = llvm.mlir.constant(50 : i32) : i32
  %2 = llvm.icmp "ne" %arg364, %0 : i32
  %3 = llvm.icmp "ne" %arg364, %1 : i32
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_ne_with_one_bit_diff_constants1_after := [llvm|
{
^0(%arg364 : i32):
  %0 = llvm.mlir.constant(-52 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.add %arg364, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ne_with_one_bit_diff_constants1_proof : and_ne_with_one_bit_diff_constants1_before ⊑ and_ne_with_one_bit_diff_constants1_after := by
  unfold and_ne_with_one_bit_diff_constants1_before and_ne_with_one_bit_diff_constants1_after
  simp_alive_peephole
  intros
  ---BEGIN and_ne_with_one_bit_diff_constants1
  all_goals (try extract_goal ; sorry)
  ---END and_ne_with_one_bit_diff_constants1



def and_ne_with_one_bit_diff_constants1_logical_before := [llvm|
{
^0(%arg363 : i32):
  %0 = llvm.mlir.constant(51 : i32) : i32
  %1 = llvm.mlir.constant(50 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ne" %arg363, %0 : i32
  %4 = llvm.icmp "ne" %arg363, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def and_ne_with_one_bit_diff_constants1_logical_after := [llvm|
{
^0(%arg363 : i32):
  %0 = llvm.mlir.constant(-52 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.add %arg363, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ne_with_one_bit_diff_constants1_logical_proof : and_ne_with_one_bit_diff_constants1_logical_before ⊑ and_ne_with_one_bit_diff_constants1_logical_after := by
  unfold and_ne_with_one_bit_diff_constants1_logical_before and_ne_with_one_bit_diff_constants1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN and_ne_with_one_bit_diff_constants1_logical
  all_goals (try extract_goal ; sorry)
  ---END and_ne_with_one_bit_diff_constants1_logical



def or_eq_with_one_bit_diff_constants2_before := [llvm|
{
^0(%arg362 : i32):
  %0 = llvm.mlir.constant(97 : i32) : i32
  %1 = llvm.mlir.constant(65 : i32) : i32
  %2 = llvm.icmp "eq" %arg362, %0 : i32
  %3 = llvm.icmp "eq" %arg362, %1 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_eq_with_one_bit_diff_constants2_after := [llvm|
{
^0(%arg362 : i32):
  %0 = llvm.mlir.constant(-33 : i32) : i32
  %1 = llvm.mlir.constant(65 : i32) : i32
  %2 = llvm.and %arg362, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_eq_with_one_bit_diff_constants2_proof : or_eq_with_one_bit_diff_constants2_before ⊑ or_eq_with_one_bit_diff_constants2_after := by
  unfold or_eq_with_one_bit_diff_constants2_before or_eq_with_one_bit_diff_constants2_after
  simp_alive_peephole
  intros
  ---BEGIN or_eq_with_one_bit_diff_constants2
  all_goals (try extract_goal ; sorry)
  ---END or_eq_with_one_bit_diff_constants2



def or_eq_with_one_bit_diff_constants2_logical_before := [llvm|
{
^0(%arg361 : i32):
  %0 = llvm.mlir.constant(97 : i32) : i32
  %1 = llvm.mlir.constant(65 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg361, %0 : i32
  %4 = llvm.icmp "eq" %arg361, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_eq_with_one_bit_diff_constants2_logical_after := [llvm|
{
^0(%arg361 : i32):
  %0 = llvm.mlir.constant(-33 : i32) : i32
  %1 = llvm.mlir.constant(65 : i32) : i32
  %2 = llvm.and %arg361, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_eq_with_one_bit_diff_constants2_logical_proof : or_eq_with_one_bit_diff_constants2_logical_before ⊑ or_eq_with_one_bit_diff_constants2_logical_after := by
  unfold or_eq_with_one_bit_diff_constants2_logical_before or_eq_with_one_bit_diff_constants2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN or_eq_with_one_bit_diff_constants2_logical
  all_goals (try extract_goal ; sorry)
  ---END or_eq_with_one_bit_diff_constants2_logical



def and_ne_with_one_bit_diff_constants2_before := [llvm|
{
^0(%arg360 : i19):
  %0 = llvm.mlir.constant(65 : i19) : i19
  %1 = llvm.mlir.constant(193 : i19) : i19
  %2 = llvm.icmp "ne" %arg360, %0 : i19
  %3 = llvm.icmp "ne" %arg360, %1 : i19
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_ne_with_one_bit_diff_constants2_after := [llvm|
{
^0(%arg360 : i19):
  %0 = llvm.mlir.constant(-129 : i19) : i19
  %1 = llvm.mlir.constant(65 : i19) : i19
  %2 = llvm.and %arg360, %0 : i19
  %3 = llvm.icmp "ne" %2, %1 : i19
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ne_with_one_bit_diff_constants2_proof : and_ne_with_one_bit_diff_constants2_before ⊑ and_ne_with_one_bit_diff_constants2_after := by
  unfold and_ne_with_one_bit_diff_constants2_before and_ne_with_one_bit_diff_constants2_after
  simp_alive_peephole
  intros
  ---BEGIN and_ne_with_one_bit_diff_constants2
  all_goals (try extract_goal ; sorry)
  ---END and_ne_with_one_bit_diff_constants2



def and_ne_with_one_bit_diff_constants2_logical_before := [llvm|
{
^0(%arg359 : i19):
  %0 = llvm.mlir.constant(65 : i19) : i19
  %1 = llvm.mlir.constant(193 : i19) : i19
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ne" %arg359, %0 : i19
  %4 = llvm.icmp "ne" %arg359, %1 : i19
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def and_ne_with_one_bit_diff_constants2_logical_after := [llvm|
{
^0(%arg359 : i19):
  %0 = llvm.mlir.constant(-129 : i19) : i19
  %1 = llvm.mlir.constant(65 : i19) : i19
  %2 = llvm.and %arg359, %0 : i19
  %3 = llvm.icmp "ne" %2, %1 : i19
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ne_with_one_bit_diff_constants2_logical_proof : and_ne_with_one_bit_diff_constants2_logical_before ⊑ and_ne_with_one_bit_diff_constants2_logical_after := by
  unfold and_ne_with_one_bit_diff_constants2_logical_before and_ne_with_one_bit_diff_constants2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN and_ne_with_one_bit_diff_constants2_logical
  all_goals (try extract_goal ; sorry)
  ---END and_ne_with_one_bit_diff_constants2_logical



def or_eq_with_one_bit_diff_constants3_before := [llvm|
{
^0(%arg358 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(126 : i8) : i8
  %2 = llvm.icmp "eq" %arg358, %0 : i8
  %3 = llvm.icmp "eq" %arg358, %1 : i8
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_eq_with_one_bit_diff_constants3_after := [llvm|
{
^0(%arg358 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(126 : i8) : i8
  %2 = llvm.and %arg358, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_eq_with_one_bit_diff_constants3_proof : or_eq_with_one_bit_diff_constants3_before ⊑ or_eq_with_one_bit_diff_constants3_after := by
  unfold or_eq_with_one_bit_diff_constants3_before or_eq_with_one_bit_diff_constants3_after
  simp_alive_peephole
  intros
  ---BEGIN or_eq_with_one_bit_diff_constants3
  all_goals (try extract_goal ; sorry)
  ---END or_eq_with_one_bit_diff_constants3



def or_eq_with_one_bit_diff_constants3_logical_before := [llvm|
{
^0(%arg357 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(126 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg357, %0 : i8
  %4 = llvm.icmp "eq" %arg357, %1 : i8
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_eq_with_one_bit_diff_constants3_logical_after := [llvm|
{
^0(%arg357 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(126 : i8) : i8
  %2 = llvm.and %arg357, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_eq_with_one_bit_diff_constants3_logical_proof : or_eq_with_one_bit_diff_constants3_logical_before ⊑ or_eq_with_one_bit_diff_constants3_logical_after := by
  unfold or_eq_with_one_bit_diff_constants3_logical_before or_eq_with_one_bit_diff_constants3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN or_eq_with_one_bit_diff_constants3_logical
  all_goals (try extract_goal ; sorry)
  ---END or_eq_with_one_bit_diff_constants3_logical



def and_ne_with_one_bit_diff_constants3_before := [llvm|
{
^0(%arg356 : i8):
  %0 = llvm.mlir.constant(65 : i8) : i8
  %1 = llvm.mlir.constant(-63 : i8) : i8
  %2 = llvm.icmp "ne" %arg356, %0 : i8
  %3 = llvm.icmp "ne" %arg356, %1 : i8
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_ne_with_one_bit_diff_constants3_after := [llvm|
{
^0(%arg356 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(65 : i8) : i8
  %2 = llvm.and %arg356, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ne_with_one_bit_diff_constants3_proof : and_ne_with_one_bit_diff_constants3_before ⊑ and_ne_with_one_bit_diff_constants3_after := by
  unfold and_ne_with_one_bit_diff_constants3_before and_ne_with_one_bit_diff_constants3_after
  simp_alive_peephole
  intros
  ---BEGIN and_ne_with_one_bit_diff_constants3
  all_goals (try extract_goal ; sorry)
  ---END and_ne_with_one_bit_diff_constants3



def and_ne_with_one_bit_diff_constants3_logical_before := [llvm|
{
^0(%arg355 : i8):
  %0 = llvm.mlir.constant(65 : i8) : i8
  %1 = llvm.mlir.constant(-63 : i8) : i8
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ne" %arg355, %0 : i8
  %4 = llvm.icmp "ne" %arg355, %1 : i8
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def and_ne_with_one_bit_diff_constants3_logical_after := [llvm|
{
^0(%arg355 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(65 : i8) : i8
  %2 = llvm.and %arg355, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ne_with_one_bit_diff_constants3_logical_proof : and_ne_with_one_bit_diff_constants3_logical_before ⊑ and_ne_with_one_bit_diff_constants3_logical_after := by
  unfold and_ne_with_one_bit_diff_constants3_logical_before and_ne_with_one_bit_diff_constants3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN and_ne_with_one_bit_diff_constants3_logical
  all_goals (try extract_goal ; sorry)
  ---END and_ne_with_one_bit_diff_constants3_logical



def or_eq_with_diff_one_before := [llvm|
{
^0(%arg354 : i8):
  %0 = llvm.mlir.constant(13 : i8) : i8
  %1 = llvm.mlir.constant(14 : i8) : i8
  %2 = llvm.icmp "eq" %arg354, %0 : i8
  %3 = llvm.icmp "eq" %arg354, %1 : i8
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_eq_with_diff_one_after := [llvm|
{
^0(%arg354 : i8):
  %0 = llvm.mlir.constant(-13 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.add %arg354, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_eq_with_diff_one_proof : or_eq_with_diff_one_before ⊑ or_eq_with_diff_one_after := by
  unfold or_eq_with_diff_one_before or_eq_with_diff_one_after
  simp_alive_peephole
  intros
  ---BEGIN or_eq_with_diff_one
  all_goals (try extract_goal ; sorry)
  ---END or_eq_with_diff_one



def or_eq_with_diff_one_logical_before := [llvm|
{
^0(%arg353 : i8):
  %0 = llvm.mlir.constant(13 : i8) : i8
  %1 = llvm.mlir.constant(14 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg353, %0 : i8
  %4 = llvm.icmp "eq" %arg353, %1 : i8
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_eq_with_diff_one_logical_after := [llvm|
{
^0(%arg353 : i8):
  %0 = llvm.mlir.constant(-13 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.add %arg353, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_eq_with_diff_one_logical_proof : or_eq_with_diff_one_logical_before ⊑ or_eq_with_diff_one_logical_after := by
  unfold or_eq_with_diff_one_logical_before or_eq_with_diff_one_logical_after
  simp_alive_peephole
  intros
  ---BEGIN or_eq_with_diff_one_logical
  all_goals (try extract_goal ; sorry)
  ---END or_eq_with_diff_one_logical



def and_ne_with_diff_one_before := [llvm|
{
^0(%arg352 : i32):
  %0 = llvm.mlir.constant(40 : i32) : i32
  %1 = llvm.mlir.constant(39 : i32) : i32
  %2 = llvm.icmp "ne" %arg352, %0 : i32
  %3 = llvm.icmp "ne" %arg352, %1 : i32
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_ne_with_diff_one_after := [llvm|
{
^0(%arg352 : i32):
  %0 = llvm.mlir.constant(-41 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.add %arg352, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ne_with_diff_one_proof : and_ne_with_diff_one_before ⊑ and_ne_with_diff_one_after := by
  unfold and_ne_with_diff_one_before and_ne_with_diff_one_after
  simp_alive_peephole
  intros
  ---BEGIN and_ne_with_diff_one
  all_goals (try extract_goal ; sorry)
  ---END and_ne_with_diff_one



def and_ne_with_diff_one_logical_before := [llvm|
{
^0(%arg351 : i32):
  %0 = llvm.mlir.constant(40 : i32) : i32
  %1 = llvm.mlir.constant(39 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ne" %arg351, %0 : i32
  %4 = llvm.icmp "ne" %arg351, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def and_ne_with_diff_one_logical_after := [llvm|
{
^0(%arg351 : i32):
  %0 = llvm.mlir.constant(-41 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.add %arg351, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ne_with_diff_one_logical_proof : and_ne_with_diff_one_logical_before ⊑ and_ne_with_diff_one_logical_after := by
  unfold and_ne_with_diff_one_logical_before and_ne_with_diff_one_logical_after
  simp_alive_peephole
  intros
  ---BEGIN and_ne_with_diff_one_logical
  all_goals (try extract_goal ; sorry)
  ---END and_ne_with_diff_one_logical



def or_eq_with_diff_one_signed_before := [llvm|
{
^0(%arg350 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "eq" %arg350, %0 : i32
  %3 = llvm.icmp "eq" %arg350, %1 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_eq_with_diff_one_signed_after := [llvm|
{
^0(%arg350 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.add %arg350, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_eq_with_diff_one_signed_proof : or_eq_with_diff_one_signed_before ⊑ or_eq_with_diff_one_signed_after := by
  unfold or_eq_with_diff_one_signed_before or_eq_with_diff_one_signed_after
  simp_alive_peephole
  intros
  ---BEGIN or_eq_with_diff_one_signed
  all_goals (try extract_goal ; sorry)
  ---END or_eq_with_diff_one_signed



def or_eq_with_diff_one_signed_logical_before := [llvm|
{
^0(%arg349 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg349, %0 : i32
  %4 = llvm.icmp "eq" %arg349, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_eq_with_diff_one_signed_logical_after := [llvm|
{
^0(%arg349 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.add %arg349, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_eq_with_diff_one_signed_logical_proof : or_eq_with_diff_one_signed_logical_before ⊑ or_eq_with_diff_one_signed_logical_after := by
  unfold or_eq_with_diff_one_signed_logical_before or_eq_with_diff_one_signed_logical_after
  simp_alive_peephole
  intros
  ---BEGIN or_eq_with_diff_one_signed_logical
  all_goals (try extract_goal ; sorry)
  ---END or_eq_with_diff_one_signed_logical



def and_ne_with_diff_one_signed_before := [llvm|
{
^0(%arg348 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.icmp "ne" %arg348, %0 : i64
  %3 = llvm.icmp "ne" %arg348, %1 : i64
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_ne_with_diff_one_signed_after := [llvm|
{
^0(%arg348 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(-2) : i64
  %2 = llvm.add %arg348, %0 : i64
  %3 = llvm.icmp "ult" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ne_with_diff_one_signed_proof : and_ne_with_diff_one_signed_before ⊑ and_ne_with_diff_one_signed_after := by
  unfold and_ne_with_diff_one_signed_before and_ne_with_diff_one_signed_after
  simp_alive_peephole
  intros
  ---BEGIN and_ne_with_diff_one_signed
  all_goals (try extract_goal ; sorry)
  ---END and_ne_with_diff_one_signed



def and_ne_with_diff_one_signed_logical_before := [llvm|
{
^0(%arg347 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ne" %arg347, %0 : i64
  %4 = llvm.icmp "ne" %arg347, %1 : i64
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def and_ne_with_diff_one_signed_logical_after := [llvm|
{
^0(%arg347 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(-2) : i64
  %2 = llvm.add %arg347, %0 : i64
  %3 = llvm.icmp "ult" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ne_with_diff_one_signed_logical_proof : and_ne_with_diff_one_signed_logical_before ⊑ and_ne_with_diff_one_signed_logical_after := by
  unfold and_ne_with_diff_one_signed_logical_before and_ne_with_diff_one_signed_logical_after
  simp_alive_peephole
  intros
  ---BEGIN and_ne_with_diff_one_signed_logical
  all_goals (try extract_goal ; sorry)
  ---END and_ne_with_diff_one_signed_logical



def PR42691_1_before := [llvm|
{
^0(%arg343 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(2147483647 : i32) : i32
  %2 = llvm.icmp "slt" %arg343, %0 : i32
  %3 = llvm.icmp "eq" %arg343, %1 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_1_after := [llvm|
{
^0(%arg343 : i32):
  %0 = llvm.mlir.constant(2147483646 : i32) : i32
  %1 = llvm.icmp "ugt" %arg343, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_1_proof : PR42691_1_before ⊑ PR42691_1_after := by
  unfold PR42691_1_before PR42691_1_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_1
  all_goals (try extract_goal ; sorry)
  ---END PR42691_1



def PR42691_1_logical_before := [llvm|
{
^0(%arg342 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(2147483647 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "slt" %arg342, %0 : i32
  %4 = llvm.icmp "eq" %arg342, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def PR42691_1_logical_after := [llvm|
{
^0(%arg342 : i32):
  %0 = llvm.mlir.constant(2147483646 : i32) : i32
  %1 = llvm.icmp "ugt" %arg342, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_1_logical_proof : PR42691_1_logical_before ⊑ PR42691_1_logical_after := by
  unfold PR42691_1_logical_before PR42691_1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_1_logical
  all_goals (try extract_goal ; sorry)
  ---END PR42691_1_logical



def PR42691_2_before := [llvm|
{
^0(%arg341 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "ult" %arg341, %0 : i32
  %3 = llvm.icmp "eq" %arg341, %1 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_2_after := [llvm|
{
^0(%arg341 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.icmp "sgt" %arg341, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_2_proof : PR42691_2_before ⊑ PR42691_2_after := by
  unfold PR42691_2_before PR42691_2_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_2
  all_goals (try extract_goal ; sorry)
  ---END PR42691_2



def PR42691_2_logical_before := [llvm|
{
^0(%arg340 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ult" %arg340, %0 : i32
  %4 = llvm.icmp "eq" %arg340, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def PR42691_2_logical_after := [llvm|
{
^0(%arg340 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.icmp "sgt" %arg340, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_2_logical_proof : PR42691_2_logical_before ⊑ PR42691_2_logical_after := by
  unfold PR42691_2_logical_before PR42691_2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_2_logical
  all_goals (try extract_goal ; sorry)
  ---END PR42691_2_logical



def PR42691_3_before := [llvm|
{
^0(%arg339 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.icmp "sge" %arg339, %0 : i32
  %3 = llvm.icmp "eq" %arg339, %1 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_3_after := [llvm|
{
^0(%arg339 : i32):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.icmp "ult" %arg339, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_3_proof : PR42691_3_before ⊑ PR42691_3_after := by
  unfold PR42691_3_before PR42691_3_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_3
  all_goals (try extract_goal ; sorry)
  ---END PR42691_3



def PR42691_3_logical_before := [llvm|
{
^0(%arg338 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "sge" %arg338, %0 : i32
  %4 = llvm.icmp "eq" %arg338, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def PR42691_3_logical_after := [llvm|
{
^0(%arg338 : i32):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.icmp "ult" %arg338, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_3_logical_proof : PR42691_3_logical_before ⊑ PR42691_3_logical_after := by
  unfold PR42691_3_logical_before PR42691_3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_3_logical
  all_goals (try extract_goal ; sorry)
  ---END PR42691_3_logical



def PR42691_4_before := [llvm|
{
^0(%arg337 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "uge" %arg337, %0 : i32
  %3 = llvm.icmp "eq" %arg337, %1 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_4_after := [llvm|
{
^0(%arg337 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "slt" %arg337, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_4_proof : PR42691_4_before ⊑ PR42691_4_after := by
  unfold PR42691_4_before PR42691_4_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_4
  all_goals (try extract_goal ; sorry)
  ---END PR42691_4



def PR42691_4_logical_before := [llvm|
{
^0(%arg336 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "uge" %arg336, %0 : i32
  %4 = llvm.icmp "eq" %arg336, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def PR42691_4_logical_after := [llvm|
{
^0(%arg336 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "slt" %arg336, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_4_logical_proof : PR42691_4_logical_before ⊑ PR42691_4_logical_after := by
  unfold PR42691_4_logical_before PR42691_4_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_4_logical
  all_goals (try extract_goal ; sorry)
  ---END PR42691_4_logical



def PR42691_5_before := [llvm|
{
^0(%arg335 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2147483647 : i32) : i32
  %2 = llvm.icmp "slt" %arg335, %0 : i32
  %3 = llvm.icmp "eq" %arg335, %1 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_5_after := [llvm|
{
^0(%arg335 : i32):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-2147483646 : i32) : i32
  %2 = llvm.add %arg335, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_5_proof : PR42691_5_before ⊑ PR42691_5_after := by
  unfold PR42691_5_before PR42691_5_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_5
  all_goals (try extract_goal ; sorry)
  ---END PR42691_5



def PR42691_5_logical_before := [llvm|
{
^0(%arg334 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2147483647 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "slt" %arg334, %0 : i32
  %4 = llvm.icmp "eq" %arg334, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def PR42691_5_logical_after := [llvm|
{
^0(%arg334 : i32):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-2147483646 : i32) : i32
  %2 = llvm.add %arg334, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_5_logical_proof : PR42691_5_logical_before ⊑ PR42691_5_logical_after := by
  unfold PR42691_5_logical_before PR42691_5_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_5_logical
  all_goals (try extract_goal ; sorry)
  ---END PR42691_5_logical



def PR42691_6_before := [llvm|
{
^0(%arg333 : i32):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "ult" %arg333, %0 : i32
  %3 = llvm.icmp "eq" %arg333, %1 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_6_after := [llvm|
{
^0(%arg333 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2147483646 : i32) : i32
  %2 = llvm.add %arg333, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_6_proof : PR42691_6_before ⊑ PR42691_6_after := by
  unfold PR42691_6_before PR42691_6_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_6
  all_goals (try extract_goal ; sorry)
  ---END PR42691_6



def PR42691_6_logical_before := [llvm|
{
^0(%arg332 : i32):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ult" %arg332, %0 : i32
  %4 = llvm.icmp "eq" %arg332, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def PR42691_6_logical_after := [llvm|
{
^0(%arg332 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2147483646 : i32) : i32
  %2 = llvm.add %arg332, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_6_logical_proof : PR42691_6_logical_before ⊑ PR42691_6_logical_after := by
  unfold PR42691_6_logical_before PR42691_6_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_6_logical
  all_goals (try extract_goal ; sorry)
  ---END PR42691_6_logical



def PR42691_7_before := [llvm|
{
^0(%arg331 : i32):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "uge" %arg331, %0 : i32
  %3 = llvm.icmp "eq" %arg331, %1 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_7_after := [llvm|
{
^0(%arg331 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.add %arg331, %0 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_7_proof : PR42691_7_before ⊑ PR42691_7_after := by
  unfold PR42691_7_before PR42691_7_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_7
  all_goals (try extract_goal ; sorry)
  ---END PR42691_7



def PR42691_7_logical_before := [llvm|
{
^0(%arg330 : i32):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "uge" %arg330, %0 : i32
  %4 = llvm.icmp "eq" %arg330, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def PR42691_7_logical_after := [llvm|
{
^0(%arg330 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.add %arg330, %0 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_7_logical_proof : PR42691_7_logical_before ⊑ PR42691_7_logical_after := by
  unfold PR42691_7_logical_before PR42691_7_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_7_logical
  all_goals (try extract_goal ; sorry)
  ---END PR42691_7_logical



def PR42691_8_before := [llvm|
{
^0(%arg329 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.icmp "slt" %arg329, %0 : i32
  %3 = llvm.icmp "ne" %arg329, %1 : i32
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_8_after := [llvm|
{
^0(%arg329 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-2147483635 : i32) : i32
  %2 = llvm.add %arg329, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_8_proof : PR42691_8_before ⊑ PR42691_8_after := by
  unfold PR42691_8_before PR42691_8_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_8
  all_goals (try extract_goal ; sorry)
  ---END PR42691_8



def PR42691_8_logical_before := [llvm|
{
^0(%arg328 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "slt" %arg328, %0 : i32
  %4 = llvm.icmp "ne" %arg328, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def PR42691_8_logical_after := [llvm|
{
^0(%arg328 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-2147483635 : i32) : i32
  %2 = llvm.add %arg328, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_8_logical_proof : PR42691_8_logical_before ⊑ PR42691_8_logical_after := by
  unfold PR42691_8_logical_before PR42691_8_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_8_logical
  all_goals (try extract_goal ; sorry)
  ---END PR42691_8_logical



def PR42691_9_before := [llvm|
{
^0(%arg327 : i32):
  %0 = llvm.mlir.constant(13 : i32) : i32
  %1 = llvm.mlir.constant(2147483647 : i32) : i32
  %2 = llvm.icmp "sgt" %arg327, %0 : i32
  %3 = llvm.icmp "ne" %arg327, %1 : i32
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_9_after := [llvm|
{
^0(%arg327 : i32):
  %0 = llvm.mlir.constant(-14 : i32) : i32
  %1 = llvm.mlir.constant(2147483633 : i32) : i32
  %2 = llvm.add %arg327, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_9_proof : PR42691_9_before ⊑ PR42691_9_after := by
  unfold PR42691_9_before PR42691_9_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_9
  all_goals (try extract_goal ; sorry)
  ---END PR42691_9



def PR42691_9_logical_before := [llvm|
{
^0(%arg326 : i32):
  %0 = llvm.mlir.constant(13 : i32) : i32
  %1 = llvm.mlir.constant(2147483647 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "sgt" %arg326, %0 : i32
  %4 = llvm.icmp "ne" %arg326, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def PR42691_9_logical_after := [llvm|
{
^0(%arg326 : i32):
  %0 = llvm.mlir.constant(-14 : i32) : i32
  %1 = llvm.mlir.constant(2147483633 : i32) : i32
  %2 = llvm.add %arg326, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_9_logical_proof : PR42691_9_logical_before ⊑ PR42691_9_logical_after := by
  unfold PR42691_9_logical_before PR42691_9_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_9_logical
  all_goals (try extract_goal ; sorry)
  ---END PR42691_9_logical



def PR42691_10_before := [llvm|
{
^0(%arg325 : i32):
  %0 = llvm.mlir.constant(13 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "ugt" %arg325, %0 : i32
  %3 = llvm.icmp "ne" %arg325, %1 : i32
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_10_after := [llvm|
{
^0(%arg325 : i32):
  %0 = llvm.mlir.constant(-14 : i32) : i32
  %1 = llvm.mlir.constant(-15 : i32) : i32
  %2 = llvm.add %arg325, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_10_proof : PR42691_10_before ⊑ PR42691_10_after := by
  unfold PR42691_10_before PR42691_10_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_10
  all_goals (try extract_goal ; sorry)
  ---END PR42691_10



def PR42691_10_logical_before := [llvm|
{
^0(%arg324 : i32):
  %0 = llvm.mlir.constant(13 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ugt" %arg324, %0 : i32
  %4 = llvm.icmp "ne" %arg324, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def PR42691_10_logical_after := [llvm|
{
^0(%arg324 : i32):
  %0 = llvm.mlir.constant(-14 : i32) : i32
  %1 = llvm.mlir.constant(-15 : i32) : i32
  %2 = llvm.add %arg324, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR42691_10_logical_proof : PR42691_10_logical_before ⊑ PR42691_10_logical_after := by
  unfold PR42691_10_logical_before PR42691_10_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR42691_10_logical
  all_goals (try extract_goal ; sorry)
  ---END PR42691_10_logical



def substitute_constant_and_eq_eq_before := [llvm|
{
^0(%arg322 : i8, %arg323 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.icmp "eq" %arg322, %0 : i8
  %2 = llvm.icmp "eq" %arg322, %arg323 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def substitute_constant_and_eq_eq_after := [llvm|
{
^0(%arg322 : i8, %arg323 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.icmp "eq" %arg322, %0 : i8
  %2 = llvm.icmp "eq" %arg323, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem substitute_constant_and_eq_eq_proof : substitute_constant_and_eq_eq_before ⊑ substitute_constant_and_eq_eq_after := by
  unfold substitute_constant_and_eq_eq_before substitute_constant_and_eq_eq_after
  simp_alive_peephole
  intros
  ---BEGIN substitute_constant_and_eq_eq
  all_goals (try extract_goal ; sorry)
  ---END substitute_constant_and_eq_eq



def substitute_constant_and_eq_eq_logical_before := [llvm|
{
^0(%arg320 : i8, %arg321 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg320, %0 : i8
  %3 = llvm.icmp "eq" %arg320, %arg321 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def substitute_constant_and_eq_eq_logical_after := [llvm|
{
^0(%arg320 : i8, %arg321 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg320, %0 : i8
  %3 = llvm.icmp "eq" %arg321, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem substitute_constant_and_eq_eq_logical_proof : substitute_constant_and_eq_eq_logical_before ⊑ substitute_constant_and_eq_eq_logical_after := by
  unfold substitute_constant_and_eq_eq_logical_before substitute_constant_and_eq_eq_logical_after
  simp_alive_peephole
  intros
  ---BEGIN substitute_constant_and_eq_eq_logical
  all_goals (try extract_goal ; sorry)
  ---END substitute_constant_and_eq_eq_logical



def substitute_constant_and_eq_eq_commute_before := [llvm|
{
^0(%arg318 : i8, %arg319 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.icmp "eq" %arg318, %0 : i8
  %2 = llvm.icmp "eq" %arg318, %arg319 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def substitute_constant_and_eq_eq_commute_after := [llvm|
{
^0(%arg318 : i8, %arg319 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.icmp "eq" %arg318, %0 : i8
  %2 = llvm.icmp "eq" %arg319, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem substitute_constant_and_eq_eq_commute_proof : substitute_constant_and_eq_eq_commute_before ⊑ substitute_constant_and_eq_eq_commute_after := by
  unfold substitute_constant_and_eq_eq_commute_before substitute_constant_and_eq_eq_commute_after
  simp_alive_peephole
  intros
  ---BEGIN substitute_constant_and_eq_eq_commute
  all_goals (try extract_goal ; sorry)
  ---END substitute_constant_and_eq_eq_commute



def substitute_constant_and_eq_eq_commute_logical_before := [llvm|
{
^0(%arg316 : i8, %arg317 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg316, %0 : i8
  %3 = llvm.icmp "eq" %arg316, %arg317 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def substitute_constant_and_eq_eq_commute_logical_after := [llvm|
{
^0(%arg316 : i8, %arg317 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.icmp "eq" %arg316, %0 : i8
  %2 = llvm.icmp "eq" %arg317, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem substitute_constant_and_eq_eq_commute_logical_proof : substitute_constant_and_eq_eq_commute_logical_before ⊑ substitute_constant_and_eq_eq_commute_logical_after := by
  unfold substitute_constant_and_eq_eq_commute_logical_before substitute_constant_and_eq_eq_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN substitute_constant_and_eq_eq_commute_logical
  all_goals (try extract_goal ; sorry)
  ---END substitute_constant_and_eq_eq_commute_logical



def substitute_constant_and_eq_ugt_swap_before := [llvm|
{
^0(%arg314 : i8, %arg315 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.icmp "eq" %arg314, %0 : i8
  %2 = llvm.icmp "ugt" %arg315, %arg314 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def substitute_constant_and_eq_ugt_swap_after := [llvm|
{
^0(%arg314 : i8, %arg315 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.icmp "eq" %arg314, %0 : i8
  %2 = llvm.icmp "ugt" %arg315, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem substitute_constant_and_eq_ugt_swap_proof : substitute_constant_and_eq_ugt_swap_before ⊑ substitute_constant_and_eq_ugt_swap_after := by
  unfold substitute_constant_and_eq_ugt_swap_before substitute_constant_and_eq_ugt_swap_after
  simp_alive_peephole
  intros
  ---BEGIN substitute_constant_and_eq_ugt_swap
  all_goals (try extract_goal ; sorry)
  ---END substitute_constant_and_eq_ugt_swap



def substitute_constant_and_eq_ugt_swap_logical_before := [llvm|
{
^0(%arg312 : i8, %arg313 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg312, %0 : i8
  %3 = llvm.icmp "ugt" %arg313, %arg312 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def substitute_constant_and_eq_ugt_swap_logical_after := [llvm|
{
^0(%arg312 : i8, %arg313 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.icmp "eq" %arg312, %0 : i8
  %2 = llvm.icmp "ugt" %arg313, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem substitute_constant_and_eq_ugt_swap_logical_proof : substitute_constant_and_eq_ugt_swap_logical_before ⊑ substitute_constant_and_eq_ugt_swap_logical_after := by
  unfold substitute_constant_and_eq_ugt_swap_logical_before substitute_constant_and_eq_ugt_swap_logical_after
  simp_alive_peephole
  intros
  ---BEGIN substitute_constant_and_eq_ugt_swap_logical
  all_goals (try extract_goal ; sorry)
  ---END substitute_constant_and_eq_ugt_swap_logical



def substitute_constant_and_ne_ugt_swap_logical_before := [llvm|
{
^0(%arg288 : i8, %arg289 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ne" %arg288, %0 : i8
  %3 = llvm.icmp "ugt" %arg289, %arg288 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def substitute_constant_and_ne_ugt_swap_logical_after := [llvm|
{
^0(%arg288 : i8, %arg289 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.icmp "ne" %arg288, %0 : i8
  %2 = llvm.icmp "ugt" %arg289, %arg288 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem substitute_constant_and_ne_ugt_swap_logical_proof : substitute_constant_and_ne_ugt_swap_logical_before ⊑ substitute_constant_and_ne_ugt_swap_logical_after := by
  unfold substitute_constant_and_ne_ugt_swap_logical_before substitute_constant_and_ne_ugt_swap_logical_after
  simp_alive_peephole
  intros
  ---BEGIN substitute_constant_and_ne_ugt_swap_logical
  all_goals (try extract_goal ; sorry)
  ---END substitute_constant_and_ne_ugt_swap_logical



def substitute_constant_or_ne_swap_sle_before := [llvm|
{
^0(%arg286 : i8, %arg287 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.icmp "ne" %arg286, %0 : i8
  %2 = llvm.icmp "sle" %arg287, %arg286 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def substitute_constant_or_ne_swap_sle_after := [llvm|
{
^0(%arg286 : i8, %arg287 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(43 : i8) : i8
  %2 = llvm.icmp "ne" %arg286, %0 : i8
  %3 = llvm.icmp "slt" %arg287, %1 : i8
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem substitute_constant_or_ne_swap_sle_proof : substitute_constant_or_ne_swap_sle_before ⊑ substitute_constant_or_ne_swap_sle_after := by
  unfold substitute_constant_or_ne_swap_sle_before substitute_constant_or_ne_swap_sle_after
  simp_alive_peephole
  intros
  ---BEGIN substitute_constant_or_ne_swap_sle
  all_goals (try extract_goal ; sorry)
  ---END substitute_constant_or_ne_swap_sle



def substitute_constant_or_ne_swap_sle_logical_before := [llvm|
{
^0(%arg284 : i8, %arg285 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ne" %arg284, %0 : i8
  %3 = llvm.icmp "sle" %arg285, %arg284 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def substitute_constant_or_ne_swap_sle_logical_after := [llvm|
{
^0(%arg284 : i8, %arg285 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(43 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ne" %arg284, %0 : i8
  %4 = llvm.icmp "slt" %arg285, %1 : i8
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem substitute_constant_or_ne_swap_sle_logical_proof : substitute_constant_or_ne_swap_sle_logical_before ⊑ substitute_constant_or_ne_swap_sle_logical_after := by
  unfold substitute_constant_or_ne_swap_sle_logical_before substitute_constant_or_ne_swap_sle_logical_after
  simp_alive_peephole
  intros
  ---BEGIN substitute_constant_or_ne_swap_sle_logical
  all_goals (try extract_goal ; sorry)
  ---END substitute_constant_or_ne_swap_sle_logical



def substitute_constant_or_ne_uge_commute_before := [llvm|
{
^0(%arg282 : i8, %arg283 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.icmp "ne" %arg282, %0 : i8
  %2 = llvm.icmp "uge" %arg282, %arg283 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def substitute_constant_or_ne_uge_commute_after := [llvm|
{
^0(%arg282 : i8, %arg283 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(43 : i8) : i8
  %2 = llvm.icmp "ne" %arg282, %0 : i8
  %3 = llvm.icmp "ult" %arg283, %1 : i8
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem substitute_constant_or_ne_uge_commute_proof : substitute_constant_or_ne_uge_commute_before ⊑ substitute_constant_or_ne_uge_commute_after := by
  unfold substitute_constant_or_ne_uge_commute_before substitute_constant_or_ne_uge_commute_after
  simp_alive_peephole
  intros
  ---BEGIN substitute_constant_or_ne_uge_commute
  all_goals (try extract_goal ; sorry)
  ---END substitute_constant_or_ne_uge_commute



def substitute_constant_or_ne_uge_commute_logical_before := [llvm|
{
^0(%arg280 : i8, %arg281 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ne" %arg280, %0 : i8
  %3 = llvm.icmp "uge" %arg280, %arg281 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def substitute_constant_or_ne_uge_commute_logical_after := [llvm|
{
^0(%arg280 : i8, %arg281 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(43 : i8) : i8
  %2 = llvm.icmp "ne" %arg280, %0 : i8
  %3 = llvm.icmp "ult" %arg281, %1 : i8
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem substitute_constant_or_ne_uge_commute_logical_proof : substitute_constant_or_ne_uge_commute_logical_before ⊑ substitute_constant_or_ne_uge_commute_logical_after := by
  unfold substitute_constant_or_ne_uge_commute_logical_before substitute_constant_or_ne_uge_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN substitute_constant_or_ne_uge_commute_logical
  all_goals (try extract_goal ; sorry)
  ---END substitute_constant_or_ne_uge_commute_logical



def or_ranges_overlap_before := [llvm|
{
^0(%arg261 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.mlir.constant(20 : i8) : i8
  %3 = llvm.icmp "uge" %arg261, %0 : i8
  %4 = llvm.icmp "ule" %arg261, %1 : i8
  %5 = llvm.and %3, %4 : i1
  %6 = llvm.icmp "uge" %arg261, %1 : i8
  %7 = llvm.icmp "ule" %arg261, %2 : i8
  %8 = llvm.and %6, %7 : i1
  %9 = llvm.or %5, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def or_ranges_overlap_after := [llvm|
{
^0(%arg261 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.mlir.constant(16 : i8) : i8
  %2 = llvm.add %arg261, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_ranges_overlap_proof : or_ranges_overlap_before ⊑ or_ranges_overlap_after := by
  unfold or_ranges_overlap_before or_ranges_overlap_after
  simp_alive_peephole
  intros
  ---BEGIN or_ranges_overlap
  all_goals (try extract_goal ; sorry)
  ---END or_ranges_overlap



def or_ranges_adjacent_before := [llvm|
{
^0(%arg260 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.mlir.constant(11 : i8) : i8
  %3 = llvm.mlir.constant(20 : i8) : i8
  %4 = llvm.icmp "uge" %arg260, %0 : i8
  %5 = llvm.icmp "ule" %arg260, %1 : i8
  %6 = llvm.and %4, %5 : i1
  %7 = llvm.icmp "uge" %arg260, %2 : i8
  %8 = llvm.icmp "ule" %arg260, %3 : i8
  %9 = llvm.and %7, %8 : i1
  %10 = llvm.or %6, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def or_ranges_adjacent_after := [llvm|
{
^0(%arg260 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.mlir.constant(16 : i8) : i8
  %2 = llvm.add %arg260, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_ranges_adjacent_proof : or_ranges_adjacent_before ⊑ or_ranges_adjacent_after := by
  unfold or_ranges_adjacent_before or_ranges_adjacent_after
  simp_alive_peephole
  intros
  ---BEGIN or_ranges_adjacent
  all_goals (try extract_goal ; sorry)
  ---END or_ranges_adjacent



def or_ranges_separated_before := [llvm|
{
^0(%arg259 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.mlir.constant(12 : i8) : i8
  %3 = llvm.mlir.constant(20 : i8) : i8
  %4 = llvm.icmp "uge" %arg259, %0 : i8
  %5 = llvm.icmp "ule" %arg259, %1 : i8
  %6 = llvm.and %4, %5 : i1
  %7 = llvm.icmp "uge" %arg259, %2 : i8
  %8 = llvm.icmp "ule" %arg259, %3 : i8
  %9 = llvm.and %7, %8 : i1
  %10 = llvm.or %6, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def or_ranges_separated_after := [llvm|
{
^0(%arg259 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.mlir.constant(-12 : i8) : i8
  %3 = llvm.mlir.constant(9 : i8) : i8
  %4 = llvm.add %arg259, %0 : i8
  %5 = llvm.icmp "ult" %4, %1 : i8
  %6 = llvm.add %arg259, %2 : i8
  %7 = llvm.icmp "ult" %6, %3 : i8
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_ranges_separated_proof : or_ranges_separated_before ⊑ or_ranges_separated_after := by
  unfold or_ranges_separated_before or_ranges_separated_after
  simp_alive_peephole
  intros
  ---BEGIN or_ranges_separated
  all_goals (try extract_goal ; sorry)
  ---END or_ranges_separated



def or_ranges_single_elem_right_before := [llvm|
{
^0(%arg258 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.mlir.constant(11 : i8) : i8
  %3 = llvm.icmp "uge" %arg258, %0 : i8
  %4 = llvm.icmp "ule" %arg258, %1 : i8
  %5 = llvm.and %3, %4 : i1
  %6 = llvm.icmp "eq" %arg258, %2 : i8
  %7 = llvm.or %5, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def or_ranges_single_elem_right_after := [llvm|
{
^0(%arg258 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.add %arg258, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_ranges_single_elem_right_proof : or_ranges_single_elem_right_before ⊑ or_ranges_single_elem_right_after := by
  unfold or_ranges_single_elem_right_before or_ranges_single_elem_right_after
  simp_alive_peephole
  intros
  ---BEGIN or_ranges_single_elem_right
  all_goals (try extract_goal ; sorry)
  ---END or_ranges_single_elem_right



def or_ranges_single_elem_left_before := [llvm|
{
^0(%arg257 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.mlir.constant(4 : i8) : i8
  %3 = llvm.icmp "uge" %arg257, %0 : i8
  %4 = llvm.icmp "ule" %arg257, %1 : i8
  %5 = llvm.and %3, %4 : i1
  %6 = llvm.icmp "eq" %arg257, %2 : i8
  %7 = llvm.or %5, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def or_ranges_single_elem_left_after := [llvm|
{
^0(%arg257 : i8):
  %0 = llvm.mlir.constant(-4 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.add %arg257, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_ranges_single_elem_left_proof : or_ranges_single_elem_left_before ⊑ or_ranges_single_elem_left_after := by
  unfold or_ranges_single_elem_left_before or_ranges_single_elem_left_after
  simp_alive_peephole
  intros
  ---BEGIN or_ranges_single_elem_left
  all_goals (try extract_goal ; sorry)
  ---END or_ranges_single_elem_left



def and_ranges_overlap_before := [llvm|
{
^0(%arg256 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.mlir.constant(7 : i8) : i8
  %3 = llvm.mlir.constant(20 : i8) : i8
  %4 = llvm.icmp "uge" %arg256, %0 : i8
  %5 = llvm.icmp "ule" %arg256, %1 : i8
  %6 = llvm.and %4, %5 : i1
  %7 = llvm.icmp "uge" %arg256, %2 : i8
  %8 = llvm.icmp "ule" %arg256, %3 : i8
  %9 = llvm.and %7, %8 : i1
  %10 = llvm.and %6, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def and_ranges_overlap_after := [llvm|
{
^0(%arg256 : i8):
  %0 = llvm.mlir.constant(-7 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.add %arg256, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ranges_overlap_proof : and_ranges_overlap_before ⊑ and_ranges_overlap_after := by
  unfold and_ranges_overlap_before and_ranges_overlap_after
  simp_alive_peephole
  intros
  ---BEGIN and_ranges_overlap
  all_goals (try extract_goal ; sorry)
  ---END and_ranges_overlap



def and_ranges_overlap_single_before := [llvm|
{
^0(%arg255 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.mlir.constant(20 : i8) : i8
  %3 = llvm.icmp "uge" %arg255, %0 : i8
  %4 = llvm.icmp "ule" %arg255, %1 : i8
  %5 = llvm.and %3, %4 : i1
  %6 = llvm.icmp "uge" %arg255, %1 : i8
  %7 = llvm.icmp "ule" %arg255, %2 : i8
  %8 = llvm.and %6, %7 : i1
  %9 = llvm.and %5, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def and_ranges_overlap_single_after := [llvm|
{
^0(%arg255 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.icmp "eq" %arg255, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ranges_overlap_single_proof : and_ranges_overlap_single_before ⊑ and_ranges_overlap_single_after := by
  unfold and_ranges_overlap_single_before and_ranges_overlap_single_after
  simp_alive_peephole
  intros
  ---BEGIN and_ranges_overlap_single
  all_goals (try extract_goal ; sorry)
  ---END and_ranges_overlap_single



def and_ranges_no_overlap_before := [llvm|
{
^0(%arg254 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.mlir.constant(11 : i8) : i8
  %3 = llvm.mlir.constant(20 : i8) : i8
  %4 = llvm.icmp "uge" %arg254, %0 : i8
  %5 = llvm.icmp "ule" %arg254, %1 : i8
  %6 = llvm.and %4, %5 : i1
  %7 = llvm.icmp "uge" %arg254, %2 : i8
  %8 = llvm.icmp "ule" %arg254, %3 : i8
  %9 = llvm.and %7, %8 : i1
  %10 = llvm.and %6, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def and_ranges_no_overlap_after := [llvm|
{
^0(%arg254 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ranges_no_overlap_proof : and_ranges_no_overlap_before ⊑ and_ranges_no_overlap_after := by
  unfold and_ranges_no_overlap_before and_ranges_no_overlap_after
  simp_alive_peephole
  intros
  ---BEGIN and_ranges_no_overlap
  all_goals (try extract_goal ; sorry)
  ---END and_ranges_no_overlap



def and_ranges_signed_pred_before := [llvm|
{
^0(%arg253 : i64):
  %0 = llvm.mlir.constant(127) : i64
  %1 = llvm.mlir.constant(1024) : i64
  %2 = llvm.mlir.constant(128) : i64
  %3 = llvm.mlir.constant(256) : i64
  %4 = llvm.add %arg253, %0 : i64
  %5 = llvm.icmp "slt" %4, %1 : i64
  %6 = llvm.add %arg253, %2 : i64
  %7 = llvm.icmp "slt" %6, %3 : i64
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def and_ranges_signed_pred_after := [llvm|
{
^0(%arg253 : i64):
  %0 = llvm.mlir.constant(-9223372036854775681) : i64
  %1 = llvm.mlir.constant(-9223372036854775553) : i64
  %2 = llvm.add %arg253, %0 : i64
  %3 = llvm.icmp "ult" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ranges_signed_pred_proof : and_ranges_signed_pred_before ⊑ and_ranges_signed_pred_after := by
  unfold and_ranges_signed_pred_before and_ranges_signed_pred_after
  simp_alive_peephole
  intros
  ---BEGIN and_ranges_signed_pred
  all_goals (try extract_goal ; sorry)
  ---END and_ranges_signed_pred



def and_two_ranges_to_mask_and_range_before := [llvm|
{
^0(%arg252 : i8):
  %0 = llvm.mlir.constant(-97 : i8) : i8
  %1 = llvm.mlir.constant(25 : i8) : i8
  %2 = llvm.mlir.constant(-65 : i8) : i8
  %3 = llvm.add %arg252, %0 : i8
  %4 = llvm.icmp "ugt" %3, %1 : i8
  %5 = llvm.add %arg252, %2 : i8
  %6 = llvm.icmp "ugt" %5, %1 : i8
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def and_two_ranges_to_mask_and_range_after := [llvm|
{
^0(%arg252 : i8):
  %0 = llvm.mlir.constant(-33 : i8) : i8
  %1 = llvm.mlir.constant(-91 : i8) : i8
  %2 = llvm.mlir.constant(-26 : i8) : i8
  %3 = llvm.and %arg252, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.icmp "ult" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_two_ranges_to_mask_and_range_proof : and_two_ranges_to_mask_and_range_before ⊑ and_two_ranges_to_mask_and_range_after := by
  unfold and_two_ranges_to_mask_and_range_before and_two_ranges_to_mask_and_range_after
  simp_alive_peephole
  intros
  ---BEGIN and_two_ranges_to_mask_and_range
  all_goals (try extract_goal ; sorry)
  ---END and_two_ranges_to_mask_and_range



def and_two_ranges_to_mask_and_range_not_pow2_diff_before := [llvm|
{
^0(%arg251 : i8):
  %0 = llvm.mlir.constant(-97 : i8) : i8
  %1 = llvm.mlir.constant(25 : i8) : i8
  %2 = llvm.mlir.constant(-64 : i8) : i8
  %3 = llvm.add %arg251, %0 : i8
  %4 = llvm.icmp "ugt" %3, %1 : i8
  %5 = llvm.add %arg251, %2 : i8
  %6 = llvm.icmp "ugt" %5, %1 : i8
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def and_two_ranges_to_mask_and_range_not_pow2_diff_after := [llvm|
{
^0(%arg251 : i8):
  %0 = llvm.mlir.constant(-123 : i8) : i8
  %1 = llvm.mlir.constant(-26 : i8) : i8
  %2 = llvm.mlir.constant(-90 : i8) : i8
  %3 = llvm.add %arg251, %0 : i8
  %4 = llvm.icmp "ult" %3, %1 : i8
  %5 = llvm.add %arg251, %2 : i8
  %6 = llvm.icmp "ult" %5, %1 : i8
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_two_ranges_to_mask_and_range_not_pow2_diff_proof : and_two_ranges_to_mask_and_range_not_pow2_diff_before ⊑ and_two_ranges_to_mask_and_range_not_pow2_diff_after := by
  unfold and_two_ranges_to_mask_and_range_not_pow2_diff_before and_two_ranges_to_mask_and_range_not_pow2_diff_after
  simp_alive_peephole
  intros
  ---BEGIN and_two_ranges_to_mask_and_range_not_pow2_diff
  all_goals (try extract_goal ; sorry)
  ---END and_two_ranges_to_mask_and_range_not_pow2_diff



def and_two_ranges_to_mask_and_range_different_sizes_before := [llvm|
{
^0(%arg250 : i8):
  %0 = llvm.mlir.constant(-97 : i8) : i8
  %1 = llvm.mlir.constant(25 : i8) : i8
  %2 = llvm.mlir.constant(-65 : i8) : i8
  %3 = llvm.mlir.constant(24 : i8) : i8
  %4 = llvm.add %arg250, %0 : i8
  %5 = llvm.icmp "ugt" %4, %1 : i8
  %6 = llvm.add %arg250, %2 : i8
  %7 = llvm.icmp "ugt" %6, %3 : i8
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def and_two_ranges_to_mask_and_range_different_sizes_after := [llvm|
{
^0(%arg250 : i8):
  %0 = llvm.mlir.constant(-123 : i8) : i8
  %1 = llvm.mlir.constant(-26 : i8) : i8
  %2 = llvm.mlir.constant(-90 : i8) : i8
  %3 = llvm.mlir.constant(-25 : i8) : i8
  %4 = llvm.add %arg250, %0 : i8
  %5 = llvm.icmp "ult" %4, %1 : i8
  %6 = llvm.add %arg250, %2 : i8
  %7 = llvm.icmp "ult" %6, %3 : i8
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_two_ranges_to_mask_and_range_different_sizes_proof : and_two_ranges_to_mask_and_range_different_sizes_before ⊑ and_two_ranges_to_mask_and_range_different_sizes_after := by
  unfold and_two_ranges_to_mask_and_range_different_sizes_before and_two_ranges_to_mask_and_range_different_sizes_after
  simp_alive_peephole
  intros
  ---BEGIN and_two_ranges_to_mask_and_range_different_sizes
  all_goals (try extract_goal ; sorry)
  ---END and_two_ranges_to_mask_and_range_different_sizes



def and_two_ranges_to_mask_and_range_no_add_on_one_range_before := [llvm|
{
^0(%arg249 : i16):
  %0 = llvm.mlir.constant(12 : i16) : i16
  %1 = llvm.mlir.constant(16 : i16) : i16
  %2 = llvm.mlir.constant(28 : i16) : i16
  %3 = llvm.icmp "uge" %arg249, %0 : i16
  %4 = llvm.icmp "ult" %arg249, %1 : i16
  %5 = llvm.icmp "uge" %arg249, %2 : i16
  %6 = llvm.or %4, %5 : i1
  %7 = llvm.and %3, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def and_two_ranges_to_mask_and_range_no_add_on_one_range_after := [llvm|
{
^0(%arg249 : i16):
  %0 = llvm.mlir.constant(-20 : i16) : i16
  %1 = llvm.mlir.constant(11 : i16) : i16
  %2 = llvm.and %arg249, %0 : i16
  %3 = llvm.icmp "ugt" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_two_ranges_to_mask_and_range_no_add_on_one_range_proof : and_two_ranges_to_mask_and_range_no_add_on_one_range_before ⊑ and_two_ranges_to_mask_and_range_no_add_on_one_range_after := by
  unfold and_two_ranges_to_mask_and_range_no_add_on_one_range_before and_two_ranges_to_mask_and_range_no_add_on_one_range_after
  simp_alive_peephole
  intros
  ---BEGIN and_two_ranges_to_mask_and_range_no_add_on_one_range
  all_goals (try extract_goal ; sorry)
  ---END and_two_ranges_to_mask_and_range_no_add_on_one_range



def is_ascii_alphabetic_before := [llvm|
{
^0(%arg248 : i32):
  %0 = llvm.mlir.constant(-65 : i32) : i32
  %1 = llvm.mlir.constant(26 : i32) : i32
  %2 = llvm.mlir.constant(-97 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.add %arg248, %0 overflow<nsw> : i32
  %5 = llvm.icmp "ult" %4, %1 : i32
  %6 = llvm.add %arg248, %2 overflow<nsw> : i32
  %7 = llvm.icmp "ult" %6, %1 : i32
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def is_ascii_alphabetic_after := [llvm|
{
^0(%arg248 : i32):
  %0 = llvm.mlir.constant(-33 : i32) : i32
  %1 = llvm.mlir.constant(-65 : i32) : i32
  %2 = llvm.mlir.constant(26 : i32) : i32
  %3 = llvm.and %arg248, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.icmp "ult" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem is_ascii_alphabetic_proof : is_ascii_alphabetic_before ⊑ is_ascii_alphabetic_after := by
  unfold is_ascii_alphabetic_before is_ascii_alphabetic_after
  simp_alive_peephole
  intros
  ---BEGIN is_ascii_alphabetic
  all_goals (try extract_goal ; sorry)
  ---END is_ascii_alphabetic



def is_ascii_alphabetic_inverted_before := [llvm|
{
^0(%arg247 : i32):
  %0 = llvm.mlir.constant(-91 : i32) : i32
  %1 = llvm.mlir.constant(-26 : i32) : i32
  %2 = llvm.mlir.constant(-123 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.add %arg247, %0 overflow<nsw> : i32
  %5 = llvm.icmp "ult" %4, %1 : i32
  %6 = llvm.add %arg247, %2 overflow<nsw> : i32
  %7 = llvm.icmp "ult" %6, %1 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def is_ascii_alphabetic_inverted_after := [llvm|
{
^0(%arg247 : i32):
  %0 = llvm.mlir.constant(-33 : i32) : i32
  %1 = llvm.mlir.constant(-91 : i32) : i32
  %2 = llvm.mlir.constant(-26 : i32) : i32
  %3 = llvm.and %arg247, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.icmp "ult" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem is_ascii_alphabetic_inverted_proof : is_ascii_alphabetic_inverted_before ⊑ is_ascii_alphabetic_inverted_after := by
  unfold is_ascii_alphabetic_inverted_before is_ascii_alphabetic_inverted_after
  simp_alive_peephole
  intros
  ---BEGIN is_ascii_alphabetic_inverted
  all_goals (try extract_goal ; sorry)
  ---END is_ascii_alphabetic_inverted



def bitwise_and_bitwise_and_icmps_before := [llvm|
{
^0(%arg244 : i8, %arg245 : i8, %arg246 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "eq" %arg245, %0 : i8
  %4 = llvm.and %arg244, %1 : i8
  %5 = llvm.shl %1, %arg246 : i8
  %6 = llvm.and %arg244, %5 : i8
  %7 = llvm.icmp "ne" %4, %2 : i8
  %8 = llvm.icmp "ne" %6, %2 : i8
  %9 = llvm.and %3, %7 : i1
  %10 = llvm.and %9, %8 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_and_bitwise_and_icmps_after := [llvm|
{
^0(%arg244 : i8, %arg245 : i8, %arg246 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg245, %0 : i8
  %3 = llvm.shl %1, %arg246 overflow<nuw> : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %arg244, %4 : i8
  %6 = llvm.icmp "eq" %5, %4 : i8
  %7 = llvm.and %2, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_bitwise_and_icmps_proof : bitwise_and_bitwise_and_icmps_before ⊑ bitwise_and_bitwise_and_icmps_after := by
  unfold bitwise_and_bitwise_and_icmps_before bitwise_and_bitwise_and_icmps_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_bitwise_and_icmps
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_bitwise_and_icmps



def bitwise_and_bitwise_and_icmps_comm1_before := [llvm|
{
^0(%arg241 : i8, %arg242 : i8, %arg243 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "eq" %arg242, %0 : i8
  %4 = llvm.and %arg241, %1 : i8
  %5 = llvm.shl %1, %arg243 : i8
  %6 = llvm.and %arg241, %5 : i8
  %7 = llvm.icmp "ne" %4, %2 : i8
  %8 = llvm.icmp "ne" %6, %2 : i8
  %9 = llvm.and %3, %7 : i1
  %10 = llvm.and %8, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_and_bitwise_and_icmps_comm1_after := [llvm|
{
^0(%arg241 : i8, %arg242 : i8, %arg243 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg242, %0 : i8
  %3 = llvm.shl %1, %arg243 overflow<nuw> : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %arg241, %4 : i8
  %6 = llvm.icmp "eq" %5, %4 : i8
  %7 = llvm.and %2, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_bitwise_and_icmps_comm1_proof : bitwise_and_bitwise_and_icmps_comm1_before ⊑ bitwise_and_bitwise_and_icmps_comm1_after := by
  unfold bitwise_and_bitwise_and_icmps_comm1_before bitwise_and_bitwise_and_icmps_comm1_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_bitwise_and_icmps_comm1
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_bitwise_and_icmps_comm1



def bitwise_and_bitwise_and_icmps_comm2_before := [llvm|
{
^0(%arg238 : i8, %arg239 : i8, %arg240 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "eq" %arg239, %0 : i8
  %4 = llvm.and %arg238, %1 : i8
  %5 = llvm.shl %1, %arg240 : i8
  %6 = llvm.and %arg238, %5 : i8
  %7 = llvm.icmp "ne" %4, %2 : i8
  %8 = llvm.icmp "ne" %6, %2 : i8
  %9 = llvm.and %7, %3 : i1
  %10 = llvm.and %9, %8 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_and_bitwise_and_icmps_comm2_after := [llvm|
{
^0(%arg238 : i8, %arg239 : i8, %arg240 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg239, %0 : i8
  %3 = llvm.shl %1, %arg240 overflow<nuw> : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %arg238, %4 : i8
  %6 = llvm.icmp "eq" %5, %4 : i8
  %7 = llvm.and %6, %2 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_bitwise_and_icmps_comm2_proof : bitwise_and_bitwise_and_icmps_comm2_before ⊑ bitwise_and_bitwise_and_icmps_comm2_after := by
  unfold bitwise_and_bitwise_and_icmps_comm2_before bitwise_and_bitwise_and_icmps_comm2_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_bitwise_and_icmps_comm2
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_bitwise_and_icmps_comm2



def bitwise_and_bitwise_and_icmps_comm3_before := [llvm|
{
^0(%arg235 : i8, %arg236 : i8, %arg237 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "eq" %arg236, %0 : i8
  %4 = llvm.and %arg235, %1 : i8
  %5 = llvm.shl %1, %arg237 : i8
  %6 = llvm.and %arg235, %5 : i8
  %7 = llvm.icmp "ne" %4, %2 : i8
  %8 = llvm.icmp "ne" %6, %2 : i8
  %9 = llvm.and %7, %3 : i1
  %10 = llvm.and %8, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_and_bitwise_and_icmps_comm3_after := [llvm|
{
^0(%arg235 : i8, %arg236 : i8, %arg237 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg236, %0 : i8
  %3 = llvm.shl %1, %arg237 overflow<nuw> : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %arg235, %4 : i8
  %6 = llvm.icmp "eq" %5, %4 : i8
  %7 = llvm.and %6, %2 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_bitwise_and_icmps_comm3_proof : bitwise_and_bitwise_and_icmps_comm3_before ⊑ bitwise_and_bitwise_and_icmps_comm3_after := by
  unfold bitwise_and_bitwise_and_icmps_comm3_before bitwise_and_bitwise_and_icmps_comm3_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_bitwise_and_icmps_comm3
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_bitwise_and_icmps_comm3



def bitwise_and_logical_and_icmps_before := [llvm|
{
^0(%arg232 : i8, %arg233 : i8, %arg234 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg233, %0 : i8
  %5 = llvm.and %arg232, %1 : i8
  %6 = llvm.shl %1, %arg234 : i8
  %7 = llvm.and %arg232, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = "llvm.select"(%4, %8, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = llvm.and %10, %9 : i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def bitwise_and_logical_and_icmps_after := [llvm|
{
^0(%arg232 : i8, %arg233 : i8, %arg234 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "eq" %arg233, %0 : i8
  %4 = llvm.shl %1, %arg234 overflow<nuw> : i8
  %5 = llvm.or %4, %1 : i8
  %6 = llvm.and %arg232, %5 : i8
  %7 = llvm.icmp "eq" %6, %5 : i8
  %8 = "llvm.select"(%3, %7, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_logical_and_icmps_proof : bitwise_and_logical_and_icmps_before ⊑ bitwise_and_logical_and_icmps_after := by
  unfold bitwise_and_logical_and_icmps_before bitwise_and_logical_and_icmps_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_logical_and_icmps
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_logical_and_icmps



def bitwise_and_logical_and_icmps_comm1_before := [llvm|
{
^0(%arg229 : i8, %arg230 : i8, %arg231 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg230, %0 : i8
  %5 = llvm.and %arg229, %1 : i8
  %6 = llvm.shl %1, %arg231 : i8
  %7 = llvm.and %arg229, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = "llvm.select"(%4, %8, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = llvm.and %9, %10 : i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def bitwise_and_logical_and_icmps_comm1_after := [llvm|
{
^0(%arg229 : i8, %arg230 : i8, %arg231 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "eq" %arg230, %0 : i8
  %4 = llvm.shl %1, %arg231 overflow<nuw> : i8
  %5 = llvm.or %4, %1 : i8
  %6 = llvm.and %arg229, %5 : i8
  %7 = llvm.icmp "eq" %6, %5 : i8
  %8 = "llvm.select"(%3, %7, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_logical_and_icmps_comm1_proof : bitwise_and_logical_and_icmps_comm1_before ⊑ bitwise_and_logical_and_icmps_comm1_after := by
  unfold bitwise_and_logical_and_icmps_comm1_before bitwise_and_logical_and_icmps_comm1_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_logical_and_icmps_comm1
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_logical_and_icmps_comm1



def bitwise_and_logical_and_icmps_comm3_before := [llvm|
{
^0(%arg223 : i8, %arg224 : i8, %arg225 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg224, %0 : i8
  %5 = llvm.and %arg223, %1 : i8
  %6 = llvm.shl %1, %arg225 : i8
  %7 = llvm.and %arg223, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = "llvm.select"(%8, %4, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = llvm.and %9, %10 : i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def bitwise_and_logical_and_icmps_comm3_after := [llvm|
{
^0(%arg223 : i8, %arg224 : i8, %arg225 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "eq" %arg224, %0 : i8
  %4 = llvm.shl %1, %arg225 overflow<nuw> : i8
  %5 = llvm.or %4, %1 : i8
  %6 = llvm.and %arg223, %5 : i8
  %7 = llvm.icmp "eq" %6, %5 : i8
  %8 = "llvm.select"(%7, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_logical_and_icmps_comm3_proof : bitwise_and_logical_and_icmps_comm3_before ⊑ bitwise_and_logical_and_icmps_comm3_after := by
  unfold bitwise_and_logical_and_icmps_comm3_before bitwise_and_logical_and_icmps_comm3_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_logical_and_icmps_comm3
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_logical_and_icmps_comm3



def logical_and_bitwise_and_icmps_before := [llvm|
{
^0(%arg220 : i8, %arg221 : i8, %arg222 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg221, %0 : i8
  %5 = llvm.and %arg220, %1 : i8
  %6 = llvm.shl %1, %arg222 : i8
  %7 = llvm.and %arg220, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = llvm.and %4, %8 : i1
  %11 = "llvm.select"(%10, %9, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_and_bitwise_and_icmps_after := [llvm|
{
^0(%arg220 : i8, %arg221 : i8, %arg222 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg221, %0 : i8
  %5 = llvm.and %arg220, %1 : i8
  %6 = llvm.shl %1, %arg222 overflow<nuw> : i8
  %7 = llvm.and %arg220, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = llvm.and %4, %8 : i1
  %11 = "llvm.select"(%10, %9, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_bitwise_and_icmps_proof : logical_and_bitwise_and_icmps_before ⊑ logical_and_bitwise_and_icmps_after := by
  unfold logical_and_bitwise_and_icmps_before logical_and_bitwise_and_icmps_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_bitwise_and_icmps
  all_goals (try extract_goal ; sorry)
  ---END logical_and_bitwise_and_icmps



def logical_and_bitwise_and_icmps_comm1_before := [llvm|
{
^0(%arg217 : i8, %arg218 : i8, %arg219 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg218, %0 : i8
  %5 = llvm.and %arg217, %1 : i8
  %6 = llvm.shl %1, %arg219 : i8
  %7 = llvm.and %arg217, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = llvm.and %4, %8 : i1
  %11 = "llvm.select"(%9, %10, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_and_bitwise_and_icmps_comm1_after := [llvm|
{
^0(%arg217 : i8, %arg218 : i8, %arg219 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg218, %0 : i8
  %5 = llvm.and %arg217, %1 : i8
  %6 = llvm.shl %1, %arg219 overflow<nuw> : i8
  %7 = llvm.and %arg217, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = llvm.and %4, %8 : i1
  %11 = "llvm.select"(%9, %10, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_bitwise_and_icmps_comm1_proof : logical_and_bitwise_and_icmps_comm1_before ⊑ logical_and_bitwise_and_icmps_comm1_after := by
  unfold logical_and_bitwise_and_icmps_comm1_before logical_and_bitwise_and_icmps_comm1_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_bitwise_and_icmps_comm1
  all_goals (try extract_goal ; sorry)
  ---END logical_and_bitwise_and_icmps_comm1



def logical_and_bitwise_and_icmps_comm2_before := [llvm|
{
^0(%arg214 : i8, %arg215 : i8, %arg216 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg215, %0 : i8
  %5 = llvm.and %arg214, %1 : i8
  %6 = llvm.shl %1, %arg216 : i8
  %7 = llvm.and %arg214, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = llvm.and %8, %4 : i1
  %11 = "llvm.select"(%10, %9, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_and_bitwise_and_icmps_comm2_after := [llvm|
{
^0(%arg214 : i8, %arg215 : i8, %arg216 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg215, %0 : i8
  %5 = llvm.and %arg214, %1 : i8
  %6 = llvm.shl %1, %arg216 overflow<nuw> : i8
  %7 = llvm.and %arg214, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = llvm.and %8, %4 : i1
  %11 = "llvm.select"(%10, %9, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_bitwise_and_icmps_comm2_proof : logical_and_bitwise_and_icmps_comm2_before ⊑ logical_and_bitwise_and_icmps_comm2_after := by
  unfold logical_and_bitwise_and_icmps_comm2_before logical_and_bitwise_and_icmps_comm2_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_bitwise_and_icmps_comm2
  all_goals (try extract_goal ; sorry)
  ---END logical_and_bitwise_and_icmps_comm2



def logical_and_bitwise_and_icmps_comm3_before := [llvm|
{
^0(%arg211 : i8, %arg212 : i8, %arg213 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg212, %0 : i8
  %5 = llvm.and %arg211, %1 : i8
  %6 = llvm.shl %1, %arg213 : i8
  %7 = llvm.and %arg211, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = llvm.and %8, %4 : i1
  %11 = "llvm.select"(%9, %10, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_and_bitwise_and_icmps_comm3_after := [llvm|
{
^0(%arg211 : i8, %arg212 : i8, %arg213 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg212, %0 : i8
  %5 = llvm.and %arg211, %1 : i8
  %6 = llvm.shl %1, %arg213 overflow<nuw> : i8
  %7 = llvm.and %arg211, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = llvm.and %8, %4 : i1
  %11 = "llvm.select"(%9, %10, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_bitwise_and_icmps_comm3_proof : logical_and_bitwise_and_icmps_comm3_before ⊑ logical_and_bitwise_and_icmps_comm3_after := by
  unfold logical_and_bitwise_and_icmps_comm3_before logical_and_bitwise_and_icmps_comm3_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_bitwise_and_icmps_comm3
  all_goals (try extract_goal ; sorry)
  ---END logical_and_bitwise_and_icmps_comm3



def logical_and_logical_and_icmps_before := [llvm|
{
^0(%arg208 : i8, %arg209 : i8, %arg210 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg209, %0 : i8
  %5 = llvm.and %arg208, %1 : i8
  %6 = llvm.shl %1, %arg210 : i8
  %7 = llvm.and %arg208, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = "llvm.select"(%4, %8, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %9, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_and_logical_and_icmps_after := [llvm|
{
^0(%arg208 : i8, %arg209 : i8, %arg210 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg209, %0 : i8
  %5 = llvm.and %arg208, %1 : i8
  %6 = llvm.shl %1, %arg210 overflow<nuw> : i8
  %7 = llvm.and %arg208, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = "llvm.select"(%4, %8, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %9, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_logical_and_icmps_proof : logical_and_logical_and_icmps_before ⊑ logical_and_logical_and_icmps_after := by
  unfold logical_and_logical_and_icmps_before logical_and_logical_and_icmps_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_logical_and_icmps
  all_goals (try extract_goal ; sorry)
  ---END logical_and_logical_and_icmps



def logical_and_logical_and_icmps_comm1_before := [llvm|
{
^0(%arg205 : i8, %arg206 : i8, %arg207 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg206, %0 : i8
  %5 = llvm.and %arg205, %1 : i8
  %6 = llvm.shl %1, %arg207 : i8
  %7 = llvm.and %arg205, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = "llvm.select"(%4, %8, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%9, %10, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_and_logical_and_icmps_comm1_after := [llvm|
{
^0(%arg205 : i8, %arg206 : i8, %arg207 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg206, %0 : i8
  %5 = llvm.and %arg205, %1 : i8
  %6 = llvm.shl %1, %arg207 overflow<nuw> : i8
  %7 = llvm.and %arg205, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = "llvm.select"(%9, %4, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %8, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_logical_and_icmps_comm1_proof : logical_and_logical_and_icmps_comm1_before ⊑ logical_and_logical_and_icmps_comm1_after := by
  unfold logical_and_logical_and_icmps_comm1_before logical_and_logical_and_icmps_comm1_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_logical_and_icmps_comm1
  all_goals (try extract_goal ; sorry)
  ---END logical_and_logical_and_icmps_comm1



def logical_and_logical_and_icmps_comm2_before := [llvm|
{
^0(%arg202 : i8, %arg203 : i8, %arg204 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg203, %0 : i8
  %5 = llvm.and %arg202, %1 : i8
  %6 = llvm.shl %1, %arg204 : i8
  %7 = llvm.and %arg202, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = "llvm.select"(%8, %4, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %9, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_and_logical_and_icmps_comm2_after := [llvm|
{
^0(%arg202 : i8, %arg203 : i8, %arg204 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg203, %0 : i8
  %5 = llvm.and %arg202, %1 : i8
  %6 = llvm.shl %1, %arg204 overflow<nuw> : i8
  %7 = llvm.and %arg202, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = "llvm.select"(%8, %4, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %9, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_logical_and_icmps_comm2_proof : logical_and_logical_and_icmps_comm2_before ⊑ logical_and_logical_and_icmps_comm2_after := by
  unfold logical_and_logical_and_icmps_comm2_before logical_and_logical_and_icmps_comm2_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_logical_and_icmps_comm2
  all_goals (try extract_goal ; sorry)
  ---END logical_and_logical_and_icmps_comm2



def logical_and_logical_and_icmps_comm3_before := [llvm|
{
^0(%arg199 : i8, %arg200 : i8, %arg201 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.icmp "eq" %arg200, %0 : i8
  %5 = llvm.and %arg199, %1 : i8
  %6 = llvm.shl %1, %arg201 : i8
  %7 = llvm.and %arg199, %6 : i8
  %8 = llvm.icmp "ne" %5, %2 : i8
  %9 = llvm.icmp "ne" %7, %2 : i8
  %10 = "llvm.select"(%8, %4, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%9, %10, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_and_logical_and_icmps_comm3_after := [llvm|
{
^0(%arg199 : i8, %arg200 : i8, %arg201 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "eq" %arg200, %0 : i8
  %4 = llvm.shl %1, %arg201 overflow<nuw> : i8
  %5 = llvm.or %4, %1 : i8
  %6 = llvm.and %arg199, %5 : i8
  %7 = llvm.icmp "eq" %6, %5 : i8
  %8 = "llvm.select"(%7, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_logical_and_icmps_comm3_proof : logical_and_logical_and_icmps_comm3_before ⊑ logical_and_logical_and_icmps_comm3_after := by
  unfold logical_and_logical_and_icmps_comm3_before logical_and_logical_and_icmps_comm3_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_logical_and_icmps_comm3
  all_goals (try extract_goal ; sorry)
  ---END logical_and_logical_and_icmps_comm3



def bitwise_or_bitwise_or_icmps_before := [llvm|
{
^0(%arg196 : i8, %arg197 : i8, %arg198 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "eq" %arg197, %0 : i8
  %4 = llvm.and %arg196, %1 : i8
  %5 = llvm.shl %1, %arg198 : i8
  %6 = llvm.and %arg196, %5 : i8
  %7 = llvm.icmp "eq" %4, %2 : i8
  %8 = llvm.icmp "eq" %6, %2 : i8
  %9 = llvm.or %3, %7 : i1
  %10 = llvm.or %9, %8 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_or_bitwise_or_icmps_after := [llvm|
{
^0(%arg196 : i8, %arg197 : i8, %arg198 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg197, %0 : i8
  %3 = llvm.shl %1, %arg198 overflow<nuw> : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %arg196, %4 : i8
  %6 = llvm.icmp "ne" %5, %4 : i8
  %7 = llvm.or %2, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_or_bitwise_or_icmps_proof : bitwise_or_bitwise_or_icmps_before ⊑ bitwise_or_bitwise_or_icmps_after := by
  unfold bitwise_or_bitwise_or_icmps_before bitwise_or_bitwise_or_icmps_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_or_bitwise_or_icmps
  all_goals (try extract_goal ; sorry)
  ---END bitwise_or_bitwise_or_icmps



def bitwise_or_bitwise_or_icmps_comm1_before := [llvm|
{
^0(%arg193 : i8, %arg194 : i8, %arg195 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "eq" %arg194, %0 : i8
  %4 = llvm.and %arg193, %1 : i8
  %5 = llvm.shl %1, %arg195 : i8
  %6 = llvm.and %arg193, %5 : i8
  %7 = llvm.icmp "eq" %4, %2 : i8
  %8 = llvm.icmp "eq" %6, %2 : i8
  %9 = llvm.or %3, %7 : i1
  %10 = llvm.or %8, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_or_bitwise_or_icmps_comm1_after := [llvm|
{
^0(%arg193 : i8, %arg194 : i8, %arg195 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg194, %0 : i8
  %3 = llvm.shl %1, %arg195 overflow<nuw> : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %arg193, %4 : i8
  %6 = llvm.icmp "ne" %5, %4 : i8
  %7 = llvm.or %2, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_or_bitwise_or_icmps_comm1_proof : bitwise_or_bitwise_or_icmps_comm1_before ⊑ bitwise_or_bitwise_or_icmps_comm1_after := by
  unfold bitwise_or_bitwise_or_icmps_comm1_before bitwise_or_bitwise_or_icmps_comm1_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_or_bitwise_or_icmps_comm1
  all_goals (try extract_goal ; sorry)
  ---END bitwise_or_bitwise_or_icmps_comm1



def bitwise_or_bitwise_or_icmps_comm2_before := [llvm|
{
^0(%arg190 : i8, %arg191 : i8, %arg192 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "eq" %arg191, %0 : i8
  %4 = llvm.and %arg190, %1 : i8
  %5 = llvm.shl %1, %arg192 : i8
  %6 = llvm.and %arg190, %5 : i8
  %7 = llvm.icmp "eq" %4, %2 : i8
  %8 = llvm.icmp "eq" %6, %2 : i8
  %9 = llvm.or %7, %3 : i1
  %10 = llvm.or %9, %8 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_or_bitwise_or_icmps_comm2_after := [llvm|
{
^0(%arg190 : i8, %arg191 : i8, %arg192 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg191, %0 : i8
  %3 = llvm.shl %1, %arg192 overflow<nuw> : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %arg190, %4 : i8
  %6 = llvm.icmp "ne" %5, %4 : i8
  %7 = llvm.or %6, %2 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_or_bitwise_or_icmps_comm2_proof : bitwise_or_bitwise_or_icmps_comm2_before ⊑ bitwise_or_bitwise_or_icmps_comm2_after := by
  unfold bitwise_or_bitwise_or_icmps_comm2_before bitwise_or_bitwise_or_icmps_comm2_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_or_bitwise_or_icmps_comm2
  all_goals (try extract_goal ; sorry)
  ---END bitwise_or_bitwise_or_icmps_comm2



def bitwise_or_bitwise_or_icmps_comm3_before := [llvm|
{
^0(%arg187 : i8, %arg188 : i8, %arg189 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "eq" %arg188, %0 : i8
  %4 = llvm.and %arg187, %1 : i8
  %5 = llvm.shl %1, %arg189 : i8
  %6 = llvm.and %arg187, %5 : i8
  %7 = llvm.icmp "eq" %4, %2 : i8
  %8 = llvm.icmp "eq" %6, %2 : i8
  %9 = llvm.or %7, %3 : i1
  %10 = llvm.or %8, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_or_bitwise_or_icmps_comm3_after := [llvm|
{
^0(%arg187 : i8, %arg188 : i8, %arg189 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg188, %0 : i8
  %3 = llvm.shl %1, %arg189 overflow<nuw> : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %arg187, %4 : i8
  %6 = llvm.icmp "ne" %5, %4 : i8
  %7 = llvm.or %6, %2 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_or_bitwise_or_icmps_comm3_proof : bitwise_or_bitwise_or_icmps_comm3_before ⊑ bitwise_or_bitwise_or_icmps_comm3_after := by
  unfold bitwise_or_bitwise_or_icmps_comm3_before bitwise_or_bitwise_or_icmps_comm3_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_or_bitwise_or_icmps_comm3
  all_goals (try extract_goal ; sorry)
  ---END bitwise_or_bitwise_or_icmps_comm3



def bitwise_or_logical_or_icmps_before := [llvm|
{
^0(%arg184 : i8, %arg185 : i8, %arg186 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg185, %0 : i8
  %5 = llvm.and %arg184, %1 : i8
  %6 = llvm.shl %1, %arg186 : i8
  %7 = llvm.and %arg184, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = "llvm.select"(%4, %3, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = llvm.or %10, %9 : i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def bitwise_or_logical_or_icmps_after := [llvm|
{
^0(%arg184 : i8, %arg185 : i8, %arg186 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg185, %0 : i8
  %4 = llvm.shl %1, %arg186 overflow<nuw> : i8
  %5 = llvm.or %4, %1 : i8
  %6 = llvm.and %arg184, %5 : i8
  %7 = llvm.icmp "ne" %6, %5 : i8
  %8 = "llvm.select"(%3, %2, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_or_logical_or_icmps_proof : bitwise_or_logical_or_icmps_before ⊑ bitwise_or_logical_or_icmps_after := by
  unfold bitwise_or_logical_or_icmps_before bitwise_or_logical_or_icmps_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_or_logical_or_icmps
  all_goals (try extract_goal ; sorry)
  ---END bitwise_or_logical_or_icmps



def bitwise_or_logical_or_icmps_comm1_before := [llvm|
{
^0(%arg181 : i8, %arg182 : i8, %arg183 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg182, %0 : i8
  %5 = llvm.and %arg181, %1 : i8
  %6 = llvm.shl %1, %arg183 : i8
  %7 = llvm.and %arg181, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = "llvm.select"(%4, %3, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = llvm.or %9, %10 : i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def bitwise_or_logical_or_icmps_comm1_after := [llvm|
{
^0(%arg181 : i8, %arg182 : i8, %arg183 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg182, %0 : i8
  %4 = llvm.shl %1, %arg183 overflow<nuw> : i8
  %5 = llvm.or %4, %1 : i8
  %6 = llvm.and %arg181, %5 : i8
  %7 = llvm.icmp "ne" %6, %5 : i8
  %8 = "llvm.select"(%3, %2, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_or_logical_or_icmps_comm1_proof : bitwise_or_logical_or_icmps_comm1_before ⊑ bitwise_or_logical_or_icmps_comm1_after := by
  unfold bitwise_or_logical_or_icmps_comm1_before bitwise_or_logical_or_icmps_comm1_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_or_logical_or_icmps_comm1
  all_goals (try extract_goal ; sorry)
  ---END bitwise_or_logical_or_icmps_comm1



def bitwise_or_logical_or_icmps_comm3_before := [llvm|
{
^0(%arg175 : i8, %arg176 : i8, %arg177 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg176, %0 : i8
  %5 = llvm.and %arg175, %1 : i8
  %6 = llvm.shl %1, %arg177 : i8
  %7 = llvm.and %arg175, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = "llvm.select"(%8, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = llvm.or %9, %10 : i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def bitwise_or_logical_or_icmps_comm3_after := [llvm|
{
^0(%arg175 : i8, %arg176 : i8, %arg177 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg176, %0 : i8
  %4 = llvm.shl %1, %arg177 overflow<nuw> : i8
  %5 = llvm.or %4, %1 : i8
  %6 = llvm.and %arg175, %5 : i8
  %7 = llvm.icmp "ne" %6, %5 : i8
  %8 = "llvm.select"(%7, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_or_logical_or_icmps_comm3_proof : bitwise_or_logical_or_icmps_comm3_before ⊑ bitwise_or_logical_or_icmps_comm3_after := by
  unfold bitwise_or_logical_or_icmps_comm3_before bitwise_or_logical_or_icmps_comm3_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_or_logical_or_icmps_comm3
  all_goals (try extract_goal ; sorry)
  ---END bitwise_or_logical_or_icmps_comm3



def logical_or_bitwise_or_icmps_before := [llvm|
{
^0(%arg172 : i8, %arg173 : i8, %arg174 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg173, %0 : i8
  %5 = llvm.and %arg172, %1 : i8
  %6 = llvm.shl %1, %arg174 : i8
  %7 = llvm.and %arg172, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = llvm.or %4, %8 : i1
  %11 = "llvm.select"(%10, %3, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_or_bitwise_or_icmps_after := [llvm|
{
^0(%arg172 : i8, %arg173 : i8, %arg174 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg173, %0 : i8
  %5 = llvm.and %arg172, %1 : i8
  %6 = llvm.shl %1, %arg174 overflow<nuw> : i8
  %7 = llvm.and %arg172, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = llvm.or %4, %8 : i1
  %11 = "llvm.select"(%10, %3, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_bitwise_or_icmps_proof : logical_or_bitwise_or_icmps_before ⊑ logical_or_bitwise_or_icmps_after := by
  unfold logical_or_bitwise_or_icmps_before logical_or_bitwise_or_icmps_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_bitwise_or_icmps
  all_goals (try extract_goal ; sorry)
  ---END logical_or_bitwise_or_icmps



def logical_or_bitwise_or_icmps_comm1_before := [llvm|
{
^0(%arg169 : i8, %arg170 : i8, %arg171 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg170, %0 : i8
  %5 = llvm.and %arg169, %1 : i8
  %6 = llvm.shl %1, %arg171 : i8
  %7 = llvm.and %arg169, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = llvm.or %4, %8 : i1
  %11 = "llvm.select"(%9, %3, %10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_or_bitwise_or_icmps_comm1_after := [llvm|
{
^0(%arg169 : i8, %arg170 : i8, %arg171 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg170, %0 : i8
  %5 = llvm.and %arg169, %1 : i8
  %6 = llvm.shl %1, %arg171 overflow<nuw> : i8
  %7 = llvm.and %arg169, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = llvm.or %4, %8 : i1
  %11 = "llvm.select"(%9, %3, %10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_bitwise_or_icmps_comm1_proof : logical_or_bitwise_or_icmps_comm1_before ⊑ logical_or_bitwise_or_icmps_comm1_after := by
  unfold logical_or_bitwise_or_icmps_comm1_before logical_or_bitwise_or_icmps_comm1_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_bitwise_or_icmps_comm1
  all_goals (try extract_goal ; sorry)
  ---END logical_or_bitwise_or_icmps_comm1



def logical_or_bitwise_or_icmps_comm2_before := [llvm|
{
^0(%arg166 : i8, %arg167 : i8, %arg168 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg167, %0 : i8
  %5 = llvm.and %arg166, %1 : i8
  %6 = llvm.shl %1, %arg168 : i8
  %7 = llvm.and %arg166, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = llvm.or %8, %4 : i1
  %11 = "llvm.select"(%10, %3, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_or_bitwise_or_icmps_comm2_after := [llvm|
{
^0(%arg166 : i8, %arg167 : i8, %arg168 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg167, %0 : i8
  %5 = llvm.and %arg166, %1 : i8
  %6 = llvm.shl %1, %arg168 overflow<nuw> : i8
  %7 = llvm.and %arg166, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = llvm.or %8, %4 : i1
  %11 = "llvm.select"(%10, %3, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_bitwise_or_icmps_comm2_proof : logical_or_bitwise_or_icmps_comm2_before ⊑ logical_or_bitwise_or_icmps_comm2_after := by
  unfold logical_or_bitwise_or_icmps_comm2_before logical_or_bitwise_or_icmps_comm2_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_bitwise_or_icmps_comm2
  all_goals (try extract_goal ; sorry)
  ---END logical_or_bitwise_or_icmps_comm2



def logical_or_bitwise_or_icmps_comm3_before := [llvm|
{
^0(%arg163 : i8, %arg164 : i8, %arg165 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg164, %0 : i8
  %5 = llvm.and %arg163, %1 : i8
  %6 = llvm.shl %1, %arg165 : i8
  %7 = llvm.and %arg163, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = llvm.or %8, %4 : i1
  %11 = "llvm.select"(%9, %3, %10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_or_bitwise_or_icmps_comm3_after := [llvm|
{
^0(%arg163 : i8, %arg164 : i8, %arg165 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg164, %0 : i8
  %5 = llvm.and %arg163, %1 : i8
  %6 = llvm.shl %1, %arg165 overflow<nuw> : i8
  %7 = llvm.and %arg163, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = llvm.or %8, %4 : i1
  %11 = "llvm.select"(%9, %3, %10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_bitwise_or_icmps_comm3_proof : logical_or_bitwise_or_icmps_comm3_before ⊑ logical_or_bitwise_or_icmps_comm3_after := by
  unfold logical_or_bitwise_or_icmps_comm3_before logical_or_bitwise_or_icmps_comm3_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_bitwise_or_icmps_comm3
  all_goals (try extract_goal ; sorry)
  ---END logical_or_bitwise_or_icmps_comm3



def logical_or_logical_or_icmps_before := [llvm|
{
^0(%arg160 : i8, %arg161 : i8, %arg162 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg161, %0 : i8
  %5 = llvm.and %arg160, %1 : i8
  %6 = llvm.shl %1, %arg162 : i8
  %7 = llvm.and %arg160, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = "llvm.select"(%4, %3, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %3, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_or_logical_or_icmps_after := [llvm|
{
^0(%arg160 : i8, %arg161 : i8, %arg162 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg161, %0 : i8
  %5 = llvm.and %arg160, %1 : i8
  %6 = llvm.shl %1, %arg162 overflow<nuw> : i8
  %7 = llvm.and %arg160, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = "llvm.select"(%4, %3, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %3, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_logical_or_icmps_proof : logical_or_logical_or_icmps_before ⊑ logical_or_logical_or_icmps_after := by
  unfold logical_or_logical_or_icmps_before logical_or_logical_or_icmps_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_logical_or_icmps
  all_goals (try extract_goal ; sorry)
  ---END logical_or_logical_or_icmps



def logical_or_logical_or_icmps_comm1_before := [llvm|
{
^0(%arg157 : i8, %arg158 : i8, %arg159 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg158, %0 : i8
  %5 = llvm.and %arg157, %1 : i8
  %6 = llvm.shl %1, %arg159 : i8
  %7 = llvm.and %arg157, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = "llvm.select"(%4, %3, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%9, %3, %10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_or_logical_or_icmps_comm1_after := [llvm|
{
^0(%arg157 : i8, %arg158 : i8, %arg159 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg158, %0 : i8
  %5 = llvm.and %arg157, %1 : i8
  %6 = llvm.shl %1, %arg159 overflow<nuw> : i8
  %7 = llvm.and %arg157, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %3, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_logical_or_icmps_comm1_proof : logical_or_logical_or_icmps_comm1_before ⊑ logical_or_logical_or_icmps_comm1_after := by
  unfold logical_or_logical_or_icmps_comm1_before logical_or_logical_or_icmps_comm1_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_logical_or_icmps_comm1
  all_goals (try extract_goal ; sorry)
  ---END logical_or_logical_or_icmps_comm1



def logical_or_logical_or_icmps_comm2_before := [llvm|
{
^0(%arg154 : i8, %arg155 : i8, %arg156 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg155, %0 : i8
  %5 = llvm.and %arg154, %1 : i8
  %6 = llvm.shl %1, %arg156 : i8
  %7 = llvm.and %arg154, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = "llvm.select"(%8, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %3, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_or_logical_or_icmps_comm2_after := [llvm|
{
^0(%arg154 : i8, %arg155 : i8, %arg156 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg155, %0 : i8
  %5 = llvm.and %arg154, %1 : i8
  %6 = llvm.shl %1, %arg156 overflow<nuw> : i8
  %7 = llvm.and %arg154, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = "llvm.select"(%8, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %3, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_logical_or_icmps_comm2_proof : logical_or_logical_or_icmps_comm2_before ⊑ logical_or_logical_or_icmps_comm2_after := by
  unfold logical_or_logical_or_icmps_comm2_before logical_or_logical_or_icmps_comm2_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_logical_or_icmps_comm2
  all_goals (try extract_goal ; sorry)
  ---END logical_or_logical_or_icmps_comm2



def logical_or_logical_or_icmps_comm3_before := [llvm|
{
^0(%arg151 : i8, %arg152 : i8, %arg153 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg152, %0 : i8
  %5 = llvm.and %arg151, %1 : i8
  %6 = llvm.shl %1, %arg153 : i8
  %7 = llvm.and %arg151, %6 : i8
  %8 = llvm.icmp "eq" %5, %2 : i8
  %9 = llvm.icmp "eq" %7, %2 : i8
  %10 = "llvm.select"(%8, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%9, %3, %10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%11) : (i1) -> ()
}
]
def logical_or_logical_or_icmps_comm3_after := [llvm|
{
^0(%arg151 : i8, %arg152 : i8, %arg153 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg152, %0 : i8
  %4 = llvm.shl %1, %arg153 overflow<nuw> : i8
  %5 = llvm.or %4, %1 : i8
  %6 = llvm.and %arg151, %5 : i8
  %7 = llvm.icmp "ne" %6, %5 : i8
  %8 = "llvm.select"(%7, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_logical_or_icmps_comm3_proof : logical_or_logical_or_icmps_comm3_before ⊑ logical_or_logical_or_icmps_comm3_after := by
  unfold logical_or_logical_or_icmps_comm3_before logical_or_logical_or_icmps_comm3_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_logical_or_icmps_comm3
  all_goals (try extract_goal ; sorry)
  ---END logical_or_logical_or_icmps_comm3



def bitwise_and_logical_and_masked_icmp_asymmetric_before := [llvm|
{
^0(%arg149 : i1, %arg150 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.mlir.constant(11 : i32) : i32
  %4 = llvm.and %arg150, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = "llvm.select"(%5, %arg149, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = llvm.and %arg150, %3 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = llvm.and %6, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def bitwise_and_logical_and_masked_icmp_asymmetric_after := [llvm|
{
^0(%arg149 : i1, %arg150 : i32):
  %0 = llvm.mlir.constant(11 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.and %arg150, %0 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = "llvm.select"(%3, %arg149, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_logical_and_masked_icmp_asymmetric_proof : bitwise_and_logical_and_masked_icmp_asymmetric_before ⊑ bitwise_and_logical_and_masked_icmp_asymmetric_after := by
  unfold bitwise_and_logical_and_masked_icmp_asymmetric_before bitwise_and_logical_and_masked_icmp_asymmetric_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_logical_and_masked_icmp_asymmetric
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_logical_and_masked_icmp_asymmetric



def bitwise_and_logical_and_masked_icmp_allzeros_before := [llvm|
{
^0(%arg147 : i1, %arg148 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.mlir.constant(7 : i32) : i32
  %4 = llvm.and %arg148, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %arg147, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = llvm.and %arg148, %3 : i32
  %8 = llvm.icmp "eq" %7, %1 : i32
  %9 = llvm.and %6, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def bitwise_and_logical_and_masked_icmp_allzeros_after := [llvm|
{
^0(%arg147 : i1, %arg148 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg148, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = "llvm.select"(%4, %arg147, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_logical_and_masked_icmp_allzeros_proof : bitwise_and_logical_and_masked_icmp_allzeros_before ⊑ bitwise_and_logical_and_masked_icmp_allzeros_after := by
  unfold bitwise_and_logical_and_masked_icmp_allzeros_before bitwise_and_logical_and_masked_icmp_allzeros_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_logical_and_masked_icmp_allzeros
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_logical_and_masked_icmp_allzeros



def bitwise_and_logical_and_masked_icmp_allzeros_poison1_before := [llvm|
{
^0(%arg144 : i1, %arg145 : i32, %arg146 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg145, %arg146 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %arg144, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.and %arg145, %2 : i32
  %7 = llvm.icmp "eq" %6, %0 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def bitwise_and_logical_and_masked_icmp_allzeros_poison1_after := [llvm|
{
^0(%arg144 : i1, %arg145 : i32, %arg146 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.or %arg146, %0 : i32
  %4 = llvm.and %arg145, %3 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %arg144, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_logical_and_masked_icmp_allzeros_poison1_proof : bitwise_and_logical_and_masked_icmp_allzeros_poison1_before ⊑ bitwise_and_logical_and_masked_icmp_allzeros_poison1_after := by
  unfold bitwise_and_logical_and_masked_icmp_allzeros_poison1_before bitwise_and_logical_and_masked_icmp_allzeros_poison1_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_logical_and_masked_icmp_allzeros_poison1
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_logical_and_masked_icmp_allzeros_poison1



def bitwise_and_logical_and_masked_icmp_allones_before := [llvm|
{
^0(%arg139 : i1, %arg140 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg140, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %arg139, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.and %arg140, %2 : i32
  %7 = llvm.icmp "eq" %6, %2 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def bitwise_and_logical_and_masked_icmp_allones_after := [llvm|
{
^0(%arg139 : i1, %arg140 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.and %arg140, %0 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = "llvm.select"(%3, %arg139, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_logical_and_masked_icmp_allones_proof : bitwise_and_logical_and_masked_icmp_allones_before ⊑ bitwise_and_logical_and_masked_icmp_allones_after := by
  unfold bitwise_and_logical_and_masked_icmp_allones_before bitwise_and_logical_and_masked_icmp_allones_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_logical_and_masked_icmp_allones
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_logical_and_masked_icmp_allones



def bitwise_and_logical_and_masked_icmp_allones_poison1_before := [llvm|
{
^0(%arg136 : i1, %arg137 : i32, %arg138 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.and %arg137, %arg138 : i32
  %3 = llvm.icmp "eq" %2, %arg138 : i32
  %4 = "llvm.select"(%3, %arg136, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.and %arg137, %1 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def bitwise_and_logical_and_masked_icmp_allones_poison1_after := [llvm|
{
^0(%arg136 : i1, %arg137 : i32, %arg138 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.or %arg138, %0 : i32
  %3 = llvm.and %arg137, %2 : i32
  %4 = llvm.icmp "eq" %3, %2 : i32
  %5 = "llvm.select"(%4, %arg136, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_logical_and_masked_icmp_allones_poison1_proof : bitwise_and_logical_and_masked_icmp_allones_poison1_before ⊑ bitwise_and_logical_and_masked_icmp_allones_poison1_after := by
  unfold bitwise_and_logical_and_masked_icmp_allones_poison1_before bitwise_and_logical_and_masked_icmp_allones_poison1_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_logical_and_masked_icmp_allones_poison1
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_logical_and_masked_icmp_allones_poison1



def bitwise_and_logical_and_masked_icmp_allones_poison2_before := [llvm|
{
^0(%arg133 : i1, %arg134 : i32, %arg135 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.and %arg134, %0 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = "llvm.select"(%3, %arg133, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.and %arg134, %arg135 : i32
  %6 = llvm.icmp "eq" %5, %arg135 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def bitwise_and_logical_and_masked_icmp_allones_poison2_after := [llvm|
{
^0(%arg133 : i1, %arg134 : i32, %arg135 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg134, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = "llvm.select"(%4, %arg133, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.and %arg134, %arg135 : i32
  %7 = llvm.icmp "eq" %6, %arg135 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bitwise_and_logical_and_masked_icmp_allones_poison2_proof : bitwise_and_logical_and_masked_icmp_allones_poison2_before ⊑ bitwise_and_logical_and_masked_icmp_allones_poison2_after := by
  unfold bitwise_and_logical_and_masked_icmp_allones_poison2_before bitwise_and_logical_and_masked_icmp_allones_poison2_after
  simp_alive_peephole
  intros
  ---BEGIN bitwise_and_logical_and_masked_icmp_allones_poison2
  all_goals (try extract_goal ; sorry)
  ---END bitwise_and_logical_and_masked_icmp_allones_poison2



def samesign_before := [llvm|
{
^0(%arg131 : i32, %arg132 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg131, %arg132 : i32
  %3 = llvm.icmp "slt" %2, %0 : i32
  %4 = llvm.or %arg131, %arg132 : i32
  %5 = llvm.icmp "sgt" %4, %1 : i32
  %6 = llvm.or %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_after := [llvm|
{
^0(%arg131 : i32, %arg132 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg131, %arg132 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem samesign_proof : samesign_before ⊑ samesign_after := by
  unfold samesign_before samesign_after
  simp_alive_peephole
  intros
  ---BEGIN samesign
  all_goals (try extract_goal ; sorry)
  ---END samesign



def samesign_different_sign_bittest2_before := [llvm|
{
^0(%arg127 : i32, %arg128 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.and %arg127, %arg128 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  %3 = llvm.or %arg127, %arg128 : i32
  %4 = llvm.icmp "sge" %3, %0 : i32
  %5 = llvm.or %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def samesign_different_sign_bittest2_after := [llvm|
{
^0(%arg127 : i32, %arg128 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg127, %arg128 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem samesign_different_sign_bittest2_proof : samesign_different_sign_bittest2_before ⊑ samesign_different_sign_bittest2_after := by
  unfold samesign_different_sign_bittest2_before samesign_different_sign_bittest2_after
  simp_alive_peephole
  intros
  ---BEGIN samesign_different_sign_bittest2
  all_goals (try extract_goal ; sorry)
  ---END samesign_different_sign_bittest2



def samesign_commute1_before := [llvm|
{
^0(%arg125 : i32, %arg126 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg125, %arg126 : i32
  %3 = llvm.icmp "slt" %2, %0 : i32
  %4 = llvm.or %arg125, %arg126 : i32
  %5 = llvm.icmp "sgt" %4, %1 : i32
  %6 = llvm.or %5, %3 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_commute1_after := [llvm|
{
^0(%arg125 : i32, %arg126 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg125, %arg126 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem samesign_commute1_proof : samesign_commute1_before ⊑ samesign_commute1_after := by
  unfold samesign_commute1_before samesign_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN samesign_commute1
  all_goals (try extract_goal ; sorry)
  ---END samesign_commute1



def samesign_commute2_before := [llvm|
{
^0(%arg123 : i32, %arg124 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg123, %arg124 : i32
  %3 = llvm.icmp "slt" %2, %0 : i32
  %4 = llvm.or %arg124, %arg123 : i32
  %5 = llvm.icmp "sgt" %4, %1 : i32
  %6 = llvm.or %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_commute2_after := [llvm|
{
^0(%arg123 : i32, %arg124 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg123, %arg124 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem samesign_commute2_proof : samesign_commute2_before ⊑ samesign_commute2_after := by
  unfold samesign_commute2_before samesign_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN samesign_commute2
  all_goals (try extract_goal ; sorry)
  ---END samesign_commute2



def samesign_commute3_before := [llvm|
{
^0(%arg121 : i32, %arg122 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg121, %arg122 : i32
  %3 = llvm.icmp "slt" %2, %0 : i32
  %4 = llvm.or %arg122, %arg121 : i32
  %5 = llvm.icmp "sgt" %4, %1 : i32
  %6 = llvm.or %5, %3 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_commute3_after := [llvm|
{
^0(%arg121 : i32, %arg122 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg122, %arg121 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem samesign_commute3_proof : samesign_commute3_before ⊑ samesign_commute3_after := by
  unfold samesign_commute3_before samesign_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN samesign_commute3
  all_goals (try extract_goal ; sorry)
  ---END samesign_commute3



def samesign_inverted_before := [llvm|
{
^0(%arg107 : i32, %arg108 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg107, %arg108 : i32
  %3 = llvm.icmp "sgt" %2, %0 : i32
  %4 = llvm.or %arg107, %arg108 : i32
  %5 = llvm.icmp "slt" %4, %1 : i32
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_inverted_after := [llvm|
{
^0(%arg107 : i32, %arg108 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.xor %arg107, %arg108 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem samesign_inverted_proof : samesign_inverted_before ⊑ samesign_inverted_after := by
  unfold samesign_inverted_before samesign_inverted_after
  simp_alive_peephole
  intros
  ---BEGIN samesign_inverted
  all_goals (try extract_goal ; sorry)
  ---END samesign_inverted



def samesign_inverted_different_sign_bittest1_before := [llvm|
{
^0(%arg105 : i32, %arg106 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.and %arg105, %arg106 : i32
  %2 = llvm.icmp "sge" %1, %0 : i32
  %3 = llvm.or %arg105, %arg106 : i32
  %4 = llvm.icmp "slt" %3, %0 : i32
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def samesign_inverted_different_sign_bittest1_after := [llvm|
{
^0(%arg105 : i32, %arg106 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.xor %arg105, %arg106 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem samesign_inverted_different_sign_bittest1_proof : samesign_inverted_different_sign_bittest1_before ⊑ samesign_inverted_different_sign_bittest1_after := by
  unfold samesign_inverted_different_sign_bittest1_before samesign_inverted_different_sign_bittest1_after
  simp_alive_peephole
  intros
  ---BEGIN samesign_inverted_different_sign_bittest1
  all_goals (try extract_goal ; sorry)
  ---END samesign_inverted_different_sign_bittest1



def samesign_inverted_different_sign_bittest2_before := [llvm|
{
^0(%arg103 : i32, %arg104 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg103, %arg104 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  %3 = llvm.or %arg103, %arg104 : i32
  %4 = llvm.icmp "sle" %3, %0 : i32
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def samesign_inverted_different_sign_bittest2_after := [llvm|
{
^0(%arg103 : i32, %arg104 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.xor %arg103, %arg104 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem samesign_inverted_different_sign_bittest2_proof : samesign_inverted_different_sign_bittest2_before ⊑ samesign_inverted_different_sign_bittest2_after := by
  unfold samesign_inverted_different_sign_bittest2_before samesign_inverted_different_sign_bittest2_after
  simp_alive_peephole
  intros
  ---BEGIN samesign_inverted_different_sign_bittest2
  all_goals (try extract_goal ; sorry)
  ---END samesign_inverted_different_sign_bittest2



def samesign_inverted_commute1_before := [llvm|
{
^0(%arg101 : i32, %arg102 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg101, %arg102 : i32
  %3 = llvm.icmp "sgt" %2, %0 : i32
  %4 = llvm.or %arg101, %arg102 : i32
  %5 = llvm.icmp "slt" %4, %1 : i32
  %6 = llvm.and %5, %3 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_inverted_commute1_after := [llvm|
{
^0(%arg101 : i32, %arg102 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.xor %arg101, %arg102 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem samesign_inverted_commute1_proof : samesign_inverted_commute1_before ⊑ samesign_inverted_commute1_after := by
  unfold samesign_inverted_commute1_before samesign_inverted_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN samesign_inverted_commute1
  all_goals (try extract_goal ; sorry)
  ---END samesign_inverted_commute1



def samesign_inverted_commute2_before := [llvm|
{
^0(%arg99 : i32, %arg100 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg99, %arg100 : i32
  %3 = llvm.icmp "sgt" %2, %0 : i32
  %4 = llvm.or %arg100, %arg99 : i32
  %5 = llvm.icmp "slt" %4, %1 : i32
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_inverted_commute2_after := [llvm|
{
^0(%arg99 : i32, %arg100 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.xor %arg99, %arg100 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem samesign_inverted_commute2_proof : samesign_inverted_commute2_before ⊑ samesign_inverted_commute2_after := by
  unfold samesign_inverted_commute2_before samesign_inverted_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN samesign_inverted_commute2
  all_goals (try extract_goal ; sorry)
  ---END samesign_inverted_commute2



def samesign_inverted_commute3_before := [llvm|
{
^0(%arg97 : i32, %arg98 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg97, %arg98 : i32
  %3 = llvm.icmp "sgt" %2, %0 : i32
  %4 = llvm.or %arg98, %arg97 : i32
  %5 = llvm.icmp "slt" %4, %1 : i32
  %6 = llvm.and %5, %3 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_inverted_commute3_after := [llvm|
{
^0(%arg97 : i32, %arg98 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.xor %arg98, %arg97 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem samesign_inverted_commute3_proof : samesign_inverted_commute3_before ⊑ samesign_inverted_commute3_after := by
  unfold samesign_inverted_commute3_before samesign_inverted_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN samesign_inverted_commute3
  all_goals (try extract_goal ; sorry)
  ---END samesign_inverted_commute3



def icmp_slt_0_or_icmp_sgt_0_i32_before := [llvm|
{
^0(%arg74 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg74, %0 : i32
  %2 = llvm.icmp "sgt" %arg74, %0 : i32
  %3 = llvm.zext %1 : i1 to i32
  %4 = llvm.zext %2 : i1 to i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def icmp_slt_0_or_icmp_sgt_0_i32_after := [llvm|
{
^0(%arg74 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg74, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_or_icmp_sgt_0_i32_proof : icmp_slt_0_or_icmp_sgt_0_i32_before ⊑ icmp_slt_0_or_icmp_sgt_0_i32_after := by
  unfold icmp_slt_0_or_icmp_sgt_0_i32_before icmp_slt_0_or_icmp_sgt_0_i32_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_or_icmp_sgt_0_i32
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_or_icmp_sgt_0_i32



def icmp_slt_0_or_icmp_sgt_0_i64_before := [llvm|
{
^0(%arg73 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "slt" %arg73, %0 : i64
  %2 = llvm.icmp "sgt" %arg73, %0 : i64
  %3 = llvm.zext %1 : i1 to i64
  %4 = llvm.zext %2 : i1 to i64
  %5 = llvm.or %3, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def icmp_slt_0_or_icmp_sgt_0_i64_after := [llvm|
{
^0(%arg73 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "ne" %arg73, %0 : i64
  %2 = llvm.zext %1 : i1 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_or_icmp_sgt_0_i64_proof : icmp_slt_0_or_icmp_sgt_0_i64_before ⊑ icmp_slt_0_or_icmp_sgt_0_i64_after := by
  unfold icmp_slt_0_or_icmp_sgt_0_i64_before icmp_slt_0_or_icmp_sgt_0_i64_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_or_icmp_sgt_0_i64
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_or_icmp_sgt_0_i64



def icmp_slt_0_or_icmp_sgt_0_i64_fail0_before := [llvm|
{
^0(%arg72 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(63) : i64
  %2 = llvm.icmp "slt" %arg72, %0 : i64
  %3 = llvm.lshr %arg72, %1 : i64
  %4 = llvm.zext %2 : i1 to i64
  %5 = llvm.or %3, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def icmp_slt_0_or_icmp_sgt_0_i64_fail0_after := [llvm|
{
^0(%arg72 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.lshr %arg72, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_or_icmp_sgt_0_i64_fail0_proof : icmp_slt_0_or_icmp_sgt_0_i64_fail0_before ⊑ icmp_slt_0_or_icmp_sgt_0_i64_fail0_after := by
  unfold icmp_slt_0_or_icmp_sgt_0_i64_fail0_before icmp_slt_0_or_icmp_sgt_0_i64_fail0_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_or_icmp_sgt_0_i64_fail0
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_or_icmp_sgt_0_i64_fail0



def icmp_slt_0_or_icmp_sgt_0_i64_fail3_before := [llvm|
{
^0(%arg69 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(62) : i64
  %2 = llvm.icmp "slt" %arg69, %0 : i64
  %3 = llvm.ashr %arg69, %1 : i64
  %4 = llvm.zext %2 : i1 to i64
  %5 = llvm.or %3, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def icmp_slt_0_or_icmp_sgt_0_i64_fail3_after := [llvm|
{
^0(%arg69 : i64):
  %0 = llvm.mlir.constant(62) : i64
  %1 = llvm.mlir.constant(63) : i64
  %2 = llvm.ashr %arg69, %0 : i64
  %3 = llvm.lshr %arg69, %1 : i64
  %4 = llvm.or %2, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_or_icmp_sgt_0_i64_fail3_proof : icmp_slt_0_or_icmp_sgt_0_i64_fail3_before ⊑ icmp_slt_0_or_icmp_sgt_0_i64_fail3_after := by
  unfold icmp_slt_0_or_icmp_sgt_0_i64_fail3_before icmp_slt_0_or_icmp_sgt_0_i64_fail3_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_or_icmp_sgt_0_i64_fail3
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_or_icmp_sgt_0_i64_fail3



def icmp_slt_0_and_icmp_sge_neg1_i32_before := [llvm|
{
^0(%arg66 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "sgt" %arg66, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg66, %1 : i32
  %5 = llvm.and %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def icmp_slt_0_and_icmp_sge_neg1_i32_after := [llvm|
{
^0(%arg66 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_and_icmp_sge_neg1_i32_proof : icmp_slt_0_and_icmp_sge_neg1_i32_before ⊑ icmp_slt_0_and_icmp_sge_neg1_i32_after := by
  unfold icmp_slt_0_and_icmp_sge_neg1_i32_before icmp_slt_0_and_icmp_sge_neg1_i32_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_and_icmp_sge_neg1_i32
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_and_icmp_sge_neg1_i32



def icmp_slt_0_or_icmp_sge_neg1_i32_before := [llvm|
{
^0(%arg65 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "sge" %arg65, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg65, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def icmp_slt_0_or_icmp_sge_neg1_i32_after := [llvm|
{
^0(%arg65 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_or_icmp_sge_neg1_i32_proof : icmp_slt_0_or_icmp_sge_neg1_i32_before ⊑ icmp_slt_0_or_icmp_sge_neg1_i32_after := by
  unfold icmp_slt_0_or_icmp_sge_neg1_i32_before icmp_slt_0_or_icmp_sge_neg1_i32_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_or_icmp_sge_neg1_i32
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_or_icmp_sge_neg1_i32



def icmp_slt_0_or_icmp_sge_100_i32_before := [llvm|
{
^0(%arg64 : i32):
  %0 = llvm.mlir.constant(100 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "sge" %arg64, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg64, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def icmp_slt_0_or_icmp_sge_100_i32_after := [llvm|
{
^0(%arg64 : i32):
  %0 = llvm.mlir.constant(99 : i32) : i32
  %1 = llvm.icmp "ugt" %arg64, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_or_icmp_sge_100_i32_proof : icmp_slt_0_or_icmp_sge_100_i32_before ⊑ icmp_slt_0_or_icmp_sge_100_i32_after := by
  unfold icmp_slt_0_or_icmp_sge_100_i32_before icmp_slt_0_or_icmp_sge_100_i32_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_or_icmp_sge_100_i32
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_or_icmp_sge_100_i32



def icmp_slt_0_and_icmp_sge_neg1_i64_before := [llvm|
{
^0(%arg63 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(63) : i64
  %2 = llvm.icmp "sge" %arg63, %0 : i64
  %3 = llvm.zext %2 : i1 to i64
  %4 = llvm.lshr %arg63, %1 : i64
  %5 = llvm.and %4, %3 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def icmp_slt_0_and_icmp_sge_neg1_i64_after := [llvm|
{
^0(%arg63 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.icmp "eq" %arg63, %0 : i64
  %2 = llvm.zext %1 : i1 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_and_icmp_sge_neg1_i64_proof : icmp_slt_0_and_icmp_sge_neg1_i64_before ⊑ icmp_slt_0_and_icmp_sge_neg1_i64_after := by
  unfold icmp_slt_0_and_icmp_sge_neg1_i64_before icmp_slt_0_and_icmp_sge_neg1_i64_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_and_icmp_sge_neg1_i64
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_and_icmp_sge_neg1_i64



def icmp_slt_0_and_icmp_sge_neg2_i64_before := [llvm|
{
^0(%arg62 : i64):
  %0 = llvm.mlir.constant(-2) : i64
  %1 = llvm.mlir.constant(63) : i64
  %2 = llvm.icmp "sge" %arg62, %0 : i64
  %3 = llvm.zext %2 : i1 to i64
  %4 = llvm.lshr %arg62, %1 : i64
  %5 = llvm.and %4, %3 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def icmp_slt_0_and_icmp_sge_neg2_i64_after := [llvm|
{
^0(%arg62 : i64):
  %0 = llvm.mlir.constant(-3) : i64
  %1 = llvm.icmp "ugt" %arg62, %0 : i64
  %2 = llvm.zext %1 : i1 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_and_icmp_sge_neg2_i64_proof : icmp_slt_0_and_icmp_sge_neg2_i64_before ⊑ icmp_slt_0_and_icmp_sge_neg2_i64_after := by
  unfold icmp_slt_0_and_icmp_sge_neg2_i64_before icmp_slt_0_and_icmp_sge_neg2_i64_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_and_icmp_sge_neg2_i64
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_and_icmp_sge_neg2_i64



def ashr_and_icmp_sge_neg1_i64_before := [llvm|
{
^0(%arg61 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(63) : i64
  %2 = llvm.icmp "sge" %arg61, %0 : i64
  %3 = llvm.zext %2 : i1 to i64
  %4 = llvm.ashr %arg61, %1 : i64
  %5 = llvm.and %4, %3 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def ashr_and_icmp_sge_neg1_i64_after := [llvm|
{
^0(%arg61 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.icmp "eq" %arg61, %0 : i64
  %2 = llvm.zext %1 : i1 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_and_icmp_sge_neg1_i64_proof : ashr_and_icmp_sge_neg1_i64_before ⊑ ashr_and_icmp_sge_neg1_i64_after := by
  unfold ashr_and_icmp_sge_neg1_i64_before ashr_and_icmp_sge_neg1_i64_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_and_icmp_sge_neg1_i64
  all_goals (try extract_goal ; sorry)
  ---END ashr_and_icmp_sge_neg1_i64



def icmp_slt_0_and_icmp_sgt_neg1_i64_before := [llvm|
{
^0(%arg60 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(63) : i64
  %2 = llvm.icmp "sgt" %arg60, %0 : i64
  %3 = llvm.zext %2 : i1 to i64
  %4 = llvm.lshr %arg60, %1 : i64
  %5 = llvm.and %4, %3 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def icmp_slt_0_and_icmp_sgt_neg1_i64_after := [llvm|
{
^0(%arg60 : i64):
  %0 = llvm.mlir.constant(0) : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_and_icmp_sgt_neg1_i64_proof : icmp_slt_0_and_icmp_sgt_neg1_i64_before ⊑ icmp_slt_0_and_icmp_sgt_neg1_i64_after := by
  unfold icmp_slt_0_and_icmp_sgt_neg1_i64_before icmp_slt_0_and_icmp_sgt_neg1_i64_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_and_icmp_sgt_neg1_i64
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_and_icmp_sgt_neg1_i64



def icmp_slt_0_and_icmp_sge_neg1_i64_fail_before := [llvm|
{
^0(%arg59 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(62) : i64
  %2 = llvm.icmp "sge" %arg59, %0 : i64
  %3 = llvm.zext %2 : i1 to i64
  %4 = llvm.lshr %arg59, %1 : i64
  %5 = llvm.and %4, %3 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def icmp_slt_0_and_icmp_sge_neg1_i64_fail_after := [llvm|
{
^0(%arg59 : i64):
  %0 = llvm.mlir.constant(-2) : i64
  %1 = llvm.mlir.constant(62) : i64
  %2 = llvm.mlir.constant(1) : i64
  %3 = llvm.mlir.constant(0) : i64
  %4 = llvm.icmp "sgt" %arg59, %0 : i64
  %5 = llvm.lshr %arg59, %1 : i64
  %6 = llvm.and %5, %2 : i64
  %7 = "llvm.select"(%4, %6, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%7) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_and_icmp_sge_neg1_i64_fail_proof : icmp_slt_0_and_icmp_sge_neg1_i64_fail_before ⊑ icmp_slt_0_and_icmp_sge_neg1_i64_fail_after := by
  unfold icmp_slt_0_and_icmp_sge_neg1_i64_fail_before icmp_slt_0_and_icmp_sge_neg1_i64_fail_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_and_icmp_sge_neg1_i64_fail
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_and_icmp_sge_neg1_i64_fail



def icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_before := [llvm|
{
^0(%arg55 : i32, %arg56 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "sgt" %arg55, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg56, %1 : i32
  %5 = llvm.xor %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_after := [llvm|
{
^0(%arg55 : i32, %arg56 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg56, %arg55 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_proof : icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_before ⊑ icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_after := by
  unfold icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_before icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32
  all_goals (try extract_goal ; sorry)
  ---END icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32



def icmp_slt_0_xor_icmp_sgt_neg2_i32_before := [llvm|
{
^0(%arg54 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "sgt" %arg54, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg54, %1 : i32
  %5 = llvm.xor %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def icmp_slt_0_xor_icmp_sgt_neg2_i32_after := [llvm|
{
^0(%arg54 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "ne" %arg54, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_xor_icmp_sgt_neg2_i32_proof : icmp_slt_0_xor_icmp_sgt_neg2_i32_before ⊑ icmp_slt_0_xor_icmp_sgt_neg2_i32_after := by
  unfold icmp_slt_0_xor_icmp_sgt_neg2_i32_before icmp_slt_0_xor_icmp_sgt_neg2_i32_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_xor_icmp_sgt_neg2_i32
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_xor_icmp_sgt_neg2_i32



def icmp_slt_0_or_icmp_eq_100_i32_fail_before := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(100 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "eq" %arg45, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg45, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def icmp_slt_0_or_icmp_eq_100_i32_fail_after := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(100 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "eq" %arg45, %0 : i32
  %3 = llvm.icmp "slt" %arg45, %1 : i32
  %4 = llvm.or %3, %2 : i1
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_or_icmp_eq_100_i32_fail_proof : icmp_slt_0_or_icmp_eq_100_i32_fail_before ⊑ icmp_slt_0_or_icmp_eq_100_i32_fail_after := by
  unfold icmp_slt_0_or_icmp_eq_100_i32_fail_before icmp_slt_0_or_icmp_eq_100_i32_fail_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_or_icmp_eq_100_i32_fail
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_or_icmp_eq_100_i32_fail



def icmp_slt_0_and_icmp_ne_neg2_i32_fail_before := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "ne" %arg44, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg44, %1 : i32
  %5 = llvm.and %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def icmp_slt_0_and_icmp_ne_neg2_i32_fail_after := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "ne" %arg44, %0 : i32
  %3 = llvm.icmp "slt" %arg44, %1 : i32
  %4 = llvm.and %3, %2 : i1
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_and_icmp_ne_neg2_i32_fail_proof : icmp_slt_0_and_icmp_ne_neg2_i32_fail_before ⊑ icmp_slt_0_and_icmp_ne_neg2_i32_fail_after := by
  unfold icmp_slt_0_and_icmp_ne_neg2_i32_fail_before icmp_slt_0_and_icmp_ne_neg2_i32_fail_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_and_icmp_ne_neg2_i32_fail
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_and_icmp_ne_neg2_i32_fail



def icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_before := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "ne" %arg42, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg43, %1 : i32
  %5 = llvm.and %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_after := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "ne" %arg42, %0 : i32
  %3 = llvm.icmp "slt" %arg43, %1 : i32
  %4 = llvm.and %3, %2 : i1
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_proof : icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_before ⊑ icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_after := by
  unfold icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_before icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail
  all_goals (try extract_goal ; sorry)
  ---END icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail



def icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "sgt" %arg40, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg41, %1 : i32
  %5 = llvm.and %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "sgt" %arg40, %0 : i32
  %3 = llvm.icmp "slt" %arg41, %1 : i32
  %4 = llvm.and %3, %2 : i1
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_proof : icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_before ⊑ icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_after := by
  unfold icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_before icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail
  all_goals (try extract_goal ; sorry)
  ---END icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail



def icmp_slt_0_xor_icmp_sge_neg2_i32_fail_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.icmp "sge" %arg39, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  %4 = llvm.lshr %arg39, %1 : i32
  %5 = llvm.xor %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def icmp_slt_0_xor_icmp_sge_neg2_i32_fail_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.icmp "ult" %arg39, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_xor_icmp_sge_neg2_i32_fail_proof : icmp_slt_0_xor_icmp_sge_neg2_i32_fail_before ⊑ icmp_slt_0_xor_icmp_sge_neg2_i32_fail_after := by
  unfold icmp_slt_0_xor_icmp_sge_neg2_i32_fail_before icmp_slt_0_xor_icmp_sge_neg2_i32_fail_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_xor_icmp_sge_neg2_i32_fail
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_xor_icmp_sge_neg2_i32_fail



def icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_before := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(100 : i32) : i32
  %2 = llvm.mlir.constant(31 : i32) : i32
  %3 = llvm.add %arg38, %0 : i32
  %4 = llvm.icmp "sge" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i32
  %6 = llvm.lshr %arg38, %2 : i32
  %7 = llvm.or %6, %5 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_after := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(99 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.add %arg38, %0 : i32
  %4 = llvm.icmp "sgt" %3, %1 : i32
  %5 = llvm.icmp "slt" %arg38, %2 : i32
  %6 = llvm.or %5, %4 : i1
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_proof : icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_before ⊑ icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_after := by
  unfold icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_before icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_0_or_icmp_add_1_sge_100_i32_fail
  all_goals (try extract_goal ; sorry)
  ---END icmp_slt_0_or_icmp_add_1_sge_100_i32_fail



def logical_and_icmps1_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.mlir.constant(10086 : i32) : i32
  %3 = llvm.icmp "sgt" %arg36, %0 : i32
  %4 = "llvm.select"(%arg37, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.icmp "slt" %arg36, %2 : i32
  %6 = "llvm.select"(%4, %5, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def logical_and_icmps1_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i1):
  %0 = llvm.mlir.constant(10086 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ult" %arg36, %0 : i32
  %3 = "llvm.select"(%arg37, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_icmps1_proof : logical_and_icmps1_before ⊑ logical_and_icmps1_after := by
  unfold logical_and_icmps1_before logical_and_icmps1_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_icmps1
  all_goals (try extract_goal ; sorry)
  ---END logical_and_icmps1



def logical_and_icmps2_before := [llvm|
{
^0(%arg34 : i32, %arg35 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.mlir.constant(10086 : i32) : i32
  %3 = llvm.icmp "slt" %arg34, %0 : i32
  %4 = "llvm.select"(%arg35, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.icmp "eq" %arg34, %2 : i32
  %6 = "llvm.select"(%4, %5, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def logical_and_icmps2_after := [llvm|
{
^0(%arg34 : i32, %arg35 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_icmps2_proof : logical_and_icmps2_before ⊑ logical_and_icmps2_after := by
  unfold logical_and_icmps2_before logical_and_icmps2_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_icmps2
  all_goals (try extract_goal ; sorry)
  ---END logical_and_icmps2



def icmp_eq_or_z_or_pow2orz_before := [llvm|
{
^0(%arg27 : i8, %arg28 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg28 : i8
  %2 = llvm.and %1, %arg28 : i8
  %3 = llvm.icmp "eq" %arg27, %0 : i8
  %4 = llvm.icmp "eq" %arg27, %2 : i8
  %5 = llvm.or %4, %3 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_eq_or_z_or_pow2orz_after := [llvm|
{
^0(%arg27 : i8, %arg28 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg28 : i8
  %2 = llvm.and %arg28, %1 : i8
  %3 = llvm.and %arg27, %2 : i8
  %4 = llvm.icmp "eq" %3, %arg27 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_or_z_or_pow2orz_proof : icmp_eq_or_z_or_pow2orz_before ⊑ icmp_eq_or_z_or_pow2orz_after := by
  unfold icmp_eq_or_z_or_pow2orz_before icmp_eq_or_z_or_pow2orz_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_or_z_or_pow2orz
  all_goals (try extract_goal ; sorry)
  ---END icmp_eq_or_z_or_pow2orz



def icmp_eq_or_z_or_pow2orz_logical_before := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.sub %0, %arg26 : i8
  %3 = llvm.and %2, %arg26 : i8
  %4 = llvm.icmp "eq" %arg25, %0 : i8
  %5 = llvm.icmp "eq" %arg25, %3 : i8
  %6 = "llvm.select"(%5, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_eq_or_z_or_pow2orz_logical_after := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg26 : i8
  %2 = llvm.and %arg26, %1 : i8
  %3 = llvm.and %arg25, %2 : i8
  %4 = llvm.icmp "eq" %3, %arg25 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_or_z_or_pow2orz_logical_proof : icmp_eq_or_z_or_pow2orz_logical_before ⊑ icmp_eq_or_z_or_pow2orz_logical_after := by
  unfold icmp_eq_or_z_or_pow2orz_logical_before icmp_eq_or_z_or_pow2orz_logical_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_or_z_or_pow2orz_logical
  all_goals (try extract_goal ; sorry)
  ---END icmp_eq_or_z_or_pow2orz_logical



def icmp_eq_or_z_or_pow2orz_fail_logic_or_before := [llvm|
{
^0(%arg21 : i8, %arg22 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.sub %0, %arg22 : i8
  %3 = llvm.and %2, %arg22 : i8
  %4 = llvm.icmp "eq" %arg21, %0 : i8
  %5 = llvm.icmp "eq" %arg21, %3 : i8
  %6 = "llvm.select"(%4, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_eq_or_z_or_pow2orz_fail_logic_or_after := [llvm|
{
^0(%arg21 : i8, %arg22 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.sub %0, %arg22 : i8
  %3 = llvm.and %arg22, %2 : i8
  %4 = llvm.icmp "eq" %arg21, %0 : i8
  %5 = llvm.icmp "eq" %arg21, %3 : i8
  %6 = "llvm.select"(%4, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_or_z_or_pow2orz_fail_logic_or_proof : icmp_eq_or_z_or_pow2orz_fail_logic_or_before ⊑ icmp_eq_or_z_or_pow2orz_fail_logic_or_after := by
  unfold icmp_eq_or_z_or_pow2orz_fail_logic_or_before icmp_eq_or_z_or_pow2orz_fail_logic_or_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_or_z_or_pow2orz_fail_logic_or
  all_goals (try extract_goal ; sorry)
  ---END icmp_eq_or_z_or_pow2orz_fail_logic_or



def icmp_ne_and_z_and_onefail_before := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(2 : i8) : i8
  %3 = llvm.icmp "ne" %arg18, %0 : i8
  %4 = llvm.icmp "ne" %arg18, %1 : i8
  %5 = llvm.icmp "ne" %arg18, %2 : i8
  %6 = llvm.and %3, %4 : i1
  %7 = llvm.and %6, %5 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def icmp_ne_and_z_and_onefail_after := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.icmp "ugt" %arg18, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_and_z_and_onefail_proof : icmp_ne_and_z_and_onefail_before ⊑ icmp_ne_and_z_and_onefail_after := by
  unfold icmp_ne_and_z_and_onefail_before icmp_ne_and_z_and_onefail_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_and_z_and_onefail
  all_goals (try extract_goal ; sorry)
  ---END icmp_ne_and_z_and_onefail



def icmp_eq_or_z_or_pow2orz_fail_nonzero_const_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.sub %0, %arg11 : i8
  %3 = llvm.and %2, %arg11 : i8
  %4 = llvm.icmp "eq" %arg10, %1 : i8
  %5 = llvm.icmp "eq" %arg10, %3 : i8
  %6 = llvm.or %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_eq_or_z_or_pow2orz_fail_nonzero_const_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.sub %0, %arg11 : i8
  %3 = llvm.and %arg11, %2 : i8
  %4 = llvm.icmp "eq" %arg10, %1 : i8
  %5 = llvm.icmp "eq" %arg10, %3 : i8
  %6 = llvm.or %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_or_z_or_pow2orz_fail_nonzero_const_proof : icmp_eq_or_z_or_pow2orz_fail_nonzero_const_before ⊑ icmp_eq_or_z_or_pow2orz_fail_nonzero_const_after := by
  unfold icmp_eq_or_z_or_pow2orz_fail_nonzero_const_before icmp_eq_or_z_or_pow2orz_fail_nonzero_const_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_or_z_or_pow2orz_fail_nonzero_const
  all_goals (try extract_goal ; sorry)
  ---END icmp_eq_or_z_or_pow2orz_fail_nonzero_const



def icmp_eq_or_z_or_pow2orz_fail_bad_pred2_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg7 : i8
  %2 = llvm.and %1, %arg7 : i8
  %3 = llvm.icmp "sle" %arg6, %0 : i8
  %4 = llvm.icmp "sle" %arg6, %2 : i8
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_eq_or_z_or_pow2orz_fail_bad_pred2_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.sub %0, %arg7 : i8
  %3 = llvm.and %arg7, %2 : i8
  %4 = llvm.icmp "slt" %arg6, %1 : i8
  %5 = llvm.icmp "sle" %arg6, %3 : i8
  %6 = llvm.or %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_or_z_or_pow2orz_fail_bad_pred2_proof : icmp_eq_or_z_or_pow2orz_fail_bad_pred2_before ⊑ icmp_eq_or_z_or_pow2orz_fail_bad_pred2_after := by
  unfold icmp_eq_or_z_or_pow2orz_fail_bad_pred2_before icmp_eq_or_z_or_pow2orz_fail_bad_pred2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_or_z_or_pow2orz_fail_bad_pred2
  all_goals (try extract_goal ; sorry)
  ---END icmp_eq_or_z_or_pow2orz_fail_bad_pred2



def and_slt_to_mask_before := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(-124 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "slt" %arg5, %0 : i8
  %4 = llvm.and %arg5, %1 : i8
  %5 = llvm.icmp "eq" %4, %2 : i8
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def and_slt_to_mask_after := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(-126 : i8) : i8
  %1 = llvm.icmp "slt" %arg5, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_slt_to_mask_proof : and_slt_to_mask_before ⊑ and_slt_to_mask_after := by
  unfold and_slt_to_mask_before and_slt_to_mask_after
  simp_alive_peephole
  intros
  ---BEGIN and_slt_to_mask
  all_goals (try extract_goal ; sorry)
  ---END and_slt_to_mask



def and_sgt_to_mask_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "sgt" %arg3, %0 : i8
  %4 = llvm.and %arg3, %1 : i8
  %5 = llvm.icmp "eq" %4, %2 : i8
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def and_sgt_to_mask_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(124 : i8) : i8
  %2 = llvm.and %arg3, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_sgt_to_mask_proof : and_sgt_to_mask_before ⊑ and_sgt_to_mask_after := by
  unfold and_sgt_to_mask_before and_sgt_to_mask_after
  simp_alive_peephole
  intros
  ---BEGIN and_sgt_to_mask
  all_goals (try extract_goal ; sorry)
  ---END and_sgt_to_mask



def and_ugt_to_mask_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "ugt" %arg1, %0 : i8
  %4 = llvm.and %arg1, %1 : i8
  %5 = llvm.icmp "eq" %4, %2 : i8
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def and_ugt_to_mask_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(-4 : i8) : i8
  %2 = llvm.and %arg1, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ugt_to_mask_proof : and_ugt_to_mask_before ⊑ and_ugt_to_mask_after := by
  unfold and_ugt_to_mask_before and_ugt_to_mask_after
  simp_alive_peephole
  intros
  ---BEGIN and_ugt_to_mask
  all_goals (try extract_goal ; sorry)
  ---END and_ugt_to_mask


