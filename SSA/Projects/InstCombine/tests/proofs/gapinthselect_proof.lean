
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthselect_proof
theorem zext_thm (e : IntW 1) : select e (const? 1) (const? 0) ⊑ zext 41 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_thm (e : IntW 1) : select e (const? (-1)) (const? 0) ⊑ sext 41 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_zext_thm (e : IntW 1) : select e (const? 0) (const? 1) ⊑ zext 999 (LLVM.xor e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_sext_thm (e : IntW 1) : select e (const? 0) (const? (-1)) ⊑ sext 999 (LLVM.xor e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e : IntW 41) :
  select (icmp IntPredicate.slt e (const? 0)) (const? (-1)) (const? 0) ⊑ ashr e (const? 40) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e : IntW 1023) :
  select (icmp IntPredicate.slt e (const? 0)) (const? (-1)) (const? 0) ⊑ ashr e (const? 1022) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


