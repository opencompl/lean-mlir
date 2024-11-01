
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gaddhmask_proof
theorem add_mask_sign_i32_thm (e : IntW 32) :
  add (LLVM.and (ashr e (const? 32 31)) (const? 32 8)) (ashr e (const? 32 31)) ⊑
    select (icmp IntPredicate.slt e (const? 32 0)) (const? 32 7) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_mask_sign_commute_i32_thm (e : IntW 32) :
  add (ashr e (const? 32 31)) (LLVM.and (ashr e (const? 32 31)) (const? 32 8)) ⊑
    select (icmp IntPredicate.slt e (const? 32 0)) (const? 32 7) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_mask_ashr28_i32_thm (e : IntW 32) :
  add (LLVM.and (ashr e (const? 32 28)) (const? 32 8)) (ashr e (const? 32 28)) ⊑
    LLVM.and (lshr e (const? 32 28)) (const? 32 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_mask_ashr28_non_pow2_i32_thm (e : IntW 32) :
  add (LLVM.and (ashr e (const? 32 28)) (const? 32 9)) (ashr e (const? 32 28)) ⊑
    add (LLVM.and (ashr e (const? 32 28)) (const? 32 9)) (ashr e (const? 32 28))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem add_mask_ashr27_i32_thm (e : IntW 32) :
  add (LLVM.and (ashr e (const? 32 27)) (const? 32 8)) (ashr e (const? 32 27)) ⊑
    add (LLVM.and (ashr e (const? 32 27)) (const? 32 8)) (ashr e (const? 32 27))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


