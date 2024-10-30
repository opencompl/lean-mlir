
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section glogicalhselecthinseltpoison_proof
theorem bools_thm :
  ∀ (e e_1 e_2 : IntW 1), LLVM.or (LLVM.and (LLVM.xor e_2 (const? 1)) e_1) (LLVM.and e_2 e) ⊑ select e_2 e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select (LLVM.xor e_2 (const? 1)) e_1 (const? 0)) (const? 1) (select e_2 e (const? 0)) ⊑
      select e_2 e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_multi_uses1_thm :
  ∀ (e e_1 e_2 : IntW 1),
    LLVM.xor (LLVM.or (LLVM.and (LLVM.xor e_2 (const? 1)) e_1) (LLVM.and e_2 e))
        (LLVM.and (LLVM.xor e_2 (const? 1)) e_1) ⊑
      LLVM.xor (select e_2 e e_1) (LLVM.and e_1 (LLVM.xor e_2 (const? 1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_multi_uses1_logical_thm :
  ∀ (e e_1 e_2 : IntW 1),
    LLVM.xor (select (select (LLVM.xor e_2 (const? 1)) e_1 (const? 0)) (const? 1) (select e_2 e (const? 0)))
        (select (LLVM.xor e_2 (const? 1)) e_1 (const? 0)) ⊑
      LLVM.xor (select e_2 e e_1) (select (LLVM.xor e_2 (const? 1)) e_1 (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_multi_uses2_thm :
  ∀ (e e_1 e_2 : IntW 1),
    LLVM.and (LLVM.or (LLVM.and (LLVM.xor e_2 (const? 1)) e_1) (LLVM.and e_2 e))
        (add (LLVM.and (LLVM.xor e_2 (const? 1)) e_1) (LLVM.and e_2 e)) ⊑
      select e_2 e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_multi_uses2_logical_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select (select (LLVM.xor e_2 (const? 1)) e_1 (const? 0)) (const? 1) (select e_2 e (const? 0)))
        (add (select (LLVM.xor e_2 (const? 1)) e_1 (const? 0)) (select e_2 e (const? 0))) (const? 0) ⊑
      select (select e_2 e e_1) (LLVM.xor (select (LLVM.xor e_2 (const? 1)) e_1 (const? 0)) (select e_2 e (const? 0)))
        (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


