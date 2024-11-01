
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcasthset_proof
theorem test5_thm (e : IntW 16) : trunc 16 (LLVM.and (sext 32 e) (const? 15)) ⊑ LLVM.and e (const? 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_thm (e : IntW 1) : icmp IntPredicate.ne (zext 32 e) (const? 0) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6a_thm (e : IntW 1) : icmp IntPredicate.ne (zext 32 e) (const? (-1)) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


