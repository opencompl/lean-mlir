
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gminmaxhdemandbits_proof
theorem and_umax_less_thm (e : IntW 32) :
  LLVM.and (select (icmp IntPredicate.ugt (const? 31) e) (const? 31) e) (const? (-32)) ⊑
    LLVM.and e (const? (-32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_umax_muchless_thm (e : IntW 32) :
  LLVM.and (select (icmp IntPredicate.ugt (const? 12) e) (const? 12) e) (const? (-32)) ⊑
    LLVM.and e (const? (-32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shr_umax_thm (e : IntW 32) :
  lshr (select (icmp IntPredicate.ugt (const? 15) e) (const? 15) e) (const? 4) ⊑ lshr e (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t_0_1_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ugt e (const? 0)) e (const? 0)) (const? 1) ⊑ LLVM.and e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t_0_10_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ugt e (const? 0)) e (const? 0)) (const? 10) ⊑ LLVM.and e (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t_1_10_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ugt e (const? 1)) e (const? 1)) (const? 10) ⊑ LLVM.and e (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t_2_4_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ugt e (const? 2)) e (const? 2)) (const? 4) ⊑ LLVM.and e (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t_2_192_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ugt e (const? 2)) e (const? 2)) (const? (-64)) ⊑
    LLVM.and e (const? (-64)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t_2_63_or_thm (e : IntW 8) :
  LLVM.or (select (icmp IntPredicate.ugt e (const? 2)) e (const? 2)) (const? 63) ⊑ LLVM.or e (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_umin_thm (e : IntW 32) :
  LLVM.and (select (icmp IntPredicate.ult (const? 15) e) (const? 15) e) (const? (-32)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_umin_thm (e : IntW 32) :
  LLVM.or (select (icmp IntPredicate.ult (const? 15) e) (const? 15) e) (const? 31) ⊑ const? 31 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_min_31_30_thm (e : IntW 8) :
  LLVM.or (select (icmp IntPredicate.ult e (const? (-30))) e (const? (-30))) (const? 31) ⊑
    LLVM.or e (const? 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_min_7_7_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ult e (const? (-7))) e (const? (-7))) (const? (-8)) ⊑
    LLVM.and e (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_min_7_8_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ult e (const? (-8))) e (const? (-8))) (const? (-8)) ⊑
    LLVM.and e (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


