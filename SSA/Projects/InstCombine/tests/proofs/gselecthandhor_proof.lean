
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthandhor_proof
theorem logical_and_not_thm (e e_1 : IntW 1) : select e_1 (const? 0) e ⊑ select (LLVM.xor e_1 (const? 1)) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_not_thm (e e_1 : IntW 1) : select e_1 e (const? 1) ⊑ select (LLVM.xor e_1 (const? 1)) (const? 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_cond_reuse_thm (e e_1 : IntW 1) : select e_1 e e_1 ⊑ select e_1 e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_cond_reuse_thm (e e_1 : IntW 1) : select e_1 e_1 e ⊑ select e_1 (const? 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_not_cond_reuse_thm (e e_1 : IntW 1) :
  select e_1 e (LLVM.xor e_1 (const? 1)) ⊑ select (LLVM.xor e_1 (const? 1)) (const? 1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_not_cond_reuse_thm (e e_1 : IntW 1) :
  select e_1 (LLVM.xor e_1 (const? 1)) e ⊑ select (LLVM.xor e_1 (const? 1)) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_or_noundef_b_thm (e e_1 : IntW 1) : select e_1 (const? 1) e ⊑ LLVM.or e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem logical_and_noundef_b_thm (e e_1 : IntW 1) : select e_1 e (const? 0) ⊑ LLVM.and e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_not_true_thm (e e_1 : IntW 1) :
  select (LLVM.xor e_1 (const? 1)) (LLVM.xor e (const? 1)) (const? 1) ⊑
    select e_1 (const? 1) (LLVM.xor e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_not_false_thm (e e_1 : IntW 1) :
  select (LLVM.xor e_1 (const? 1)) (LLVM.xor e (const? 1)) (const? 0) ⊑
    LLVM.xor (select e_1 (const? 1) e) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_true_not_thm (e e_1 : IntW 1) :
  select (LLVM.xor e_1 (const? 1)) (const? 1) (LLVM.xor e (const? 1)) ⊑
    LLVM.xor (select e_1 e (const? 0)) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_false_not_thm (e e_1 : IntW 1) :
  select (LLVM.xor e_1 (const? 1)) (const? 0) (LLVM.xor e (const? 1)) ⊑
    select e_1 (LLVM.xor e (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or1_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or (LLVM.xor e_2 (const? 1)) e_1) e_2 e ⊑ select e_2 (select e_1 (const? 1) e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or2_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and (LLVM.xor e_2 (const? 1)) e_1) e e_1 ⊑ select e_1 (select e_2 (const? 1) e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or1_commuted_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 (LLVM.xor e_1 (const? 1))) e_1 e ⊑ select e_1 (select e_2 (const? 1) e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or2_commuted_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_2 (LLVM.xor e_1 (const? 1))) e e_2 ⊑ select e_2 (select e_1 (const? 1) e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or1_wrong_operand_thm (e e_1 e_2 e_3 : IntW 1) :
  select (LLVM.or (LLVM.xor e_3 (const? 1)) e_2) e_1 e ⊑ select (LLVM.or e_2 (LLVM.xor e_3 (const? 1))) e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_or2_wrong_operand_thm (e e_1 e_2 e_3 : IntW 1) :
  select (LLVM.and (LLVM.xor e_3 (const? 1)) e_2) e_1 e ⊑ select (LLVM.and e_2 (LLVM.xor e_3 (const? 1))) e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and1_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and (LLVM.xor e_2 (const? 1)) e_1) e e_2 ⊑ select e_2 (const? 1) (select e_1 e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and2_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or (LLVM.xor e_2 (const? 1)) e_1) e_1 e ⊑ select e_1 (const? 1) (select e_2 e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and1_commuted_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_2 (LLVM.xor e_1 (const? 1))) e e_1 ⊑ select e_1 (const? 1) (select e_2 e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_and2_commuted_thm (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 (LLVM.xor e_1 (const? 1))) e_2 e ⊑ select e_2 (const? 1) (select e_1 e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem pr64558_thm (e e_1 : IntW 1) : select (LLVM.and (LLVM.xor e_1 (const? 1)) e) e e_1 ⊑ LLVM.or e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


