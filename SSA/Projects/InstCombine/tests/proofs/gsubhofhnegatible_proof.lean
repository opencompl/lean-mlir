
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubhofhnegatible_proof
theorem t0_thm (e✝ : IntW 8) : sub e✝ (const? (-42)) ⊑ add e✝ (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t2_thm (e✝ e✝¹ : IntW 8) : sub e✝¹ (shl (const? (-42)) e✝) ⊑ add (shl (const? 42) e✝) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t4_thm (e✝ : IntW 1) (e✝¹ : IntW 8) :
  sub e✝¹ (select e✝ (const? (-42)) (const? 44)) ⊑ add (select e✝ (const? 42) (const? (-44))) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR52261_thm (e✝ : IntW 1) :
  LLVM.and (select e✝ (const? 2) (const? (-2)))
      (sub (const? 0) (select e✝ (const? 2) (const? (-2))) { «nsw» := true, «nuw» := false }) ⊑
    const? 2 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t7_thm (e✝ : IntW 8) (e✝¹ : IntW 1) (e✝² : IntW 8) :
  sub e✝² (select e✝¹ (const? 0) (shl (const? 1) e✝)) ⊑
    add (select e✝¹ (const? 0) (shl (const? (-1)) e✝ { «nsw» := true, «nuw» := false })) e✝² := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t9_thm (e✝ e✝¹ : IntW 8) : sub (const? 0) (sub e✝¹ e✝) ⊑ sub e✝ e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_of_sub_from_constant_thm (e✝ : IntW 8) : sub (const? 0) (sub (const? 42) e✝) ⊑ add e✝ (const? (-42)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_from_constant_of_sub_from_constant_thm (e✝ : IntW 8) : sub (const? 11) (sub (const? 42) e✝) ⊑ add e✝ (const? (-31)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_from_variable_of_sub_from_constant_thm (e✝ e✝¹ : IntW 8) : sub e✝¹ (sub (const? 42) e✝) ⊑ add (add e✝ (const? (-42))) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_of_add_with_constant_thm (e✝ : IntW 8) : sub (const? 0) (add e✝ (const? 42)) ⊑ sub (const? (-42)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_from_constant_of_add_with_constant_thm (e✝ : IntW 8) : sub (const? 11) (add e✝ (const? 42)) ⊑ sub (const? (-31)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t20_thm (e✝ : IntW 16) (e✝¹ : IntW 8) :
  sub e✝¹ (trunc 8 (shl (const? (-42)) e✝)) ⊑ add e✝¹ (trunc 8 (shl (const? 42) e✝)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negate_xor_thm (e✝ : IntW 4) :
  sub (const? 0) (LLVM.xor e✝ (const? 5)) ⊑ add (LLVM.xor e✝ (const? (-6))) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negate_shl_xor_thm (e✝ e✝¹ : IntW 4) :
  sub (const? 0) (shl (LLVM.xor e✝¹ (const? 5)) e✝) ⊑ shl (add (LLVM.xor e✝¹ (const? (-6))) (const? 1)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negate_sdiv_thm (e✝ e✝¹ : IntW 8) :
  sub e✝¹ (LLVM.sdiv e✝ (const? 42)) ⊑ add (LLVM.sdiv e✝ (const? (-42))) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negate_ashr_thm (e✝ e✝¹ : IntW 8) : sub e✝¹ (ashr e✝ (const? 7)) ⊑ add (lshr e✝ (const? 7)) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negate_lshr_thm (e✝ e✝¹ : IntW 8) : sub e✝¹ (lshr e✝ (const? 7)) ⊑ add (ashr e✝ (const? 7)) e✝¹ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negate_sext_thm (e✝ : IntW 1) (e✝¹ : IntW 8) : sub e✝¹ (sext 8 e✝) ⊑ add e✝¹ (zext 8 e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negate_zext_thm (e✝ : IntW 1) (e✝¹ : IntW 8) : sub e✝¹ (zext 8 e✝) ⊑ add e✝¹ (sext 8 e✝) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negation_of_increment_via_or_with_no_common_bits_set_thm (e✝ e✝¹ : IntW 8) :
  sub e✝¹ (LLVM.or (shl e✝ (const? 1)) (const? 1)) ⊑ add e✝¹ (LLVM.xor (shl e✝ (const? 1)) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negation_of_increment_via_or_disjoint_thm (e✝ e✝¹ : IntW 8) : sub e✝¹ (LLVM.or e✝ (const? 1)) ⊑ add e✝¹ (LLVM.xor e✝ (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negate_add_with_single_negatible_operand_thm (e✝ : IntW 8) : sub (const? 0) (add e✝ (const? 42)) ⊑ sub (const? (-42)) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negate_add_with_single_negatible_operand_depth2_thm (e✝ e✝¹ : IntW 8) :
  sub (const? 0) (mul (add e✝¹ (const? 21)) e✝) ⊑ mul (sub (const? (-21)) e✝¹) e✝ := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


