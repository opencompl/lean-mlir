
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gandhorhicmps_proof
theorem PR1817_1_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.slt e (const? 32 10)) (icmp IntPredicate.ult e (const? 32 10)) ⊑
    icmp IntPredicate.ult e (const? 32 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR1817_1_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 32 10)) (icmp IntPredicate.ult e (const? 32 10)) (const? 1 0) ⊑
    icmp IntPredicate.ult e (const? 32 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR1817_2_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.slt e (const? 32 10)) (icmp IntPredicate.ult e (const? 32 10)) ⊑
    icmp IntPredicate.slt e (const? 32 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR1817_2_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 32 10)) (const? 1 1) (icmp IntPredicate.ult e (const? 32 10)) ⊑
    icmp IntPredicate.slt e (const? 32 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR2330_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e_1 (const? 32 8)) (icmp IntPredicate.ult e (const? 32 8)) ⊑
    icmp IntPredicate.ult (LLVM.or e_1 e) (const? 32 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants1_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.eq e (const? 32 50)) (icmp IntPredicate.eq e (const? 32 51)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 (-2))) (const? 32 50) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants1_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 32 50)) (const? 1 1) (icmp IntPredicate.eq e (const? 32 51)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 (-2))) (const? 32 50) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants1_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne e (const? 32 51)) (icmp IntPredicate.ne e (const? 32 50)) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-52))) (const? 32 (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants1_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ne e (const? 32 51)) (icmp IntPredicate.ne e (const? 32 50)) (const? 1 0) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-52))) (const? 32 (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants2_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.eq e (const? 32 97)) (icmp IntPredicate.eq e (const? 32 65)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 (-33))) (const? 32 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants2_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 32 97)) (const? 1 1) (icmp IntPredicate.eq e (const? 32 65)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 (-33))) (const? 32 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants2_thm (e : IntW 19) :
  LLVM.and (icmp IntPredicate.ne e (const? 19 65)) (icmp IntPredicate.ne e (const? 19 193)) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 19 (-129))) (const? 19 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants2_logical_thm (e : IntW 19) :
  select (icmp IntPredicate.ne e (const? 19 65)) (icmp IntPredicate.ne e (const? 19 193)) (const? 1 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 19 (-129))) (const? 19 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants3_thm (e : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e (const? 8 (-2))) (icmp IntPredicate.eq e (const? 8 126)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 127)) (const? 8 126) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_eq_with_one_bit_diff_constants3_logical_thm (e : IntW 8) :
  select (icmp IntPredicate.eq e (const? 8 (-2))) (const? 1 1) (icmp IntPredicate.eq e (const? 8 126)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 127)) (const? 8 126) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants3_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.ne e (const? 8 65)) (icmp IntPredicate.ne e (const? 8 (-63))) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 127)) (const? 8 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ne_with_one_bit_diff_constants3_logical_thm (e : IntW 8) :
  select (icmp IntPredicate.ne e (const? 8 65)) (icmp IntPredicate.ne e (const? 8 (-63))) (const? 1 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 127)) (const? 8 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_eq_with_diff_one_thm (e : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e (const? 8 13)) (icmp IntPredicate.eq e (const? 8 14)) ⊑
    icmp IntPredicate.ult (add e (const? 8 (-13))) (const? 8 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_eq_with_diff_one_logical_thm (e : IntW 8) :
  select (icmp IntPredicate.eq e (const? 8 13)) (const? 1 1) (icmp IntPredicate.eq e (const? 8 14)) ⊑
    icmp IntPredicate.ult (add e (const? 8 (-13))) (const? 8 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ne_with_diff_one_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne e (const? 32 40)) (icmp IntPredicate.ne e (const? 32 39)) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-41))) (const? 32 (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ne_with_diff_one_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ne e (const? 32 40)) (icmp IntPredicate.ne e (const? 32 39)) (const? 1 0) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-41))) (const? 32 (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_eq_with_diff_one_signed_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.eq e (const? 32 0)) (icmp IntPredicate.eq e (const? 32 (-1))) ⊑
    icmp IntPredicate.ult (add e (const? 32 1)) (const? 32 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_eq_with_diff_one_signed_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 32 0)) (const? 1 1) (icmp IntPredicate.eq e (const? 32 (-1))) ⊑
    icmp IntPredicate.ult (add e (const? 32 1)) (const? 32 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ne_with_diff_one_signed_thm (e : IntW 64) :
  LLVM.and (icmp IntPredicate.ne e (const? 64 (-1))) (icmp IntPredicate.ne e (const? 64 0)) ⊑
    icmp IntPredicate.ult (add e (const? 64 (-1))) (const? 64 (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ne_with_diff_one_signed_logical_thm (e : IntW 64) :
  select (icmp IntPredicate.ne e (const? 64 (-1))) (icmp IntPredicate.ne e (const? 64 0)) (const? 1 0) ⊑
    icmp IntPredicate.ult (add e (const? 64 (-1))) (const? 64 (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_1_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.slt e (const? 32 0)) (icmp IntPredicate.eq e (const? 32 2147483647)) ⊑
    icmp IntPredicate.ugt e (const? 32 2147483646) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_1_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 32 0)) (const? 1 1) (icmp IntPredicate.eq e (const? 32 2147483647)) ⊑
    icmp IntPredicate.ugt e (const? 32 2147483646) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_2_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.ult e (const? 32 (-2147483648))) (icmp IntPredicate.eq e (const? 32 (-1))) ⊑
    icmp IntPredicate.sgt e (const? 32 (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_2_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 32 (-2147483648))) (const? 1 1) (icmp IntPredicate.eq e (const? 32 (-1))) ⊑
    icmp IntPredicate.sgt e (const? 32 (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_3_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.sge e (const? 32 0)) (icmp IntPredicate.eq e (const? 32 (-2147483648))) ⊑
    icmp IntPredicate.ult e (const? 32 (-2147483647)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_3_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sge e (const? 32 0)) (const? 1 1) (icmp IntPredicate.eq e (const? 32 (-2147483648))) ⊑
    icmp IntPredicate.ult e (const? 32 (-2147483647)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_4_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.uge e (const? 32 (-2147483648))) (icmp IntPredicate.eq e (const? 32 0)) ⊑
    icmp IntPredicate.slt e (const? 32 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_4_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.uge e (const? 32 (-2147483648))) (const? 1 1) (icmp IntPredicate.eq e (const? 32 0)) ⊑
    icmp IntPredicate.slt e (const? 32 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_5_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.slt e (const? 32 1)) (icmp IntPredicate.eq e (const? 32 2147483647)) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-2147483647))) (const? 32 (-2147483646)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_5_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 32 1)) (const? 1 1) (icmp IntPredicate.eq e (const? 32 2147483647)) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-2147483647))) (const? 32 (-2147483646)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_6_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.ult e (const? 32 (-2147483647))) (icmp IntPredicate.eq e (const? 32 (-1))) ⊑
    icmp IntPredicate.ult (add e (const? 32 1)) (const? 32 (-2147483646)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_6_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 32 (-2147483647))) (const? 1 1) (icmp IntPredicate.eq e (const? 32 (-1))) ⊑
    icmp IntPredicate.ult (add e (const? 32 1)) (const? 32 (-2147483646)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_7_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.uge e (const? 32 (-2147483647))) (icmp IntPredicate.eq e (const? 32 0)) ⊑
    icmp IntPredicate.slt (add e (const? 32 (-1))) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_7_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.uge e (const? 32 (-2147483647))) (const? 1 1) (icmp IntPredicate.eq e (const? 32 0)) ⊑
    icmp IntPredicate.slt (add e (const? 32 (-1))) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_8_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.slt e (const? 32 14)) (icmp IntPredicate.ne e (const? 32 (-2147483648))) ⊑
    icmp IntPredicate.ult (add e (const? 32 2147483647)) (const? 32 (-2147483635)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_8_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.slt e (const? 32 14)) (icmp IntPredicate.ne e (const? 32 (-2147483648))) (const? 1 0) ⊑
    icmp IntPredicate.ult (add e (const? 32 2147483647)) (const? 32 (-2147483635)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_9_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt e (const? 32 13)) (icmp IntPredicate.ne e (const? 32 2147483647)) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-14))) (const? 32 2147483633) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_9_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt e (const? 32 13)) (icmp IntPredicate.ne e (const? 32 2147483647)) (const? 1 0) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-14))) (const? 32 2147483633) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_10_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ugt e (const? 32 13)) (icmp IntPredicate.ne e (const? 32 (-1))) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-14))) (const? 32 (-15)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR42691_10_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ugt e (const? 32 13)) (icmp IntPredicate.ne e (const? 32 (-1))) (const? 1 0) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-14))) (const? 32 (-15)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem substitute_constant_and_eq_eq_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 (const? 8 42)) (icmp IntPredicate.eq e_1 e) ⊑
    LLVM.and (icmp IntPredicate.eq e_1 (const? 8 42)) (icmp IntPredicate.eq e (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem substitute_constant_and_eq_eq_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 42)) (icmp IntPredicate.eq e_1 e) (const? 1 0) ⊑
    select (icmp IntPredicate.eq e_1 (const? 8 42)) (icmp IntPredicate.eq e (const? 8 42)) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem substitute_constant_and_eq_eq_commute_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.eq e_1 e) (icmp IntPredicate.eq e_1 (const? 8 42)) ⊑
    LLVM.and (icmp IntPredicate.eq e_1 (const? 8 42)) (icmp IntPredicate.eq e (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem substitute_constant_and_eq_eq_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 e) (icmp IntPredicate.eq e_1 (const? 8 42)) (const? 1 0) ⊑
    LLVM.and (icmp IntPredicate.eq e_1 (const? 8 42)) (icmp IntPredicate.eq e (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem substitute_constant_and_eq_ugt_swap_thm (e e_1 : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.eq e (const? 8 42)) ⊑
    LLVM.and (icmp IntPredicate.eq e (const? 8 42)) (icmp IntPredicate.ugt e_1 (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem substitute_constant_and_eq_ugt_swap_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.eq e (const? 8 42)) (const? 1 0) ⊑
    LLVM.and (icmp IntPredicate.eq e (const? 8 42)) (icmp IntPredicate.ugt e_1 (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem substitute_constant_and_ne_ugt_swap_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.ne e (const? 8 42)) (const? 1 0) ⊑
    LLVM.and (icmp IntPredicate.ugt e_1 e) (icmp IntPredicate.ne e (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem substitute_constant_or_ne_swap_sle_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.ne e_1 (const? 8 42)) (icmp IntPredicate.sle e e_1) ⊑
    LLVM.or (icmp IntPredicate.ne e_1 (const? 8 42)) (icmp IntPredicate.slt e (const? 8 43)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem substitute_constant_or_ne_swap_sle_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne e_1 (const? 8 42)) (const? 1 1) (icmp IntPredicate.sle e e_1) ⊑
    select (icmp IntPredicate.ne e_1 (const? 8 42)) (const? 1 1) (icmp IntPredicate.slt e (const? 8 43)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem substitute_constant_or_ne_uge_commute_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.uge e_1 e) (icmp IntPredicate.ne e_1 (const? 8 42)) ⊑
    LLVM.or (icmp IntPredicate.ne e_1 (const? 8 42)) (icmp IntPredicate.ult e (const? 8 43)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem substitute_constant_or_ne_uge_commute_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.uge e_1 e) (const? 1 1) (icmp IntPredicate.ne e_1 (const? 8 42)) ⊑
    LLVM.or (icmp IntPredicate.ne e_1 (const? 8 42)) (icmp IntPredicate.ult e (const? 8 43)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_ranges_overlap_thm (e : IntW 8) :
  LLVM.or (LLVM.and (icmp IntPredicate.uge e (const? 8 5)) (icmp IntPredicate.ule e (const? 8 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 8 10)) (icmp IntPredicate.ule e (const? 8 20))) ⊑
    icmp IntPredicate.ult (add e (const? 8 (-5))) (const? 8 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_ranges_adjacent_thm (e : IntW 8) :
  LLVM.or (LLVM.and (icmp IntPredicate.uge e (const? 8 5)) (icmp IntPredicate.ule e (const? 8 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 8 11)) (icmp IntPredicate.ule e (const? 8 20))) ⊑
    icmp IntPredicate.ult (add e (const? 8 (-5))) (const? 8 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_ranges_separated_thm (e : IntW 8) :
  LLVM.or (LLVM.and (icmp IntPredicate.uge e (const? 8 5)) (icmp IntPredicate.ule e (const? 8 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 8 12)) (icmp IntPredicate.ule e (const? 8 20))) ⊑
    LLVM.or (icmp IntPredicate.ult (add e (const? 8 (-5))) (const? 8 6))
      (icmp IntPredicate.ult (add e (const? 8 (-12))) (const? 8 9)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_ranges_single_elem_right_thm (e : IntW 8) :
  LLVM.or (LLVM.and (icmp IntPredicate.uge e (const? 8 5)) (icmp IntPredicate.ule e (const? 8 10)))
      (icmp IntPredicate.eq e (const? 8 11)) ⊑
    icmp IntPredicate.ult (add e (const? 8 (-5))) (const? 8 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_ranges_single_elem_left_thm (e : IntW 8) :
  LLVM.or (LLVM.and (icmp IntPredicate.uge e (const? 8 5)) (icmp IntPredicate.ule e (const? 8 10)))
      (icmp IntPredicate.eq e (const? 8 4)) ⊑
    icmp IntPredicate.ult (add e (const? 8 (-4))) (const? 8 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ranges_overlap_thm (e : IntW 8) :
  LLVM.and (LLVM.and (icmp IntPredicate.uge e (const? 8 5)) (icmp IntPredicate.ule e (const? 8 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 8 7)) (icmp IntPredicate.ule e (const? 8 20))) ⊑
    icmp IntPredicate.ult (add e (const? 8 (-7))) (const? 8 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ranges_overlap_single_thm (e : IntW 8) :
  LLVM.and (LLVM.and (icmp IntPredicate.uge e (const? 8 5)) (icmp IntPredicate.ule e (const? 8 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 8 10)) (icmp IntPredicate.ule e (const? 8 20))) ⊑
    icmp IntPredicate.eq e (const? 8 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ranges_no_overlap_thm (e : IntW 8) :
  LLVM.and (LLVM.and (icmp IntPredicate.uge e (const? 8 5)) (icmp IntPredicate.ule e (const? 8 10)))
      (LLVM.and (icmp IntPredicate.uge e (const? 8 11)) (icmp IntPredicate.ule e (const? 8 20))) ⊑
    const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ranges_signed_pred_thm (e : IntW 64) :
  LLVM.and (icmp IntPredicate.slt (add e (const? 64 127)) (const? 64 1024))
      (icmp IntPredicate.slt (add e (const? 64 128)) (const? 64 256)) ⊑
    icmp IntPredicate.ult (add e (const? 64 (-9223372036854775681))) (const? 64 (-9223372036854775553)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_two_ranges_to_mask_and_range_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt (add e (const? 8 (-97))) (const? 8 25))
      (icmp IntPredicate.ugt (add e (const? 8 (-65))) (const? 8 25)) ⊑
    icmp IntPredicate.ult (add (LLVM.and e (const? 8 (-33))) (const? 8 (-91))) (const? 8 (-26)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_two_ranges_to_mask_and_range_not_pow2_diff_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt (add e (const? 8 (-97))) (const? 8 25))
      (icmp IntPredicate.ugt (add e (const? 8 (-64))) (const? 8 25)) ⊑
    LLVM.and (icmp IntPredicate.ult (add e (const? 8 (-123))) (const? 8 (-26)))
      (icmp IntPredicate.ult (add e (const? 8 (-90))) (const? 8 (-26))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_two_ranges_to_mask_and_range_different_sizes_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt (add e (const? 8 (-97))) (const? 8 25))
      (icmp IntPredicate.ugt (add e (const? 8 (-65))) (const? 8 24)) ⊑
    LLVM.and (icmp IntPredicate.ult (add e (const? 8 (-123))) (const? 8 (-26)))
      (icmp IntPredicate.ult (add e (const? 8 (-90))) (const? 8 (-25))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_two_ranges_to_mask_and_range_no_add_on_one_range_thm (e : IntW 16) :
  LLVM.and (icmp IntPredicate.uge e (const? 16 12))
      (LLVM.or (icmp IntPredicate.ult e (const? 16 16)) (icmp IntPredicate.uge e (const? 16 28))) ⊑
    icmp IntPredicate.ugt (LLVM.and e (const? 16 (-20))) (const? 16 11) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem is_ascii_alphabetic_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? 32 (-65)) { «nsw» := true, «nuw» := false }) (const? 32 26)) (const? 1 1)
      (icmp IntPredicate.ult (add e (const? 32 (-97)) { «nsw» := true, «nuw» := false }) (const? 32 26)) ⊑
    icmp IntPredicate.ult (add (LLVM.and e (const? 32 (-33))) (const? 32 (-65))) (const? 32 26) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem is_ascii_alphabetic_inverted_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? 32 (-91)) { «nsw» := true, «nuw» := false }) (const? 32 (-26)))
      (icmp IntPredicate.ult (add e (const? 32 (-123)) { «nsw» := true, «nuw» := false }) (const? 32 (-26)))
      (const? 1 0) ⊑
    icmp IntPredicate.ult (add (LLVM.and e (const? 32 (-33))) (const? 32 (-91))) (const? 32 (-26)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_bitwise_and_icmps_thm (e e_1 e_2 : IntW 8) :
  LLVM.and
      (LLVM.and (icmp IntPredicate.eq e_2 (const? 8 42))
        (icmp IntPredicate.ne (LLVM.and e_1 (const? 8 1)) (const? 8 0)))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 8 1) e)) (const? 8 0)) ⊑
    LLVM.and (icmp IntPredicate.eq e_2 (const? 8 42))
      (icmp IntPredicate.eq (LLVM.and e_1 (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_bitwise_and_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (LLVM.and (icmp IntPredicate.eq e (const? 8 42))
        (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0))) ⊑
    LLVM.and (icmp IntPredicate.eq e (const? 8 42))
      (icmp IntPredicate.eq
        (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_bitwise_and_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  LLVM.and
      (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0))
        (icmp IntPredicate.eq e_1 (const? 8 42)))
      (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e)) (const? 8 0)) ⊑
    LLVM.and
      (icmp IntPredicate.eq (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1)))
      (icmp IntPredicate.eq e_1 (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_bitwise_and_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0))
        (icmp IntPredicate.eq e (const? 8 42))) ⊑
    LLVM.and
      (icmp IntPredicate.eq
        (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
      (icmp IntPredicate.eq e (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_logical_and_icmps_thm (e e_1 e_2 : IntW 8) :
  LLVM.and
      (select (icmp IntPredicate.eq e_2 (const? 8 42)) (icmp IntPredicate.ne (LLVM.and e_1 (const? 8 1)) (const? 8 0))
        (const? 1 0))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 8 1) e)) (const? 8 0)) ⊑
    select (icmp IntPredicate.eq e_2 (const? 8 42))
      (icmp IntPredicate.eq (LLVM.and e_1 (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1)))
      (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_logical_and_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (select (icmp IntPredicate.eq e (const? 8 42)) (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0))
        (const? 1 0)) ⊑
    select (icmp IntPredicate.eq e (const? 8 42))
      (icmp IntPredicate.eq
        (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
      (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_logical_and_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (select (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (icmp IntPredicate.eq e (const? 8 42))
        (const? 1 0)) ⊑
    select
      (icmp IntPredicate.eq
        (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
      (icmp IntPredicate.eq e (const? 8 42)) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_bitwise_and_icmps_thm (e e_1 e_2 : IntW 8) :
  select
      (LLVM.and (icmp IntPredicate.eq e_2 (const? 8 42))
        (icmp IntPredicate.ne (LLVM.and e_1 (const? 8 1)) (const? 8 0)))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 8 1) e)) (const? 8 0)) (const? 1 0) ⊑
    select
      (LLVM.and (icmp IntPredicate.eq e_2 (const? 8 42))
        (icmp IntPredicate.ne (LLVM.and e_1 (const? 8 1)) (const? 8 0)))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 8 1) e { «nsw» := false, «nuw» := true })) (const? 8 0))
      (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_bitwise_and_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (LLVM.and (icmp IntPredicate.eq e (const? 8 42)) (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0)))
      (const? 1 0) ⊑
    select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true })) (const? 8 0))
      (LLVM.and (icmp IntPredicate.eq e (const? 8 42)) (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0)))
      (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_bitwise_and_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  select
      (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0))
        (icmp IntPredicate.eq e_1 (const? 8 42)))
      (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e)) (const? 8 0)) (const? 1 0) ⊑
    select
      (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0))
        (icmp IntPredicate.eq e_1 (const? 8 42)))
      (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e { «nsw» := false, «nuw» := true })) (const? 8 0))
      (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_bitwise_and_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (icmp IntPredicate.eq e (const? 8 42)))
      (const? 1 0) ⊑
    select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true })) (const? 8 0))
      (LLVM.and (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (icmp IntPredicate.eq e (const? 8 42)))
      (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_logical_and_icmps_thm (e e_1 e_2 : IntW 8) :
  select
      (select (icmp IntPredicate.eq e_2 (const? 8 42)) (icmp IntPredicate.ne (LLVM.and e_1 (const? 8 1)) (const? 8 0))
        (const? 1 0))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 8 1) e)) (const? 8 0)) (const? 1 0) ⊑
    select
      (select (icmp IntPredicate.eq e_2 (const? 8 42)) (icmp IntPredicate.ne (LLVM.and e_1 (const? 8 1)) (const? 8 0))
        (const? 1 0))
      (icmp IntPredicate.ne (LLVM.and e_1 (shl (const? 8 1) e { «nsw» := false, «nuw» := true })) (const? 8 0))
      (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_logical_and_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (select (icmp IntPredicate.eq e (const? 8 42)) (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0))
        (const? 1 0))
      (const? 1 0) ⊑
    select
      (select
        (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true })) (const? 8 0))
        (icmp IntPredicate.eq e (const? 8 42)) (const? 1 0))
      (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_logical_and_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  select
      (select (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (icmp IntPredicate.eq e_1 (const? 8 42))
        (const? 1 0))
      (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e)) (const? 8 0)) (const? 1 0) ⊑
    select
      (select (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (icmp IntPredicate.eq e_1 (const? 8 42))
        (const? 1 0))
      (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e { «nsw» := false, «nuw» := true })) (const? 8 0))
      (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_logical_and_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (select (icmp IntPredicate.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (icmp IntPredicate.eq e (const? 8 42))
        (const? 1 0))
      (const? 1 0) ⊑
    select
      (icmp IntPredicate.eq
        (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
      (icmp IntPredicate.eq e (const? 8 42)) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_or_bitwise_or_icmps_thm (e e_1 e_2 : IntW 8) :
  LLVM.or
      (LLVM.or (icmp IntPredicate.eq e_2 (const? 8 42)) (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 1)) (const? 8 0)))
      (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 8 1) e)) (const? 8 0)) ⊑
    LLVM.or (icmp IntPredicate.eq e_2 (const? 8 42))
      (icmp IntPredicate.ne (LLVM.and e_1 (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_or_bitwise_or_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (LLVM.or (icmp IntPredicate.eq e (const? 8 42)) (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0))) ⊑
    LLVM.or (icmp IntPredicate.eq e (const? 8 42))
      (icmp IntPredicate.ne
        (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_or_bitwise_or_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  LLVM.or
      (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (icmp IntPredicate.eq e_1 (const? 8 42)))
      (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e)) (const? 8 0)) ⊑
    LLVM.or
      (icmp IntPredicate.ne (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1)))
      (icmp IntPredicate.eq e_1 (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_or_bitwise_or_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (icmp IntPredicate.eq e (const? 8 42))) ⊑
    LLVM.or
      (icmp IntPredicate.ne
        (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
      (icmp IntPredicate.eq e (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_or_logical_or_icmps_thm (e e_1 e_2 : IntW 8) :
  LLVM.or
      (select (icmp IntPredicate.eq e_2 (const? 8 42)) (const? 1 1)
        (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 1)) (const? 8 0)))
      (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 8 1) e)) (const? 8 0)) ⊑
    select (icmp IntPredicate.eq e_2 (const? 8 42)) (const? 1 1)
      (icmp IntPredicate.ne (LLVM.and e_1 (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_or_logical_or_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (select (icmp IntPredicate.eq e (const? 8 42)) (const? 1 1)
        (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0))) ⊑
    select (icmp IntPredicate.eq e (const? 8 42)) (const? 1 1)
      (icmp IntPredicate.ne
        (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_or_logical_or_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0))
      (select (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (const? 1 1)
        (icmp IntPredicate.eq e (const? 8 42))) ⊑
    select
      (icmp IntPredicate.ne
        (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
      (const? 1 1) (icmp IntPredicate.eq e (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_bitwise_or_icmps_thm (e e_1 e_2 : IntW 8) :
  select
      (LLVM.or (icmp IntPredicate.eq e_2 (const? 8 42)) (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 1)) (const? 8 0)))
      (const? 1 1) (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 8 1) e)) (const? 8 0)) ⊑
    select
      (LLVM.or (icmp IntPredicate.eq e_2 (const? 8 42)) (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 1)) (const? 8 0)))
      (const? 1 1)
      (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 8 1) e { «nsw» := false, «nuw» := true })) (const? 8 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_bitwise_or_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0)) (const? 1 1)
      (LLVM.or (icmp IntPredicate.eq e (const? 8 42)) (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true })) (const? 8 0))
      (const? 1 1)
      (LLVM.or (icmp IntPredicate.eq e (const? 8 42))
        (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_bitwise_or_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  select
      (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (icmp IntPredicate.eq e_1 (const? 8 42)))
      (const? 1 1) (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e)) (const? 8 0)) ⊑
    select
      (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (icmp IntPredicate.eq e_1 (const? 8 42)))
      (const? 1 1)
      (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e { «nsw» := false, «nuw» := true })) (const? 8 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_bitwise_or_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0)) (const? 1 1)
      (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (icmp IntPredicate.eq e (const? 8 42))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true })) (const? 8 0))
      (const? 1 1)
      (LLVM.or (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0))
        (icmp IntPredicate.eq e (const? 8 42))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_logical_or_icmps_thm (e e_1 e_2 : IntW 8) :
  select
      (select (icmp IntPredicate.eq e_2 (const? 8 42)) (const? 1 1)
        (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 1)) (const? 8 0)))
      (const? 1 1) (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 8 1) e)) (const? 8 0)) ⊑
    select
      (select (icmp IntPredicate.eq e_2 (const? 8 42)) (const? 1 1)
        (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 1)) (const? 8 0)))
      (const? 1 1)
      (icmp IntPredicate.eq (LLVM.and e_1 (shl (const? 8 1) e { «nsw» := false, «nuw» := true })) (const? 8 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_logical_or_icmps_comm1_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0)) (const? 1 1)
      (select (icmp IntPredicate.eq e (const? 8 42)) (const? 1 1)
        (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0))) ⊑
    select
      (select
        (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true })) (const? 8 0))
        (const? 1 1) (icmp IntPredicate.eq e (const? 8 42)))
      (const? 1 1) (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_logical_or_icmps_comm2_thm (e e_1 e_2 : IntW 8) :
  select
      (select (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (const? 1 1)
        (icmp IntPredicate.eq e_1 (const? 8 42)))
      (const? 1 1) (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e)) (const? 8 0)) ⊑
    select
      (select (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (const? 1 1)
        (icmp IntPredicate.eq e_1 (const? 8 42)))
      (const? 1 1)
      (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e { «nsw» := false, «nuw» := true })) (const? 8 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_or_logical_or_icmps_comm3_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_2 (shl (const? 8 1) e_1)) (const? 8 0)) (const? 1 1)
      (select (icmp IntPredicate.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) (const? 1 1)
        (icmp IntPredicate.eq e (const? 8 42))) ⊑
    select
      (icmp IntPredicate.ne
        (LLVM.and e_2 (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
        (LLVM.or (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) (const? 8 1)))
      (const? 1 1) (icmp IntPredicate.eq e (const? 8 42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_asymmetric_thm (e : IntW 1) (e_1 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.ne (LLVM.and e_1 (const? 32 255)) (const? 32 0)) e (const? 1 0))
      (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 11)) (const? 32 11)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 11)) (const? 32 11)) e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_allzeros_thm (e : IntW 1) (e_1 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 8)) (const? 32 0)) e (const? 1 0))
      (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 7)) (const? 32 0)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 15)) (const? 32 0)) e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_allzeros_poison1_thm (e : IntW 1) (e_1 e_2 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.eq (LLVM.and e_2 e_1) (const? 32 0)) e (const? 1 0))
      (icmp IntPredicate.eq (LLVM.and e_2 (const? 32 7)) (const? 32 0)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_2 (LLVM.or e_1 (const? 32 7))) (const? 32 0)) e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_allones_thm (e : IntW 1) (e_1 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 8)) (const? 32 8)) e (const? 1 0))
      (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 7)) (const? 32 7)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 15)) (const? 32 15)) e (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_allones_poison1_thm (e : IntW 1) (e_1 e_2 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.eq (LLVM.and e_2 e_1) e_1) e (const? 1 0))
      (icmp IntPredicate.eq (LLVM.and e_2 (const? 32 7)) (const? 32 7)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_2 (LLVM.or e_1 (const? 32 7))) (LLVM.or e_1 (const? 32 7))) e
      (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bitwise_and_logical_and_masked_icmp_allones_poison2_thm (e : IntW 32) (e_1 : IntW 1) (e_2 : IntW 32) :
  LLVM.and (select (icmp IntPredicate.eq (LLVM.and e_2 (const? 32 8)) (const? 32 8)) e_1 (const? 1 0))
      (icmp IntPredicate.eq (LLVM.and e_2 e) e) ⊑
    LLVM.and (select (icmp IntPredicate.ne (LLVM.and e_2 (const? 32 8)) (const? 32 0)) e_1 (const? 1 0))
      (icmp IntPredicate.eq (LLVM.and e_2 e) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem samesign_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.slt (LLVM.and e_1 e) (const? 32 0))
      (icmp IntPredicate.sgt (LLVM.or e_1 e) (const? 32 (-1))) ⊑
    icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? 32 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem samesign_different_sign_bittest2_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.slt (LLVM.and e_1 e) (const? 32 0)) (icmp IntPredicate.sge (LLVM.or e_1 e) (const? 32 0)) ⊑
    icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? 32 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem samesign_commute1_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.sgt (LLVM.or e_1 e) (const? 32 (-1)))
      (icmp IntPredicate.slt (LLVM.and e_1 e) (const? 32 0)) ⊑
    icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? 32 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem samesign_commute2_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.slt (LLVM.and e_1 e) (const? 32 0))
      (icmp IntPredicate.sgt (LLVM.or e e_1) (const? 32 (-1))) ⊑
    icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? 32 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem samesign_commute3_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.sgt (LLVM.or e_1 e) (const? 32 (-1)))
      (icmp IntPredicate.slt (LLVM.and e e_1) (const? 32 0)) ⊑
    icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? 32 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem samesign_inverted_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt (LLVM.and e_1 e) (const? 32 (-1)))
      (icmp IntPredicate.slt (LLVM.or e_1 e) (const? 32 0)) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem samesign_inverted_different_sign_bittest1_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.sge (LLVM.and e_1 e) (const? 32 0))
      (icmp IntPredicate.slt (LLVM.or e_1 e) (const? 32 0)) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem samesign_inverted_different_sign_bittest2_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt (LLVM.and e_1 e) (const? 32 (-1)))
      (icmp IntPredicate.sle (LLVM.or e_1 e) (const? 32 (-1))) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem samesign_inverted_commute1_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.slt (LLVM.or e_1 e) (const? 32 0))
      (icmp IntPredicate.sgt (LLVM.and e_1 e) (const? 32 (-1))) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem samesign_inverted_commute2_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt (LLVM.and e_1 e) (const? 32 (-1)))
      (icmp IntPredicate.slt (LLVM.or e e_1) (const? 32 0)) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem samesign_inverted_commute3_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.slt (LLVM.or e_1 e) (const? 32 0))
      (icmp IntPredicate.sgt (LLVM.and e e_1) (const? 32 (-1))) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_or_icmp_sgt_0_i32_thm (e : IntW 32) :
  LLVM.or (zext 32 (icmp IntPredicate.slt e (const? 32 0))) (zext 32 (icmp IntPredicate.sgt e (const? 32 0))) ⊑
    zext 32 (icmp IntPredicate.ne e (const? 32 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_or_icmp_sgt_0_i64_thm (e : IntW 64) :
  LLVM.or (zext 64 (icmp IntPredicate.slt e (const? 64 0))) (zext 64 (icmp IntPredicate.sgt e (const? 64 0))) ⊑
    zext 64 (icmp IntPredicate.ne e (const? 64 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_or_icmp_sgt_0_i64_fail0_thm (e : IntW 64) :
  LLVM.or (lshr e (const? 64 63)) (zext 64 (icmp IntPredicate.slt e (const? 64 0))) ⊑ lshr e (const? 64 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_or_icmp_sgt_0_i64_fail3_thm (e : IntW 64) :
  LLVM.or (ashr e (const? 64 62)) (zext 64 (icmp IntPredicate.slt e (const? 64 0))) ⊑
    LLVM.or (ashr e (const? 64 62)) (lshr e (const? 64 63)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_and_icmp_sge_neg1_i32_thm (e : IntW 32) :
  LLVM.and (lshr e (const? 32 31)) (zext 32 (icmp IntPredicate.sgt e (const? 32 (-1)))) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_or_icmp_sge_neg1_i32_thm (e : IntW 32) :
  LLVM.or (lshr e (const? 32 31)) (zext 32 (icmp IntPredicate.sge e (const? 32 (-1)))) ⊑ const? 32 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_or_icmp_sge_100_i32_thm (e : IntW 32) :
  LLVM.or (lshr e (const? 32 31)) (zext 32 (icmp IntPredicate.sge e (const? 32 100))) ⊑
    zext 32 (icmp IntPredicate.ugt e (const? 32 99)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_and_icmp_sge_neg1_i64_thm (e : IntW 64) :
  LLVM.and (lshr e (const? 64 63)) (zext 64 (icmp IntPredicate.sge e (const? 64 (-1)))) ⊑
    zext 64 (icmp IntPredicate.eq e (const? 64 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_and_icmp_sge_neg2_i64_thm (e : IntW 64) :
  LLVM.and (lshr e (const? 64 63)) (zext 64 (icmp IntPredicate.sge e (const? 64 (-2)))) ⊑
    zext 64 (icmp IntPredicate.ugt e (const? 64 (-3))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_and_icmp_sge_neg1_i64_thm (e : IntW 64) :
  LLVM.and (ashr e (const? 64 63)) (zext 64 (icmp IntPredicate.sge e (const? 64 (-1)))) ⊑
    zext 64 (icmp IntPredicate.eq e (const? 64 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_and_icmp_sgt_neg1_i64_thm (e : IntW 64) :
  LLVM.and (lshr e (const? 64 63)) (zext 64 (icmp IntPredicate.sgt e (const? 64 (-1)))) ⊑ const? 64 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_and_icmp_sge_neg1_i64_fail_thm (e : IntW 64) :
  LLVM.and (lshr e (const? 64 62)) (zext 64 (icmp IntPredicate.sge e (const? 64 (-1)))) ⊑
    select (icmp IntPredicate.sgt e (const? 64 (-2))) (LLVM.and (lshr e (const? 64 62)) (const? 64 1))
      (const? 64 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_thm (e e_1 : IntW 32) :
  LLVM.xor (lshr e_1 (const? 32 31)) (zext 32 (icmp IntPredicate.sgt e (const? 32 (-1)))) ⊑
    zext 32 (icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? 32 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_xor_icmp_sgt_neg2_i32_thm (e : IntW 32) :
  LLVM.xor (lshr e (const? 32 31)) (zext 32 (icmp IntPredicate.sgt e (const? 32 (-2)))) ⊑
    zext 32 (icmp IntPredicate.ne e (const? 32 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_or_icmp_eq_100_i32_fail_thm (e : IntW 32) :
  LLVM.or (lshr e (const? 32 31)) (zext 32 (icmp IntPredicate.eq e (const? 32 100))) ⊑
    zext 32 (LLVM.or (icmp IntPredicate.slt e (const? 32 0)) (icmp IntPredicate.eq e (const? 32 100))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_and_icmp_ne_neg2_i32_fail_thm (e : IntW 32) :
  LLVM.and (lshr e (const? 32 31)) (zext 32 (icmp IntPredicate.ne e (const? 32 (-2)))) ⊑
    zext 32 (LLVM.and (icmp IntPredicate.slt e (const? 32 0)) (icmp IntPredicate.ne e (const? 32 (-2)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_thm (e e_1 : IntW 32) :
  LLVM.and (lshr e_1 (const? 32 31)) (zext 32 (icmp IntPredicate.ne e (const? 32 (-2)))) ⊑
    zext 32 (LLVM.and (icmp IntPredicate.slt e_1 (const? 32 0)) (icmp IntPredicate.ne e (const? 32 (-2)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_thm (e e_1 : IntW 32) :
  LLVM.and (lshr e_1 (const? 32 31)) (zext 32 (icmp IntPredicate.sgt e (const? 32 (-1)))) ⊑
    zext 32 (LLVM.and (icmp IntPredicate.slt e_1 (const? 32 0)) (icmp IntPredicate.sgt e (const? 32 (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_xor_icmp_sge_neg2_i32_fail_thm (e : IntW 32) :
  LLVM.xor (lshr e (const? 32 31)) (zext 32 (icmp IntPredicate.sge e (const? 32 (-2)))) ⊑
    zext 32 (icmp IntPredicate.ult e (const? 32 (-2))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_thm (e : IntW 32) :
  LLVM.or (lshr e (const? 32 31)) (zext 32 (icmp IntPredicate.sge (add e (const? 32 1)) (const? 32 100))) ⊑
    zext 32
      (LLVM.or (icmp IntPredicate.slt e (const? 32 0))
        (icmp IntPredicate.sgt (add e (const? 32 1)) (const? 32 99))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_icmps1_thm (e : IntW 32) (e_1 : IntW 1) :
  select (select e_1 (icmp IntPredicate.sgt e (const? 32 (-1))) (const? 1 0))
      (icmp IntPredicate.slt e (const? 32 10086)) (const? 1 0) ⊑
    select e_1 (icmp IntPredicate.ult e (const? 32 10086)) (const? 1 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem logical_and_icmps2_thm (e : IntW 32) (e_1 : IntW 1) :
  select (select e_1 (icmp IntPredicate.slt e (const? 32 (-1))) (const? 1 0)) (icmp IntPredicate.eq e (const? 32 10086))
      (const? 1 0) ⊑
    const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_or_z_or_pow2orz_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (LLVM.and (sub (const? 8 0) e) e)) (icmp IntPredicate.eq e_1 (const? 8 0)) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (LLVM.and e (sub (const? 8 0) e))) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_or_z_or_pow2orz_logical_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (LLVM.and (sub (const? 8 0) e) e)) (const? 1 1)
      (icmp IntPredicate.eq e_1 (const? 8 0)) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (LLVM.and e (sub (const? 8 0) e))) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_or_z_or_pow2orz_fail_logic_or_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq e_1 (const? 8 0)) (const? 1 1)
      (icmp IntPredicate.eq e_1 (LLVM.and (sub (const? 8 0) e) e)) ⊑
    select (icmp IntPredicate.eq e_1 (const? 8 0)) (const? 1 1)
      (icmp IntPredicate.eq e_1 (LLVM.and e (sub (const? 8 0) e))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_and_z_and_onefail_thm (e : IntW 8) :
  LLVM.and (LLVM.and (icmp IntPredicate.ne e (const? 8 0)) (icmp IntPredicate.ne e (const? 8 1)))
      (icmp IntPredicate.ne e (const? 8 2)) ⊑
    icmp IntPredicate.ugt e (const? 8 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_or_z_or_pow2orz_fail_nonzero_const_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.eq e_1 (const? 8 1)) (icmp IntPredicate.eq e_1 (LLVM.and (sub (const? 8 0) e) e)) ⊑
    LLVM.or (icmp IntPredicate.eq e_1 (const? 8 1))
      (icmp IntPredicate.eq e_1 (LLVM.and e (sub (const? 8 0) e))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_or_z_or_pow2orz_fail_bad_pred2_thm (e e_1 : IntW 8) :
  LLVM.or (icmp IntPredicate.sle e_1 (const? 8 0)) (icmp IntPredicate.sle e_1 (LLVM.and (sub (const? 8 0) e) e)) ⊑
    LLVM.or (icmp IntPredicate.slt e_1 (const? 8 1))
      (icmp IntPredicate.sle e_1 (LLVM.and e (sub (const? 8 0) e))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_slt_to_mask_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.slt e (const? 8 (-124))) (icmp IntPredicate.eq (LLVM.and e (const? 8 2)) (const? 8 0)) ⊑
    icmp IntPredicate.slt e (const? 8 (-126)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_sgt_to_mask_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.sgt e (const? 8 123)) (icmp IntPredicate.eq (LLVM.and e (const? 8 2)) (const? 8 0)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 (-2))) (const? 8 124) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_ugt_to_mask_thm (e : IntW 8) :
  LLVM.and (icmp IntPredicate.ugt e (const? 8 (-5))) (icmp IntPredicate.eq (LLVM.and e (const? 8 2)) (const? 8 0)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 (-2))) (const? 8 (-4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


