
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshlhandhnegChicmpeqhzero_proof
theorem scalar_i8_shl_and_negC_eq_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (shl e_1 e) (const? (-4))) (const? 0) ⊑
    icmp IntPredicate.ult (shl e_1 e) (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i16_shl_and_negC_eq_thm (e e_1 : IntW 16) :
  icmp IntPredicate.eq (LLVM.and (shl e_1 e) (const? (-128))) (const? 0) ⊑
    icmp IntPredicate.ult (shl e_1 e) (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_shl_and_negC_eq_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl e_1 e) (const? (-262144))) (const? 0) ⊑
    icmp IntPredicate.ult (shl e_1 e) (const? 262144) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i64_shl_and_negC_eq_thm (e e_1 : IntW 64) :
  icmp IntPredicate.eq (LLVM.and (shl e_1 e) (const? (-8589934592))) (const? 0) ⊑
    icmp IntPredicate.ult (shl e_1 e) (const? 8589934592) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_shl_and_negC_ne_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (shl e_1 e) (const? (-262144))) (const? 0) ⊑
    icmp IntPredicate.ugt (shl e_1 e) (const? 262143) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_shl_and_negC_eq_X_is_constant1_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl (const? 12345) e) (const? (-8))) (const? 0) ⊑
    icmp IntPredicate.ult (shl (const? 12345) e) (const? 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_shl_and_negC_eq_X_is_constant2_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl (const? 1) e) (const? (-8))) (const? 0) ⊑
    icmp IntPredicate.ult e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_shl_and_negC_slt_thm (e e_1 : IntW 32) :
  icmp IntPredicate.slt (LLVM.and (shl e_1 e) (const? (-8))) (const? 0) ⊑
    icmp IntPredicate.slt (shl e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_shl_and_negC_eq_nonzero_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl e_1 e) (const? (-8))) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


