
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gandhxorhmerge_proof
theorem test1_thm (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.and e_2 e_1) (LLVM.and e_2 e) ⊑ LLVM.and e_2 (LLVM.xor e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e e_1 : IntW 32) : LLVM.xor (LLVM.and e_1 e) (LLVM.or e_1 e) ⊑ LLVM.xor e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR75692_1_thm (e : IntW 32) : LLVM.and (LLVM.xor e (const? 4)) (LLVM.xor e (const? (-5))) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


