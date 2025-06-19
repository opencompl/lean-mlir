
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphsub_proof
theorem test_nuw_and_unsigned_pred_thm (e : IntW 64) :
  icmp IntPred.ult (sub (const? 64 10) e { «nsw» := false, «nuw» := true }) (const? 64 3) ⊑
    icmp IntPred.ugt e (const? 64 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_nsw_and_signed_pred_thm (e : IntW 64) :
  icmp IntPred.sgt (sub (const? 64 3) e { «nsw» := true, «nuw» := false }) (const? 64 10) ⊑
    icmp IntPred.slt e (const? 64 (-7)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_nuw_nsw_and_unsigned_pred_thm (e : IntW 64) :
  icmp IntPred.ule (sub (const? 64 10) e { «nsw» := true, «nuw» := true }) (const? 64 3) ⊑
    icmp IntPred.ugt e (const? 64 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_nuw_nsw_and_signed_pred_thm (e : IntW 64) :
  icmp IntPred.slt (sub (const? 64 10) e { «nsw» := true, «nuw» := true }) (const? 64 3) ⊑
    icmp IntPred.ugt e (const? 64 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_negative_nuw_and_signed_pred_thm (e : IntW 64) :
  icmp IntPred.slt (sub (const? 64 10) e { «nsw» := false, «nuw» := true }) (const? 64 3) ⊑
    icmp IntPred.ugt e (const? 64 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_negative_nsw_and_unsigned_pred_thm (e : IntW 64) :
  icmp IntPred.ult (sub (const? 64 10) e { «nsw» := true, «nuw» := false }) (const? 64 3) ⊑
    icmp IntPred.ult (add e (const? 64 (-8))) (const? 64 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_negative_combined_sub_unsigned_overflow_thm (e : IntW 64) :
  icmp IntPred.ult (sub (const? 64 10) e { «nsw» := false, «nuw» := true }) (const? 64 11) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_negative_combined_sub_signed_overflow_thm (e : IntW 8) :
  icmp IntPred.slt (sub (const? 8 127) e { «nsw» := true, «nuw» := false }) (const? 8 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_sub_0_Y_eq_0_thm (e : IntW 8) :
  icmp IntPred.eq (sub (const? 8 0) e) (const? 8 0) ⊑ icmp IntPred.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_sub_0_Y_ne_0_thm (e : IntW 8) :
  icmp IntPred.ne (sub (const? 8 0) e) (const? 8 0) ⊑ icmp IntPred.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_sub_4_Y_ne_4_thm (e : IntW 8) :
  icmp IntPred.ne (sub (const? 8 4) e) (const? 8 4) ⊑ icmp IntPred.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_sub_127_Y_eq_127_thm (e : IntW 8) :
  icmp IntPred.eq (sub (const? 8 127) e) (const? 8 127) ⊑ icmp IntPred.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test_sub_255_Y_eq_255_thm (e : IntW 8) :
  icmp IntPred.eq (sub (const? 8 (-1)) e) (const? 8 (-1)) ⊑ icmp IntPred.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_sgt_42_thm (e : IntW 32) :
  icmp IntPred.sgt (sub (const? 32 0) e) (const? 32 42) ⊑
    icmp IntPred.slt (add e (const? 32 (-1))) (const? 32 (-43)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_slt_42_thm (e : IntW 128) :
  icmp IntPred.slt (sub (const? 128 0) e) (const? 128 42) ⊑
    icmp IntPred.sgt (add e (const? 128 (-1))) (const? 128 (-43)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_slt_n1_thm (e : IntW 8) :
  icmp IntPred.slt (sub (const? 8 0) e) (const? 8 (-1)) ⊑
    icmp IntPred.sgt (add e (const? 8 (-1))) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_slt_0_thm (e : IntW 8) :
  icmp IntPred.slt (sub (const? 8 0) e) (const? 8 0) ⊑
    icmp IntPred.sgt (add e (const? 8 (-1))) (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_slt_1_thm (e : IntW 8) :
  icmp IntPred.slt (sub (const? 8 0) e) (const? 8 1) ⊑ icmp IntPred.ult e (const? 8 (-127)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_sgt_n1_thm (e : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e) (const? 8 (-1)) ⊑
    icmp IntPred.slt (add e (const? 8 (-1))) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_sgt_0_thm (e : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e) (const? 8 0) ⊑ icmp IntPred.ugt e (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_sgt_1_thm (e : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e) (const? 8 1) ⊑
    icmp IntPred.slt (add e (const? 8 (-1))) (const? 8 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_nsw_slt_n1_thm (e : IntW 8) :
  icmp IntPred.slt (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) (const? 8 (-1)) ⊑
    icmp IntPred.sgt e (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_nsw_slt_0_thm (e : IntW 8) :
  icmp IntPred.slt (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) (const? 8 0) ⊑
    icmp IntPred.sgt e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_nsw_slt_1_thm (e : IntW 8) :
  icmp IntPred.slt (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) (const? 8 1) ⊑
    icmp IntPred.sgt e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_nsw_sgt_n1_thm (e : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) (const? 8 (-1)) ⊑
    icmp IntPred.slt e (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_nsw_sgt_0_thm (e : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) (const? 8 0) ⊑
    icmp IntPred.slt e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_nsw_sgt_1_thm (e : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) (const? 8 1) ⊑
    icmp IntPred.slt e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR60818_ne_thm (e : IntW 32) :
  icmp IntPred.ne (sub (const? 32 0) e) e ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 2147483647)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR60818_eq_thm (e : IntW 32) :
  icmp IntPred.eq (sub (const? 32 0) e) e ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 2147483647)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR60818_eq_commuted_thm (e : IntW 32) :
  icmp IntPred.eq (mul e (const? 32 43)) (sub (const? 32 0) (mul e (const? 32 43))) ⊑
    icmp IntPred.eq (LLVM.and (mul e (const? 32 43)) (const? 32 2147483647)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR60818_sgt_thm (e : IntW 32) :
  icmp IntPred.sgt (sub (const? 32 0) e) e ⊑ icmp IntPred.slt e (sub (const? 32 0) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
