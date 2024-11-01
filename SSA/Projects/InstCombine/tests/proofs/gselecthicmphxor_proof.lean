
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthicmphxor_proof
theorem select_icmp_eq_pow2_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 4)) (const? 0)) e (LLVM.xor e (const? 4)) ⊑
    LLVM.and e (const? (-5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_icmp_eq_pow2_flipped_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 4)) (const? 0)) (LLVM.xor e (const? 4)) e ⊑
    LLVM.or e (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_icmp_ne_pow2_thm (e : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 4)) (const? 0)) (LLVM.xor e (const? 4)) e ⊑
    LLVM.and e (const? (-5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_icmp_ne_pow2_flipped_thm (e : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 4)) (const? 0)) e (LLVM.xor e (const? 4)) ⊑
    LLVM.or e (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_icmp_ne_not_pow2_thm (e : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 5)) (const? 0)) (LLVM.xor e (const? 5)) e ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 5)) (const? 0)) e (LLVM.xor e (const? 5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_icmp_slt_zero_smin_thm (e : IntW 8) :
  select (icmp IntPredicate.slt e (const? 0)) e (LLVM.xor e (const? (-128))) ⊑ LLVM.or e (const? (-128)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_icmp_slt_zero_smin_flipped_thm (e : IntW 8) :
  select (icmp IntPredicate.slt e (const? 0)) (LLVM.xor e (const? (-128))) e ⊑ LLVM.and e (const? 127) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_icmp_sgt_allones_smin_thm (e : IntW 8) :
  select (icmp IntPredicate.sgt e (const? (-1))) e (LLVM.xor e (const? (-128))) ⊑ LLVM.and e (const? 127) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_icmp_sgt_allones_smin_flipped_thm (e : IntW 8) :
  select (icmp IntPredicate.sgt e (const? (-1))) (LLVM.xor e (const? (-128))) e ⊑ LLVM.or e (const? (-128)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem select_icmp_sgt_not_smin_thm (e : IntW 8) :
  select (icmp IntPredicate.sgt e (const? (-1))) e (LLVM.xor e (const? (-127))) ⊑
    select (icmp IntPredicate.slt e (const? 0)) (LLVM.xor e (const? (-127))) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


