
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthsafehtransforms_proof
theorem bools_logical_commute0_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select (LLVM.xor e_2 (const? 1)) e_1 (const? 0)) (const? 1) (select e_2 e (const? 0)) ⊑
      select e_2 e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute0_and1_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (LLVM.and (LLVM.xor e_2 (const? 1)) e_1) (const? 1) (select e_2 e (const? 0)) ⊑ select e_2 e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute0_and2_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select (LLVM.xor e_2 (const? 1)) e_1 (const? 0)) (const? 1) (LLVM.and e_2 e) ⊑ select e_2 e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute0_and1_and2_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (LLVM.and (LLVM.xor e_2 (const? 1)) e_1) (const? 1) (LLVM.and e_2 e) ⊑ select e_2 e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute1_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select e_2 (LLVM.xor e_1 (const? 1)) (const? 0)) (const? 1) (select e_1 e (const? 0)) ⊑
      select e_1 e e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute1_and2_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select e_2 (LLVM.xor e_1 (const? 1)) (const? 0)) (const? 1) (LLVM.and e_1 e) ⊑ select e_1 e e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools_logical_commute3_and2_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select e_2 (LLVM.xor e_1 (const? 1)) (const? 0)) (const? 1) (LLVM.and e e_1) ⊑ select e_1 e e_2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute0_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select e_2 e_1 (const? 0)) (const? 1) (select (LLVM.xor e_2 (const? 1)) e (const? 0)) ⊑
      select e_2 e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute0_and1_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (LLVM.and e_2 e_1) (const? 1) (select (LLVM.xor e_2 (const? 1)) e (const? 0)) ⊑ select e_2 e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute0_and2_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select e_2 e_1 (const? 0)) (const? 1) (LLVM.and (LLVM.xor e_2 (const? 1)) e) ⊑ select e_2 e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute0_and1_and2_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (LLVM.and e_2 e_1) (const? 1) (LLVM.and (LLVM.xor e_2 (const? 1)) e) ⊑ select e_2 e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute1_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select e_2 e_1 (const? 0)) (const? 1) (select (LLVM.xor e_1 (const? 1)) e (const? 0)) ⊑
      select e_1 e_2 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute1_and1_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (LLVM.and e_2 e_1) (const? 1) (select (LLVM.xor e_1 (const? 1)) e (const? 0)) ⊑ select e_1 e_2 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute1_and2_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select e_2 e_1 (const? 0)) (const? 1) (LLVM.and (LLVM.xor e_1 (const? 1)) e) ⊑ select e_1 e_2 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute1_and1_and2_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (LLVM.and e_2 e_1) (const? 1) (LLVM.and (LLVM.xor e_1 (const? 1)) e) ⊑ select e_1 e_2 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute2_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select e_2 e_1 (const? 0)) (const? 1) (select e (LLVM.xor e_2 (const? 1)) (const? 0)) ⊑
      select e_2 e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute2_and1_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (LLVM.and e_2 e_1) (const? 1) (select e (LLVM.xor e_2 (const? 1)) (const? 0)) ⊑ select e_2 e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute3_nopoison_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (select e_2 e_1 (const? 0)) (const? 1) (select e (LLVM.xor e_1 (const? 1)) (const? 0)) ⊑
      select e_1 e_2 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem bools2_logical_commute3_and1_thm :
  ∀ (e e_1 e_2 : IntW 1),
    select (LLVM.and e_2 e_1) (const? 1) (select e (LLVM.xor e_1 (const? 1)) (const? 0)) ⊑ select e_1 e_2 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


