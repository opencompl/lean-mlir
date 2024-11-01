
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gunsigned_saturated_sub_proof
theorem max_sub_ugt_c0_thm (e : IntW 32) :
  select (icmp IntPredicate.ugt e (const? (-1))) (add e (const? 0)) (const? 0) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem max_sub_ult_c1_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 1)) (add e (const? (-1))) (const? 0) ⊑
    sext 32 (icmp IntPredicate.eq e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem max_sub_ugt_c32_thm (e : IntW 32) :
  select (icmp IntPredicate.ugt (const? 3) e) (add e (const? (-2))) (const? 0) ⊑
    select (icmp IntPredicate.ult e (const? 3)) (add e (const? (-2))) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem max_sub_uge_c32_thm (e : IntW 32) :
  select (icmp IntPredicate.uge (const? 2) e) (add e (const? (-2))) (const? 0) ⊑
    select (icmp IntPredicate.ult e (const? 3)) (add e (const? (-2))) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem max_sub_ult_c12_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 1)) (add e (const? (-2))) (const? 0) ⊑
    select (icmp IntPredicate.eq e (const? 0)) (const? (-2)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem max_sub_ult_c0_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 0)) (add e (const? (-1))) (const? 0) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


