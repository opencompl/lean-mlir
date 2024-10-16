
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
section gshifthadd_statements
                                                    
def ashr_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg77 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %3 = llvm.and %arg77, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.ashr %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def ashr_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg77 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem ashr_C1_add_A_C2_i32_proof : ashr_C1_add_A_C2_i32_before ⊑ ashr_C1_add_A_C2_i32_after := by
  unfold ashr_C1_add_A_C2_i32_before ashr_C1_add_A_C2_i32_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_C1_add_A_C2_i32
  all_goals (try extract_goal ; sorry)
  ---END ashr_C1_add_A_C2_i32



def lshr_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg76 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %3 = llvm.and %arg76, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.shl %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lshr_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg76 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 192 : i32}> : () -> i32
  %2 = llvm.and %arg76, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem lshr_C1_add_A_C2_i32_proof : lshr_C1_add_A_C2_i32_before ⊑ lshr_C1_add_A_C2_i32_after := by
  unfold lshr_C1_add_A_C2_i32_before lshr_C1_add_A_C2_i32_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_C1_add_A_C2_i32
  all_goals (try extract_goal ; sorry)
  ---END lshr_C1_add_A_C2_i32



def shl_add_nuw_before := [llvm|
{
^0(%arg69 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %2 = llvm.add %arg69, %0 overflow<nuw> : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_add_nuw_after := [llvm|
{
^0(%arg69 : i32):
  %0 = "llvm.mlir.constant"() <{value = 192 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg69 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_add_nuw_proof : shl_add_nuw_before ⊑ shl_add_nuw_after := by
  unfold shl_add_nuw_before shl_add_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_add_nuw



def shl_nuw_add_nuw_before := [llvm|
{
^0(%arg65 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.add %arg65, %0 overflow<nuw> : i32
  %2 = llvm.shl %0, %1 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_nuw_add_nuw_after := [llvm|
{
^0(%arg65 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg65 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_nuw_add_nuw_proof : shl_nuw_add_nuw_before ⊑ shl_nuw_add_nuw_after := by
  unfold shl_nuw_add_nuw_before shl_nuw_add_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_nuw_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_nuw_add_nuw



def shl_nsw_add_nuw_before := [llvm|
{
^0(%arg64 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.add %arg64, %0 overflow<nuw> : i32
  %3 = llvm.shl %1, %2 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_add_nuw_after := [llvm|
{
^0(%arg64 : i32):
  %0 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg64 overflow<nsw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_nsw_add_nuw_proof : shl_nsw_add_nuw_before ⊑ shl_nsw_add_nuw_after := by
  unfold shl_nsw_add_nuw_before shl_nsw_add_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_nsw_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_add_nuw



def lshr_exact_add_nuw_before := [llvm|
{
^0(%arg63 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %2 = llvm.add %arg63, %0 overflow<nuw> : i32
  %3 = llvm.lshr %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_exact_add_nuw_after := [llvm|
{
^0(%arg63 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.lshr %0, %arg63 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem lshr_exact_add_nuw_proof : lshr_exact_add_nuw_before ⊑ lshr_exact_add_nuw_after := by
  unfold lshr_exact_add_nuw_before lshr_exact_add_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_exact_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END lshr_exact_add_nuw



def ashr_exact_add_nuw_before := [llvm|
{
^0(%arg62 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -4 : i32}> : () -> i32
  %2 = llvm.add %arg62, %0 overflow<nuw> : i32
  %3 = llvm.ashr %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_exact_add_nuw_after := [llvm|
{
^0(%arg62 : i32):
  %0 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %1 = llvm.ashr %0, %arg62 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem ashr_exact_add_nuw_proof : ashr_exact_add_nuw_before ⊑ ashr_exact_add_nuw_after := by
  unfold ashr_exact_add_nuw_before ashr_exact_add_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_exact_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END ashr_exact_add_nuw



def lshr_exact_add_negative_shift_positive_before := [llvm|
{
^0(%arg56 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.add %arg56, %0 : i32
  %3 = llvm.lshr %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_exact_add_negative_shift_positive_after := [llvm|
{
^0(%arg56 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = llvm.lshr %0, %arg56 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem lshr_exact_add_negative_shift_positive_proof : lshr_exact_add_negative_shift_positive_before ⊑ lshr_exact_add_negative_shift_positive_after := by
  unfold lshr_exact_add_negative_shift_positive_before lshr_exact_add_negative_shift_positive_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_exact_add_negative_shift_positive
  all_goals (try extract_goal ; sorry)
  ---END lshr_exact_add_negative_shift_positive



def ashr_exact_add_negative_shift_negative_before := [llvm|
{
^0(%arg49 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.add %arg49, %0 : i32
  %3 = llvm.ashr %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_exact_add_negative_shift_negative_after := [llvm|
{
^0(%arg49 : i32):
  %0 = "llvm.mlir.constant"() <{value = -4 : i32}> : () -> i32
  %1 = llvm.ashr %0, %arg49 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem ashr_exact_add_negative_shift_negative_proof : ashr_exact_add_negative_shift_negative_before ⊑ ashr_exact_add_negative_shift_negative_after := by
  unfold ashr_exact_add_negative_shift_negative_before ashr_exact_add_negative_shift_negative_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_exact_add_negative_shift_negative
  all_goals (try extract_goal ; sorry)
  ---END ashr_exact_add_negative_shift_negative



def shl_nsw_add_negative_before := [llvm|
{
^0(%arg45 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.add %arg45, %0 : i32
  %3 = llvm.shl %1, %2 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_add_negative_after := [llvm|
{
^0(%arg45 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg45 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_nsw_add_negative_proof : shl_nsw_add_negative_before ⊑ shl_nsw_add_negative_after := by
  unfold shl_nsw_add_negative_before shl_nsw_add_negative_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_nsw_add_negative
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_add_negative



def shl_nsw_add_negative_invalid_constant3_before := [llvm|
{
^0(%arg39 : i4):
  %0 = "llvm.mlir.constant"() <{value = -8 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 2 : i4}> : () -> i4
  %2 = llvm.add %arg39, %0 : i4
  %3 = llvm.shl %1, %2 overflow<nsw> : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def shl_nsw_add_negative_invalid_constant3_after := [llvm|
{
^0(%arg39 : i4):
  %0 = "llvm.mlir.constant"() <{value = -8 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 2 : i4}> : () -> i4
  %2 = llvm.xor %arg39, %0 : i4
  %3 = llvm.shl %1, %2 overflow<nsw> : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem shl_nsw_add_negative_invalid_constant3_proof : shl_nsw_add_negative_invalid_constant3_before ⊑ shl_nsw_add_negative_invalid_constant3_after := by
  unfold shl_nsw_add_negative_invalid_constant3_before shl_nsw_add_negative_invalid_constant3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_nsw_add_negative_invalid_constant3
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_add_negative_invalid_constant3



def lshr_16_add_known_16_leading_zeroes_before := [llvm|
{
^0(%arg29 : i32, %arg30 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %2 = llvm.and %arg29, %0 : i32
  %3 = llvm.and %arg30, %0 : i32
  %4 = llvm.add %2, %3 : i32
  %5 = llvm.lshr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lshr_16_add_known_16_leading_zeroes_after := [llvm|
{
^0(%arg29 : i32, %arg30 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %2 = llvm.and %arg29, %0 : i32
  %3 = llvm.and %arg30, %0 : i32
  %4 = llvm.add %2, %3 overflow<nsw,nuw> : i32
  %5 = llvm.lshr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem lshr_16_add_known_16_leading_zeroes_proof : lshr_16_add_known_16_leading_zeroes_before ⊑ lshr_16_add_known_16_leading_zeroes_after := by
  unfold lshr_16_add_known_16_leading_zeroes_before lshr_16_add_known_16_leading_zeroes_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_16_add_known_16_leading_zeroes
  all_goals (try extract_goal ; sorry)
  ---END lshr_16_add_known_16_leading_zeroes



def lshr_16_add_not_known_16_leading_zeroes_before := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = "llvm.mlir.constant"() <{value = 131071 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %3 = llvm.and %arg27, %0 : i32
  %4 = llvm.and %arg28, %1 : i32
  %5 = llvm.add %3, %4 : i32
  %6 = llvm.lshr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def lshr_16_add_not_known_16_leading_zeroes_after := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = "llvm.mlir.constant"() <{value = 131071 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %3 = llvm.and %arg27, %0 : i32
  %4 = llvm.and %arg28, %1 : i32
  %5 = llvm.add %3, %4 overflow<nsw,nuw> : i32
  %6 = llvm.lshr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem lshr_16_add_not_known_16_leading_zeroes_proof : lshr_16_add_not_known_16_leading_zeroes_before ⊑ lshr_16_add_not_known_16_leading_zeroes_after := by
  unfold lshr_16_add_not_known_16_leading_zeroes_before lshr_16_add_not_known_16_leading_zeroes_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_16_add_not_known_16_leading_zeroes
  all_goals (try extract_goal ; sorry)
  ---END lshr_16_add_not_known_16_leading_zeroes



def lshr_32_add_known_32_leading_zeroes_before := [llvm|
{
^0(%arg15 : i64, %arg16 : i64):
  %0 = "llvm.mlir.constant"() <{value = 4294967295 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
  %2 = llvm.and %arg15, %0 : i64
  %3 = llvm.and %arg16, %0 : i64
  %4 = llvm.add %2, %3 : i64
  %5 = llvm.lshr %4, %1 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def lshr_32_add_known_32_leading_zeroes_after := [llvm|
{
^0(%arg15 : i64, %arg16 : i64):
  %0 = "llvm.mlir.constant"() <{value = 4294967295 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
  %2 = llvm.and %arg15, %0 : i64
  %3 = llvm.and %arg16, %0 : i64
  %4 = llvm.add %2, %3 overflow<nsw,nuw> : i64
  %5 = llvm.lshr %4, %1 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
theorem lshr_32_add_known_32_leading_zeroes_proof : lshr_32_add_known_32_leading_zeroes_before ⊑ lshr_32_add_known_32_leading_zeroes_after := by
  unfold lshr_32_add_known_32_leading_zeroes_before lshr_32_add_known_32_leading_zeroes_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_32_add_known_32_leading_zeroes
  all_goals (try extract_goal ; sorry)
  ---END lshr_32_add_known_32_leading_zeroes



def lshr_32_add_not_known_32_leading_zeroes_before := [llvm|
{
^0(%arg13 : i64, %arg14 : i64):
  %0 = "llvm.mlir.constant"() <{value = 8589934591 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 4294967295 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
  %3 = llvm.and %arg13, %0 : i64
  %4 = llvm.and %arg14, %1 : i64
  %5 = llvm.add %3, %4 : i64
  %6 = llvm.lshr %5, %2 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def lshr_32_add_not_known_32_leading_zeroes_after := [llvm|
{
^0(%arg13 : i64, %arg14 : i64):
  %0 = "llvm.mlir.constant"() <{value = 8589934591 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 4294967295 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
  %3 = llvm.and %arg13, %0 : i64
  %4 = llvm.and %arg14, %1 : i64
  %5 = llvm.add %3, %4 overflow<nsw,nuw> : i64
  %6 = llvm.lshr %5, %2 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
theorem lshr_32_add_not_known_32_leading_zeroes_proof : lshr_32_add_not_known_32_leading_zeroes_before ⊑ lshr_32_add_not_known_32_leading_zeroes_after := by
  unfold lshr_32_add_not_known_32_leading_zeroes_before lshr_32_add_not_known_32_leading_zeroes_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_32_add_not_known_32_leading_zeroes
  all_goals (try extract_goal ; sorry)
  ---END lshr_32_add_not_known_32_leading_zeroes



def shl_fold_or_disjoint_cnt_before := [llvm|
{
^0(%arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.or %arg2, %0 : i8
  %3 = llvm.shl %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_fold_or_disjoint_cnt_after := [llvm|
{
^0(%arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_fold_or_disjoint_cnt_proof : shl_fold_or_disjoint_cnt_before ⊑ shl_fold_or_disjoint_cnt_after := by
  unfold shl_fold_or_disjoint_cnt_before shl_fold_or_disjoint_cnt_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_fold_or_disjoint_cnt
  all_goals (try extract_goal ; sorry)
  ---END shl_fold_or_disjoint_cnt


