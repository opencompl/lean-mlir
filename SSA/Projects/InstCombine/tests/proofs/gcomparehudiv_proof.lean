
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcomparehudiv_proof
theorem test1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.udiv e_1 e) (const? 0) ⊑ icmp IntPredicate.ugt e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.udiv (const? 64) e) (const? 0) ⊑ icmp IntPredicate.ugt e (const? 64) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.udiv e_1 e) (const? 0) ⊑ icmp IntPredicate.ule e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e : IntW 32) :
  icmp IntPredicate.ne (LLVM.udiv (const? 64) e) (const? 0) ⊑ icmp IntPredicate.ult e (const? 65) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e : IntW 32) : icmp IntPredicate.ne (LLVM.udiv (const? (-1)) e) (const? 0) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_thm (e : IntW 32) :
  icmp IntPredicate.ugt (LLVM.udiv (const? 5) e) (const? 0) ⊑ icmp IntPredicate.ult e (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm (e : IntW 32) : icmp IntPredicate.ugt (LLVM.udiv (const? 8) e) (const? 8) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm (e : IntW 32) :
  icmp IntPredicate.ugt (LLVM.udiv (const? 4) e) (const? 3) ⊑ icmp IntPredicate.ult e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm (e : IntW 32) :
  icmp IntPredicate.ugt (LLVM.udiv (const? 4) e) (const? 2) ⊑ icmp IntPredicate.ult e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_thm (e : IntW 32) :
  icmp IntPredicate.ugt (LLVM.udiv (const? 4) e) (const? 1) ⊑ icmp IntPredicate.ult e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11_thm (e : IntW 32) :
  icmp IntPredicate.ult (LLVM.udiv (const? 4) e) (const? 1) ⊑ icmp IntPredicate.ugt e (const? 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_thm (e : IntW 32) :
  icmp IntPredicate.ult (LLVM.udiv (const? 4) e) (const? 2) ⊑ icmp IntPredicate.ugt e (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm (e : IntW 32) :
  icmp IntPredicate.ult (LLVM.udiv (const? 4) e) (const? 3) ⊑ icmp IntPredicate.ugt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test14_thm (e : IntW 32) :
  icmp IntPredicate.ult (LLVM.udiv (const? 4) e) (const? 4) ⊑ icmp IntPredicate.ugt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test15_thm (e : IntW 32) : icmp IntPredicate.ugt (LLVM.udiv (const? 4) e) (const? (-1)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test16_thm (e : IntW 32) : icmp IntPredicate.ult (LLVM.udiv (const? 4) e) (const? (-1)) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


