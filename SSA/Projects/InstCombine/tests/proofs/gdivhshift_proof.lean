
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gdivhshift_proof
theorem t1_thm (e✝ : IntW 32) (e✝¹ : IntW 16) :
  LLVM.sdiv (zext 32 e✝¹) (shl (const? 2) e✝) ⊑ lshr (zext 32 e✝¹) (add e✝ (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_thm (e✝ : IntW 32) (e✝¹ : IntW 64) :
  LLVM.udiv e✝¹ (zext 64 (shl (const? 1) e✝)) ⊑ lshr e✝¹ (zext 64 e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t3_thm (e✝ : IntW 32) (e✝¹ : IntW 64) :
  LLVM.udiv e✝¹ (zext 64 (shl (const? 4) e✝)) ⊑ lshr e✝¹ (zext 64 (add e✝ (const? 2))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t5_thm (e✝ e✝¹ : IntW 1) (e✝² : IntW 32) :
  LLVM.udiv e✝² (select e✝¹ (select e✝ (const? 32) (const? 64)) (shl (const? 1) e✝²)) ⊑
    lshr e✝² (select e✝¹ (select e✝ (const? 5) (const? 6)) e✝²) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t7_thm (e✝ : IntW 32) :
  LLVM.sdiv (shl e✝ (const? 2) { «nsw» := true, «nuw» := false }) e✝ ⊑ const? 4 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t10_thm (e✝ e✝¹ : IntW 32) :
  LLVM.sdiv (shl e✝¹ e✝ { «nsw» := true, «nuw» := false }) e✝¹ ⊑
    shl (const? 1) e✝ { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t12_thm (e✝ : IntW 32) :
  LLVM.udiv (shl e✝ (const? 2) { «nsw» := false, «nuw» := true }) e✝ ⊑ const? 4 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t15_thm (e✝ e✝¹ : IntW 32) :
  LLVM.udiv (shl e✝¹ e✝ { «nsw» := false, «nuw» := true }) e✝¹ ⊑
    shl (const? 1) e✝ { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_mul_shl_nsw_thm (e✝ e✝¹ e✝² : IntW 5) :
  LLVM.sdiv (mul e✝² e✝¹ { «nsw» := true, «nuw» := false }) (shl e✝² e✝ { «nsw» := true, «nuw» := false }) ⊑
    LLVM.sdiv e✝¹ (shl (const? 1) e✝ { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_mul_shl_nsw_exact_commute1_thm (e✝ e✝¹ e✝² : IntW 5) :
  LLVM.sdiv (mul e✝² e✝¹ { «nsw» := true, «nuw» := false }) (shl e✝¹ e✝ { «nsw» := true, «nuw» := false }) ⊑
    LLVM.sdiv e✝² (shl (const? 1) e✝ { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_mul_shl_nuw_thm (e✝ e✝¹ e✝² : IntW 5) :
  LLVM.udiv (mul e✝² e✝¹ { «nsw» := false, «nuw» := true }) (shl e✝² e✝ { «nsw» := false, «nuw» := true }) ⊑
    lshr e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_mul_shl_nuw_exact_commute1_thm (e✝ e✝¹ e✝² : IntW 5) :
  LLVM.udiv (mul e✝² e✝¹ { «nsw» := false, «nuw» := true }) (shl e✝¹ e✝ { «nsw» := false, «nuw» := true }) ⊑
    lshr e✝² e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_mul_nuw_thm (e✝ e✝¹ e✝² : IntW 5) :
  LLVM.udiv (shl e✝² e✝¹ { «nsw» := false, «nuw» := true }) (mul e✝² e✝ { «nsw» := false, «nuw» := true }) ⊑
    LLVM.udiv (shl (const? 1) e✝¹ { «nsw» := false, «nuw» := true }) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_mul_nuw_swap_thm (e✝ e✝¹ e✝² : IntW 5) :
  LLVM.udiv (shl e✝² e✝¹ { «nsw» := false, «nuw» := true }) (mul e✝ e✝² { «nsw» := false, «nuw» := true }) ⊑
    LLVM.udiv (shl (const? 1) e✝¹ { «nsw» := false, «nuw» := true }) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_mul_nuw_exact_thm (e✝ e✝¹ e✝² : IntW 5) :
  LLVM.udiv (shl e✝² e✝¹ { «nsw» := false, «nuw» := true }) (mul e✝² e✝ { «nsw» := false, «nuw» := true }) ⊑
    LLVM.udiv (shl (const? 1) e✝¹ { «nsw» := false, «nuw» := true }) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_lshr_mul_nuw_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.udiv (lshr (mul e✝² e✝¹ { «nsw» := false, «nuw» := true }) e✝) e✝² ⊑ lshr e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_shl_shl_nsw2_nuw_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.sdiv (shl e✝² e✝¹ { «nsw» := true, «nuw» := false }) (shl e✝ e✝¹ { «nsw» := true, «nuw» := true }) ⊑
    LLVM.sdiv e✝² e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_shl_nuw_nsw2_thm (e✝ e✝¹ e✝² : IntW 8) :
  LLVM.udiv (shl e✝² e✝¹ { «nsw» := true, «nuw» := true }) (shl e✝ e✝¹ { «nsw» := true, «nuw» := false }) ⊑
    LLVM.udiv e✝² e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_shl_pair_const_thm (e✝ : IntW 32) :
  LLVM.sdiv (shl e✝ (const? 2) { «nsw» := true, «nuw» := false })
      (shl e✝ (const? 1) { «nsw» := true, «nuw» := false }) ⊑
    const? 2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_pair_const_thm (e✝ : IntW 32) :
  LLVM.udiv (shl e✝ (const? 2) { «nsw» := false, «nuw» := true })
      (shl e✝ (const? 1) { «nsw» := false, «nuw» := true }) ⊑
    const? 2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_shl_pair1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.sdiv (shl e✝² e✝¹ { «nsw» := true, «nuw» := false }) (shl e✝² e✝ { «nsw» := true, «nuw» := true }) ⊑
    lshr (shl (const? 1) e✝¹ { «nsw» := true, «nuw» := true }) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_shl_pair2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.sdiv (shl e✝² e✝¹ { «nsw» := true, «nuw» := true }) (shl e✝² e✝ { «nsw» := true, «nuw» := false }) ⊑
    lshr (shl (const? 1) e✝¹ { «nsw» := true, «nuw» := true }) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_shl_pair3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.sdiv (shl e✝² e✝¹ { «nsw» := true, «nuw» := false }) (shl e✝² e✝ { «nsw» := true, «nuw» := false }) ⊑
    lshr (shl (const? 1) e✝¹ { «nsw» := false, «nuw» := true }) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_pair1_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.udiv (shl e✝² e✝¹ { «nsw» := false, «nuw» := true }) (shl e✝² e✝ { «nsw» := false, «nuw» := true }) ⊑
    lshr (shl (const? 1) e✝¹ { «nsw» := false, «nuw» := true }) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_pair2_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.udiv (shl e✝² e✝¹ { «nsw» := true, «nuw» := true }) (shl e✝² e✝ { «nsw» := false, «nuw» := true }) ⊑
    lshr (shl (const? 1) e✝¹ { «nsw» := true, «nuw» := true }) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_shl_pair3_thm (e✝ e✝¹ e✝² : IntW 32) :
  LLVM.udiv (shl e✝² e✝¹ { «nsw» := false, «nuw» := true }) (shl e✝² e✝ { «nsw» := true, «nuw» := true }) ⊑
    lshr (shl (const? 1) e✝¹ { «nsw» := false, «nuw» := true }) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


