
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthdivrem_proof
theorem udiv_common_divisor_thm (e e_1 e_2 : IntW 5) (e_3 : IntW 1) :
  select e_3 (LLVM.udiv e_2 e_1) (LLVM.udiv e e_1) ⊑ LLVM.udiv (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_common_divisor_thm (e e_1 e_2 : IntW 5) (e_3 : IntW 1) :
  select e_3 (urem e_2 e_1) (urem e e_1) ⊑ urem (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_common_divisor_defined_cond_thm (e e_1 e_2 : IntW 5) (e_3 : IntW 1) :
  select e_3 (LLVM.sdiv e_2 e_1) (LLVM.sdiv e e_1) ⊑ LLVM.sdiv (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem srem_common_divisor_defined_cond_thm (e e_1 e_2 : IntW 5) (e_3 : IntW 1) :
  select e_3 (LLVM.srem e_2 e_1) (LLVM.srem e e_1) ⊑ LLVM.srem (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_common_divisor_defined_cond_thm (e e_1 e_2 : IntW 5) (e_3 : IntW 1) :
  select e_3 (LLVM.udiv e_2 e_1) (LLVM.udiv e e_1) ⊑ LLVM.udiv (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_common_divisor_defined_cond_thm (e e_1 e_2 : IntW 5) (e_3 : IntW 1) :
  select e_3 (urem e_2 e_1) (urem e e_1) ⊑ urem (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_common_dividend_defined_cond_thm (e e_1 e_2 : IntW 5) (e_3 : IntW 1) :
  select e_3 (LLVM.sdiv e_2 e_1) (LLVM.sdiv e_2 e) ⊑ LLVM.sdiv e_2 (select e_3 e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem srem_common_dividend_defined_cond_thm (e e_1 e_2 : IntW 5) (e_3 : IntW 1) :
  select e_3 (LLVM.srem e_2 e_1) (LLVM.srem e_2 e) ⊑ LLVM.srem e_2 (select e_3 e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_common_dividend_defined_cond_thm (e e_1 e_2 : IntW 5) (e_3 : IntW 1) :
  select e_3 (LLVM.udiv e_2 e_1) (LLVM.udiv e_2 e) ⊑ LLVM.udiv e_2 (select e_3 e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_common_dividend_defined_cond_thm (e e_1 e_2 : IntW 5) (e_3 : IntW 1) :
  select e_3 (urem e_2 e_1) (urem e_2 e) ⊑ urem e_2 (select e_3 e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem rem_euclid_1_thm (e : IntW 32) :
  select (icmp IntPredicate.slt (LLVM.srem e (const? 8)) (const? 0)) (add (LLVM.srem e (const? 8)) (const? 8))
      (LLVM.srem e (const? 8)) ⊑
    LLVM.and e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem rem_euclid_2_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt (LLVM.srem e (const? 8)) (const? (-1))) (LLVM.srem e (const? 8))
      (add (LLVM.srem e (const? 8)) (const? 8)) ⊑
    LLVM.and e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem rem_euclid_wrong_sign_test_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt (LLVM.srem e (const? 8)) (const? 0)) (add (LLVM.srem e (const? 8)) (const? 8))
      (LLVM.srem e (const? 8)) ⊑
    select (icmp IntPredicate.sgt (LLVM.srem e (const? 8)) (const? 0))
      (add (LLVM.srem e (const? 8)) (const? 8) { «nsw» := true, «nuw» := false }) (LLVM.srem e (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem rem_euclid_add_different_const_thm (e : IntW 32) :
  select (icmp IntPredicate.slt (LLVM.srem e (const? 8)) (const? 0)) (add (LLVM.srem e (const? 8)) (const? 9))
      (LLVM.srem e (const? 8)) ⊑
    select (icmp IntPredicate.slt (LLVM.srem e (const? 8)) (const? 0))
      (add (LLVM.srem e (const? 8)) (const? 9) { «nsw» := true, «nuw» := false }) (LLVM.srem e (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem rem_euclid_wrong_operands_select_thm (e : IntW 32) :
  select (icmp IntPredicate.slt (LLVM.srem e (const? 8)) (const? 0)) (LLVM.srem e (const? 8))
      (add (LLVM.srem e (const? 8)) (const? 8)) ⊑
    select (icmp IntPredicate.slt (LLVM.srem e (const? 8)) (const? 0)) (LLVM.srem e (const? 8))
      (add (LLVM.srem e (const? 8)) (const? 8) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem rem_euclid_i128_thm (e : IntW 128) :
  select (icmp IntPredicate.slt (LLVM.srem e (const? 8)) (const? 0)) (add (LLVM.srem e (const? 8)) (const? 8))
      (LLVM.srem e (const? 8)) ⊑
    LLVM.and e (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem rem_euclid_non_const_pow2_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.slt (LLVM.srem e_1 (shl (const? 1) e)) (const? 0))
      (add (LLVM.srem e_1 (shl (const? 1) e)) (shl (const? 1) e)) (LLVM.srem e_1 (shl (const? 1) e)) ⊑
    LLVM.and e_1 (LLVM.xor (shl (const? (-1)) e { «nsw» := true, «nuw» := false }) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem rem_euclid_pow2_true_arm_folded_thm (e : IntW 32) :
  select (icmp IntPredicate.slt (LLVM.srem e (const? 2)) (const? 0)) (const? 1) (LLVM.srem e (const? 2)) ⊑
    LLVM.and e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem rem_euclid_pow2_false_arm_folded_thm (e : IntW 32) :
  select (icmp IntPredicate.sge (LLVM.srem e (const? 2)) (const? 0)) (LLVM.srem e (const? 2)) (const? 1) ⊑
    LLVM.and e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem pr89516_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.slt e_1 (const? 0))
      (add (LLVM.srem (const? 1) (shl (const? 1) e { «nsw» := false, «nuw» := true }))
        (shl (const? 1) e { «nsw» := false, «nuw» := true }) { «nsw» := false, «nuw» := true })
      (LLVM.srem (const? 1) (shl (const? 1) e { «nsw» := false, «nuw» := true })) ⊑
    add (LLVM.srem (const? 1) (shl (const? 1) e { «nsw» := false, «nuw» := true }))
      (select (icmp IntPredicate.slt e_1 (const? 0)) (shl (const? 1) e { «nsw» := false, «nuw» := true }) (const? 0))
      { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


