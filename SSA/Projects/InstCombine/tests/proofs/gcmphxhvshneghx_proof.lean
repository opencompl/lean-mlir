
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcmphxhvshneghx_proof
theorem t0_thm (e : IntW 8) :
  icmp IntPredicate.sgt (sub (const? 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_thm (e : IntW 8) :
  icmp IntPredicate.sge (sub (const? 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPredicate.slt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_thm (e : IntW 8) :
  icmp IntPredicate.slt (sub (const? 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPredicate.sgt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t3_thm (e : IntW 8) :
  icmp IntPredicate.sle (sub (const? 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPredicate.sgt e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t4_thm (e : IntW 8) :
  icmp IntPredicate.ugt (sub (const? 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPredicate.sgt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t5_thm (e : IntW 8) :
  icmp IntPredicate.uge (sub (const? 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPredicate.sgt e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t6_thm (e : IntW 8) :
  icmp IntPredicate.ult (sub (const? 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t7_thm (e : IntW 8) :
  icmp IntPredicate.ule (sub (const? 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPredicate.slt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t8_thm (e : IntW 8) :
  icmp IntPredicate.eq (sub (const? 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t9_thm (e : IntW 8) :
  icmp IntPredicate.ne (sub (const? 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n10_thm (e : IntW 8) :
  icmp IntPredicate.sgt (sub (const? 0) e) e ⊑ icmp IntPredicate.slt e (sub (const? 0) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n12_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sgt (sub (const? 0) e_1 { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPredicate.slt e (sub (const? 0) e_1 { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


