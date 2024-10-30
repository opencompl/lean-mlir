
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshlhbo_proof
theorem lshr_add_thm :
  ∀ (e e_1 : IntW 8),
    shl (add (lshr e_1 (const? 5)) (LLVM.srem e (const? 42))) (const? 5) ⊑
      LLVM.and (add (shl (LLVM.srem e (const? 42)) (const? 5)) e_1) (const? (-32)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_and_thm :
  ∀ (e e_1 : IntW 8),
    shl (LLVM.and (lshr e_1 (const? 6)) (LLVM.srem e (const? 42))) (const? 6) ⊑
      LLVM.and (shl (LLVM.srem e (const? 42)) (const? 6)) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_or_thm :
  ∀ (e e_1 : IntW 8),
    shl (LLVM.or (LLVM.srem e_1 (const? 42)) (lshr e (const? 4))) (const? 4) ⊑
      LLVM.or (shl (LLVM.srem e_1 (const? 42)) (const? 4)) (LLVM.and e (const? (-16))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_xor_thm :
  ∀ (e e_1 : IntW 8),
    shl (LLVM.xor (lshr e_1 (const? 3)) (LLVM.srem e (const? 42))) (const? 3) ⊑
      LLVM.xor (shl (LLVM.srem e (const? 42)) (const? 3)) (LLVM.and e_1 (const? (-8))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_and_add_thm :
  ∀ (e e_1 : IntW 8),
    shl (add (LLVM.srem e_1 (const? 42)) (LLVM.and (lshr e (const? 3)) (const? 12))) (const? 3) ⊑
      add (LLVM.and e (const? 96)) (shl (LLVM.srem e_1 (const? 42)) (const? 3)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_and_and_thm :
  ∀ (e e_1 : IntW 8),
    shl (LLVM.and (LLVM.and (lshr e_1 (const? 2)) (const? 13)) (LLVM.srem e (const? 42))) (const? 2) ⊑
      LLVM.and (LLVM.and e_1 (const? 52)) (shl (LLVM.srem e (const? 42)) (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_and_or_thm :
  ∀ (e e_1 : IntW 8),
    shl (LLVM.or (LLVM.srem e_1 (const? 42)) (LLVM.and (lshr e (const? 2)) (const? 13))) (const? 2) ⊑
      LLVM.or (LLVM.and e (const? 52)) (shl (LLVM.srem e_1 (const? 42)) (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_and_or_disjoint_thm :
  ∀ (e e_1 : IntW 8),
    shl (LLVM.or (LLVM.srem e_1 (const? 42)) (LLVM.and (lshr e (const? 2)) (const? 13))) (const? 2) ⊑
      LLVM.or (LLVM.and e (const? 52)) (shl (LLVM.srem e_1 (const? 42)) (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_and_or_disjoint_thm :
  ∀ (e e_1 : IntW 8),
    shl (LLVM.or (LLVM.srem e_1 (const? 42)) (LLVM.and (ashr e (const? 2)) (const? 13))) (const? 2) ⊑
      LLVM.or (LLVM.and e (const? 52)) (shl (LLVM.srem e_1 (const? 42)) (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_and_xor_thm :
  ∀ (e e_1 : IntW 8),
    shl (LLVM.xor (LLVM.and (lshr e_1 (const? 2)) (const? 13)) (LLVM.srem e (const? 42))) (const? 2) ⊑
      LLVM.xor (LLVM.and e_1 (const? 52)) (shl (LLVM.srem e (const? 42)) (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem lshr_add_and_shl_thm :
  ∀ (e e_1 : IntW 32),
    shl (add e_1 (LLVM.and (lshr e (const? 5)) (const? 127))) (const? 5) ⊑
      add (LLVM.and e (const? 4064)) (shl e_1 (const? 5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_and_lshr_thm :
  ∀ (e e_1 : IntW 32),
    shl (add (LLVM.and (lshr e_1 (const? 4)) (const? 8)) e) (const? 4) ⊑
      add (LLVM.and e_1 (const? 128)) (shl e (const? 4)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


