
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gashrhdemand_proof
theorem srem2_ashr_mask_thm :
  ∀ (e : IntW 32),
    LLVM.and (ashr (LLVM.srem e (const? 2)) (const? 31)) (const? 2) ⊑
      LLVM.and (LLVM.srem e (const? 2)) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_can_be_lshr_thm : ∀ (e : IntW 32), trunc 16 (ashr e (const? 16)) ⊑ trunc 16 (lshr e (const? 16)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_can_be_lshr_2_thm :
  ∀ (e : IntW 32),
    trunc 32 (ashr (shl (LLVM.or (zext 64 e) (const? 4278190080)) (const? 34)) (const? 32)) ⊑
      LLVM.or (shl e (const? 2)) (const? (-67108864)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


