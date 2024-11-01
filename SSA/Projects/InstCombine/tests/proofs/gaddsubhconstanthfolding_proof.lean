
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gaddsubhconstanthfolding_proof
theorem add_const_add_const_thm (e : IntW 32) : add (add e (const? 8)) (const? 2) ⊑ add e (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_const_sub_const_thm (e : IntW 32) : sub (add e (const? 8)) (const? 2) ⊑ add e (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_const_const_sub_thm (e : IntW 32) : sub (const? 2) (add e (const? 8)) ⊑ sub (const? (-6)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nsw_const_const_sub_nsw_thm (e : IntW 8) :
  sub (const? (-127)) (add e (const? 1) { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    sub (const? (-128)) e { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nsw_const_const_sub_thm (e : IntW 8) :
  sub (const? (-127)) (add e (const? 1) { «nsw» := true, «nuw» := false }) ⊑ sub (const? (-128)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_const_const_sub_nsw_thm (e : IntW 8) :
  sub (const? (-127)) (add e (const? 1)) { «nsw» := true, «nuw» := false } ⊑ sub (const? (-128)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nsw_const_const_sub_nsw_ov_thm (e : IntW 8) :
  sub (const? (-127)) (add e (const? 2) { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    sub (const? 127) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nuw_const_const_sub_nuw_thm (e : IntW 8) :
  sub (const? (-127)) (add e (const? 1) { «nsw» := false, «nuw» := true }) { «nsw» := false, «nuw» := true } ⊑
    sub (const? (-128)) e { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_nuw_const_const_sub_thm (e : IntW 8) :
  sub (const? (-127)) (add e (const? 1) { «nsw» := false, «nuw» := true }) ⊑ sub (const? (-128)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_const_const_sub_nuw_thm (e : IntW 8) :
  sub (const? (-127)) (add e (const? 1)) { «nsw» := false, «nuw» := true } ⊑ sub (const? (-128)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_const_add_const_thm (e : IntW 32) : add (sub e (const? 8)) (const? 2) ⊑ add e (const? (-6)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_const_sub_const_thm (e : IntW 32) : sub (sub e (const? 8)) (const? 2) ⊑ add e (const? (-10)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_const_const_sub_thm (e : IntW 32) : sub (const? 2) (sub e (const? 8)) ⊑ sub (const? 10) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem const_sub_add_const_thm (e : IntW 32) : add (sub (const? 8) e) (const? 2) ⊑ sub (const? 10) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem const_sub_sub_const_thm (e : IntW 32) : sub (sub (const? 8) e) (const? 2) ⊑ sub (const? 6) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem const_sub_const_sub_thm (e : IntW 32) : sub (const? 2) (sub (const? 8) e) ⊑ add e (const? (-6)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem addsub_combine_constants_thm (e e_1 : IntW 7) :
  add (add e_1 (const? 42)) (sub (const? 10) e) { «nsw» := true, «nuw» := false } ⊑ add (sub e_1 e) (const? 52) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_from_constant_thm (e e_1 : IntW 5) : add (sub (const? 10) e_1) e ⊑ add (sub e e_1) (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_from_constant_commute_thm (e e_1 : IntW 5) :
  add (mul e_1 e_1) (sub (const? 10) e { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    add (sub (mul e_1 e_1) e) (const? 10) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


