
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphsub_proof
theorem test_nuw_and_unsigned_pred_thm (e : IntW 64) :
  icmp IntPredicate.ult (sub (const? 10) e { «nsw» := false, «nuw» := true }) (const? 3) ⊑
    icmp IntPredicate.ugt e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_nsw_and_signed_pred_thm (e : IntW 64) :
  icmp IntPredicate.sgt (sub (const? 3) e { «nsw» := true, «nuw» := false }) (const? 10) ⊑
    icmp IntPredicate.slt e (const? (-7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_nuw_nsw_and_unsigned_pred_thm (e : IntW 64) :
  icmp IntPredicate.ule (sub (const? 10) e { «nsw» := true, «nuw» := true }) (const? 3) ⊑
    icmp IntPredicate.ugt e (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_nuw_nsw_and_signed_pred_thm (e : IntW 64) :
  icmp IntPredicate.slt (sub (const? 10) e { «nsw» := true, «nuw» := true }) (const? 3) ⊑
    icmp IntPredicate.ugt e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_negative_nuw_and_signed_pred_thm (e : IntW 64) :
  icmp IntPredicate.slt (sub (const? 10) e { «nsw» := false, «nuw» := true }) (const? 3) ⊑
    icmp IntPredicate.ugt e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_negative_nsw_and_unsigned_pred_thm (e : IntW 64) :
  icmp IntPredicate.ult (sub (const? 10) e { «nsw» := true, «nuw» := false }) (const? 3) ⊑
    icmp IntPredicate.ult (add e (const? (-8))) (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_negative_combined_sub_unsigned_overflow_thm (e : IntW 64) :
  icmp IntPredicate.ult (sub (const? 10) e { «nsw» := false, «nuw» := true }) (const? 11) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_negative_combined_sub_signed_overflow_thm (e : IntW 8) :
  icmp IntPredicate.slt (sub (const? 127) e { «nsw» := true, «nuw» := false }) (const? (-1)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_0_Y_eq_0_thm (e : IntW 8) :
  icmp IntPredicate.eq (sub (const? 0) e) (const? 0) ⊑ icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_0_Y_ne_0_thm (e : IntW 8) :
  icmp IntPredicate.ne (sub (const? 0) e) (const? 0) ⊑ icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_4_Y_ne_4_thm (e : IntW 8) :
  icmp IntPredicate.ne (sub (const? 4) e) (const? 4) ⊑ icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_127_Y_eq_127_thm (e : IntW 8) :
  icmp IntPredicate.eq (sub (const? 127) e) (const? 127) ⊑ icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_255_Y_eq_255_thm (e : IntW 8) :
  icmp IntPredicate.eq (sub (const? (-1)) e) (const? (-1)) ⊑ icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_sgt_42_thm (e : IntW 32) :
  icmp IntPredicate.sgt (sub (const? 0) e) (const? 42) ⊑
    icmp IntPredicate.slt (add e (const? (-1))) (const? (-43)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_slt_42_thm (e : IntW 128) :
  icmp IntPredicate.slt (sub (const? 0) e) (const? 42) ⊑
    icmp IntPredicate.sgt (add e (const? (-1))) (const? (-43)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_slt_n1_thm (e : IntW 8) :
  icmp IntPredicate.slt (sub (const? 0) e) (const? (-1)) ⊑
    icmp IntPredicate.sgt (add e (const? (-1))) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_slt_0_thm (e : IntW 8) :
  icmp IntPredicate.slt (sub (const? 0) e) (const? 0) ⊑
    icmp IntPredicate.sgt (add e (const? (-1))) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_slt_1_thm (e : IntW 8) :
  icmp IntPredicate.slt (sub (const? 0) e) (const? 1) ⊑ icmp IntPredicate.ult e (const? (-127)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_sgt_n1_thm (e : IntW 8) :
  icmp IntPredicate.sgt (sub (const? 0) e) (const? (-1)) ⊑
    icmp IntPredicate.slt (add e (const? (-1))) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_sgt_0_thm (e : IntW 8) :
  icmp IntPredicate.sgt (sub (const? 0) e) (const? 0) ⊑ icmp IntPredicate.ugt e (const? (-128)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_sgt_1_thm (e : IntW 8) :
  icmp IntPredicate.sgt (sub (const? 0) e) (const? 1) ⊑
    icmp IntPredicate.slt (add e (const? (-1))) (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_nsw_slt_n1_thm (e : IntW 8) :
  icmp IntPredicate.slt (sub (const? 0) e { «nsw» := true, «nuw» := false }) (const? (-1)) ⊑
    icmp IntPredicate.sgt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_nsw_slt_0_thm (e : IntW 8) :
  icmp IntPredicate.slt (sub (const? 0) e { «nsw» := true, «nuw» := false }) (const? 0) ⊑
    icmp IntPredicate.sgt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_nsw_slt_1_thm (e : IntW 8) :
  icmp IntPredicate.slt (sub (const? 0) e { «nsw» := true, «nuw» := false }) (const? 1) ⊑
    icmp IntPredicate.sgt e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_nsw_sgt_n1_thm (e : IntW 8) :
  icmp IntPredicate.sgt (sub (const? 0) e { «nsw» := true, «nuw» := false }) (const? (-1)) ⊑
    icmp IntPredicate.slt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_nsw_sgt_0_thm (e : IntW 8) :
  icmp IntPredicate.sgt (sub (const? 0) e { «nsw» := true, «nuw» := false }) (const? 0) ⊑
    icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_nsw_sgt_1_thm (e : IntW 8) :
  icmp IntPredicate.sgt (sub (const? 0) e { «nsw» := true, «nuw» := false }) (const? 1) ⊑
    icmp IntPredicate.slt e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR60818_ne_thm (e : IntW 32) :
  icmp IntPredicate.ne (sub (const? 0) e) e ⊑ icmp IntPredicate.ne (LLVM.and e (const? 2147483647)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR60818_eq_thm (e : IntW 32) :
  icmp IntPredicate.eq (sub (const? 0) e) e ⊑ icmp IntPredicate.eq (LLVM.and e (const? 2147483647)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR60818_eq_commuted_thm (e : IntW 32) :
  icmp IntPredicate.eq (mul e (const? 43)) (sub (const? 0) (mul e (const? 43))) ⊑
    icmp IntPredicate.eq (LLVM.and (mul e (const? 43)) (const? 2147483647)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR60818_sgt_thm (e : IntW 32) :
  icmp IntPredicate.sgt (sub (const? 0) e) e ⊑ icmp IntPredicate.slt e (sub (const? 0) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


