
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthandhorhand_proof
theorem test1_thm :
  ∀ (e e_1 : IntW 17),
    LLVM.and (LLVM.or (LLVM.and e_1 (const? 7)) (LLVM.and e (const? 8))) (const? 7) ⊑ LLVM.and e_1 (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm :
  ∀ (e e_1 : IntW 49), LLVM.and (LLVM.or e_1 (shl e (const? 1))) (const? 1) ⊑ LLVM.and e_1 (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm :
  ∀ (e e_1 : IntW 67), LLVM.and (LLVM.or e_1 (lshr e (const? 66))) (const? 2) ⊑ LLVM.and e_1 (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_test1_thm : ∀ (e : IntW 231), LLVM.or (LLVM.and e (const? 1)) (const? 1) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_test2_thm : ∀ (e : IntW 7), LLVM.or (shl e (const? 6)) (const? (-64)) ⊑ const? (-64) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


