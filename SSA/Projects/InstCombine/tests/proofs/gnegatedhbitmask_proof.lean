
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gnegatedhbitmask_proof
theorem neg_mask1_lshr_thm (e : IntW 8) :
  sub (const? 0) (LLVM.and (lshr e (const? 3)) (const? 1)) ⊑ ashr (shl e (const? 4)) (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_mask1_lshr_thm (e : IntW 8) :
  sub (const? 10) (LLVM.and (lshr e (const? 1)) (const? 1)) ⊑
    add (ashr (shl e (const? 6)) (const? 7)) (const? 10) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_mask1_trunc_lshr_thm (e : IntW 64) :
  sub (const? 10) (LLVM.and (trunc 8 (lshr e (const? 15))) (const? 1)) ⊑
    add (trunc 8 (ashr (shl e (const? 48)) (const? 63))) (const? 10) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_sext_mask1_trunc_lshr_thm (e : IntW 64) :
  sub (const? 10) (sext 32 (LLVM.and (trunc 8 (lshr e (const? 15))) (const? 1))) ⊑
    zext 32
      (add (trunc 8 (ashr (shl e (const? 48)) (const? 63))) (const? 10) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sub_zext_trunc_lshr_thm (e : IntW 64) :
  sub (const? 10) (zext 32 (trunc 1 (lshr e (const? 15)))) ⊑
    add (ashr (shl (trunc 32 e) (const? 16)) (const? 31)) (const? 10) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_mask2_lshr_thm (e : IntW 8) :
  sub (const? 0) (LLVM.and (lshr e (const? 3)) (const? 2)) ⊑
    sub (const? 0) (LLVM.and (lshr e (const? 3)) (const? 2)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_signbit_thm (e : IntW 8) : sub (const? 0) (zext 32 (lshr e (const? 7))) ⊑ sext 32 (ashr e (const? 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_not_signbit2_thm (e : IntW 8) :
  sub (const? 0) (zext 32 (lshr e (const? 6))) ⊑
    sub (const? 0) (zext 32 (lshr e (const? 6))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_not_signbit3_thm (e : IntW 8) :
  sub (const? 0) (zext 32 (ashr e (const? 7))) ⊑
    sub (const? 0) (zext 32 (ashr e (const? 7))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


