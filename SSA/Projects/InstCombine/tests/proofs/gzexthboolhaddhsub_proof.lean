
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gzexthboolhaddhsub_proof
theorem a_thm (e✝ e✝¹ : IntW 1) :
  add (add (zext 32 e✝¹) (const? 1)) (sub (const? 0) (zext 32 e✝)) ⊑
    add (select e✝¹ (const? 2) (const? 1)) (sext 32 e✝) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR30273_three_bools_thm (e✝ e✝¹ e✝² : IntW 1) :
  select e✝²
      (add (select e✝¹ (add (zext 32 e✝) (const? 1) { «nsw» := true, «nuw» := false }) (zext 32 e✝)) (const? 1)
        { «nsw» := true, «nuw» := false })
      (select e✝¹ (add (zext 32 e✝) (const? 1) { «nsw» := true, «nuw» := false }) (zext 32 e✝)) ⊑
    add (select e✝¹ (select e✝ (const? 2) (const? 1)) (zext 32 e✝)) (zext 32 e✝²)
      { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zext_add_scalar_thm (e✝ : IntW 1) : add (zext 32 e✝) (const? 42) ⊑ select e✝ (const? 43) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zext_negate_thm (e✝ : IntW 1) : sub (const? 0) (zext 64 e✝) ⊑ sext 64 e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zext_sub_const_thm (e✝ : IntW 1) : sub (const? 42) (zext 64 e✝) ⊑ select e✝ (const? 41) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_negate_thm (e✝ : IntW 1) : sub (const? 0) (sext 64 e✝) ⊑ zext 64 e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_sub_const_thm (e✝ : IntW 1) : sub (const? 42) (sext 64 e✝) ⊑ select e✝ (const? 43) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_sub_thm (e✝ : IntW 1) (e✝¹ : IntW 8) : sub e✝¹ (sext 8 e✝) ⊑ add e✝¹ (zext 8 e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_sub_nuw_thm (e✝ : IntW 1) (e✝¹ : IntW 8) :
  sub e✝¹ (sext 8 e✝) { «nsw» := false, «nuw» := true } ⊑ add e✝¹ (zext 8 e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sextbool_add_thm (e✝ : IntW 32) (e✝¹ : IntW 1) : add (sext 32 e✝¹) e✝ ⊑ add e✝ (sext 32 e✝¹) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sextbool_add_commute_thm (e✝ : IntW 1) (e✝¹ : IntW 32) :
  add (urem e✝¹ (const? 42)) (sext 32 e✝) ⊑
    add (urem e✝¹ (const? 42)) (sext 32 e✝) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


