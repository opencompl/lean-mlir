
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthshifthsimplify_proof
theorem test0_thm (e e_1 e_2 : IntW 41) : LLVM.and (shl e_2 e_1) (shl e e_1) ⊑ shl (LLVM.and e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test1_thm (e e_1 e_2 : IntW 57) : LLVM.or (lshr e_2 e_1) (lshr e e_1) ⊑ lshr (LLVM.or e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e e_1 e_2 : IntW 49) : LLVM.xor (ashr e_2 e_1) (ashr e e_1) ⊑ ashr (LLVM.xor e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


