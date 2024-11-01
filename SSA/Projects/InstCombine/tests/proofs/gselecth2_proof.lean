
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecth2_proof
theorem ashr_exact_poison_constant_fold_thm (e✝ : IntW 8) (e✝¹ : IntW 1) :
  ashr (select e✝¹ e✝ (const? 42)) (const? 3) ⊑ select e✝¹ (ashr e✝ (const? 3)) (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_exact_thm (e✝ : IntW 8) (e✝¹ : IntW 1) :
  ashr (select e✝¹ e✝ (const? 16)) (const? 3) ⊑ select e✝¹ (ashr e✝ (const? 3)) (const? 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_nuw_poison_constant_fold_thm (e✝ : IntW 8) (e✝¹ : IntW 1) :
  shl (const? 16) (select e✝¹ (const? 3) e✝) { «nsw» := true, «nuw» := true } ⊑
    select e✝¹ (const? (-128)) (shl (const? 16) e✝ { «nsw» := true, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_nsw_nuw_thm (e✝ : IntW 8) (e✝¹ : IntW 1) :
  shl (const? 7) (select e✝¹ (const? 3) e✝) { «nsw» := true, «nuw» := true } ⊑
    select e✝¹ (const? 56) (shl (const? 7) e✝ { «nsw» := true, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nsw_poison_constant_fold_thm (e✝ : IntW 8) (e✝¹ : IntW 1) :
  add (select e✝¹ e✝ (const? 65)) (const? 64) { «nsw» := true, «nuw» := false } ⊑
    select e✝¹ (add e✝ (const? 64) { «nsw» := true, «nuw» := false }) (const? (-127)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nsw_thm (e✝ : IntW 8) (e✝¹ : IntW 1) :
  add (select e✝¹ e✝ (const? 7)) (const? 64) { «nsw» := true, «nuw» := false } ⊑
    select e✝¹ (add e✝ (const? 64) { «nsw» := true, «nuw» := false }) (const? 71) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


