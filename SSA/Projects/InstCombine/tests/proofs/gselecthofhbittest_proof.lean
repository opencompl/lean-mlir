
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthofhbittest_proof
theorem and_lshr_and_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 1)) (const? 0)) (LLVM.and (lshr e (const? 1)) (const? 1))
      (const? 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e (const? 3)) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_and_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 2)) (const? 0)) (LLVM.and e (const? 1)) (const? 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e (const? 3)) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem f_var0_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 e) (const? 0)) (LLVM.and (lshr e_1 (const? 1)) (const? 1)) (const? 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e_1 (LLVM.or e (const? 2))) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem f_var0_commutative_and_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 e) (const? 0)) (LLVM.and (lshr e (const? 1)) (const? 1)) (const? 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e (LLVM.or e_1 (const? 2))) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem f_var1_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 e) (const? 0)) (LLVM.and e_1 (const? 1)) (const? 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e_1 (LLVM.or e (const? 1))) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem f_var1_commutative_and_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 e) (const? 0)) (LLVM.and e (const? 1)) (const? 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e (LLVM.or e_1 (const? 1))) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n5_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 2)) (const? 0)) (LLVM.and e (const? 2)) (const? 1) ⊑
    LLVM.and (lshr e (const? 1)) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n6_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 1)) (const? 0)) (LLVM.and (lshr e (const? 2)) (const? 1))
      (const? 1) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 1)) (const? 0)) (const? 1)
      (LLVM.and (lshr e (const? 2)) (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n7_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 2)) (const? 0)) (LLVM.and e (const? 1)) (const? 1) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 2)) (const? 0)) (const? 1) (LLVM.and e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n8_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 1)) (const? 1)) (LLVM.and (lshr e (const? 2)) (const? 1))
      (const? 1) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 1)) (const? 0)) (const? 1)
      (LLVM.and (lshr e (const? 2)) (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


