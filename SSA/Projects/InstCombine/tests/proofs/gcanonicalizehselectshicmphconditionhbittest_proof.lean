
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehselectshicmphconditionhbittest_proof
theorem p0_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 1)) e_1 e ⊑
    select (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p1_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 0)) e_1 e ⊑
    select (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n5_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 2)) e_1 e ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n6_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 3)) e_1 e ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n7_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_2 (const? 1)) (const? 1)) e_1 e ⊑
    select (icmp IntPredicate.eq (LLVM.and e_2 (const? 1)) (const? 0)) e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


