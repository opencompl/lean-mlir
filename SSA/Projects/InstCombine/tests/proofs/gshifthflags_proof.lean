
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthflags_proof
theorem shl_add_nuw_thm :
  ∀ (e e_1 : IntW 8),
    shl (LLVM.and e_1 (const? 63)) (LLVM.and e (const? 2)) ⊑
      shl (LLVM.and e_1 (const? 63)) (LLVM.and e (const? 2)) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_nuw_and_nsw_thm :
  ∀ (e e_1 : IntW 8),
    shl (LLVM.and e_1 (const? 31)) (LLVM.and e (const? 2)) ⊑
      shl (LLVM.and e_1 (const? 31)) (LLVM.and e (const? 2)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shl_add_nsw_thm :
  ∀ (e e_1 : IntW 8),
    shl (LLVM.or e_1 (const? (-32))) (LLVM.and e (const? 2)) ⊑
      shl (LLVM.or e_1 (const? (-32))) (LLVM.and e (const? 2)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


