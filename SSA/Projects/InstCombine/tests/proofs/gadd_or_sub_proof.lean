
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gadd_or_sub_proof
theorem add_or_sub_comb_i32_commuted1_nuw_thm : ∀ (e : IntW 32), add (LLVM.or (sub (const? 0) e) e) e ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_or_sub_comb_i8_commuted2_nsw_thm :
  ∀ (e : IntW 8),
    add (mul e e) (LLVM.or (sub (const? 0) (mul e e)) (mul e e)) ⊑
      LLVM.and (add (mul e e) (const? (-1))) (mul e e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_or_sub_comb_i128_commuted3_nuw_nsw_thm : ∀ (e : IntW 128), add (LLVM.or (mul e e) (sub (const? 0) (mul e e))) (mul e e) ⊑ mul e e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_or_sub_comb_i64_commuted4_thm :
  ∀ (e : IntW 64),
    add (mul e e) (LLVM.or (mul e e) (sub (const? 0) (mul e e))) ⊑
      LLVM.and (add (mul e e) (const? (-1))) (mul e e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


