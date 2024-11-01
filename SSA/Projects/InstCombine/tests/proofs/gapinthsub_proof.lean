
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthsub_proof
theorem test1_thm (e : IntW 23) : sub e e ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e : IntW 47) : sub e (const? 0) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e : IntW 97) : sub (const? 0) (sub (const? 0) e) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e e_1 : IntW 108) : sub e_1 (sub (const? 0) e) ⊑ add e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e e_1 e_2 : IntW 19) : sub e_2 (sub e_1 e) ⊑ add (sub e e_1) e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_thm (e e_1 : IntW 57) : sub e_1 (LLVM.and e_1 e) ⊑ LLVM.and e_1 (LLVM.xor e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm (e : IntW 77) : sub (const? (-1)) e ⊑ LLVM.xor e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm (e : IntW 27) : sub (mul (const? 9) e) e ⊑ shl e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm (e : IntW 42) : sub e (mul (const? 3) e) ⊑ mul e (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test11_thm (e e_1 : IntW 9) : icmp IntPredicate.ne (sub e_1 e) (const? 0) ⊑ icmp IntPredicate.ne e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test12_thm (e : IntW 43) : sub (const? 0) (ashr e (const? 42)) ⊑ lshr e (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test13_thm (e : IntW 79) : sub (const? 0) (lshr e (const? 78)) ⊑ ashr e (const? 78) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test16_thm (e : IntW 51) : sub (const? 0) (LLVM.sdiv e (const? 1123)) ⊑ LLVM.sdiv e (const? (-1123)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test18_thm (e : IntW 128) : sub (shl e (const? 2)) (shl e (const? 2)) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test19_thm (e e_1 : IntW 39) : add (sub e_1 e) e ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test20_thm (e e_1 : IntW 33) :
  icmp IntPredicate.ne (sub e_1 e) e_1 ⊑ icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test21_thm (e e_1 : IntW 256) :
  icmp IntPredicate.ne (sub e_1 e) e_1 ⊑ icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


