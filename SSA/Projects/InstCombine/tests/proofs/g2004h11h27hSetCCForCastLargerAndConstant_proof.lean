
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section g2004h11h27hSetCCForCastLargerAndConstant_proof
theorem lt_signed_to_large_unsigned_thm (e : IntW 8) :
  icmp IntPredicate.ult (sext 32 e) (const? 32 1024) ⊑ icmp IntPredicate.sgt e (const? 8 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lt_signed_to_large_signed_thm (e : IntW 8) : icmp IntPredicate.slt (sext 32 e) (const? 32 1024) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lt_signed_to_large_negative_thm (e : IntW 8) : icmp IntPredicate.slt (sext 32 e) (const? 32 (-1024)) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lt_signed_to_small_unsigned_thm (e : IntW 8) :
  icmp IntPredicate.ult (sext 32 e) (const? 32 17) ⊑ icmp IntPredicate.ult e (const? 8 17) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lt_signed_to_small_signed_thm (e : IntW 8) :
  icmp IntPredicate.slt (sext 32 e) (const? 32 17) ⊑ icmp IntPredicate.slt e (const? 8 17) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lt_signed_to_small_negative_thm (e : IntW 8) :
  icmp IntPredicate.slt (sext 32 e) (const? 32 (-17)) ⊑ icmp IntPredicate.slt e (const? 8 (-17)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lt_unsigned_to_large_unsigned_thm (e : IntW 8) : icmp IntPredicate.ult (zext 32 e) (const? 32 1024) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lt_unsigned_to_large_signed_thm (e : IntW 8) : icmp IntPredicate.slt (zext 32 e) (const? 32 1024) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lt_unsigned_to_large_negative_thm (e : IntW 8) : icmp IntPredicate.slt (zext 32 e) (const? 32 (-1024)) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lt_unsigned_to_small_unsigned_thm (e : IntW 8) :
  icmp IntPredicate.ult (zext 32 e) (const? 32 17) ⊑ icmp IntPredicate.ult e (const? 8 17) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lt_unsigned_to_small_signed_thm (e : IntW 8) :
  icmp IntPredicate.slt (zext 32 e) (const? 32 17) ⊑ icmp IntPredicate.ult e (const? 8 17) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lt_unsigned_to_small_negative_thm (e : IntW 8) : icmp IntPredicate.slt (zext 32 e) (const? 32 (-17)) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_signed_to_large_unsigned_thm (e : IntW 8) :
  icmp IntPredicate.ugt (sext 32 e) (const? 32 1024) ⊑ icmp IntPredicate.slt e (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_signed_to_large_signed_thm (e : IntW 8) : icmp IntPredicate.sgt (sext 32 e) (const? 32 1024) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_signed_to_large_negative_thm (e : IntW 8) : icmp IntPredicate.sgt (sext 32 e) (const? 32 (-1024)) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_signed_to_small_unsigned_thm (e : IntW 8) :
  icmp IntPredicate.ugt (sext 32 e) (const? 32 17) ⊑ icmp IntPredicate.ugt e (const? 8 17) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_signed_to_small_signed_thm (e : IntW 8) :
  icmp IntPredicate.sgt (sext 32 e) (const? 32 17) ⊑ icmp IntPredicate.sgt e (const? 8 17) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_signed_to_small_negative_thm (e : IntW 8) :
  icmp IntPredicate.sgt (sext 32 e) (const? 32 (-17)) ⊑ icmp IntPredicate.sgt e (const? 8 (-17)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_unsigned_to_large_unsigned_thm (e : IntW 8) : icmp IntPredicate.ugt (zext 32 e) (const? 32 1024) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_unsigned_to_large_signed_thm (e : IntW 8) : icmp IntPredicate.sgt (zext 32 e) (const? 32 1024) ⊑ const? 1 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_unsigned_to_large_negative_thm (e : IntW 8) : icmp IntPredicate.sgt (zext 32 e) (const? 32 (-1024)) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_unsigned_to_small_unsigned_thm (e : IntW 8) :
  icmp IntPredicate.ugt (zext 32 e) (const? 32 17) ⊑ icmp IntPredicate.ugt e (const? 8 17) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_unsigned_to_small_signed_thm (e : IntW 8) :
  icmp IntPredicate.sgt (zext 32 e) (const? 32 17) ⊑ icmp IntPredicate.ugt e (const? 8 17) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem gt_unsigned_to_small_negative_thm (e : IntW 8) : icmp IntPredicate.sgt (zext 32 e) (const? 32 (-17)) ⊑ const? 1 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem different_size_zext_zext_ugt_thm (e : IntW 4) (e_1 : IntW 7) :
  icmp IntPredicate.ugt (zext 25 e_1) (zext 25 e) ⊑ icmp IntPredicate.ugt e_1 (zext 7 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem different_size_zext_zext_ult_thm (e : IntW 7) (e_1 : IntW 4) :
  icmp IntPredicate.ult (zext 25 e_1) (zext 25 e) ⊑ icmp IntPredicate.ugt e (zext 7 e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem different_size_zext_zext_eq_thm (e : IntW 7) (e_1 : IntW 4) :
  icmp IntPredicate.eq (zext 25 e_1) (zext 25 e) ⊑ icmp IntPredicate.eq e (zext 7 e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem different_size_zext_zext_ne_commute_thm (e : IntW 4) (e_1 : IntW 7) :
  icmp IntPredicate.ne (zext 25 e_1) (zext 25 e) ⊑ icmp IntPredicate.ne e_1 (zext 7 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem different_size_zext_zext_slt_thm (e : IntW 4) (e_1 : IntW 7) :
  icmp IntPredicate.slt (zext 25 e_1) (zext 25 e) ⊑ icmp IntPredicate.ult e_1 (zext 7 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem different_size_zext_zext_sgt_thm (e : IntW 4) (e_1 : IntW 7) :
  icmp IntPredicate.sgt (zext 25 e_1) (zext 25 e) ⊑ icmp IntPredicate.ugt e_1 (zext 7 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem different_size_sext_sext_sgt_thm (e : IntW 4) (e_1 : IntW 7) :
  icmp IntPredicate.sgt (sext 25 e_1) (sext 25 e) ⊑ icmp IntPredicate.sgt e_1 (sext 7 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem different_size_sext_sext_sle_thm (e : IntW 4) (e_1 : IntW 7) :
  icmp IntPredicate.sle (sext 25 e_1) (sext 25 e) ⊑ icmp IntPredicate.sle e_1 (sext 7 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem different_size_sext_sext_eq_thm (e : IntW 4) (e_1 : IntW 7) :
  icmp IntPredicate.eq (sext 25 e_1) (sext 25 e) ⊑ icmp IntPredicate.eq e_1 (sext 7 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem different_size_sext_sext_ule_thm (e : IntW 4) (e_1 : IntW 7) :
  icmp IntPredicate.ule (sext 25 e_1) (sext 25 e) ⊑ icmp IntPredicate.ule e_1 (sext 7 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


