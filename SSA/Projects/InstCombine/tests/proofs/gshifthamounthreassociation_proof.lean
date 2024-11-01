
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthamounthreassociation_proof
theorem t0_thm (e e_1 : IntW 32) :
  lshr (lshr e_1 (sub (const? 32) e)) (add e (const? (-2))) ⊑ lshr e_1 (const? 30) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t6_shl_thm (e e_1 : IntW 32) :
  shl (shl e_1 (sub (const? 32) e) { «nsw» := false, «nuw» := true }) (add e (const? (-2)))
      { «nsw» := true, «nuw» := false } ⊑
    shl e_1 (const? 30) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t7_ashr_thm (e e_1 : IntW 32) :
  ashr (ashr e_1 (sub (const? 32) e)) (add e (const? (-2))) ⊑ ashr e_1 (const? 30) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t8_lshr_exact_flag_preservation_thm (e e_1 : IntW 32) :
  lshr (lshr e_1 (sub (const? 32) e)) (add e (const? (-2))) ⊑ lshr e_1 (const? 30) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t9_ashr_exact_flag_preservation_thm (e e_1 : IntW 32) :
  ashr (ashr e_1 (sub (const? 32) e)) (add e (const? (-2))) ⊑ ashr e_1 (const? 30) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t10_shl_nuw_flag_preservation_thm (e e_1 : IntW 32) :
  shl (shl e_1 (sub (const? 32) e) { «nsw» := false, «nuw» := true }) (add e (const? (-2)))
      { «nsw» := true, «nuw» := true } ⊑
    shl e_1 (const? 30) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t11_shl_nsw_flag_preservation_thm (e e_1 : IntW 32) :
  shl (shl e_1 (sub (const? 32) e) { «nsw» := true, «nuw» := false }) (add e (const? (-2)))
      { «nsw» := true, «nuw» := true } ⊑
    shl e_1 (const? 30) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


