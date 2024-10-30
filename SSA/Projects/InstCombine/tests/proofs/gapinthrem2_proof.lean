
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthrem2_proof
theorem test1_thm : ∀ (e : IntW 333), urem e (const? 70368744177664) ⊑ LLVM.and e (const? 70368744177663) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm :
  ∀ (e : IntW 499),
    urem e (shl (const? 4096) (const? 111)) ⊑ LLVM.and e (const? 10633823966279326983230456482242756607) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm :
  ∀ (e : IntW 1) (e_1 : IntW 599),
    urem e_1 (select e (const? 70368744177664) (const? 4096)) ⊑
      LLVM.and e_1 (select e (const? 70368744177663) (const? 4095)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


