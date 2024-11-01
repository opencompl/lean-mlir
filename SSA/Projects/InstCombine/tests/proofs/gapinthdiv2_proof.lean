
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthdiv2_proof
theorem test1_thm (e : IntW 333) : LLVM.udiv e (const? 70368744177664) ⊑ lshr e (const? 46) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e : IntW 499) : LLVM.udiv e (shl (const? 4096) (const? 197)) ⊑ lshr e (const? 209) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e : IntW 1) (e_1 : IntW 599) :
  LLVM.udiv e_1 (select e (const? 70368744177664) (const? 4096)) ⊑ lshr e_1 (select e (const? 46) (const? 12)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


