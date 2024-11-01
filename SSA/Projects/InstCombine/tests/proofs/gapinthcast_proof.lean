
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gapinthcast_proof
theorem test1_thm (e✝ : IntW 17) :
  trunc 17 (LLVM.or (lshr (zext 37 e✝) (const? 8)) (shl (zext 37 e✝) (const? 8))) ⊑
    LLVM.or (lshr e✝ (const? 8)) (shl e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e✝ : IntW 167) :
  trunc 167 (LLVM.or (lshr (zext 577 e✝) (const? 9)) (shl (zext 577 e✝) (const? 8))) ⊑
    LLVM.or (lshr e✝ (const? 9)) (shl e✝ (const? 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


