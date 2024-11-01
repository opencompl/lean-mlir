
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gnarrowhmath_proof
theorem sext_sext_add_thm (e✝ : IntW 32) :
  add (sext 64 (ashr e✝ (const? 7))) (sext 64 (ashr e✝ (const? 9))) ⊑
    sext 64 (add (ashr e✝ (const? 7)) (ashr e✝ (const? 9)) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_zext_add_mismatched_exts_thm (e✝ : IntW 32) :
  add (sext 64 (ashr e✝ (const? 7))) (zext 64 (lshr e✝ (const? 9))) ⊑
    add (sext 64 (ashr e✝ (const? 7))) (zext 64 (lshr e✝ (const? 9))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sext_sext_add_mismatched_types_thm (e✝ : IntW 32) (e✝¹ : IntW 16) :
  add (sext 64 (ashr e✝¹ (const? 7))) (sext 64 (ashr e✝ (const? 9))) ⊑
    add (sext 64 (ashr e✝¹ (const? 7))) (sext 64 (ashr e✝ (const? 9))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e✝ : IntW 32) :
  add (sext 64 (ashr e✝ (const? 1))) (const? 1073741823) ⊑
    sext 64 (add (ashr e✝ (const? 1)) (const? 1073741823) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test6_thm (e✝ : IntW 32) :
  add (sext 64 (ashr e✝ (const? 1))) (const? (-1073741824)) ⊑
    sext 64 (add (ashr e✝ (const? 1)) (const? (-1073741824)) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test7_thm (e✝ : IntW 32) :
  add (zext 64 (lshr e✝ (const? 1))) (const? 2147483647) ⊑
    zext 64 (add (lshr e✝ (const? 1)) (const? 2147483647) { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test8_thm (e✝ : IntW 32) :
  mul (sext 64 (ashr e✝ (const? 16))) (const? 32767) ⊑
    sext 64 (mul (ashr e✝ (const? 16)) (const? 32767) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test9_thm (e✝ : IntW 32) :
  mul (sext 64 (ashr e✝ (const? 16))) (const? (-32767)) ⊑
    sext 64 (mul (ashr e✝ (const? 16)) (const? (-32767)) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test10_thm (e✝ : IntW 32) :
  mul (zext 64 (lshr e✝ (const? 16))) (const? 65535) ⊑
    zext 64 (mul (lshr e✝ (const? 16)) (const? 65535) { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test15_thm (e✝ : IntW 32) :
  sub (const? 8) (sext 64 (ashr e✝ (const? 1))) ⊑
    sext 64 (sub (const? 8) (ashr e✝ (const? 1)) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test16_thm (e✝ : IntW 32) :
  sub (const? 4294967294) (zext 64 (lshr e✝ (const? 1))) ⊑
    zext 64 (sub (const? (-2)) (lshr e✝ (const? 1)) { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


