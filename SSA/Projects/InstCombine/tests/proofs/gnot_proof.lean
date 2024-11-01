
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gnot_proof
theorem test1_thm (e✝ : IntW 32) : LLVM.xor (LLVM.xor e✝ (const? (-1))) (const? (-1)) ⊑ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_ashr_not_thm (e✝ e✝¹ : IntW 32) :
  LLVM.xor (ashr (LLVM.xor e✝¹ (const? (-1))) e✝) (const? (-1)) ⊑ ashr e✝¹ e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_ashr_const_thm (e✝ : IntW 8) : LLVM.xor (ashr (const? (-42)) e✝) (const? (-1)) ⊑ lshr (const? 41) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_lshr_const_thm (e✝ : IntW 8) : LLVM.xor (lshr (const? 42) e✝) (const? (-1)) ⊑ ashr (const? (-43)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_sub_thm (e✝ : IntW 32) : LLVM.xor (sub (const? 123) e✝) (const? (-1)) ⊑ add e✝ (const? (-124)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_add_thm (e✝ : IntW 32) : LLVM.xor (add e✝ (const? 123)) (const? (-1)) ⊑ sub (const? (-124)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_or_neg_thm (e✝ e✝¹ : IntW 8) :
  LLVM.xor (LLVM.or (sub (const? 0) e✝¹) e✝) (const? (-1)) ⊑
    LLVM.and (add e✝¹ (const? (-1))) (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_select_bool_const1_thm (e✝ e✝¹ : IntW 1) :
  LLVM.xor (select e✝¹ e✝ (const? 1)) (const? 1) ⊑ select e✝¹ (LLVM.xor e✝ (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_select_bool_const4_thm (e✝ e✝¹ : IntW 1) :
  LLVM.xor (select e✝¹ (const? 0) e✝) (const? 1) ⊑ select e✝¹ (const? 1) (LLVM.xor e✝ (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_logicalAnd_not_op1_thm (e✝ e✝¹ : IntW 1) :
  LLVM.xor (select e✝¹ (LLVM.xor e✝ (const? 1)) (const? 0)) (const? 1) ⊑
    select (LLVM.xor e✝¹ (const? 1)) (const? 1) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_logicalOr_not_op1_thm (e✝ e✝¹ : IntW 1) :
  LLVM.xor (select e✝¹ (const? 1) (LLVM.xor e✝ (const? 1))) (const? 1) ⊑
    select (LLVM.xor e✝¹ (const? 1)) e✝ (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_zext_nneg_thm (e✝ : IntW 64) (e✝¹ : IntW 32) (e✝² : IntW 64) :
  sub (add e✝² (const? (-5))) (add (zext 64 (LLVM.xor e✝¹ (const? (-1)))) e✝) ⊑
    add (add e✝² (const? (-4))) (sub (sext 64 e✝¹) e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_invert_demorgan_and2_thm (e✝ : IntW 64) :
  LLVM.xor (LLVM.and (add e✝ (const? 9223372036854775807)) (const? 9223372036854775807)) (const? (-1)) ⊑
    LLVM.or (sub (const? 0) e✝) (const? (-9223372036854775808)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


