
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gshlhunsignedhcmphconst_proof
theorem scalar_i8_shl_ult_const_1_thm (e : IntW 8) :
  icmp IntPredicate.ult (shl e (const? 8 5)) (const? 8 64) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 6)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i8_shl_ult_const_2_thm (e : IntW 8) :
  icmp IntPredicate.ult (shl e (const? 8 6)) (const? 8 64) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 3)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i8_shl_ult_const_3_thm (e : IntW 8) :
  icmp IntPredicate.ult (shl e (const? 8 7)) (const? 8 64) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 1)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i16_shl_ult_const_thm (e : IntW 16) :
  icmp IntPredicate.ult (shl e (const? 16 8)) (const? 16 1024) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 16 252)) (const? 16 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i32_shl_ult_const_thm (e : IntW 32) :
  icmp IntPredicate.ult (shl e (const? 32 11)) (const? 32 131072) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 2097088)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i64_shl_ult_const_thm (e : IntW 64) :
  icmp IntPredicate.ult (shl e (const? 64 25)) (const? 64 8589934592) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 64 549755813632)) (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i8_shl_uge_const_thm (e : IntW 8) :
  icmp IntPredicate.uge (shl e (const? 8 5)) (const? 8 64) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 6)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i8_shl_ule_const_thm (e : IntW 8) :
  icmp IntPredicate.ule (shl e (const? 8 5)) (const? 8 63) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 6)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i8_shl_ugt_const_thm (e : IntW 8) :
  icmp IntPredicate.ugt (shl e (const? 8 5)) (const? 8 63) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 6)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
