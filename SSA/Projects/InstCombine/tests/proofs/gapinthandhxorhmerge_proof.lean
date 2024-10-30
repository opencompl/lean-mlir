
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthandhxorhmerge_proof
theorem test1_thm :
  ∀ (e e_1 e_2 : IntW 57), LLVM.xor (LLVM.and e_2 e_1) (LLVM.and e_2 e) ⊑ LLVM.and (LLVM.xor e_1 e) e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm : ∀ (e e_1 : IntW 23), LLVM.xor (LLVM.and e_1 e) (LLVM.or e_1 e) ⊑ LLVM.xor e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


