
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section glshr_proof
theorem lshr_exact_thm :
  ∀ (e : IntW 8), lshr (add (shl e (const? 2)) (const? 4)) (const? 2) ⊑ LLVM.and (add e (const? 1)) (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_thm :
  ∀ (e e_1 : IntW 8),
    lshr (add (shl e_1 (const? 2)) e) (const? 2) ⊑ LLVM.and (add (lshr e (const? 2)) e_1) (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_splat_fold_thm : ∀ (e : IntW 32), lshr (mul e (const? 65537)) (const? 16) ⊑ LLVM.and e (const? 65535) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_or_lshr_comm_thm :
  ∀ (e e_1 e_2 : IntW 32), lshr (LLVM.or e_2 (shl e_1 e)) e ⊑ lshr (LLVM.or (shl e_1 e) e_2) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_or_disjoint_lshr_comm_thm :
  ∀ (e e_1 e_2 : IntW 32), lshr (LLVM.or e_2 (shl e_1 e)) e ⊑ lshr (LLVM.or (shl e_1 e) e_2) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_xor_lshr_comm_thm :
  ∀ (e e_1 e_2 : IntW 32), lshr (LLVM.xor e_2 (shl e_1 e)) e ⊑ lshr (LLVM.xor (shl e_1 e) e_2) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_and_lshr_comm_thm :
  ∀ (e e_1 e_2 : IntW 32), lshr (LLVM.and e_2 (shl e_1 e)) e ⊑ lshr (LLVM.and (shl e_1 e) e_2) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_splat_fold_too_narrow_thm : ∀ (e : IntW 2), lshr (mul e (const? (-2))) (const? 1) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_and_odd_thm :
  ∀ (e : IntW 32), lshr (LLVM.srem e (const? 2)) (const? 31) ⊑ LLVM.and (lshr e (const? 31)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


