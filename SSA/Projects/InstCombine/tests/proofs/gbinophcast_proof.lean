
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gbinophcast_proof
theorem and_sext_to_sel_thm (e : IntW 32) (e_1 : IntW 1) : LLVM.and (sext 32 e_1) e ⊑ select e_1 e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_sext_to_sel_thm (e : IntW 32) (e_1 : IntW 1) : LLVM.or (sext 32 e_1) e ⊑ select e_1 (const? (-1)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_sext_to_sel_thm (e : IntW 32) (e_1 : IntW 1) : LLVM.xor (sext 32 e_1) e ⊑ LLVM.xor e (sext 32 e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_add_bool_to_select_thm (e : IntW 32) (e_1 : IntW 1) :
  LLVM.and (add (const? (-1)) (zext 32 e_1)) e ⊑ select e_1 (const? 0) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem and_add_bool_to_select_multi_use_thm (e : IntW 32) (e_1 : IntW 1) :
  add (LLVM.and (add (const? (-1)) (zext 32 e_1)) e) (add (const? (-1)) (zext 32 e_1)) ⊑
    select e_1 (const? 0) (add e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


