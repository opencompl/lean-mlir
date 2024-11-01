
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsetcchstrengthhreduce_proof
theorem test1_thm (e : IntW 32) : icmp IntPredicate.uge e (const? 1) ⊑ icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e : IntW 32) : icmp IntPredicate.ugt e (const? 0) ⊑ icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e : IntW 8) :
  icmp IntPredicate.sge e (const? (-127)) ⊑ icmp IntPredicate.ne e (const? (-128)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e : IntW 8) : icmp IntPredicate.sle e (const? 126) ⊑ icmp IntPredicate.ne e (const? 127) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e : IntW 8) : icmp IntPredicate.slt e (const? 127) ⊑ icmp IntPredicate.ne e (const? 127) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


