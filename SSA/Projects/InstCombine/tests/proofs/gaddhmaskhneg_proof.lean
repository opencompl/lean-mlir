
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gaddhmaskhneg_proof
theorem dec_mask_neg_i32_thm (e : IntW 32) :
  add (LLVM.and (sub (const? 0) e) e) (const? (-1)) ⊑ LLVM.and (add e (const? (-1))) (LLVM.xor e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem dec_mask_commute_neg_i32_thm (e : IntW 32) :
  add (LLVM.and (LLVM.sdiv (const? 42) e) (sub (const? 0) (LLVM.sdiv (const? 42) e))) (const? (-1)) ⊑
    LLVM.and (add (LLVM.sdiv (const? 42) e) (const? (-1)) { «nsw» := true, «nuw» := false })
      (LLVM.xor (LLVM.sdiv (const? 42) e) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem dec_commute_mask_neg_i32_thm (e : IntW 32) :
  add (const? (-1)) (LLVM.and (sub (const? 0) e) e) ⊑ LLVM.and (add e (const? (-1))) (LLVM.xor e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


