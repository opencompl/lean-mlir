
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gandhorhicmps_proof
theorem PR1817_1_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.slt e (const? 10)) (icmp IntPredicate.ult e (const? 10)) ⊑
    icmp IntPredicate.ult e (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR1817_1_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 10)) (icmp IntPredicate.ult e (const? 10)) (const? 0) ⊑
    icmp IntPredicate.ult e (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR1817_2_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.slt e (const? 10)) (icmp IntPredicate.ult e (const? 10)) ⊑
    icmp IntPredicate.slt e (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR1817_2_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 10)) (const? 1) (icmp IntPredicate.ult e (const? 10)) ⊑
    icmp IntPredicate.slt e (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR2330_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e_1 (const? 8)) (icmp IntPredicate.ult e (const? 8)) ⊑
    icmp IntPredicate.ult (LLVM.or e_1 e) (const? 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants1_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.eq e (const? 50)) (icmp IntPredicate.eq e (const? 51)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? (-2))) (const? 50) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants1_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 50)) (const? 1) (icmp IntPredicate.eq e (const? 51)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? (-2))) (const? 50) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants1_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne e (const? 51)) (icmp IntPredicate.ne e (const? 50)) ⊑
    icmp IntPredicate.ult (add e (const? (-52))) (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants1_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ne e (const? 51)) (icmp IntPredicate.ne e (const? 50)) (const? 0) ⊑
    icmp IntPredicate.ult (add e (const? (-52))) (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants2_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.eq e (const? 97)) (icmp IntPredicate.eq e (const? 65)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? (-33))) (const? 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants2_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 97)) (const? 1) (icmp IntPredicate.eq e (const? 65)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? (-33))) (const? 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants2_thm (e : IntW 19) :
  LLVM.and (icmp IntPredicate.ne e (const? 65)) (icmp IntPredicate.ne e (const? 193)) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? (-129))) (const? 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants2_logical_thm (e : IntW 19) :
  select (icmp IntPredicate.ne e (const? 65)) (icmp IntPredicate.ne e (const? 193)) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? (-129))) (const? 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants3_thm (e : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e (const? (-2))) (icmp IntPredicate.eq e (const? 126)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 127)) (const? 126) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants3_logical_thm (e : IntW 8) :
  select (icmp IntPredicate.eq e (const? (-2))) (const? 1) (icmp IntPredicate.eq e (const? 126)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 127)) (const? 126) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants3_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e (const? 65)) (icmp IntPredicate.ne e (const? (-63))) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 127)) (const? 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants3_logical_thm (e : IntW 8) :
  select (icmp IntPredicate.ne e (const? 65)) (icmp IntPredicate.ne e (const? (-63))) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 127)) (const? 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_eq_with_diff_one_thm (e : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e (const? 13)) (icmp IntPredicate.eq e (const? 14)) ⊑
    icmp IntPredicate.ult (add e (const? (-13))) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_eq_with_diff_one_logical_thm (e : IntW 8) :
  select (icmp IntPredicate.eq e (const? 13)) (const? 1) (icmp IntPredicate.eq e (const? 14)) ⊑
    icmp IntPredicate.ult (add e (const? (-13))) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ne_with_diff_one_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne e (const? 40)) (icmp IntPredicate.ne e (const? 39)) ⊑
    icmp IntPredicate.ult (add e (const? (-41))) (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ne_with_diff_one_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ne e (const? 40)) (icmp IntPredicate.ne e (const? 39)) (const? 0) ⊑
    icmp IntPredicate.ult (add e (const? (-41))) (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_eq_with_diff_one_signed_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.eq e (const? 0)) (icmp IntPredicate.eq e (const? (-1))) ⊑
    icmp IntPredicate.ult (add e (const? 1)) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_eq_with_diff_one_signed_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 0)) (const? 1) (icmp IntPredicate.eq e (const? (-1))) ⊑
    icmp IntPredicate.ult (add e (const? 1)) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ne_with_diff_one_signed_thm (e : IntW 64) :
  LLVM.and (icmp IntPredicate.ne e (const? (-1))) (icmp IntPredicate.ne e (const? 0)) ⊑
    icmp IntPredicate.ult (add e (const? (-1))) (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ne_with_diff_one_signed_logical_thm (e : IntW 64) :
  select (icmp IntPredicate.ne e (const? (-1))) (icmp IntPredicate.ne e (const? 0)) (const? 0) ⊑
    icmp IntPredicate.ult (add e (const? (-1))) (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_1_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.slt e (const? 0)) (icmp IntPredicate.eq e (const? 2147483647)) ⊑
    icmp IntPredicate.ugt e (const? 2147483646) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_1_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 0)) (const? 1) (icmp IntPredicate.eq e (const? 2147483647)) ⊑
    icmp IntPredicate.ugt e (const? 2147483646) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_2_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.ult e (const? (-2147483648))) (icmp IntPredicate.eq e (const? (-1))) ⊑
    icmp IntPredicate.sgt e (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_2_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? (-2147483648))) (const? 1) (icmp IntPredicate.eq e (const? (-1))) ⊑
    icmp IntPredicate.sgt e (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_3_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.sge e (const? 0)) (icmp IntPredicate.eq e (const? (-2147483648))) ⊑
    icmp IntPredicate.ult e (const? (-2147483647)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_3_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sge e (const? 0)) (const? 1) (icmp IntPredicate.eq e (const? (-2147483648))) ⊑
    icmp IntPredicate.ult e (const? (-2147483647)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_4_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.uge e (const? (-2147483648))) (icmp IntPredicate.eq e (const? 0)) ⊑
    icmp IntPredicate.slt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_4_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.uge e (const? (-2147483648))) (const? 1) (icmp IntPredicate.eq e (const? 0)) ⊑
    icmp IntPredicate.slt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_5_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.slt e (const? 1)) (icmp IntPredicate.eq e (const? 2147483647)) ⊑
    icmp IntPredicate.ult (add e (const? (-2147483647))) (const? (-2147483646)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_5_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 1)) (const? 1) (icmp IntPredicate.eq e (const? 2147483647)) ⊑
    icmp IntPredicate.ult (add e (const? (-2147483647))) (const? (-2147483646)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_6_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.ult e (const? (-2147483647))) (icmp IntPredicate.eq e (const? (-1))) ⊑
    icmp IntPredicate.ult (add e (const? 1)) (const? (-2147483646)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_6_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? (-2147483647))) (const? 1) (icmp IntPredicate.eq e (const? (-1))) ⊑
    icmp IntPredicate.ult (add e (const? 1)) (const? (-2147483646)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_7_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.uge e (const? (-2147483647))) (icmp IntPredicate.eq e (const? 0)) ⊑
    icmp IntPredicate.slt (add e (const? (-1))) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_7_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.uge e (const? (-2147483647))) (const? 1) (icmp IntPredicate.eq e (const? 0)) ⊑
    icmp IntPredicate.slt (add e (const? (-1))) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_8_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.slt e (const? 14)) (icmp IntPredicate.ne e (const? (-2147483648))) ⊑
    icmp IntPredicate.ult (add e (const? 2147483647)) (const? (-2147483635)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_8_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 14)) (icmp IntPredicate.ne e (const? (-2147483648))) (const? 0) ⊑
    icmp IntPredicate.ult (add e (const? 2147483647)) (const? (-2147483635)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_9_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt e (const? 13)) (icmp IntPredicate.ne e (const? 2147483647)) ⊑
    icmp IntPredicate.ult (add e (const? (-14))) (const? 2147483633) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_9_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt e (const? 13)) (icmp IntPredicate.ne e (const? 2147483647)) (const? 0) ⊑
    icmp IntPredicate.ult (add e (const? (-14))) (const? 2147483633) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_10_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ugt e (const? 13)) (icmp IntPredicate.ne e (const? (-1))) ⊑
    icmp IntPredicate.ult (add e (const? (-14))) (const? (-15)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR42691_10_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ugt e (const? 13)) (icmp IntPredicate.ne e (const? (-1))) (const? 0) ⊑
    icmp IntPredicate.ult (add e (const? (-14))) (const? (-15)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem substitute_constant_and_eq_eq_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 42)) (icmp IntPredicate.eq e_1 e) ⊑
    LLVM.and (icmp IntPredicate.eq e_1 (const? 42)) (icmp IntPredicate.eq e (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem substitute_constant_and_eq_eq_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 42)) (icmp IntPredicate.eq e_1 e) (const? 0) ⊑
    select (icmp IntPredicate.eq e_1 (const? 42)) (icmp IntPredicate.eq e (const? 42)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem substitute_constant_and_eq_eq_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 e) (icmp IntPredicate.eq e_1 (const? 42)) ⊑
    LLVM.and (icmp IntPredicate.eq e_1 (const? 42)) (icmp IntPredicate.eq e (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem substitute_constant_and_eq_eq_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 e) (icmp IntPredicate.eq e_1 (const? 42)) (const? 0) ⊑
    LLVM.and (icmp IntPredicate.eq e_1 (const? 42)) (icmp IntPredicate.eq e (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem substitute_constant_and_eq_ugt_swap_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.eq e (const? 42)) ⊑
    LLVM.and (icmp IntPredicate.eq e (const? 42)) (icmp IntPredicate.ugt e_1 (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem substitute_constant_and_eq_ugt_swap_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.eq e (const? 42)) (const? 0) ⊑
    LLVM.and (icmp IntPredicate.eq e (const? 42)) (icmp IntPredicate.ugt e_1 (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem substitute_constant_and_ne_ugt_swap_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.ne e (const? 42)) (const? 0) ⊑
    LLVM.and (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.ne e (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem substitute_constant_or_ne_swap_sle_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 42)) (icmp IntPredicate.sle e e_1) ⊑
    LLVM.or (icmp IntPredicate.ne e_1 (const? 42)) (icmp IntPredicate.slt e (const? 43)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem substitute_constant_or_ne_swap_sle_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 42)) (const? 1) (icmp IntPredicate.sle e e_1) ⊑
    select (icmp IntPredicate.ne e_1 (const? 42)) (const? 1) (icmp IntPredicate.slt e (const? 43)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem substitute_constant_or_ne_uge_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.uge e_1 e) (icmp IntPredicate.ne e_1 (const? 42)) ⊑
    LLVM.or (icmp IntPredicate.ne e_1 (const? 42)) (icmp IntPredicate.ult e (const? 43)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem substitute_constant_or_ne_uge_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.uge e_1 e) (const? 1) (icmp IntPredicate.ne e_1 (const? 42)) ⊑
    LLVM.or (icmp IntPredicate.ne e_1 (const? 42)) (icmp IntPredicate.ult e (const? 43)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_ranges_overlap_thm (e : IntW 8) :
  LLVM.or (LLVM.and (icmp IntPredicate.uge e (const? 5)) (icmp IntPredicate.ule e (const? 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 10)) (icmp IntPredicate.ule e (const? 20))) ⊑
    icmp IntPredicate.ult (add e (const? (-5))) (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_ranges_adjacent_thm (e : IntW 8) :
  LLVM.or (LLVM.and (icmp IntPredicate.uge e (const? 5)) (icmp IntPredicate.ule e (const? 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 11)) (icmp IntPredicate.ule e (const? 20))) ⊑
    icmp IntPredicate.ult (add e (const? (-5))) (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_ranges_separated_thm (e : IntW 8) :
  LLVM.or (LLVM.and (icmp IntPredicate.uge e (const? 5)) (icmp IntPredicate.ule e (const? 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 12)) (icmp IntPredicate.ule e (const? 20))) ⊑
    LLVM.or (icmp IntPredicate.ult (add e (const? (-5))) (const? 6))
      (icmp IntPredicate.ult (add e (const? (-12))) (const? 9)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_ranges_single_elem_right_thm (e : IntW 8) :
  LLVM.or (LLVM.and (icmp IntPredicate.uge e (const? 5)) (icmp IntPredicate.ule e (const? 10)))
      (icmp IntPredicate.eq e (const? 11)) ⊑
    icmp IntPredicate.ult (add e (const? (-5))) (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_ranges_single_elem_left_thm (e : IntW 8) :
  LLVM.or (LLVM.and (icmp IntPredicate.uge e (const? 5)) (icmp IntPredicate.ule e (const? 10)))
      (icmp IntPredicate.eq e (const? 4)) ⊑
    icmp IntPredicate.ult (add e (const? (-4))) (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ranges_overlap_thm (e : IntW 8) :
  LLVM.and (LLVM.and (icmp IntPredicate.uge e (const? 5)) (icmp IntPredicate.ule e (const? 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 7)) (icmp IntPredicate.ule e (const? 20))) ⊑
    icmp IntPredicate.ult (add e (const? (-7))) (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ranges_overlap_single_thm (e : IntW 8) :
  LLVM.and (LLVM.and (icmp IntPredicate.uge e (const? 5)) (icmp IntPredicate.ule e (const? 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 10)) (icmp IntPredicate.ule e (const? 20))) ⊑
    icmp IntPredicate.eq e (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ranges_no_overlap_thm (e : IntW 8) :
  LLVM.and (LLVM.and (icmp IntPredicate.uge e (const? 5)) (icmp IntPredicate.ule e (const? 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 11)) (icmp IntPredicate.ule e (const? 20))) ⊑
    const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ranges_signed_pred_thm (e : IntW 64) :
  LLVM.and (icmp IntPredicate.slt (add e (const? 127)) (const? 1024))
      (icmp IntPredicate.slt (add e (const? 128)) (const? 256)) ⊑
    icmp IntPredicate.ult (add e (const? (-9223372036854775681))) (const? (-9223372036854775553)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_two_ranges_to_mask_and_range_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt (add e (const? (-97))) (const? 25))
      (icmp IntPredicate.ugt (add e (const? (-65))) (const? 25)) ⊑
    icmp IntPredicate.ult (add (LLVM.and e (const? (-33))) (const? (-91))) (const? (-26)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_two_ranges_to_mask_and_range_not_pow2_diff_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt (add e (const? (-97))) (const? 25))
      (icmp IntPredicate.ugt (add e (const? (-64))) (const? 25)) ⊑
    LLVM.and (icmp IntPredicate.ult (add e (const? (-123))) (const? (-26)))
      (icmp IntPredicate.ult (add e (const? (-90))) (const? (-26))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_two_ranges_to_mask_and_range_different_sizes_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt (add e (const? (-97))) (const? 25))
      (icmp IntPredicate.ugt (add e (const? (-65))) (const? 24)) ⊑
    LLVM.and (icmp IntPredicate.ult (add e (const? (-123))) (const? (-26)))
      (icmp IntPredicate.ult (add e (const? (-90))) (const? (-25))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_two_ranges_to_mask_and_range_no_add_on_one_range_thm (e : IntW 16) :
  LLVM.and (icmp IntPredicate.uge e (const? 12))
      (LLVM.or (icmp IntPredicate.ult e (const? 16)) (icmp IntPredicate.uge e (const? 28))) ⊑
    icmp IntPredicate.ugt (LLVM.and e (const? (-20))) (const? 11) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem is_ascii_alphabetic_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? (-65)) { «nsw» := true, «nuw» := false }) (const? 26)) (const? 1)
      (icmp IntPredicate.ult (add e (const? (-97)) { «nsw» := true, «nuw» := false }) (const? 26)) ⊑
    icmp IntPredicate.ult (add (LLVM.and e (const? (-33))) (const? (-65))) (const? 26) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem is_ascii_alphabetic_inverted_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? (-91)) { «nsw» := true, «nuw» := false }) (const? (-26)))
      (icmp IntPredicate.ult (add e (const? (-123)) { «nsw» := true, «nuw» := false }) (const? (-26))) (const? 0) ⊑
    icmp IntPredicate.ult (add (LLVM.and e (const? (-33))) (const? (-91))) (const? (-26)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_bitwise_and_icmps_thm (e e_1 e_2 : IntW 8) :
  LLVM.and (LLVM.and (icmp IntPredicate.eq e_2 (const? 42)) (icmp IntPredicate.ne (LLVM.and e_1 (const? 1)) (const? 0)))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 1) e)) (const? 0)) ⊑
    LLVM.and (icmp IntPredicate.eq e_2 (const? 42))
      (icmp IntPredicate.eq (LLVM.and e_1 (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_bitwise_and_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (LLVM.and (icmp IntPredicate.eq e (const? 42)) (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0))) ⊑
    LLVM.and (icmp IntPredicate.eq e (const? 42))
      (icmp IntPredicate.eq (LLVM.and e_2 (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_bitwise_and_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  LLVM.and (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e_1 (const? 42)))
      (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e)) (const? 0)) ⊑
    LLVM.and
      (icmp IntPredicate.eq (LLVM.and e_2 (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1)))
      (icmp IntPredicate.eq e_1 (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_bitwise_and_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e (const? 42))) ⊑
    LLVM.and
      (icmp IntPredicate.eq (LLVM.and e_2 (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
      (icmp IntPredicate.eq e (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_logical_and_icmps_thm (e e_1 e_2 : IntW 8) :
  LLVM.and
      (select (icmp IntPredicate.eq e_2 (const? 42)) (icmp IntPredicate.ne (LLVM.and e_1 (const? 1)) (const? 0))
        (const? 0))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 1) e)) (const? 0)) ⊑
    select (icmp IntPredicate.eq e_2 (const? 42))
      (icmp IntPredicate.eq (LLVM.and e_1 (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1)))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_logical_and_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (select (icmp IntPredicate.eq e (const? 42)) (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0))
        (const? 0)) ⊑
    select (icmp IntPredicate.eq e (const? 42))
      (icmp IntPredicate.eq (LLVM.and e_2 (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_logical_and_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (select (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e (const? 42))
        (const? 0)) ⊑
    select
      (icmp IntPredicate.eq (LLVM.and e_2 (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
      (icmp IntPredicate.eq e (const? 42)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_bitwise_and_icmps_thm (e e_1 e_2 : IntW 8) :
  select (LLVM.and (icmp IntPredicate.eq e_2 (const? 42)) (icmp IntPredicate.ne (LLVM.and e_1 (const? 1)) (const? 0)))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 1) e)) (const? 0)) (const? 0) ⊑
    select (LLVM.and (icmp IntPredicate.eq e_2 (const? 42)) (icmp IntPredicate.ne (LLVM.and e_1 (const? 1)) (const? 0)))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 1) e { «nsw» := false, «nuw» := true })) (const? 0))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_bitwise_and_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (LLVM.and (icmp IntPredicate.eq e (const? 42)) (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)))
      (const? 0) ⊑
    select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e_1 { «nsw» := false, «nuw» := true })) (const? 0))
      (LLVM.and (icmp IntPredicate.eq e (const? 42)) (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_bitwise_and_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  select (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e_1 (const? 42)))
      (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e)) (const? 0)) (const? 0) ⊑
    select (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e_1 (const? 42)))
      (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e { «nsw» := false, «nuw» := true })) (const? 0))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_bitwise_and_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e (const? 42)))
      (const? 0) ⊑
    select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e_1 { «nsw» := false, «nuw» := true })) (const? 0))
      (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e (const? 42)))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_logical_and_icmps_thm (e e_1 e_2 : IntW 8) :
  select
      (select (icmp IntPredicate.eq e_2 (const? 42)) (icmp IntPredicate.ne (LLVM.and e_1 (const? 1)) (const? 0))
        (const? 0))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 1) e)) (const? 0)) (const? 0) ⊑
    select
      (select (icmp IntPredicate.eq e_2 (const? 42)) (icmp IntPredicate.ne (LLVM.and e_1 (const? 1)) (const? 0))
        (const? 0))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 1) e { «nsw» := false, «nuw» := true })) (const? 0))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_logical_and_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (select (icmp IntPredicate.eq e (const? 42)) (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0))
        (const? 0))
      (const? 0) ⊑
    select
      (select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e_1 { «nsw» := false, «nuw» := true })) (const? 0))
        (icmp IntPredicate.eq e (const? 42)) (const? 0))
      (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_logical_and_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  select
      (select (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e_1 (const? 42))
        (const? 0))
      (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e)) (const? 0)) (const? 0) ⊑
    select
      (select (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e_1 (const? 42))
        (const? 0))
      (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e { «nsw» := false, «nuw» := true })) (const? 0))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_logical_and_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (select (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e (const? 42))
        (const? 0))
      (const? 0) ⊑
    select
      (icmp IntPredicate.eq (LLVM.and e_2 (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
      (icmp IntPredicate.eq e (const? 42)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_or_bitwise_or_icmps_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.or (icmp IntPredicate.eq e_2 (const? 42)) (icmp IntPredicate.eq (LLVM.and e_1 (const? 1)) (const? 0)))
      (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 1) e)) (const? 0)) ⊑
    LLVM.or (icmp IntPredicate.eq e_2 (const? 42))
      (icmp IntPredicate.ne (LLVM.and e_1 (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_or_bitwise_or_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (LLVM.or (icmp IntPredicate.eq e (const? 42)) (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0))) ⊑
    LLVM.or (icmp IntPredicate.eq e (const? 42))
      (icmp IntPredicate.ne (LLVM.and e_2 (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_or_bitwise_or_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e_1 (const? 42)))
      (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e)) (const? 0)) ⊑
    LLVM.or
      (icmp IntPredicate.ne (LLVM.and e_2 (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1)))
      (icmp IntPredicate.eq e_1 (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_or_bitwise_or_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e (const? 42))) ⊑
    LLVM.or
      (icmp IntPredicate.ne (LLVM.and e_2 (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
      (icmp IntPredicate.eq e (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_or_logical_or_icmps_thm (e e_1 e_2 : IntW 8) :
  LLVM.or
      (select (icmp IntPredicate.eq e_2 (const? 42)) (const? 1)
        (icmp IntPredicate.eq (LLVM.and e_1 (const? 1)) (const? 0)))
      (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 1) e)) (const? 0)) ⊑
    select (icmp IntPredicate.eq e_2 (const? 42)) (const? 1)
      (icmp IntPredicate.ne (LLVM.and e_1 (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_or_logical_or_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (select (icmp IntPredicate.eq e (const? 42)) (const? 1)
        (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0))) ⊑
    select (icmp IntPredicate.eq e (const? 42)) (const? 1)
      (icmp IntPredicate.ne (LLVM.and e_2 (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_or_logical_or_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0))
      (select (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) (const? 1)
        (icmp IntPredicate.eq e (const? 42))) ⊑
    select
      (icmp IntPredicate.ne (LLVM.and e_2 (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
      (const? 1) (icmp IntPredicate.eq e (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_bitwise_or_icmps_thm (e e_1 e_2 : IntW 8) :
  select (LLVM.or (icmp IntPredicate.eq e_2 (const? 42)) (icmp IntPredicate.eq (LLVM.and e_1 (const? 1)) (const? 0)))
      (const? 1) (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 1) e)) (const? 0)) ⊑
    select (LLVM.or (icmp IntPredicate.eq e_2 (const? 42)) (icmp IntPredicate.eq (LLVM.and e_1 (const? 1)) (const? 0)))
      (const? 1)
      (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 1) e { «nsw» := false, «nuw» := true })) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_bitwise_or_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0)) (const? 1)
      (LLVM.or (icmp IntPredicate.eq e (const? 42)) (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e_1 { «nsw» := false, «nuw» := true })) (const? 0))
      (const? 1)
      (LLVM.or (icmp IntPredicate.eq e (const? 42))
        (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_bitwise_or_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  select (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e_1 (const? 42)))
      (const? 1) (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e)) (const? 0)) ⊑
    select (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e_1 (const? 42)))
      (const? 1)
      (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e { «nsw» := false, «nuw» := true })) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_bitwise_or_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0)) (const? 1)
      (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) (icmp IntPredicate.eq e (const? 42))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e_1 { «nsw» := false, «nuw» := true })) (const? 0))
      (const? 1)
      (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0))
        (icmp IntPredicate.eq e (const? 42))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_logical_or_icmps_thm (e e_1 e_2 : IntW 8) :
  select
      (select (icmp IntPredicate.eq e_2 (const? 42)) (const? 1)
        (icmp IntPredicate.eq (LLVM.and e_1 (const? 1)) (const? 0)))
      (const? 1) (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 1) e)) (const? 0)) ⊑
    select
      (select (icmp IntPredicate.eq e_2 (const? 42)) (const? 1)
        (icmp IntPredicate.eq (LLVM.and e_1 (const? 1)) (const? 0)))
      (const? 1)
      (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 1) e { «nsw» := false, «nuw» := true })) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_logical_or_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0)) (const? 1)
      (select (icmp IntPredicate.eq e (const? 42)) (const? 1)
        (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0))) ⊑
    select
      (select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e_1 { «nsw» := false, «nuw» := true })) (const? 0))
        (const? 1) (icmp IntPredicate.eq e (const? 42)))
      (const? 1) (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_logical_or_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  select
      (select (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) (const? 1)
        (icmp IntPredicate.eq e_1 (const? 42)))
      (const? 1) (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e)) (const? 0)) ⊑
    select
      (select (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) (const? 1)
        (icmp IntPredicate.eq e_1 (const? 42)))
      (const? 1)
      (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e { «nsw» := false, «nuw» := true })) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_logical_or_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 1) e_1)) (const? 0)) (const? 1)
      (select (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) (const? 1)
        (icmp IntPredicate.eq e (const? 42))) ⊑
    select
      (icmp IntPredicate.ne (LLVM.and e_2 (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
        (LLVM.or (shl (const? 1) e_1 { «nsw» := false, «nuw» := true }) (const? 1)))
      (const? 1) (icmp IntPredicate.eq e (const? 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_asymmetric_thm (e : IntW 1) (e_1 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.ne (LLVM.and e_1 (const? 255)) (const? 0)) e (const? 0))
      (icmp IntPredicate.eq (LLVM.and e_1 (const? 11)) (const? 11)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 11)) (const? 11)) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_allzeros_thm (e : IntW 1) (e_1 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8)) (const? 0)) e (const? 0))
      (icmp IntPredicate.eq (LLVM.and e_1 (const? 7)) (const? 0)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_allzeros_poison1_thm (e : IntW 1) (e_1 e_2 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.eq (LLVM.and e_2 e_1) (const? 0)) e (const? 0))
      (icmp IntPredicate.eq (LLVM.and e_2 (const? 7)) (const? 0)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_2 (LLVM.or e_1 (const? 7))) (const? 0)) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_allones_thm (e : IntW 1) (e_1 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8)) (const? 8)) e (const? 0))
      (icmp IntPredicate.eq (LLVM.and e_1 (const? 7)) (const? 7)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 15)) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_allones_poison1_thm (e : IntW 1) (e_1 e_2 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.eq (LLVM.and e_2 e_1) e_1) e (const? 0))
      (icmp IntPredicate.eq (LLVM.and e_2 (const? 7)) (const? 7)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_2 (LLVM.or e_1 (const? 7))) (LLVM.or e_1 (const? 7))) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_allones_poison2_thm (e : IntW 32) (e_1 : IntW 1) (e_2 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.eq (LLVM.and e_2 (const? 8)) (const? 8)) e_1 (const? 0))
      (icmp IntPredicate.eq (LLVM.and e_2 e) e) ⊑
    LLVM.and (select (icmp IntPredicate.ne (LLVM.and e_2 (const? 8)) (const? 0)) e_1 (const? 0))
      (icmp IntPredicate.eq (LLVM.and e_2 e) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem samesign_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.slt (LLVM.and e_1 e) (const? 0)) (icmp IntPredicate.sgt (LLVM.or e_1 e) (const? (-1))) ⊑
    icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem samesign_different_sign_bittest2_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.slt (LLVM.and e_1 e) (const? 0)) (icmp IntPredicate.sge (LLVM.or e_1 e) (const? 0)) ⊑
    icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem samesign_commute1_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.sgt (LLVM.or e_1 e) (const? (-1))) (icmp IntPredicate.slt (LLVM.and e_1 e) (const? 0)) ⊑
    icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem samesign_commute2_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.slt (LLVM.and e_1 e) (const? 0)) (icmp IntPredicate.sgt (LLVM.or e e_1) (const? (-1))) ⊑
    icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem samesign_commute3_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.sgt (LLVM.or e_1 e) (const? (-1))) (icmp IntPredicate.slt (LLVM.and e e_1) (const? 0)) ⊑
    icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem samesign_inverted_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt (LLVM.and e_1 e) (const? (-1))) (icmp IntPredicate.slt (LLVM.or e_1 e) (const? 0)) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem samesign_inverted_different_sign_bittest1_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.sge (LLVM.and e_1 e) (const? 0)) (icmp IntPredicate.slt (LLVM.or e_1 e) (const? 0)) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem samesign_inverted_different_sign_bittest2_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt (LLVM.and e_1 e) (const? (-1)))
      (icmp IntPredicate.sle (LLVM.or e_1 e) (const? (-1))) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem samesign_inverted_commute1_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.slt (LLVM.or e_1 e) (const? 0)) (icmp IntPredicate.sgt (LLVM.and e_1 e) (const? (-1))) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem samesign_inverted_commute2_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt (LLVM.and e_1 e) (const? (-1))) (icmp IntPredicate.slt (LLVM.or e e_1) (const? 0)) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem samesign_inverted_commute3_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.slt (LLVM.or e_1 e) (const? 0)) (icmp IntPredicate.sgt (LLVM.and e e_1) (const? (-1))) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_or_icmp_sgt_0_i32_thm (e : IntW 32) :
  LLVM.or (zext 32 (icmp IntPredicate.slt e (const? 0))) (zext 32 (icmp IntPredicate.sgt e (const? 0))) ⊑
    zext 32 (icmp IntPredicate.ne e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_or_icmp_sgt_0_i64_thm (e : IntW 64) :
  LLVM.or (zext 64 (icmp IntPredicate.slt e (const? 0))) (zext 64 (icmp IntPredicate.sgt e (const? 0))) ⊑
    zext 64 (icmp IntPredicate.ne e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_or_icmp_sgt_0_i64_fail0_thm (e : IntW 64) :
  LLVM.or (lshr e (const? 63)) (zext 64 (icmp IntPredicate.slt e (const? 0))) ⊑ lshr e (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_or_icmp_sgt_0_i64_fail3_thm (e : IntW 64) :
  LLVM.or (ashr e (const? 62)) (zext 64 (icmp IntPredicate.slt e (const? 0))) ⊑
    LLVM.or (ashr e (const? 62)) (lshr e (const? 63)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_and_icmp_sge_neg1_i32_thm (e : IntW 32) :
  LLVM.and (lshr e (const? 31)) (zext 32 (icmp IntPredicate.sgt e (const? (-1)))) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_or_icmp_sge_neg1_i32_thm (e : IntW 32) :
  LLVM.or (lshr e (const? 31)) (zext 32 (icmp IntPredicate.sge e (const? (-1)))) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_or_icmp_sge_100_i32_thm (e : IntW 32) :
  LLVM.or (lshr e (const? 31)) (zext 32 (icmp IntPredicate.sge e (const? 100))) ⊑
    zext 32 (icmp IntPredicate.ugt e (const? 99)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_and_icmp_sge_neg1_i64_thm (e : IntW 64) :
  LLVM.and (lshr e (const? 63)) (zext 64 (icmp IntPredicate.sge e (const? (-1)))) ⊑
    zext 64 (icmp IntPredicate.eq e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_and_icmp_sge_neg2_i64_thm (e : IntW 64) :
  LLVM.and (lshr e (const? 63)) (zext 64 (icmp IntPredicate.sge e (const? (-2)))) ⊑
    zext 64 (icmp IntPredicate.ugt e (const? (-3))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_and_icmp_sge_neg1_i64_thm (e : IntW 64) :
  LLVM.and (ashr e (const? 63)) (zext 64 (icmp IntPredicate.sge e (const? (-1)))) ⊑
    zext 64 (icmp IntPredicate.eq e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_and_icmp_sgt_neg1_i64_thm (e : IntW 64) :
  LLVM.and (lshr e (const? 63)) (zext 64 (icmp IntPredicate.sgt e (const? (-1)))) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_and_icmp_sge_neg1_i64_fail_thm (e : IntW 64) :
  LLVM.and (lshr e (const? 62)) (zext 64 (icmp IntPredicate.sge e (const? (-1)))) ⊑
    select (icmp IntPredicate.sgt e (const? (-2))) (LLVM.and (lshr e (const? 62)) (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_thm (e e_1 : IntW 32) :
  LLVM.xor (lshr e_1 (const? 31)) (zext 32 (icmp IntPredicate.sgt e (const? (-1)))) ⊑
    zext 32 (icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_xor_icmp_sgt_neg2_i32_thm (e : IntW 32) :
  LLVM.xor (lshr e (const? 31)) (zext 32 (icmp IntPredicate.sgt e (const? (-2)))) ⊑
    zext 32 (icmp IntPredicate.ne e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_or_icmp_eq_100_i32_fail_thm (e : IntW 32) :
  LLVM.or (lshr e (const? 31)) (zext 32 (icmp IntPredicate.eq e (const? 100))) ⊑
    zext 32 (LLVM.or (icmp IntPredicate.slt e (const? 0)) (icmp IntPredicate.eq e (const? 100))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_and_icmp_ne_neg2_i32_fail_thm (e : IntW 32) :
  LLVM.and (lshr e (const? 31)) (zext 32 (icmp IntPredicate.ne e (const? (-2)))) ⊑
    zext 32 (LLVM.and (icmp IntPredicate.slt e (const? 0)) (icmp IntPredicate.ne e (const? (-2)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_thm (e e_1 : IntW 32) :
  LLVM.and (lshr e_1 (const? 31)) (zext 32 (icmp IntPredicate.ne e (const? (-2)))) ⊑
    zext 32 (LLVM.and (icmp IntPredicate.slt e_1 (const? 0)) (icmp IntPredicate.ne e (const? (-2)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_thm (e e_1 : IntW 32) :
  LLVM.and (lshr e_1 (const? 31)) (zext 32 (icmp IntPredicate.sgt e (const? (-1)))) ⊑
    zext 32 (LLVM.and (icmp IntPredicate.slt e_1 (const? 0)) (icmp IntPredicate.sgt e (const? (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_xor_icmp_sge_neg2_i32_fail_thm (e : IntW 32) :
  LLVM.xor (lshr e (const? 31)) (zext 32 (icmp IntPredicate.sge e (const? (-2)))) ⊑
    zext 32 (icmp IntPredicate.ult e (const? (-2))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_thm (e : IntW 32) :
  LLVM.or (lshr e (const? 31)) (zext 32 (icmp IntPredicate.sge (add e (const? 1)) (const? 100))) ⊑
    zext 32
      (LLVM.or (icmp IntPredicate.slt e (const? 0)) (icmp IntPredicate.sgt (add e (const? 1)) (const? 99))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_icmps1_thm (e : IntW 32) (e_1 : IntW 1) :
  select (select e_1 (icmp IntPredicate.sgt e (const? (-1))) (const? 0)) (icmp IntPredicate.slt e (const? 10086))
      (const? 0) ⊑
    select e_1 (icmp IntPredicate.ult e (const? 10086)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_icmps2_thm (e : IntW 32) (e_1 : IntW 1) :
  select (select e_1 (icmp IntPredicate.slt e (const? (-1))) (const? 0)) (icmp IntPredicate.eq e (const? 10086))
      (const? 0) ⊑
    const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_or_z_or_pow2orz_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (LLVM.and (sub (const? 0) e) e)) (icmp IntPredicate.eq e_1 (const? 0)) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (LLVM.and e (sub (const? 0) e))) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_or_z_or_pow2orz_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (LLVM.and (sub (const? 0) e) e)) (const? 1) (icmp IntPredicate.eq e_1 (const? 0)) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (LLVM.and e (sub (const? 0) e))) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_or_z_or_pow2orz_fail_logic_or_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 0)) (const? 1) (icmp IntPredicate.eq e_1 (LLVM.and (sub (const? 0) e) e)) ⊑
    select (icmp IntPredicate.eq e_1 (const? 0)) (const? 1)
      (icmp IntPredicate.eq e_1 (LLVM.and e (sub (const? 0) e))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ne_and_z_and_onefail_thm (e : IntW 8) :
  LLVM.and (LLVM.and (icmp IntPredicate.ne e (const? 0)) (icmp IntPredicate.ne e (const? 1)))
      (icmp IntPredicate.ne e (const? 2)) ⊑
    icmp IntPredicate.ugt e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_or_z_or_pow2orz_fail_nonzero_const_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 1)) (icmp IntPredicate.eq e_1 (LLVM.and (sub (const? 0) e) e)) ⊑
    LLVM.or (icmp IntPredicate.eq e_1 (const? 1)) (icmp IntPredicate.eq e_1 (LLVM.and e (sub (const? 0) e))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq_or_z_or_pow2orz_fail_bad_pred2_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sle e_1 (const? 0)) (icmp IntPredicate.sle e_1 (LLVM.and (sub (const? 0) e) e)) ⊑
    LLVM.or (icmp IntPredicate.slt e_1 (const? 1)) (icmp IntPredicate.sle e_1 (LLVM.and e (sub (const? 0) e))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_slt_to_mask_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.slt e (const? (-124))) (icmp IntPredicate.eq (LLVM.and e (const? 2)) (const? 0)) ⊑
    icmp IntPredicate.slt e (const? (-126)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_sgt_to_mask_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.sgt e (const? 123)) (icmp IntPredicate.eq (LLVM.and e (const? 2)) (const? 0)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? (-2))) (const? 124) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_ugt_to_mask_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt e (const? (-5))) (icmp IntPredicate.eq (LLVM.and e (const? 2)) (const? 0)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? (-2))) (const? (-4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


