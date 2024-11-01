
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2012h08h28hudiv_ashl_proof
theorem udiv400_thm (e : IntW 32) : LLVM.udiv (lshr e (const? 2)) (const? 100) ⊑ LLVM.udiv e (const? 400) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv400_yes_thm (e : IntW 32) : LLVM.sdiv (lshr e (const? 2)) (const? 100) ⊑ LLVM.udiv e (const? 400) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_i80_thm (e : IntW 80) : LLVM.udiv (lshr e (const? 2)) (const? 100) ⊑ LLVM.udiv e (const? 400) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


