
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphshlhnuw_proof
theorem icmp_ugt_32_thm (e : IntW 64) :
  icmp IntPredicate.ugt (shl e (const? 64 32) { «nsw» := false, «nuw» := true }) (const? 64 4294967295) ⊑
    icmp IntPredicate.ne e (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ule_64_thm (e : IntW 128) :
  icmp IntPredicate.ule (shl e (const? 128 64) { «nsw» := false, «nuw» := true }) (const? 128 18446744073709551615) ⊑
    icmp IntPredicate.eq e (const? 128 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ugt_16_thm (e : IntW 64) :
  icmp IntPredicate.ugt (shl e (const? 64 16) { «nsw» := false, «nuw» := true }) (const? 64 1048575) ⊑
    icmp IntPredicate.ugt e (const? 64 15) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ult_8_thm (e : IntW 64) :
  icmp IntPredicate.ult (shl e (const? 64 8) { «nsw» := false, «nuw» := true }) (const? 64 4095) ⊑
    icmp IntPredicate.ult e (const? 64 16) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_icmp_shl_nuw_c1_thm (e : IntW 32) :
  icmp IntPredicate.ult
      (shl (const? 32 2) (LLVM.and (lshr e (const? 32 12)) (const? 32 15)) { «nsw» := false, «nuw» := true })
      (const? 32 4) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 61440)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 32 16) e { «nsw» := false, «nuw» := true }) (const? 32 64) ⊑
    icmp IntPredicate.ult e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_non_pow2_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 32 48) e { «nsw» := false, «nuw» := true }) (const? 32 192) ⊑
    icmp IntPredicate.ult e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_div_non_pow2_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 32 2) e { «nsw» := false, «nuw» := true }) (const? 32 60) ⊑
    icmp IntPredicate.ult e (const? 32 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_icmp_shl_nuw_c3_thm (e : IntW 32) :
  icmp IntPredicate.uge (shl (const? 32 48) e { «nsw» := false, «nuw» := true }) (const? 32 144) ⊑
    icmp IntPredicate.ugt e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_indivisible_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 32 16) e { «nsw» := false, «nuw» := true }) (const? 32 63) ⊑
    icmp IntPredicate.ult e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_precondition1_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 32 0) e { «nsw» := false, «nuw» := true }) (const? 32 63) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_precondition2_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 32 127) e { «nsw» := false, «nuw» := true }) (const? 32 63) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_icmp_shl_nuw_c2_precondition3_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl (const? 32 1) e { «nsw» := false, «nuw» := true }) (const? 32 1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
