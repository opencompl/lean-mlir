
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthdivrem_proof
theorem udiv_common_divisor_thm :
  ∀ (e e_1 e_2 : IntW 5) (e_3 : IntW 1),
    select e_3 (LLVM.udiv e_2 e_1) (LLVM.udiv e e_1) ⊑ LLVM.udiv (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_common_divisor_thm :
  ∀ (e e_1 e_2 : IntW 5) (e_3 : IntW 1), select e_3 (urem e_2 e_1) (urem e e_1) ⊑ urem (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_common_divisor_defined_cond_thm :
  ∀ (e e_1 e_2 : IntW 5) (e_3 : IntW 1),
    select e_3 (LLVM.sdiv e_2 e_1) (LLVM.sdiv e e_1) ⊑ LLVM.sdiv (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem srem_common_divisor_defined_cond_thm :
  ∀ (e e_1 e_2 : IntW 5) (e_3 : IntW 1),
    select e_3 (LLVM.srem e_2 e_1) (LLVM.srem e e_1) ⊑ LLVM.srem (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_common_divisor_defined_cond_thm :
  ∀ (e e_1 e_2 : IntW 5) (e_3 : IntW 1),
    select e_3 (LLVM.udiv e_2 e_1) (LLVM.udiv e e_1) ⊑ LLVM.udiv (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_common_divisor_defined_cond_thm :
  ∀ (e e_1 e_2 : IntW 5) (e_3 : IntW 1), select e_3 (urem e_2 e_1) (urem e e_1) ⊑ urem (select e_3 e_2 e) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_common_dividend_defined_cond_thm :
  ∀ (e e_1 e_2 : IntW 5) (e_3 : IntW 1),
    select e_3 (LLVM.sdiv e_2 e_1) (LLVM.sdiv e_2 e) ⊑ LLVM.sdiv e_2 (select e_3 e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem srem_common_dividend_defined_cond_thm :
  ∀ (e e_1 e_2 : IntW 5) (e_3 : IntW 1),
    select e_3 (LLVM.srem e_2 e_1) (LLVM.srem e_2 e) ⊑ LLVM.srem e_2 (select e_3 e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_common_dividend_defined_cond_thm :
  ∀ (e e_1 e_2 : IntW 5) (e_3 : IntW 1),
    select e_3 (LLVM.udiv e_2 e_1) (LLVM.udiv e_2 e) ⊑ LLVM.udiv e_2 (select e_3 e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem urem_common_dividend_defined_cond_thm :
  ∀ (e e_1 e_2 : IntW 5) (e_3 : IntW 1), select e_3 (urem e_2 e_1) (urem e_2 e) ⊑ urem e_2 (select e_3 e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


