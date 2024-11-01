
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthdiv1_proof
theorem test1_thm (e : IntW 33) : LLVM.udiv e (const? 4096) ⊑ lshr e (const? 12) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e : IntW 49) : LLVM.udiv e (shl (const? 4096) (const? 17)) ⊑ lshr e (const? 29) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e : IntW 1) (e_1 : IntW 59) :
  LLVM.udiv e_1 (select e (const? 1024) (const? 4096)) ⊑ lshr e_1 (select e (const? 10) (const? 12)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


