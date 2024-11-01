
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gintegerhroundhuphpow2halignment_proof
theorem t0_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 15)) (const? 0)) e (LLVM.and (add e (const? 16)) (const? (-16))) ⊑
    LLVM.and (add e (const? 15)) (const? (-16)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 31)) (const? 0)) e (LLVM.and (add e (const? 32)) (const? (-32))) ⊑
    LLVM.and (add e (const? 31)) (const? (-32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 15)) (const? 0)) e (LLVM.and (add e (const? 15)) (const? (-16))) ⊑
    LLVM.and (add e (const? 15)) (const? (-16)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n9_wrong_x0_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e
      (LLVM.and (add e_1 (const? 16)) (const? (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e
      (add (LLVM.and e_1 (const? (-16))) (const? 16)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n9_wrong_x1_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e_1
      (LLVM.and (add e (const? 16)) (const? (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e_1
      (add (LLVM.and e (const? (-16))) (const? 16)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n9_wrong_x2_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e (LLVM.and (add e (const? 16)) (const? (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e
      (add (LLVM.and e (const? (-16))) (const? 16)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n10_wrong_low_bit_mask_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 31)) (const? 0)) e (LLVM.and (add e (const? 16)) (const? (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 31)) (const? 0)) e
      (add (LLVM.and e (const? (-16))) (const? 16)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n12_wrong_bias_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 15)) (const? 0)) e (LLVM.and (add e (const? 32)) (const? (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 15)) (const? 0)) e
      (add (LLVM.and e (const? (-16))) (const? 32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n14_wrong_comparison_constant_thm (e : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 15)) (const? 1)) e (LLVM.and (add e (const? 16)) (const? (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 15)) (const? 1)) e
      (add (LLVM.and e (const? (-16))) (const? 16)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n15_wrong_comparison_predicate_and_constant_thm (e : IntW 8) :
  select (icmp IntPredicate.ult (LLVM.and e (const? 15)) (const? 2)) e (LLVM.and (add e (const? 16)) (const? (-16))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 14)) (const? 0)) e
      (add (LLVM.and e (const? (-16))) (const? 16)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


